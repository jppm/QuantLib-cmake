# CMake build system for QuantLib 
# 2012, Joao Paulo Magalhaes <jpmagalhaes@ist.utl.pt>

# benchmarks require unit test framework
find_package ( Boost COMPONENTS unit_test_framework REQUIRED )

add_definitions ( -DQL_WORKING_BOOST_STREAMS )
set_source_files_properties ( main.cpp PROPERTIES 
  COMPILE_DEFINITIONS BOOST_TEST_DYN_LINK )

include ( files.cmake )

add_executable ( QuantLib-test-suite main.cpp ${QuantLib_TEST_SRCS} )
set_target_properties ( QuantLib-test-suite PROPERTIES
 OUTPUT_NAME quantlib-test-suite FOLDER "benchmark" )
target_link_libraries ( QuantLib-test-suite QuantLib-static ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY} )
install ( TARGETS QuantLib-test-suite DESTINATION bin )


add_executable ( QuantLib-benchmark main.cpp ${QuantLib_BENCHMARK_SRCS} )
set_target_properties ( QuantLib-benchmark PROPERTIES
 OUTPUT_NAME quantlib-benchmark FOLDER "benchmark" )
target_link_libraries ( QuantLib-benchmark QuantLib-static ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY} )
install ( TARGETS QuantLib-benchmark DESTINATION bin )


