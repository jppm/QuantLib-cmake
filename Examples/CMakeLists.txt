# CMake build system for QuantLib 
# 2012, Joao Paulo Magalhaes <jpmagalhaes@ist.utl.pt>

add_custom_target ( examples )

# use a macro to simplify things
macro ( add_ql_example name )
  set ( ql_rname example-${name} )
  if ( ${ARGC} EQUAL 1 )
    # we rely on the fact that each 
    # example comes from a cpp file named as its parent folder
    set ( ql_files ${name}/${name}.cpp )
  else ()
    # cpp was also given - get it from ARGN
    set ( ql_files ${ARGN} )
  endif ()
  add_executable ( ${ql_rname} ${ql_files} )
  set_target_properties ( ${ql_rname} PROPERTIES OUTPUT_NAME ${name} )
  target_link_libraries ( ${ql_rname} QuantLib-static )
  add_dependencies ( examples ${ql_rname} )
  if ( QuantLib_ENABLE_EXAMPLES_INSTALL_SHARE )
    install ( TARGETS ${ql_rname} DESTINATION share/examples/${name} )
    install ( FILES ${ql_files} DESTINATION share/examples/${name} )
  else ()
    install ( TARGETS ${ql_rname} DESTINATION bin )
  endif ()
  unset ( ql_rname )
  unset ( ql_files )
endmacro ()


add_ql_example ( BermudanSwaption )
add_ql_example ( Bonds )
add_ql_example ( CallableBonds )
add_ql_example ( CDS )
add_ql_example ( ConvertibleBonds )
add_ql_example ( DiscreteHedging )
add_ql_example ( EquityOption )
add_ql_example ( FittedBondCurve )
add_ql_example ( FRA )
add_ql_example ( MarketModels )
add_ql_example ( Replication )
add_ql_example ( Repo )
add_ql_example ( Swap Swap/swapvaluation.cpp )

