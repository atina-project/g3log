# g3log is a KjellKod Logger
# 2015 @author Kjell Hedström, hedstrom@kjellkod.cc 
# ==================================================================
# 2015 by KjellKod.cc. This is PUBLIC DOMAIN to use at your own
#    risk and comes  with no warranties.
#
# This code is yours to share, use and modify with no strings attached
#   and no restrictions or obligations.
# ===================================================================


# PLEASE NOTE THAT:
# the following definitions can through options be added 
# to the auto generated file src/g3log/generated_definitions.hpp
#   add_definitions(-DG3_DYNAMIC_LOGGING)
#   add_definitions(-DCHANGE_G3LOG_DEBUG_TO_DBUG)
#   add_definitions(-DWINDOWS_FUNCSIG)
#   add_definitions(-DPRETTY_FUNCTION)
#   add_definitions(-DDISABLE_FATAL_SIGNALHANDLING)
#   add_definitions(-DDISABLE_VECTORED_EXCEPTIONHANDLING)
#   add_definitions(-DDEBUG_BREAK_AT_FATAL_SIGNAL)
#   add_definitions(-DG3_DYNAMIC_MAX_MESSAGE_SIZE)



# Used for generating a macro definitions file  that is to be included
# that way you do not have to re-state the Options.cmake definitions when 
# compiling your binary (if done in a separate build step from the g3log library)
SET(G3_DEFINITIONS "")

# -DG3_IOS_LIB=ON : iOS version of library
option(G3_IOS_LIB
      "iOS version of library." OFF)
IF(G3_IOS_LIB)
   MESSAGE("-DG3_IOS_LIB=ON\t\t\t\tBuilding iOS version")
ENDIF(G3_IOS_LIB)

# -DUSE_DYNAMIC_LOGGING_LEVELS=ON   : run-type turn on/off levels
option (USE_DYNAMIC_LOGGING_LEVELS
       "Turn ON/OFF log levels. An disabled level will not push logs of that level to the sink. By default dynamic logging is disabled" OFF)
IF(USE_DYNAMIC_LOGGING_LEVELS)
   LIST(APPEND G3_DEFINITIONS G3_DYNAMIC_LOGGING)
   message( STATUS "-DUSE_DYNAMIC_LOGGING_LEVELS=ON" )
   message( STATUS "\tDynamic logging levels is used" )
   message( STATUS "\tUse  [g3::addLogLevel(LEVEL boolean)] to enable/disable logging on specified levels\n\n" )
ELSE() 
   message( STATUS "-DUSE_DYNAMIC_LOGGING_LEVELS=OFF" ) 
ENDIF(USE_DYNAMIC_LOGGING_LEVELS)



# -DCHANGE_G3LOG_DEBUG_TO_DBUG=ON   : change the DEBUG logging level to be DBUG to avoid clash with other libraries that might have
# predefined DEBUG for their own purposes
option (CHANGE_G3LOG_DEBUG_TO_DBUG
       "Use DBUG logging level instead of DEBUG. By default DEBUG is the debugging level" OFF)
IF(CHANGE_G3LOG_DEBUG_TO_DBUG)
   LIST(APPEND G3_DEFINITIONS CHANGE_G3LOG_DEBUG_TO_DBUG)
   LIST(APPEND G3_DEFINITIONS "G3LOG_DEBUG DBUG")
   message( STATUS "-DCHANGE_G3LOG_DEBUG_TO_DBUG=ON                 DBUG instead of DEBUG logging level is used" )
ELSE() 
   LIST(APPEND G3_DEFINITIONS "G3LOG_DEBUG DEBUG")
   message( STATUS "-DCHANGE_G3LOG_DEBUG_TO_DBUG=OFF \t(Debuggin logging level is 'DEBUG')" ) 
ENDIF(CHANGE_G3LOG_DEBUG_TO_DBUG)


# -DWINDOWS_USE_FUNCSIG=ON   : (Default OFF) Override the use of __FUNCTION__ for Windows platform and instead use __FUNCSIG__
option (WINDOWS_FUNCSIG
       "Windows __FUNCSIG__ to expand `Function` location of the LOG call instead of the default __FUNCTION__" OFF)
IF(WINDOWS_FUNCSIG)
   LIST(APPEND G3_DEFINITIONS WINDOWS_FUNCSIG)
   message( STATUS "-DWINDOWS_FUNCSIG=ON\t\t__SIGFUNC__ is used instead of the default __FUNCTION__ for LOG call locations" )
ELSE() 
   message( STATUS "-DWINDOWS_FUNCSIG=OFF") 
ENDIF(WINDOWS_FUNCSIG)


# -DPRETTY_FUNCTION=ON   : (Default OFF) Override the use of __FUNCTION__ for Windows platform and instead use __FUNCSIG__
# NOTE: heavy templated integrations such as boost log calls that shows the function name can cause function name expansion
# to "spam" the LOG output with the now visible template arguments. 
option (PRETTY_FUNCTION
       "Windows __PRETTY_FUNCTION__ to expand `Function` location of the LOG call instead of the default __FUNCTION__" OFF)
IF(PRETTY_FUNCTION)
   LIST(APPEND G3_DEFINITIONS PRETTY_FUNCTION)
   message( STATUS "-DPRETTY_FUNCTION=ON\t\t__PRETTY_FUNCTION__ is used instead of the default __FUNCTION__ for LOG call locations" )
ELSE() 
   message( STATUS "-DPRETTY_FUNCTION=OFF") 
ENDIF(PRETTY_FUNCTION)



