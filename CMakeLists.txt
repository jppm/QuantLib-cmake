# CMake build system for QuantLib 
# 2012, Joao Paulo Magalhaes <jpmagalhaes@ist.utl.pt>

cmake_minimum_required ( VERSION 2.8 )

project ( QuantLib )

set ( QuantLib_MAJOR_VERSION 1 CACHE STRING "QuantLib major version number." FORCE )
set ( QuantLib_MINOR_VERSION 2 CACHE STRING "QuantLib minor version number." FORCE )
set ( QuantLib_PATCH_VERSION 0 CACHE STRING "QuantLib patch version number." FORCE )
set ( QuantLib_VERSION_STRING "${QuantLib_MAJOR_VERSION}.${QuantLib_MINOR_VERSION}.${QuantLib_PATCH_VERSION}" )                                                       

#--------------------------------------------------
# initial settings - cached

OPTION ( QuantLib_BUILD_STATIC "Build a static library." ON )
OPTION ( QuantLib_BUILD_SHARED "Build a shared library." OFF )


OPTION ( QuantLib_ENABLE_INDEXED_COUPONS "Use indexed coupons in a floating rate leg. Use par coupons otherwise." OFF )
OPTION ( QuantLib_ENABLE_NEGATIVE_RATES "Allow negative yield rates in a few places where they are currently forbidden. It is still not clear whether this is safe." OFF )
OPTION ( QuantLib_ENABLE_EXTRA_SAFETY_CHECKS "Add extra runtime checks to a few functions. This can prevent their inlining and degrade performance." OFF )
OPTION ( QuantLib_ENABLE_DEPRECATED_CODE "Include deprecated code in the library." ON )
OPTION ( QuantLib_ENABLE_SESSIONS "If enabled, singletons will return different instances for different sessions. You will have to provide and link with the library a sessionId() function in namespace QuantLib, returning a different session id for each session." OFF )


OPTION ( QuantLib_ENABLE_MSG_ERROR_LINES "Whether to print file and line info in error messages." OFF )
OPTION ( QuantLib_ENABLE_MSG_FUNCTIONS "Whether to print function names in error messages." OFF )
OPTION ( QuantLib_ENABLE_MSG_TRACING "Whether to print traces in error messages. Degrades performance." OFF )


OPTION ( QuantLib_ENABLE_EXAMPLES "Whether to build and install examples." OFF )

if ( QuantLib_ENABLE_EXAMPLES )
  OPTION ( QuantLib_ENABLE_EXAMPLES_INSTALL_SHARE "Whether the examples binaries and respective sources shall be put in the share folder. When OFF, the binary goes to bin and the source is not copied." OFF )
endif ()

OPTION ( QuantLib_ENABLE_BENCHMARK "Whether to build and install benchmarks." OFF )

# Benchmarks require boost unit test, which is linkable
if ( QuantLib_ENABLE_BENCHMARK ) 
  OPTION ( QuantLib_Boost_USE_STATIC_LIBS "Use the static Boost libraries" OFF )
  OPTION ( QuantLib_Boost_USE_MULTITHREADED "Use the multithreaded Boost libraries" OFF )
  OPTION ( QuantLib_Boost_USE_STATIC_RUNTIME "Searches for Boost libraries linked against a static C++ standard library (s ABI tag)." OFF )
endif ()


#--------------------------------------------------
# initial settings - non-cached

set ( QuantLib_ROOT_DIR  ${PROJECT_SOURCE_DIR} )
# resolve the path without any relative components
get_filename_component ( tmp ${QuantLib_ROOT_DIR} REALPATH )
set ( QuantLib_ROOT_DIR  ${tmp} ) 

set ( QuantLib_SRC_DIR   ${QuantLib_ROOT_DIR}/ql )
set ( QuantLib_EXAMPLES_DIR   ${QuantLib_ROOT_DIR}/Examples )
set ( QuantLib_BENCHMARK_DIR   ${QuantLib_ROOT_DIR}/test-suite )
set ( QuantLib_BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR} )

#--------------------------------------------------
# libraries 

set ( QuantLib_LIBRARIES )

#--------------------------------
# find BOOST - see http://www.cmake.org/cmake/help/cmake-2-8-docs.html#module:FindBoost

set ( Boost_DEBUG FALSE )
set ( Boost_DETAILED_FAILURE_MSG TRUE )
find_package ( Boost COMPONENTS ${qlbc} REQUIRED )
list ( APPEND QuantLib_INCLUDE_DIRS ${Boost_INCLUDE_DIRS} )
list ( APPEND QuantLib_LIBRARIES ${Boost_LIBRARIES} )

#---------------------------------------------------------
# deal with the source files

# to generate files.cmake, use the following cmd from the top dir:
# ( d=`pwd`/ql ; echo "set ( QuantLib_HEADERS " ; find $d -name "*.hpp" | sed "s:$d:  \${QuantLib_ROOT_DIR}/ql:g" | sort ; echo ")" ; echo ; echo ; echo "set(QuantLib_SOURCES " ; find $d -name "*.cpp" -o -name "*.c" | sed "s:$d:  \${QuantLib_ROOT_DIR}/ql:g" | sort ; echo ")" ; echo ) > files.cmake

include ( files.cmake )

#---------------------------------------------------------
# deal with configuration & system introspection

#---------------------------------------------------------
# system introspection

include ( config.cmake )

#---------------------------------------------------------
# create the library

include_directories ( 
  ${QuantLib_ROOT_DIR}
  ${QuantLib_INCLUDE_DIRS}
)

add_custom_target ( QuantLib )

if ( NOT QuantLib_BUILD_STATIC AND NOT QuantLib_BUILD_SHARED ) 
  message ( ERROR "Must build at least one static or shared version" )
endif ()

# static version -------------------------------------------
if ( QuantLib_BUILD_STATIC )
  add_library ( QuantLib-static STATIC ${QuantLib_SOURCES} ${QuantLib_HEADERS} )
  set_target_properties ( QuantLib-static PROPERTIES
    VERSION ${QuantLib_VERSION_STRING}
    OUTPUT_NAME "QuantLib"
  )
  target_link_libraries ( QuantLib-static ${QuantLib_LIBRARIES} )
  add_dependencies ( QuantLib QuantLib-static )
  install ( TARGETS QuantLib-static
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
  )
endif ()


# shared version -------------------------------------------
if ( QuantLib_BUILD_SHARED )
  add_library ( QuantLib-shared SHARED ${QuantLib_SOURCES} ${QuantLib_HEADERS} )
  set_target_properties ( QuantLib-shared PROPERTIES
    VERSION ${QuantLib_VERSION_STRING}
    OUTPUT_NAME "QuantLib"
  )
  target_link_libraries ( QuantLib-shared ${QuantLib_LIBRARIES} )
  add_dependencies ( QuantLib QuantLib-shared )
  install ( TARGETS QuantLib-shared
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
  )
endif ()

# install headers ----------------------------------------
install ( DIRECTORY ${QuantLib_SRC_DIR} 
  DESTINATION include 
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)

#----------------------------------------------------------------------
# examples

if ( QuantLib_ENABLE_EXAMPLES )
  add_subdirectory ( ${QuantLib_EXAMPLES_DIR} examples )
endif ()

#----------------------------------------------------------------------
# benchmark

if ( QuantLib_ENABLE_BENCHMARK )
  add_subdirectory ( ${QuantLib_BENCHMARK_DIR} benchmark )
endif ()

