#
# Generated by the Apple Project Builder.
#
# NOTE: Do NOT change this file -- Project Builder maintains it.
#
# Put all of your customizations in files called Makefile.preamble
# and Makefile.postamble (both optional), and Makefile will include them.
#

NAME = SenTestingKit

PROJECTVERSION = 2.8
PROJECT_TYPE = Framework

GLOBAL_RESOURCES = ApplicationWrapperExtensions.plist\
                   NoSourceDirectoryExtensions.plist

CLASSES = NSException_SenTestFailure.m NSInvocation_SenTesting.m\
          SenInterfaceTestCase.m SenTest.m SenTestCase.m\
          SenTestCaseRun.m SenTestDistributedNotifier.m SenTestLog.m\
          SenTestObserver.m SenTestProbe.m SenTestRun.m SenTestSuite.m\
          SenTestSuiteRun.m

HFILES = NSException_SenTestFailure.h NSInvocation_SenTesting.h\
         SenInterfaceTestCase.h SenTest.h SenTestCase.h\
         SenTestCaseRun.h SenTestCase_Macros.h SenTestDefines.h\
         SenTestDistributedNotifier.h SenTestingKit.h SenTestLog.h\
         SenTestObserver.h SenTestProbe.h SenTestRun.h SenTestSuite.h\
         SenTestSuiteRun.h

SUBPROJECTS = Tests.subproj

OTHERSRCS = CustomInfo.plist h.template m.template Makefile\
            Makefile.postamble Makefile.preamble OpenSourceLicense.html

MAKEFILEDIR = $(MAKEFILEPATH)/pb_makefiles
CURRENTLY_ACTIVE_VERSION = YES
DEPLOY_WITH_VERSION_NAME = A
CODE_GEN_STYLE = DYNAMIC
MAKEFILE = framework.make
NEXTSTEP_INSTALLDIR = /Library/Frameworks
WINDOWS_INSTALLDIR = /Library/Frameworks
LIBS = 
DEBUG_LIBS = $(LIBS)
PROF_LIBS = $(LIBS)


FRAMEWORK_PATHS = -F$(USER_LIBRARY_DIR)/Frameworks\
                  -F$(NEXT_ROOT)$(LOCAL_LIBRARY_DIR)/Frameworks
NEXTSTEP_PB_CFLAGS = -DRHAPSODY
WINDOWS_PB_CFLAGS = -DBUILDINGSENTEST
FRAMEWORKS = -framework Foundation -framework SenFoundation
PUBLIC_HEADERS = SenTest.h SenTestCase.h SenTestSuite.h\
                 SenTestCase_Macros.h SenTestingKit.h SenTestDefines.h\
                 NSException_SenTestFailure.h SenTestRun.h\
                 SenTestSuiteRun.h SenTestCaseRun.h SenTestObserver.h\
                 SenTestLog.h SenTestProbe.h\
                 SenTestDistributedNotifier.h SenInterfaceTestCase.h



NEXTSTEP_BUILD_OUTPUT_DIR = $(LOCAL_DEVELOPER_DIR)/Builds/$(USER)/$(NAME)

NEXTSTEP_OBJCPLUS_COMPILER = /usr/bin/cc
WINDOWS_OBJCPLUS_COMPILER = $(DEVDIR)/gcc
PDO_UNIX_OBJCPLUS_COMPILER = $(NEXTDEV_BIN)/gcc
NEXTSTEP_JAVA_COMPILER = /usr/bin/javac
WINDOWS_JAVA_COMPILER = $(JDKBINDIR)/javac.exe
PDO_UNIX_JAVA_COMPILER = $(NEXTDEV_BIN)/javac

include $(MAKEFILEDIR)/platform.make

-include Makefile.preamble

include $(MAKEFILEDIR)/$(MAKEFILE)

-include Makefile.postamble

-include Makefile.dependencies
