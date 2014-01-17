include_directories("../interface" spreadsortlib)

set (systerm_wrappers_sources
	../interface/aligned_malloc.h
	../interface/atomic32.h
	../interface/clock.h
	../interface/compile_assert.h
	../interface/condition_variable_wrapper.h
	../interface/cpu_info.h
	../interface/cpu_features_wrapper.h
	../interface/critical_section_wrapper.h
	../interface/data_log.h
	../interface/data_log_c.h
	../interface/data_log_impl.h
	../interface/event_tracer.h
	../interface/event_wrapper.h
	../interface/file_wrapper.h
	../interface/fix_interlocked_exchange_pointer_win.h
	../interface/logging.h
	../interface/ref_count.h
	../interface/rw_lock_wrapper.h
	../interface/scoped_ptr.h
	../interface/scoped_refptr.h
	../interface/sleep.h
	../interface/sort.h
	../interface/static_instance.h
	../interface/stringize_macros.h
	../interface/thread_annotations.h
	../interface/thread_wrapper.h
	../interface/tick_util.h
	../interface/trace.h
	../interface/trace_event.h
	aligned_malloc.cc
	atomic32_mac.cc
	atomic32_posix.cc
	atomic32_win.cc
	clock.cc
	condition_variable.cc
	condition_variable_posix.cc
	condition_variable_posix.h
	condition_variable_event_win.cc
	condition_variable_event_win.h
	condition_variable_native_win.cc
	condition_variable_native_win.h
	cpu_info.cc
	cpu_features.cc
	critical_section.cc
	critical_section_posix.cc
	critical_section_posix.h
	critical_section_win.cc
	critical_section_win.h
	data_log.cc
	data_log_c.cc
	data_log_no_op.cc
	event.cc
	event_posix.cc
	event_posix.h
	event_tracer.cc
	event_win.cc
	event_win.h
	file_impl.cc
	file_impl.h
	logging.cc
	rw_lock.cc
	rw_lock_generic.cc
	rw_lock_generic.h
	rw_lock_posix.cc
	rw_lock_posix.h
	rw_lock_win.cc
	rw_lock_win.h
	set_thread_name_win.h
	sleep.cc
	sort.cc
	tick_util.cc
	thread.cc
	thread_posix.cc
	thread_posix.h
	thread_win.cc
	thread_win.h
	trace_impl.cc
	trace_impl.h
	trace_posix.cc
	trace_posix.h
	trace_win.cc
	trace_win.h)


if (${CMAKE_SYSTEM_NAME} MATCHES  "Android")
	list(APPEND systerm_wrappers_sources "../interface/logcat_trace_context.h")
	list(APPEND systerm_wrappers_sources "logcat_trace_context.cc")
endif()

extract_platform_specific_source(systerm_wrappers_sources)
#message(STATUS "systerm_wrappers_sources =${systerm_wrappers_sources}")

add_library(system_wrappers STATIC ${systerm_wrappers_sources})

if(MSVC)
	target_link_libraries(system_wrappers winmm.lib)
elseif(UNIX)
	add_definitions(-DWEBRTC_THREAD_RR)
	target_link_libraries(system_wrappers rt)
endif()


