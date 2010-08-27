// Pomodoro Desktop - Copyright (c) 2009, Ugo Landini (ugol@computer.org)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// * Neither the name of the <organization> nor the
// names of its contributors may be used to endorse or promote products
// derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY COPYRIGHT HOLDERS ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <copyright holder> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "StatsController.h"
#import "PomodoroStats.h"
#import "sqlite3.h"

@implementation StatsController
@synthesize pomodorosDoneTableView;

- (NSString *)applicationSupportFolder {
		
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"Pomodoro"];
}

#pragma mark ---- Pomodoros Stats delegate/datasource methods ----

- (int)numberOfRowsInTableView:(NSTableView *)tableView {
    return [pomodorosDone count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn
			row:(int)row {
	id dict = [pomodorosDone objectAtIndex:row];
	NSString *key = [tableColumn identifier];
	return [dict valueForKey:key];
}

#pragma mark ---- Business methods ----

- (IBAction) resetStatistics:(id)sender {
	
	[pomoStats clear];
	
}

#pragma mark ---- Lifecycle methods ----

- (id) init {	
	if (![super initWithWindowNibName:@"Stats"]) return nil;
	pomodorosDone = [[NSMutableArray alloc]init];
	return self;
}

- (void) dealloc{
	[pomodorosDone release];
	[super dealloc];
}


- (void)createDb:(sqlite3 *)database{
	char *errorMsg;
	const char *createSql = 
	"CREATE TABLE IF NOT EXISTS ZPOMODOROS ( Z_PK INTEGER PRIMARY KEY, ZWHEN TIMESTAMP, ZNAME VARCHAR, ZTAG VARCHAR ); CREATE INDEX IF NOT EXISTS ZPOMODOROS_ZWHEN_INDEX ON ZPOMODOROS (ZWHEN);";
	int result = sqlite3_exec(database, createSql, NULL, NULL, &errorMsg);
	if(result != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Error creating backlog database: %s", errorMsg);
	}
}

- (void)migrateDb:(sqlite3 *)database{	
	char *errorMsg;
	char *readTagSql = "SELECT ZTAG from ZPOMODOROS;";
	if(sqlite3_exec(database, readTagSql, NULL, NULL, &errorMsg) == SQLITE_OK)
		return;

	const char *addColumnSql = "ALTER TABLE ZPOMODOROS	ADD ZTAG VARCHAR;";
	int result = sqlite3_exec(database, addColumnSql, NULL, NULL, &errorMsg);
	if(result != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Error migrating backlog database: %s", errorMsg);
	}
}

- (void)loadData:(sqlite3 *)database{	
	const char *selectSql = "SELECT ZTAG, ZNAME, ZWHEN FROM ZPOMODOROS ORDER BY ZWHEN DESC;";
	sqlite3_stmt *statement;
	
	int result = sqlite3_prepare_v2(database, selectSql, -1, &statement, nil);
	if(result != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Error loading data from backlog database");
	}

	[pomodorosDone removeAllObjects];
	while (sqlite3_step(statement) == SQLITE_ROW) {
		NSMutableDictionary *dict= [[[NSMutableDictionary alloc]init]autorelease];
		
		char *tag = (char *)sqlite3_column_text(statement, 0);
		if(tag != NULL) {
			[dict setValue:[NSString stringWithUTF8String:tag] forKey:@"Tag"];
		} else {
			[dict setValue:@"" forKey:@"Tag"];
		}

		char *name = (char *)sqlite3_column_text(statement, 1);
		[dict setValue:[NSString stringWithUTF8String:name] forKey:@"Description"];
		int when = sqlite3_column_int(statement, 2);
		[dict setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:when] forKey:@"DoneAt"];
				
		[pomodorosDone addObject:dict];
	}
	
	[pomodorosDoneTableView reloadData];
}

- (NSString *) databaseName {
  NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *applicationSupportFolder = [self applicationSupportFolder];
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        [fileManager createDirectoryAtPath:applicationSupportFolder attributes:nil];
    }
    
    NSString *databaseName = [applicationSupportFolder stringByAppendingPathComponent: @"Pomodoro.sql"];
  return databaseName;
}

- (sqlite3 *) openDatabase {
  sqlite3 *database;
  NSString *databaseName = [self databaseName];
	char *errorMsg;
	int result = sqlite3_open([databaseName UTF8String], &database);
	if(result != SQLITE_OK) {
		NSAssert(0, @"Error opening backlog database: %s", errorMsg);
	}
  return database;
}



- (void) loadPomodoros {
	sqlite3 *database;
	database = [self openDatabase];
	[self createDb:database];
	[self migrateDb:database];
	[self loadData:database];
	sqlite3_close(database);
	
}

-(void)savePomodoro:(NSString *)description with:(NSString *)tag finished:(NSDate *)at database:(sqlite3 *)database {
	char *sql = "INSERT INTO ZPOMODOROS (ZNAME, ZWHEN, ZTAG) VALUES (?, ?, ?);";
	sqlite3_stmt *stmt;
	if (sqlite3_prepare_v2(database, sql, -1, &stmt, nil) == SQLITE_OK) {
		sqlite3_bind_text(stmt, 1, [description UTF8String], -1, NULL);
		sqlite3_bind_double(stmt, 2, [at timeIntervalSinceReferenceDate]);
		sqlite3_bind_text(stmt, 3, [tag UTF8String], -1, NULL);
	}
	if (sqlite3_step(stmt) != SQLITE_DONE) {
		sqlite3_close(database);
		NSAssert(0, @"Serious problem saving on backlog database");
	}
	sqlite3_finalize(stmt);
}

-(void)pomodoro:(NSString *)description with:(NSString *)tag finished:(NSDate *)at {
	sqlite3 *database = [self openDatabase];
	[self savePomodoro:description with:tag finished:at database:database];
	sqlite3_close(database);
}

- (void)showWindow:(id)sender {
	[self loadPomodoros];
	[super showWindow:sender];
}

@end
