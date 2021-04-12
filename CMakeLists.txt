cmake_minimum_required(VERSION 3.3)
project(globfilelists)

#force out of tree build
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

#The easiset way to get filepaths in cmake to use is file(GLOB varname path_to_file). file glob sets the passed variable to a list of full paths of exisiting files that match the passed path.
#get full paths to verilog files in hdl directory and system verilog files in tb
file(GLOB hdlfiles hdl/*.vhdl)
file(GLOB tbfiles tb/*.vhdl)

#print out those full paths
message(STATUS "hdlfiles ${hdlfiles}")
message(STATUS "hdlfiles ${tbfiles}")

#An absolute path can be gotten from a relative path using the function get_filename_component with the REALPATH mode
set(filenames
  hdl/DFlipFlop.vhdl
  hdl/GenericDFlipFlop.vhdl
  )
foreach(filename ${filenames})
  get_filename_component(hdlfile ${filename} REALPATH)
  message(STATUS "file ${hdlfile}")
endforeach()
