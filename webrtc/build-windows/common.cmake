#=======================
#  WebRTC common settings
#=======================

# cmake 不支持 architecture，没有预定义的变量
# 这里简单手工指定吧
set (target_arch "x64")

# 添加自定义系统平台变量定义
# "android" "ios" "linux" "mac" "win"
set (OS "win")

set (build_with_libjingle 0)
set (webrtc_root "")
set (webrtc_vp8_dir "")

# Adds video support to dependencies shared by voice and video engine.
# This should normally be enabled; the intended use is to disable only
# when building voice engine exclusively.
set (enable_video 1)

# Selects fixed-point code where possible.
set (prefer_fixed_point  0)

# Enable data logging. Produces text files with data logged within engines
# which can be easily parsed for offline processing.
set (enable_data_logging 0)

# Enables the use of protocol buffers for debug recordings.
set (enable_protobuf  1)

# Disable these to not build components which can be externally provided.
set (build_libjpeg  1)
set (build_libyuv 1)
set (build_libvpx  1)
set (libyuv_dir "../..//third_party/libyuv")

# 是否包含单元测试程序项目
set (include_tests 1)
set (include_opus 1)

set (include_pulse_audio 1)
set (include_internal_audio_device 1)
set (include_internal_video_capture 1)
set (include_internal_video_render 1)
set (include_internal_audio_device 1)

###################################################
#  list functions from  curl/CMake/Utilities.cmake
###################################################

# File containing various utilities

# Converts a CMake list to a string containing elements separated by spaces
function(TO_LIST_SPACES _LIST_NAME OUTPUT_VAR)
  set(NEW_LIST_SPACE)
  foreach(ITEM ${${_LIST_NAME}})
    set(NEW_LIST_SPACE "${NEW_LIST_SPACE} ${ITEM}")
  endforeach()
  string(STRIP ${NEW_LIST_SPACE} NEW_LIST_SPACE)
  set(${OUTPUT_VAR} "${NEW_LIST_SPACE}" PARENT_SCOPE)
endfunction()

# Appends a lis of item to a string which is a space-separated list, if they don't already exist.
function(LIST_SPACES_APPEND_ONCE LIST_NAME)
  string(REPLACE " " ";" _LIST ${${LIST_NAME}})
  list(APPEND _LIST ${ARGN})
  list(REMOVE_DUPLICATES _LIST)
  to_list_spaces(_LIST NEW_LIST_SPACE)
  set(${LIST_NAME} "${NEW_LIST_SPACE}" PARENT_SCOPE)
endfunction()

# Convinience function that does the same as LIST(FIND ...) but with a TRUE/FALSE return value.
# Ex: IN_STR_LIST(MY_LIST "Searched item" WAS_FOUND)
function(IN_STR_LIST LIST_NAME ITEM_SEARCHED RETVAL)
  list(FIND ${LIST_NAME} ${ITEM_SEARCHED} FIND_POS)
  if(${FIND_POS} EQUAL -1)
    set(${RETVAL} FALSE PARENT_SCOPE)
  else()
    set(${RETVAL} TRUE PARENT_SCOPE)
  endif()
endfunction()

#################################################
# functions to extract platform specific source #
#################################################

function (extract_windows_source source_list out_arg)
	set (new_source_list)
	foreach (source_name ${${source_list}})
		if (NOT source_name MATCHES "(mac\\/|_mac\\.|posix\\/|_posix\\.|x11\\/|_x11\\.)")
			#message(STATUS "source_name =${source_name}")
			list(APPEND new_source_list ${source_name})
		endif()
	endforeach()
	set(${out_arg} ${new_source_list} PARENT_SCOPE)
endfunction()

function (extract_linux_source source_list out_arg)
	set (new_source_list)
	foreach (source_name ${${source_list}})
		if (NOT source_name MATCHES "win\\/|_win\\.|mac\\/|mac\\.")
			list(APPEND new_source_list ${source_name})
		endif()
	endforeach()
	set(${out_arg} ${new_source_list} PARENT_SCOPE)
endfunction()

# 把不是该平台的源文件从 source_list 列表里面删除
function (extract_platform_specific_source source_list)
	if (MSVC)
		extract_windows_source(${source_list} new_source_list)
	elseif(UNIX)
		extract_linux_source(${source_list} new_source_list)
	endif()
	set(${source_list} ${new_source_list} PARENT_SCOPE)
endfunction()

# 把符合正则表达式的源文件名从列表中排除出去
function (exclude_regex_matched_source regex source_list)
	set (new_source_list)
	foreach (source_name ${${source_list}})
		if (NOT source_name MATCHES regex)
			list(APPEND new_source_list ${source_name})
		endif()
	endforeach()
	set(${source_list} ${new_source_list} PARENT_SCOPE)
endfunction()


#=========================================================
# Append str to a string property of a target.
# target:      string: target name.
# property:            name of target’s property. e.g: COMPILE_FLAGS, or LINK_FLAGS
# str:         string: string to be appended to the property
macro(my_append_target_property target property str)
	get_target_property(current_property ${target} ${property})
	if(NOT current_property) # property non-existent or empty
		set_target_properties(${target} PROPERTIES ${property} ${str})
	else()
		set_target_properties(${target} PROPERTIES ${property} "${current_property} ${str}")
	endif()
endmacro(my_append_target_property)

# Add/append link flags to a target.
# target: string: target name.
# flags : string: link flags to be appended
macro(target_link_options target flags)
	my_append_target_property(${target} LINK_FLAGS ${flags})
endmacro(target_link_options)
