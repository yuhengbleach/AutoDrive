# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/zhouji/Documents/autodrive/rpc_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/zhouji/Documents/autodrive/rpc_ws/build

# Utility rule file for clean_test_results_av_comm.

# Include the progress variables for this target.
include common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/progress.make

common/av_comm/CMakeFiles/clean_test_results_av_comm:
	cd /home/zhouji/Documents/autodrive/rpc_ws/build/common/av_comm && /usr/bin/python /opt/ros/jade/share/catkin/cmake/test/remove_test_results.py /home/zhouji/Documents/autodrive/rpc_ws/build/test_results/av_comm

clean_test_results_av_comm: common/av_comm/CMakeFiles/clean_test_results_av_comm
clean_test_results_av_comm: common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/build.make
.PHONY : clean_test_results_av_comm

# Rule to build all files generated by this target.
common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/build: clean_test_results_av_comm
.PHONY : common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/build

common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/clean:
	cd /home/zhouji/Documents/autodrive/rpc_ws/build/common/av_comm && $(CMAKE_COMMAND) -P CMakeFiles/clean_test_results_av_comm.dir/cmake_clean.cmake
.PHONY : common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/clean

common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/depend:
	cd /home/zhouji/Documents/autodrive/rpc_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/zhouji/Documents/autodrive/rpc_ws/src /home/zhouji/Documents/autodrive/rpc_ws/src/common/av_comm /home/zhouji/Documents/autodrive/rpc_ws/build /home/zhouji/Documents/autodrive/rpc_ws/build/common/av_comm /home/zhouji/Documents/autodrive/rpc_ws/build/common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : common/av_comm/CMakeFiles/clean_test_results_av_comm.dir/depend