# -DG3_DYNAMIC_MAX_MESSAGE_SIZE   : use dynamic memory for final_message in logcapture.cpp
option (USE_G3_DYNAMIC_MAX_MESSAGE_SIZE
       "Use dynamic memory for message buffer during log capturing" OFF)
IF(USE_G3_DYNAMIC_MAX_MESSAGE_SIZE)
   LIST(APPEND G3_DEFINITIONS G3_DYNAMIC_MAX_MESSAGE_SIZE)
   message( STATUS "-DUSE_G3_DYNAMIC_MAX_MESSAGE_SIZE=ON\t\tDynamic memory used during log capture" )
ELSE()
   message( STATUS "-DUSE_G3_DYNAMIC_MAX_MESSAGE_SIZE=OFF" )
ENDIF(USE_G3_DYNAMIC_MAX_MESSAGE_SIZE)


# G3LOG_FULL_FILENAME logs full file name instead of short filename.  This makes it
# easier to copy filenames to open them without needing to search.
option (G3_LOG_FULL_FILENAME "Log full filename" OFF)
IF(G3_LOG_FULL_FILENAME)
   LIST(APPEND G3_DEFINITIONS G3_LOG_FULL_FILENAME)
   message( STATUS "-DG3_LOG_FULL_FILENAME=ON\t\tShowing full filenames with logs")
ELSE()
   message( STATUS "-DG3_LOG_FULL_FILENAME=OFF")
ENDIF(G3_LOG_FULL_FILENAME)


# -DENABLE_FATAL_SIGNALHANDLING=ON   : default change the
# By default fatal signal handling is enabled. You can disable it with this option
# enumerated in src/stacktrace_windows.cpp 
option (ENABLE_FATAL_SIGNALHANDLING
    "Vectored exception / crash handling with improved stack trace" ON)

IF(NOT ENABLE_FATAL_SIGNALHANDLING)
   LIST(APPEND G3_DEFINITIONS DISABLE_FATAL_SIGNALHANDLING)

   message( STATUS "-DENABLE_FATAL_SIGNALHANDLING=OFF               Fatal signal handler is disabled" )
ELSE() 
   message( STATUS "-DENABLE_FATAL_SIGNALHANDLING=ON\tFatal signal handler is enabled" )
ENDIF(NOT ENABLE_FATAL_SIGNALHANDLING)

# Option for building as a static or shared library in all platforms
option (G3_SHARED_LIB  "Build shared library" ON)
IF(G3_SHARED_LIB)
   message( STATUS "-DG3_SHARED_LIB=ON\tBuild shared library" ) 
ELSE()
   MESSAGE( STATUS "-DG3_SHARED_LIB=OFF\tBuild static library")  
ENDIF()

# Option for building as a static or shared runtime library in MS VC++
option (G3_SHARED_RUNTIME  "Build shared runtime library MS VC" ON)
IF(G3_SHARED_RUNTIME)
   message( STATUS "-DG3_SHARED_RUNTIME=ON\tBuild shared runtime library" )
ELSE()
   message( STATUS "-DG3_SHARED_RUNTIME=OFF\tBuild static runtime library")
ENDIF()

# WINDOWS OPTIONS
IF (MSVC OR MINGW) 
# -DENABLE_VECTORED_EXCEPTIONHANDLING=ON   : defualt change the
# By default vectored exception handling is enabled, you can disable it with this option. 
# Please know that only known fatal exceptions will be caught, these exceptions are the ones
# enumerated in src/stacktrace_windows.cpp 
   option (ENABLE_VECTORED_EXCEPTIONHANDLING
       "Vectored exception / crash handling with improved stack trace" ON)

   IF(NOT ENABLE_VECTORED_EXCEPTIONHANDLING)
      LIST(APPEND G3_DEFINITIONS DISABLE_VECTORED_EXCEPTIONHANDLING)
      message( STATUS "-DENABLE_VECTORED_EXCEPTIONHANDLING=OFF           Vectored exception handling is disabled" ) 
   ELSE() 
      message( STATUS "-DENABLE_VECTORED_EXCEPTIONHANDLING=ON\t\t\tVectored exception handling is enabled" ) 
   ENDIF(NOT ENABLE_VECTORED_EXCEPTIONHANDLING)




# Default ON. Will trigger a break point in DEBUG builds if the signal handler 
#  receives a fatal signal.
#
   option (DEBUG_BREAK_AT_FATAL_SIGNAL
       "Enable Visual Studio break point when receiving a fatal exception. In __DEBUG mode only" OFF)
   IF(DEBUG_BREAK_AT_FATAL_SIGNAL)
     LIST(APPEND G3_DEFINITIONS DEBUG_BREAK_AT_FATAL_SIGNAL)
     message( STATUS "-DDEBUG_BREAK_AT_FATAL_SIGNAL=ON                  Break point for fatal signal is enabled for __DEBUG." ) 
   ELSE() 
      message( STATUS "-DDEBUG_BREAK_AT_FATAL_SIGNAL=OFF\t\t\tBreak point for fatal signal is disabled" ) 
   ENDIF(DEBUG_BREAK_AT_FATAL_SIGNAL)

ENDIF (MSVC OR MINGW)
message( STATUS "\n\n\n" )

option(INSTALL_G3LOG "Enable installation of g3log. (Projects embedding g3log may want to turn this OFF.)" ON)
option(INSTALL_G3LOG_LIB_ONLY "Install g3log lib only." OFF)
option(G3LOG_LIB_INSTALL_PATH "The path g3log lib should be installed to." OFF)
option(G3LOG_LIB_NO_SOVERSION "Disable setting soversion for g3log lib." OFF)
