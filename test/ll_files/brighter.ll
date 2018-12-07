; ModuleID = 'brighter'
source_filename = "/Users/dillon/CppWorkspace/Halide/src/runtime/posix_allocator.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx"

%struct.mach_timebase_info = type { i32, i32 }
%"struct.Halide::Runtime::Internal::work_queue_t" = type { %struct.halide_mutex, i32, i32, %"struct.Halide::Runtime::Internal::work"*, i32, i32, %struct.halide_mutex, %struct.halide_mutex, %struct.halide_mutex, [256 x %struct.halide_thread*], i32, i8, i8 }
%"struct.Halide::Runtime::Internal::work" = type { %"struct.Halide::Runtime::Internal::work"*, i32 (i8*, i32, i8*)*, i8*, i32, i32, i8*, i32, i32 }
%struct.halide_mutex = type { [1 x i64] }
%struct.halide_thread = type opaque
%"class.Halide::Runtime::Internal::TraceBuffer" = type { %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock", i32, i32, [1048576 x i8] }
%"class.Halide::Runtime::Internal::SharedExclusiveSpinLock" = type { i32 }
%struct.halide_trace_event_t = type <{ i8*, i8*, i32*, i8*, %struct.halide_type_t, i32, i32, i32, i32, [4 x i8] }>
%struct.halide_type_t = type { i8, i8, i16 }
%"struct.Halide::Runtime::Internal::CacheEntry" = type { %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"*, i8*, i64, i8*, i32, i32, i32, i32, %struct.halide_dimension_t*, %struct.halide_buffer_t* }
%struct.halide_dimension_t = type { i32, i32, i32, i32 }
%struct.halide_buffer_t = type { i64, %struct.halide_device_interface_t*, i8*, i64, %struct.halide_type_t, i32, %struct.halide_dimension_t*, i8* }
%struct.halide_device_interface_t = type { i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, void (i8*, %struct.halide_device_interface_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, i32, i32, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, i64, %struct.halide_device_interface_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, %struct.halide_device_interface_impl_t* }
%struct.halide_device_interface_impl_t = type { void ()*, void ()*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, i32, i32, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, i64)*, i32 (i8*, %struct.halide_buffer_t*)* }
%struct.halide_profiler_state = type { %struct.halide_mutex, i32, i32, i32, i32, %struct.halide_profiler_pipeline_stats*, void (i32*, i32*)*, %struct.halide_thread* }
%struct.halide_profiler_pipeline_stats = type { i64, i64, i64, i64, i64, i64, i8*, %struct.halide_profiler_func_stats*, i8*, i32, i32, i32, i32, i32, [4 x i8] }
%struct.halide_profiler_func_stats = type { i64, i64, i64, i64, i64, i64, i64, i8*, i32, [4 x i8] }
%"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control" = type { %"struct.Halide::Runtime::Internal::Synchronization::parking_control", i64* }
%"struct.Halide::Runtime::Internal::Synchronization::parking_control" = type { i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)*, void (i8*)*, i64 (i8*, i32, i1)*, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* }
%"struct.Halide::Runtime::Internal::Synchronization::validate_action" = type { i8, [7 x i8], i64 }
%"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control" = type { %"struct.Halide::Runtime::Internal::Synchronization::parking_control", i64*, %"class.Halide::Runtime::Internal::Synchronization::word_lock"* }
%"class.Halide::Runtime::Internal::Synchronization::word_lock" = type { i64 }
%"struct.Halide::Runtime::Internal::Synchronization::hash_bucket" = type { %"class.Halide::Runtime::Internal::Synchronization::word_lock", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* }
%"struct.Halide::Runtime::Internal::Synchronization::queue_data" = type { %"struct.Halide::Runtime::Internal::Synchronization::thread_parker", i64, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, i64 }
%"struct.Halide::Runtime::Internal::Synchronization::thread_parker" = type <{ %struct.pthread_mutex_t, %struct.pthread_mutex_t, i8, [7 x i8] }>
%struct.pthread_mutex_t = type { [8 x i64] }
%"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data" = type { %"struct.Halide::Runtime::Internal::Synchronization::thread_parker", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* }
%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair" = type { %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* }
%"struct.Halide::Runtime::Internal::spawned_thread" = type { void (i8*)*, i8*, i64 }
%"struct.Halide::Runtime::Internal::halide_tiff_header" = type <{ i16, i16, i32, i16, [15 x %"struct.Halide::Runtime::Internal::tiff_tag"], i32, [2 x i32], [2 x i32] }>
%"struct.Halide::Runtime::Internal::tiff_tag" = type { i16, i16, i32, %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock" }
%"struct.Halide::Runtime::Internal::CacheBlockHeader" = type { %"struct.Halide::Runtime::Internal::CacheEntry"*, i32, [4 x i8] }
%"struct.Halide::Runtime::Internal::device_copy" = type { i64, i64, i64, [16 x i64], [16 x i64], [16 x i64], i64 }
%struct.halide_filter_metadata_t = type { i32, i32, %struct.halide_filter_argument_t*, i8*, i8* }
%struct.halide_filter_argument_t = type { i8*, i32, i32, %struct.halide_type_t, %struct.halide_scalar_value_t*, %struct.halide_scalar_value_t*, %struct.halide_scalar_value_t* }
%struct.halide_scalar_value_t = type { %union.anon.25 }
%union.anon.25 = type { double }
%struct.buffer_t = type { i64, i8*, [4 x i32], [4 x i32], [4 x i32], i32, i8, i8, [2 x i8] }
%"struct.Halide::Runtime::Internal::old_dev_wrapper" = type { i64, %struct.halide_device_interface_t* }
%"struct.Halide::Runtime::Internal::CpuFeatures" = type { [1 x i64], [1 x i64] }

$call_destructor = comdat any

@_ZN6Halide7Runtime8Internal13custom_mallocE = linkonce local_unnamed_addr global i8* (i8*, i64)* @halide_default_malloc, align 8
@_ZN6Halide7Runtime8Internal11custom_freeE = linkonce local_unnamed_addr global void (i8*, i8*)* @halide_default_free, align 8
@_ZN6Halide7Runtime8Internal13error_handlerE = linkonce local_unnamed_addr global void (i8*, i8*)* @halide_default_error, align 8
@.str = private unnamed_addr constant [8 x i8] c"Error: \00", align 1
@_ZN6Halide7Runtime8Internal12custom_printE = linkonce local_unnamed_addr global void (i8*, i8*)* @halide_default_print, align 8
@_ZN6Halide7Runtime8Internal29halide_reference_clock_initedE = linkonce local_unnamed_addr global i8 0, align 1
@_ZN6Halide7Runtime8Internal22halide_reference_clockE = linkonce local_unnamed_addr global i64 0, align 8
@_ZN6Halide7Runtime8Internal20halide_timebase_infoE = linkonce global %struct.mach_timebase_info zeroinitializer, align 4
@.str.5 = private unnamed_addr constant [6 x i8] c"/tmp/\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"XXXXXX\00", align 1
@_ZN6Halide7Runtime8Internal15Synchronization13table_storageE = linkonce global [24576 x i8] zeroinitializer, align 1
@_ZN6Halide7Runtime8Internal10work_queueE = linkonce global %"struct.Halide::Runtime::Internal::work_queue_t" zeroinitializer, align 8
@_ZN6Halide7Runtime8Internal14custom_do_taskE = linkonce local_unnamed_addr global i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)* @halide_default_do_task, align 8
@_ZN6Halide7Runtime8Internal17custom_do_par_forE = linkonce local_unnamed_addr global i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)* @halide_default_do_par_for, align 8
@.str.5.6 = private unnamed_addr constant [162 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/thread_pool_common.h:71 Assert failed: bytes == limit && \22Logic error in thread pool work queue initialization.\5Cn\22\0A\00", align 1
@.str.4 = private unnamed_addr constant [102 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/synchronization_common.h:1070 Assert failed: val & 0x1\0A\00", align 1
@.str.7 = private unnamed_addr constant [15 x i8] c"HL_NUM_THREADS\00", align 1
@.str.1.8 = private unnamed_addr constant [14 x i8] c"HL_NUMTHREADS\00", align 1
@llvm.global_dtors = appending global [4 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @halide_thread_pool_cleanup, i8* null }, { i32, void ()*, i8* } { i32 65535, void ()* @halide_trace_cleanup, i8* null }, { i32, void ()*, i8* } { i32 65535, void ()* @halide_cache_cleanup, i8* null }, { i32, void ()*, i8* } { i32 65535, void ()* @halide_profiler_shutdown, i8* null }]
@.str.2 = private unnamed_addr constant [38 x i8] c"halide_set_num_threads: must be >= 0.\00", align 1
@_ZN6Halide7Runtime8Internal17custom_get_symbolE = linkonce local_unnamed_addr global i8* (i8*)* @halide_default_get_symbol, align 8
@_ZN6Halide7Runtime8Internal19custom_load_libraryE = linkonce local_unnamed_addr global i8* (i8*)* @halide_default_load_library, align 8
@_ZN6Halide7Runtime8Internal25custom_get_library_symbolE = linkonce local_unnamed_addr global i8* (i8*, i8*)* @halide_default_get_library_symbol, align 8
@_ZN6Halide7Runtime8Internal17halide_gpu_deviceE = linkonce local_unnamed_addr global i32 0, align 4
@_ZN6Halide7Runtime8Internal22halide_gpu_device_lockE = linkonce global i32 0, align 4
@_ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE = linkonce local_unnamed_addr global i8 0, align 1
@.str.9 = private unnamed_addr constant [14 x i8] c"HL_GPU_DEVICE\00", align 1
@_ZN6Halide7Runtime8Internal19halide_trace_bufferE = linkonce local_unnamed_addr global %"class.Halide::Runtime::Internal::TraceBuffer"* null, align 8
@_ZN6Halide7Runtime8Internal17halide_trace_fileE = linkonce local_unnamed_addr global i32 -1, align 4
@_ZN6Halide7Runtime8Internal22halide_trace_file_lockE = linkonce global i32 0, align 4
@_ZN6Halide7Runtime8Internal29halide_trace_file_initializedE = linkonce local_unnamed_addr global i8 0, align 1
@_ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE = linkonce local_unnamed_addr global i8* null, align 8
@_ZN6Halide7Runtime8Internal19halide_custom_traceE = linkonce local_unnamed_addr global i32 (i8*, %struct.halide_trace_event_t*)* @halide_default_trace, align 8
@_ZZ20halide_default_traceE3ids = internal global i32 1, align 4
@.str.32 = private unnamed_addr constant [121 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/tracing.cpp:111 Assert failed: success && \22Could not write to trace file\22\0A\00", align 1
@.str.31 = private unnamed_addr constant [97 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/tracing.cpp:82 Assert failed: size <= buffer_size\0A\00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.33 = private unnamed_addr constant [35 x i8] c"Printer buffer allocation failed.\0A\00", align 1
@.str.1.11 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.2.12 = private unnamed_addr constant [117 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/tracing.cpp:205 Assert failed: print_bits <= 64 && \22Tracing bad type\22\0A\00", align 1
@_ZZ20halide_default_traceE11event_types = private unnamed_addr constant [11 x i8*] [i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4.13, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.5.14, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.7.15, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.8, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.9.16, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.10.17, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.11, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.12, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.13, i32 0, i32 0)], align 8
@.str.14 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.34 = private unnamed_addr constant [7 x i8] c"<NULL>\00", align 1
@.str.15 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.16 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@.str.17 = private unnamed_addr constant [2 x i8] c"<\00", align 1
@.str.20 = private unnamed_addr constant [3 x i8] c">)\00", align 1
@.str.21 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.19 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.18 = private unnamed_addr constant [5 x i8] c">, <\00", align 1
@.str.22 = private unnamed_addr constant [5 x i8] c" = <\00", align 1
@.str.23 = private unnamed_addr constant [4 x i8] c" = \00", align 1
@.str.24 = private unnamed_addr constant [119 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/tracing.cpp:274 Assert failed: print_bits >= 16 && \22Tracing a bad type\22\0A\00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c">\00", align 1
@.str.26 = private unnamed_addr constant [9 x i8] c" tag = \22\00", align 1
@.str.27 = private unnamed_addr constant [2 x i8] c"\22\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"Load\00", align 1
@.str.4.13 = private unnamed_addr constant [6 x i8] c"Store\00", align 1
@.str.5.14 = private unnamed_addr constant [18 x i8] c"Begin realization\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"End realization\00", align 1
@.str.7.15 = private unnamed_addr constant [8 x i8] c"Produce\00", align 1
@.str.8 = private unnamed_addr constant [12 x i8] c"End produce\00", align 1
@.str.9.16 = private unnamed_addr constant [8 x i8] c"Consume\00", align 1
@.str.10.17 = private unnamed_addr constant [12 x i8] c"End consume\00", align 1
@.str.11 = private unnamed_addr constant [15 x i8] c"Begin pipeline\00", align 1
@.str.12 = private unnamed_addr constant [13 x i8] c"End pipeline\00", align 1
@.str.13 = private unnamed_addr constant [4 x i8] c"Tag\00", align 1
@.str.28 = private unnamed_addr constant [14 x i8] c"HL_TRACE_FILE\00", align 1
@.str.29 = private unnamed_addr constant [3 x i8] c"ab\00", align 1
@.str.30 = private unnamed_addr constant [116 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/tracing.cpp:335 Assert failed: file && \22Failed to open trace file\5Cn\22\0A\00", align 1
@_ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE = linkonce local_unnamed_addr global [10 x i16] [i16 3, i16 3, i16 1, i16 2, i16 1, i16 2, i16 1, i16 2, i16 1, i16 2], align 2
@_ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE = linkonce local_unnamed_addr global [10 x i8] c"\07\06\09\08\0B\0A\0D\0C\0F\0E", align 1
@_ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE = linkonce local_unnamed_addr global [10 x i8] c"\07\09\02\01\04\03\06\05\0D\0C", align 1
@.str.35 = private unnamed_addr constant [59 x i8] c"Can't debug_to_file a Func with more than four dimensions\0A\00", align 1
@.str.1.36 = private unnamed_addr constant [3 x i8] c"wb\00", align 1
@.str.2.37 = private unnamed_addr constant [6 x i8] c".tiff\00", align 1
@.str.3.38 = private unnamed_addr constant [5 x i8] c".tif\00", align 1
@.str.4.39 = private unnamed_addr constant [5 x i8] c".mat\00", align 1
@_ZZ20halide_debug_to_fileE6header = private unnamed_addr constant [129 x i8] c"MATLAB 5.0 MAT-file, produced by Halide                                                                                     \00\01IM\00", align 1
@.str.5.40 = private unnamed_addr constant [53 x i8] c"Can't debug_to_file to a .mat file greater than 4GB\0A\00", align 1
@.str.6.41 = private unnamed_addr constant [39 x i8] c"Unexpectedly large final_padding_bytes\00", align 1
@_ZN6Halide7Runtime8Internal16memoization_lockE = linkonce global %struct.halide_mutex zeroinitializer, align 8
@_ZN6Halide7Runtime8Internal13cache_entriesE = linkonce local_unnamed_addr global [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*] zeroinitializer, align 8
@_ZN6Halide7Runtime8Internal18most_recently_usedE = linkonce local_unnamed_addr global %"struct.Halide::Runtime::Internal::CacheEntry"* null, align 8
@_ZN6Halide7Runtime8Internal19least_recently_usedE = linkonce local_unnamed_addr global %"struct.Halide::Runtime::Internal::CacheEntry"* null, align 8
@_ZN6Halide7Runtime8Internal14max_cache_sizeE = linkonce local_unnamed_addr global i64 1048576, align 8
@_ZN6Halide7Runtime8Internal18current_cache_sizeE = linkonce local_unnamed_addr global i64 0, align 8
@.str.4.43 = private unnamed_addr constant [100 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/cache.cpp:273 Assert failed: prev_hash_entry != NULL\0A\00", align 1
@.str.5.44 = private unnamed_addr constant [103 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/cache.cpp:360 Assert failed: entry->more_recent != NULL\0A\00", align 1
@.str.6.45 = private unnamed_addr constant [105 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/cache.cpp:364 Assert failed: least_recently_used == entry\0A\00", align 1
@.str.7.46 = private unnamed_addr constant [103 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/cache.cpp:367 Assert failed: entry->more_recent != NULL\0A\00", align 1
@.str.9.47 = private unnamed_addr constant [99 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/cache.cpp:458 Assert failed: no_host_pointers_equal\0A\00", align 1
@.str.12.48 = private unnamed_addr constant [100 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/cache.cpp:536 Assert failed: entry->in_use_count > 0\0A\00", align 1
@.str.57 = private unnamed_addr constant [5 x i8] c"-nan\00", align 1
@.str.1.58 = private unnamed_addr constant [4 x i8] c"nan\00", align 1
@.str.2.59 = private unnamed_addr constant [5 x i8] c"-inf\00", align 1
@.str.3.60 = private unnamed_addr constant [4 x i8] c"inf\00", align 1
@.str.4.61 = private unnamed_addr constant [14 x i8] c"-0.000000e+00\00", align 1
@.str.5.62 = private unnamed_addr constant [13 x i8] c"0.000000e+00\00", align 1
@.str.6.63 = private unnamed_addr constant [10 x i8] c"-0.000000\00", align 1
@.str.7.64 = private unnamed_addr constant [9 x i8] c"0.000000\00", align 1
@.str.8.65 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.9.66 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.10.67 = private unnamed_addr constant [3 x i8] c"e+\00", align 1
@.str.11.68 = private unnamed_addr constant [3 x i8] c"e-\00", align 1
@.str.12.71 = private unnamed_addr constant [17 x i8] c"0123456789abcdef\00", align 1
@.str.17.72 = private unnamed_addr constant [14 x i8] c"bad_type_code\00", align 1
@.str.16.73 = private unnamed_addr constant [7 x i8] c"handle\00", align 1
@.str.15.74 = private unnamed_addr constant [6 x i8] c"float\00", align 1
@.str.14.75 = private unnamed_addr constant [5 x i8] c"uint\00", align 1
@.str.13.76 = private unnamed_addr constant [4 x i8] c"int\00", align 1
@.str.18.77 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.19.78 = private unnamed_addr constant [5 x i8] c"NULL\00", align 1
@.str.20.79 = private unnamed_addr constant [8 x i8] c"buffer(\00", align 1
@.str.21.80 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.24.81 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.22.82 = private unnamed_addr constant [4 x i8] c", {\00", align 1
@.str.23.83 = private unnamed_addr constant [2 x i8] c"}\00", align 1
@_ZN6Halide7Runtime8Internal17device_copy_mutexE = linkonce global %struct.halide_mutex zeroinitializer, align 8
@.str.9.88 = private unnamed_addr constant [20 x i8] c"halide_copy_to_host\00", align 1
@.str.10.89 = private unnamed_addr constant [22 x i8] c"halide_copy_to_device\00", align 1
@.str.12.90 = private unnamed_addr constant [61 x i8] c"halide_copy_to_device does not support switching interfaces\0A\00", align 1
@.str.18.91 = private unnamed_addr constant [21 x i8] c"halide_device_malloc\00", align 1
@.str.20.92 = private unnamed_addr constant [59 x i8] c"halide_device_malloc doesn't support switching interfaces\0A\00", align 1
@.str.17.93 = private unnamed_addr constant [19 x i8] c"halide_device_sync\00", align 1
@.str.21.96 = private unnamed_addr constant [19 x i8] c"halide_device_free\00", align 1
@.str.22.97 = private unnamed_addr constant [104 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/device_interface.cpp:247 Assert failed: buf->device == 0\0A\00", align 1
@.str.23.98 = private unnamed_addr constant [30 x i8] c"halide_device_and_host_malloc\00", align 1
@.str.25.99 = private unnamed_addr constant [68 x i8] c"halide_device_and_host_malloc doesn't support switching interfaces\0A\00", align 1
@.str.26.100 = private unnamed_addr constant [42 x i8] c"allocating host and device memory failed\0A\00", align 1
@.str.27.101 = private unnamed_addr constant [28 x i8] c"halide_device_and_host_free\00", align 1
@.str.28.102 = private unnamed_addr constant [104 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/device_interface.cpp:312 Assert failed: buf->device == 0\0A\00", align 1
@.str.29.103 = private unnamed_addr constant [38 x i8] c"halide_default_device_and_host_malloc\00", align 1
@.str.30.104 = private unnamed_addr constant [36 x i8] c"halide_default_device_and_host_free\00", align 1
@.str.31.105 = private unnamed_addr constant [26 x i8] c"halide_device_wrap_native\00", align 1
@.str.32.106 = private unnamed_addr constant [64 x i8] c"halide_device_wrap_native doesn't support switching interfaces\0A\00", align 1
@.str.33.107 = private unnamed_addr constant [28 x i8] c"halide_device_detach_native\00", align 1
@.str.34.108 = private unnamed_addr constant [104 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/device_interface.cpp:399 Assert failed: buf->device == 0\0A\00", align 1
@.str.35.109 = private unnamed_addr constant [34 x i8] c"halide_default_device_wrap_native\00", align 1
@.str.36 = private unnamed_addr constant [36 x i8] c"halide_default_device_detach_native\00", align 1
@.str.48 = private unnamed_addr constant [64 x i8] c"halide_buffer_copy does not support switching device interfaces\00", align 1
@.str.49 = private unnamed_addr constant [44 x i8] c"device_interface does not support cropping\0A\00", align 1
@.str.50 = private unnamed_addr constant [43 x i8] c"device_interface does not support slicing\0A\00", align 1
@.str.51 = private unnamed_addr constant [52 x i8] c"destination buffer already has a device allocation\0A\00", align 1
@.str.52 = private unnamed_addr constant [48 x i8] c"src and dst must have identical dimensionality\0A\00", align 1
@.str.55 = private unnamed_addr constant [52 x i8] c"dst must have exactly one fewer dimension than src\0A\00", align 1
@.str.112 = private unnamed_addr constant [41 x i8] c"Bounds inference call to external stage \00", align 1
@.str.74 = private unnamed_addr constant [7 x i8] c"<NULL>\00", align 1
@.str.1.113 = private unnamed_addr constant [27 x i8] c" returned non-zero value: \00", align 1
@.str.73 = private unnamed_addr constant [35 x i8] c"Printer buffer allocation failed.\0A\00", align 1
@.str.2.114 = private unnamed_addr constant [24 x i8] c"Call to external stage \00", align 1
@.str.3.115 = private unnamed_addr constant [18 x i8] c"Bounds given for \00", align 1
@.str.4.116 = private unnamed_addr constant [5 x i8] c" in \00", align 1
@.str.5.117 = private unnamed_addr constant [8 x i8] c" (from \00", align 1
@.str.6.118 = private unnamed_addr constant [5 x i8] c" to \00", align 1
@.str.7.119 = private unnamed_addr constant [38 x i8] c") do not cover required region (from \00", align 1
@.str.8.120 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.9.121 = private unnamed_addr constant [11 x i8] c" has type \00", align 1
@.str.10.122 = private unnamed_addr constant [38 x i8] c" but type of the buffer passed in is \00", align 1
@.str.11.123 = private unnamed_addr constant [31 x i8] c" requires a buffer of exactly \00", align 1
@.str.12.124 = private unnamed_addr constant [43 x i8] c" dimensions, but the buffer passed in has \00", align 1
@.str.13.125 = private unnamed_addr constant [12 x i8] c" dimensions\00", align 1
@.str.14.126 = private unnamed_addr constant [17 x i8] c" is accessed at \00", align 1
@.str.15.127 = private unnamed_addr constant [28 x i8] c", which is before the min (\00", align 1
@.str.16.128 = private unnamed_addr constant [16 x i8] c") in dimension \00", align 1
@.str.17.129 = private unnamed_addr constant [28 x i8] c", which is beyond the max (\00", align 1
@.str.18.130 = private unnamed_addr constant [29 x i8] c"Total allocation for buffer \00", align 1
@.str.19.131 = private unnamed_addr constant [5 x i8] c" is \00", align 1
@.str.20.132 = private unnamed_addr constant [37 x i8] c", which exceeds the maximum size of \00", align 1
@.str.21.133 = private unnamed_addr constant [24 x i8] c"The extents for buffer \00", align 1
@.str.22.134 = private unnamed_addr constant [12 x i8] c" dimension \00", align 1
@.str.23.135 = private unnamed_addr constant [15 x i8] c" is negative (\00", align 1
@.str.24.136 = private unnamed_addr constant [31 x i8] c"Product of extents for buffer \00", align 1
@.str.25.137 = private unnamed_addr constant [29 x i8] c"Applying the constraints on \00", align 1
@.str.26.138 = private unnamed_addr constant [42 x i8] c" to the required region made it smaller. \00", align 1
@.str.27.139 = private unnamed_addr constant [16 x i8] c"Required size: \00", align 1
@.str.28.140 = private unnamed_addr constant [3 x i8] c". \00", align 1
@.str.29.141 = private unnamed_addr constant [19 x i8] c"Constrained size: \00", align 1
@.str.30.142 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.31.143 = private unnamed_addr constant [22 x i8] c"Constraint violated: \00", align 1
@.str.32.144 = private unnamed_addr constant [3 x i8] c" (\00", align 1
@.str.33.145 = private unnamed_addr constant [6 x i8] c") == \00", align 1
@.str.34.146 = private unnamed_addr constant [11 x i8] c"Parameter \00", align 1
@.str.35.147 = private unnamed_addr constant [23 x i8] c" but must be at least \00", align 1
@.str.36.148 = private unnamed_addr constant [22 x i8] c" but must be at most \00", align 1
@.str.37 = private unnamed_addr constant [44 x i8] c"Out of memory (halide_malloc returned NULL)\00", align 1
@.str.38 = private unnamed_addr constant [17 x i8] c"Buffer argument \00", align 1
@.str.39 = private unnamed_addr constant [9 x i8] c" is NULL\00", align 1
@.str.40 = private unnamed_addr constant [25 x i8] c"Failed to dump function \00", align 1
@.str.41 = private unnamed_addr constant [10 x i8] c" to file \00", align 1
@.str.42 = private unnamed_addr constant [13 x i8] c" with error \00", align 1
@.str.43 = private unnamed_addr constant [51 x i8] c"Failed to upgrade buffer_t to halide_buffer_t for \00", align 1
@.str.44 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.45 = private unnamed_addr constant [53 x i8] c"Failed to downgrade halide_buffer_t to buffer_t for \00", align 1
@.str.46 = private unnamed_addr constant [21 x i8] c"The host pointer of \00", align 1
@.str.47 = private unnamed_addr constant [22 x i8] c" is not aligned to a \00", align 1
@.str.48.149 = private unnamed_addr constant [17 x i8] c" bytes boundary.\00", align 1
@.str.49.150 = private unnamed_addr constant [55 x i8] c" is null, but the pipeline will access it on the host.\00", align 1
@.str.50.151 = private unnamed_addr constant [30 x i8] c"The folded storage dimension \00", align 1
@.str.51.152 = private unnamed_addr constant [5 x i8] c" of \00", align 1
@.str.52.153 = private unnamed_addr constant [36 x i8] c" was accessed out of order by loop \00", align 1
@.str.53 = private unnamed_addr constant [23 x i8] c"Cannot fold dimension \00", align 1
@.str.54 = private unnamed_addr constant [36 x i8] c" because an extern stage accesses [\00", align 1
@.str.55.154 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.56 = private unnamed_addr constant [3 x i8] c"],\00", align 1
@.str.57.155 = private unnamed_addr constant [47 x i8] c" which is outside the range currently valid: [\00", align 1
@.str.58 = private unnamed_addr constant [3 x i8] c"].\00", align 1
@.str.59 = private unnamed_addr constant [47 x i8] c" which wraps around the boundary of the fold, \00", align 1
@.str.60 = private unnamed_addr constant [30 x i8] c"which occurs at multiples of \00", align 1
@.str.61 = private unnamed_addr constant [18 x i8] c"The fold factor (\00", align 1
@.str.62 = private unnamed_addr constant [16 x i8] c") of dimension \00", align 1
@.str.63 = private unnamed_addr constant [61 x i8] c" is too small to store the required region accessed by loop \00", align 1
@.str.64 = private unnamed_addr constant [3 x i8] c").\00", align 1
@.str.65 = private unnamed_addr constant [22 x i8] c"Requirement Failed: (\00", align 1
@.str.66 = private unnamed_addr constant [3 x i8] c") \00", align 1
@.str.67 = private unnamed_addr constant [59 x i8] c"A schedule specialized with specialize_fail() was chosen: \00", align 1
@.str.68 = private unnamed_addr constant [55 x i8] c"Buffer has a non-zero device but no device interface.\0A\00", align 1
@.str.69 = private unnamed_addr constant [56 x i8] c"Buffer has a non-null devie_interface but device is 0.\0A\00", align 1
@.str.70 = private unnamed_addr constant [49 x i8] c"Buffer has both host and device dirty bits set.\0A\00", align 1
@.str.71 = private unnamed_addr constant [26 x i8] c"Buffer pointer passed to \00", align 1
@.str.72 = private unnamed_addr constant [11 x i8] c" is null.\0A\00", align 1
@.str.164 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.1.165 = private unnamed_addr constant [44 x i8] c"elem_size of buffer was not in [1, 2, 4, 8]\00", align 1
@.str.2.166 = private unnamed_addr constant [33 x i8] c"buffer has incorrect elem_size (\00", align 1
@.str.3.167 = private unnamed_addr constant [3 x i8] c") \00", align 1
@.str.4.168 = private unnamed_addr constant [20 x i8] c"for expected type (\00", align 1
@.str.5.169 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.8.170 = private unnamed_addr constant [35 x i8] c"Printer buffer allocation failed.\0A\00", align 1
@.str.6.171 = private unnamed_addr constant [65 x i8] c"Internal error: buffer host mismatch in halide_upgrade_buffer_t.\00", align 1
@.str.7.172 = private unnamed_addr constant [37 x i8] c"buffer has more than four dimensions\00", align 1
@.str.30.174 = private unnamed_addr constant [7 x i8] c"<NULL>\00", align 1
@.str.7.175 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.8.176 = private unnamed_addr constant [14 x i8] c" total time: \00", align 1
@.str.9.177 = private unnamed_addr constant [4 x i8] c" ms\00", align 1
@.str.10.178 = private unnamed_addr constant [12 x i8] c"  samples: \00", align 1
@.str.11.179 = private unnamed_addr constant [9 x i8] c"  runs: \00", align 1
@.str.12.180 = private unnamed_addr constant [13 x i8] c"  time/run: \00", align 1
@.str.13.181 = private unnamed_addr constant [5 x i8] c" ms\0A\00", align 1
@.str.14.182 = private unnamed_addr constant [24 x i8] c" average threads used: \00", align 1
@.str.15.183 = private unnamed_addr constant [20 x i8] c" heap allocations: \00", align 1
@.str.16.184 = private unnamed_addr constant [20 x i8] c"  peak heap usage: \00", align 1
@.str.17.185 = private unnamed_addr constant [8 x i8] c" bytes\0A\00", align 1
@.str.18.186 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.19.187 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str.20.188 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.21.189 = private unnamed_addr constant [3 x i8] c"ms\00", align 1
@.str.22.190 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@.str.23.191 = private unnamed_addr constant [3 x i8] c"%)\00", align 1
@.str.24.192 = private unnamed_addr constant [10 x i8] c"threads: \00", align 1
@.str.25.193 = private unnamed_addr constant [8 x i8] c" peak: \00", align 1
@.str.26.194 = private unnamed_addr constant [7 x i8] c" num: \00", align 1
@.str.27.195 = private unnamed_addr constant [7 x i8] c" avg: \00", align 1
@.str.28.196 = private unnamed_addr constant [9 x i8] c" stack: \00", align 1
@_ZZ25halide_profiler_get_stateE1s = internal global %struct.halide_profiler_state { %struct.halide_mutex zeroinitializer, i32 1, i32 0, i32 0, i32 0, %struct.halide_profiler_pipeline_stats* null, void (i32*, i32*)* null, %struct.halide_thread* null }, align 8
@.str.197 = private unnamed_addr constant [95 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:201 Assert failed: p_stats != NULL\0A\00", align 1
@.str.1.198 = private unnamed_addr constant [95 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:228 Assert failed: p_stats != NULL\0A\00", align 1
@.str.2.199 = private unnamed_addr constant [92 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:229 Assert failed: func_id >= 0\0A\00", align 1
@.str.3.200 = private unnamed_addr constant [108 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:230 Assert failed: func_id < p_stats->num_funcs\0A\00", align 1
@.str.4.201 = private unnamed_addr constant [95 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:264 Assert failed: p_stats != NULL\0A\00", align 1
@.str.5.202 = private unnamed_addr constant [92 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:265 Assert failed: func_id >= 0\0A\00", align 1
@.str.6.203 = private unnamed_addr constant [108 x i8] c"/Users/dillon/CppWorkspace/Halide/src/runtime/profiler.cpp:266 Assert failed: func_id < p_stats->num_funcs\0A\00", align 1
@_ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE = linkonce local_unnamed_addr global i32 (i32, i64*)* @halide_default_can_use_target_features, align 8
@_ZZ38halide_default_can_use_target_featuresE11initialized = internal unnamed_addr global i1 false, align 1
@_ZZ38halide_default_can_use_target_featuresE20cpu_features_storage = internal global [2 x i64] zeroinitializer, align 8
@.str.208 = private unnamed_addr constant [81 x i8] c"Internal error: wrong structure size passed to halide_can_use_target_features()\0A\00", align 1

; Function Attrs: nounwind
define weak i8* @halide_default_malloc(i8*, i64) #0 {
  %3 = tail call i32 @_ZN6Halide7Runtime8Internal23halide_malloc_alignmentEv() #13
  %4 = sext i32 %3 to i64
  %5 = add i64 %4, %1
  %6 = tail call i8* @malloc(i64 %5) #13
  %7 = icmp eq i8* %6, null
  br i1 %7, label %17, label %8

; <label>:8:                                      ; preds = %2
  %9 = ptrtoint i8* %6 to i64
  %10 = add nsw i64 %4, 7
  %11 = add i64 %10, %9
  %12 = sub nsw i64 0, %4
  %13 = and i64 %11, %12
  %14 = inttoptr i64 %13 to i8*
  %15 = inttoptr i64 %13 to i8**
  %16 = getelementptr inbounds i8*, i8** %15, i64 -1
  store i8* %6, i8** %16, align 8, !tbaa !3
  br label %17

; <label>:17:                                     ; preds = %8, %2
  %18 = phi i8* [ %14, %8 ], [ null, %2 ]
  ret i8* %18
}

declare i8* @malloc(i64) local_unnamed_addr #1

; Function Attrs: nounwind
define weak void @halide_default_free(i8*, i8*) #0 {
  %3 = getelementptr inbounds i8, i8* %1, i64 -8
  %4 = bitcast i8* %3 to i8**
  %5 = load i8*, i8** %4, align 8, !tbaa !3
  tail call void @free(i8* %5) #13
  ret void
}

declare void @free(i8*) local_unnamed_addr #1

; Function Attrs: norecurse nounwind
define weak i8* (i8*, i64)* @halide_set_custom_malloc(i8* (i8*, i64)*) local_unnamed_addr #2 {
  %2 = load i8* (i8*, i64)*, i8* (i8*, i64)** @_ZN6Halide7Runtime8Internal13custom_mallocE, align 8, !tbaa !3
  store i8* (i8*, i64)* %0, i8* (i8*, i64)** @_ZN6Halide7Runtime8Internal13custom_mallocE, align 8, !tbaa !3
  ret i8* (i8*, i64)* %2
}

; Function Attrs: norecurse nounwind
define weak void (i8*, i8*)* @halide_set_custom_free(void (i8*, i8*)*) local_unnamed_addr #2 {
  %2 = load void (i8*, i8*)*, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal11custom_freeE, align 8, !tbaa !3
  store void (i8*, i8*)* %0, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal11custom_freeE, align 8, !tbaa !3
  ret void (i8*, i8*)* %2
}

; Function Attrs: nounwind
define weak i8* @halide_malloc(i8*, i64) local_unnamed_addr #0 {
  %3 = load i8* (i8*, i64)*, i8* (i8*, i64)** @_ZN6Halide7Runtime8Internal13custom_mallocE, align 8, !tbaa !3
  %4 = tail call i8* %3(i8* %0, i64 %1) #13
  ret i8* %4
}

; Function Attrs: nounwind
define weak void @halide_free(i8*, i8*) local_unnamed_addr #0 {
  %3 = load void (i8*, i8*)*, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal11custom_freeE, align 8, !tbaa !3
  tail call void %3(i8* %0, i8* %1) #13
  ret void
}

; Function Attrs: nounwind
define weak void @halide_default_error(i8*, i8*) #0 {
  %3 = alloca [4096 x i8], align 1
  %4 = getelementptr inbounds [4096 x i8], [4096 x i8]* %3, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 4096, i8* nonnull %4) #14
  %5 = getelementptr inbounds [4096 x i8], [4096 x i8]* %3, i64 0, i64 4094
  %6 = call i8* @halide_string_to_string(i8* nonnull %4, i8* nonnull %5, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0)) #13
  %7 = call i8* @halide_string_to_string(i8* %6, i8* nonnull %5, i8* %1) #13
  %8 = getelementptr inbounds i8, i8* %7, i64 -1
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 10
  br i1 %10, label %13, label %11

; <label>:11:                                     ; preds = %2
  store i8 10, i8* %7, align 1, !tbaa !7
  %12 = getelementptr inbounds i8, i8* %7, i64 1
  store i8 0, i8* %12, align 1, !tbaa !7
  br label %13

; <label>:13:                                     ; preds = %11, %2
  %14 = phi i8* [ %12, %11 ], [ %7, %2 ]
  %15 = ptrtoint i8* %14 to i64
  %16 = ptrtoint [4096 x i8]* %3 to i64
  %17 = sub i64 1, %16
  %18 = add i64 %17, %15
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %18) #13
  call void @halide_print(i8* %0, i8* nonnull %4) #13
  call void @abort() #13
  call void @llvm.lifetime.end.p0i8(i64 4096, i8* nonnull %4) #14
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #3

declare void @abort() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #3

; Function Attrs: nounwind
define weak void @halide_error(i8*, i8*) local_unnamed_addr #0 {
  %3 = load void (i8*, i8*)*, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal13error_handlerE, align 8, !tbaa !3
  tail call void %3(i8* %0, i8* %1) #13
  ret void
}

; Function Attrs: norecurse nounwind
define weak void (i8*, i8*)* @halide_set_error_handler(void (i8*, i8*)*) local_unnamed_addr #2 {
  %2 = load void (i8*, i8*)*, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal13error_handlerE, align 8, !tbaa !3
  store void (i8*, i8*)* %0, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal13error_handlerE, align 8, !tbaa !3
  ret void (i8*, i8*)* %2
}

; Function Attrs: nounwind
define weak void @halide_print(i8*, i8*) local_unnamed_addr #0 {
  %3 = load void (i8*, i8*)*, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal12custom_printE, align 8, !tbaa !3
  tail call void %3(i8* %0, i8* %1) #13
  ret void
}

; Function Attrs: norecurse nounwind
define weak void (i8*, i8*)* @halide_set_custom_print(void (i8*, i8*)*) local_unnamed_addr #2 {
  %2 = load void (i8*, i8*)*, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal12custom_printE, align 8, !tbaa !3
  store void (i8*, i8*)* %0, void (i8*, i8*)** @_ZN6Halide7Runtime8Internal12custom_printE, align 8, !tbaa !3
  ret void (i8*, i8*)* %2
}

; Function Attrs: nounwind
define weak i32 @halide_start_clock(i8*) local_unnamed_addr #0 {
  %2 = load i8, i8* @_ZN6Halide7Runtime8Internal29halide_reference_clock_initedE, align 1, !tbaa !8, !range !10
  %3 = icmp eq i8 %2, 0
  br i1 %3, label %4, label %7

; <label>:4:                                      ; preds = %1
  %5 = tail call i32 @mach_timebase_info(%struct.mach_timebase_info* nonnull @_ZN6Halide7Runtime8Internal20halide_timebase_infoE) #13
  %6 = tail call i64 @mach_absolute_time() #13
  store i64 %6, i64* @_ZN6Halide7Runtime8Internal22halide_reference_clockE, align 8, !tbaa !11
  store i8 1, i8* @_ZN6Halide7Runtime8Internal29halide_reference_clock_initedE, align 1, !tbaa !8
  br label %7

; <label>:7:                                      ; preds = %4, %1
  ret i32 0
}

declare i32 @mach_timebase_info(%struct.mach_timebase_info*) local_unnamed_addr #1

declare i64 @mach_absolute_time() local_unnamed_addr #1

; Function Attrs: nounwind
define weak i64 @halide_current_time_ns(i8*) local_unnamed_addr #0 {
  %2 = tail call i64 @mach_absolute_time() #13
  %3 = load i64, i64* @_ZN6Halide7Runtime8Internal22halide_reference_clockE, align 8, !tbaa !11
  %4 = sub i64 %2, %3
  %5 = load i32, i32* getelementptr inbounds (%struct.mach_timebase_info, %struct.mach_timebase_info* @_ZN6Halide7Runtime8Internal20halide_timebase_infoE, i64 0, i32 0), align 4, !tbaa !13
  %6 = zext i32 %5 to i64
  %7 = mul i64 %4, %6
  %8 = load i32, i32* getelementptr inbounds (%struct.mach_timebase_info, %struct.mach_timebase_info* @_ZN6Halide7Runtime8Internal20halide_timebase_infoE, i64 0, i32 1), align 4, !tbaa !16
  %9 = zext i32 %8 to i64
  %10 = udiv i64 %7, %9
  ret i64 %10
}

; Function Attrs: nounwind
define weak void @halide_sleep_ms(i8*, i32) local_unnamed_addr #0 {
  %3 = mul nsw i32 %1, 1000
  %4 = tail call i32 @usleep(i32 %3) #13
  ret void
}

declare i32 @usleep(i32) local_unnamed_addr #1

; Function Attrs: nounwind
define weak void @halide_default_print(i8*, i8*) #0 {
  %3 = tail call i64 @strlen(i8* %1) #13
  %4 = tail call i64 @write(i32 1, i8* %1, i64 %3) #13
  ret void
}

declare i64 @strlen(i8*) local_unnamed_addr #1

declare i64 @write(i32, i8*, i64) local_unnamed_addr #1

; Function Attrs: nounwind
define weak i32 @halide_create_temp_file(i8*, i8*, i8*, i8*, i64) local_unnamed_addr #0 {
  %6 = icmp ne i8* %1, null
  %7 = icmp ne i8* %2, null
  %8 = and i1 %6, %7
  %9 = icmp ne i8* %3, null
  %10 = and i1 %8, %9
  br i1 %10, label %11, label %34

; <label>:11:                                     ; preds = %5
  %12 = tail call i64 @strlen(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0)) #13
  %13 = tail call i64 @strlen(i8* nonnull %1) #13
  %14 = tail call i64 @strlen(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0)) #13
  %15 = tail call i64 @strlen(i8* nonnull %2) #13
  %16 = add i64 %12, 1
  %17 = add i64 %16, %13
  %18 = add i64 %17, %14
  %19 = add i64 %18, %15
  %20 = icmp ugt i64 %19, %4
  br i1 %20, label %34, label %21

; <label>:21:                                     ; preds = %11
  %22 = getelementptr inbounds i8, i8* %3, i64 %4
  %23 = getelementptr inbounds i8, i8* %22, i64 -1
  %24 = tail call i8* @halide_string_to_string(i8* nonnull %3, i8* nonnull %23, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0)) #13
  %25 = tail call i8* @halide_string_to_string(i8* %24, i8* nonnull %23, i8* nonnull %1) #13
  %26 = tail call i8* @halide_string_to_string(i8* %25, i8* nonnull %23, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0)) #13
  %27 = tail call i8* @halide_string_to_string(i8* %26, i8* nonnull %23, i8* nonnull %2) #13
  store i8 0, i8* %27, align 1, !tbaa !7
  %28 = tail call i64 @strlen(i8* nonnull %2) #13
  %29 = trunc i64 %28 to i32
  %30 = tail call i32 @mkstemps(i8* nonnull %3, i32 %29) #13
  %31 = icmp eq i32 %30, -1
  br i1 %31, label %34, label %32

; <label>:32:                                     ; preds = %21
  %33 = tail call i32 @close(i32 %30) #13
  br label %34

; <label>:34:                                     ; preds = %32, %21, %11, %5
  %35 = phi i32 [ -22, %5 ], [ -22, %11 ], [ 0, %32 ], [ -22, %21 ]
  ret i32 %35
}

declare i32 @mkstemps(i8*, i32) local_unnamed_addr #1

declare i32 @close(i32) local_unnamed_addr #1

; Function Attrs: nounwind
define weak i32 @halide_host_cpu_count() local_unnamed_addr #0 {
  %1 = tail call i64 @sysconf(i32 58) #13
  %2 = trunc i64 %1 to i32
  ret i32 %2
}

declare i64 @sysconf(i32) local_unnamed_addr #1

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal19halide_thread_yieldEv() local_unnamed_addr #0 {
  %1 = tail call i32 @swtch_pri(i32 0) #13
  ret void
}

declare i32 @swtch_pri(i32) local_unnamed_addr #1

; Function Attrs: nounwind
define weak i32 @halide_default_do_task(i8*, i32 (i8*, i32, i8*)*, i32, i8*) #0 {
  %5 = tail call i32 %1(i8* %0, i32 %2, i8* %3) #13
  ret i32 %5
}

; Function Attrs: nounwind
define weak i32 @halide_default_do_par_for(i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*) #0 {
  %6 = alloca %"struct.Halide::Runtime::Internal::work", align 8
  %7 = icmp slt i32 %3, 1
  br i1 %7, label %71, label %8

; <label>:8:                                      ; preds = %5
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %9 = load i8, i8* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 12), align 1, !tbaa !17, !range !10
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %14, label %11

; <label>:11:                                     ; preds = %8
  %12 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 10), align 8, !tbaa !21
  %13 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  br label %33

; <label>:14:                                     ; preds = %18, %8
  %15 = phi i8* [ %19, %18 ], [ bitcast (i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 2) to i8*), %8 ]
  %16 = load i8, i8* %15, align 1, !tbaa !7
  %17 = icmp eq i8 %16, 0
  br i1 %17, label %18, label %21

; <label>:18:                                     ; preds = %14
  %19 = getelementptr inbounds i8, i8* %15, i64 1
  %20 = icmp ult i8* %19, bitcast (%"struct.Halide::Runtime::Internal::work_queue_t"* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 1) to i8*)
  br i1 %20, label %14, label %21

; <label>:21:                                     ; preds = %18, %14
  %22 = phi i8* [ %19, %18 ], [ %15, %14 ]
  %23 = icmp eq i8* %22, bitcast (%"struct.Halide::Runtime::Internal::work_queue_t"* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 1) to i8*)
  br i1 %23, label %25, label %24

; <label>:24:                                     ; preds = %21
  tail call void @halide_print(i8* null, i8* getelementptr inbounds ([162 x i8], [162 x i8]* @.str.5.6, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %25

; <label>:25:                                     ; preds = %24, %21
  %26 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %30

; <label>:28:                                     ; preds = %25
  %29 = tail call i32 @_ZN6Halide7Runtime8Internal27default_desired_num_threadsEv() #15
  store i32 %29, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  br label %30

; <label>:30:                                     ; preds = %28, %25
  %31 = phi i32 [ %26, %25 ], [ %29, %28 ]
  %32 = tail call i32 @_ZN6Halide7Runtime8Internal17clamp_num_threadsEi(i32 %31) #15
  store i32 %32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  store i32 0, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 10), align 8, !tbaa !21
  store i32 %32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 4), align 8, !tbaa !23
  store i8 1, i8* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 12), align 1, !tbaa !17
  br label %33

; <label>:33:                                     ; preds = %30, %11
  %34 = phi i32 [ %13, %11 ], [ %32, %30 ]
  %35 = phi i32 [ %12, %11 ], [ 0, %30 ]
  %36 = add nsw i32 %34, -1
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %47

; <label>:38:                                     ; preds = %38, %33
  %39 = tail call %struct.halide_thread* @halide_spawn_thread(void (i8*)* nonnull @_ZN6Halide7Runtime8Internal13worker_threadEPv, i8* null) #15
  %40 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 10), align 8, !tbaa !21
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 10), align 8, !tbaa !21
  %42 = sext i32 %40 to i64
  %43 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 9, i64 %42
  store %struct.halide_thread* %39, %struct.halide_thread** %43, align 8, !tbaa !3
  %44 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  %45 = add nsw i32 %44, -1
  %46 = icmp slt i32 %41, %45
  br i1 %46, label %38, label %47

; <label>:47:                                     ; preds = %38, %33
  %48 = phi i32 [ %34, %33 ], [ %44, %38 ]
  %49 = bitcast %"struct.Halide::Runtime::Internal::work"* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %49) #14
  %50 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 1
  store i32 (i8*, i32, i8*)* %1, i32 (i8*, i32, i8*)** %50, align 8, !tbaa !24
  %51 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 2
  store i8* %0, i8** %51, align 8, !tbaa !26
  %52 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 3
  store i32 %2, i32* %52, align 8, !tbaa !27
  %53 = add nsw i32 %3, %2
  %54 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 4
  store i32 %53, i32* %54, align 4, !tbaa !28
  %55 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 5
  store i8* %4, i8** %55, align 8, !tbaa !29
  %56 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 7
  store i32 0, i32* %56, align 4, !tbaa !30
  %57 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %6, i64 0, i32 6
  store i32 0, i32* %57, align 8, !tbaa !31
  %58 = load %"struct.Halide::Runtime::Internal::work"*, %"struct.Halide::Runtime::Internal::work"** getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 3), align 8, !tbaa !32
  %59 = icmp eq %"struct.Halide::Runtime::Internal::work"* %58, null
  %60 = icmp sgt i32 %48, %3
  %61 = and i1 %60, %59
  %62 = select i1 %61, i32 %3, i32 %48
  store i32 %62, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 5), align 4, !tbaa !33
  %63 = ptrtoint %"struct.Halide::Runtime::Internal::work"* %58 to i64
  %64 = bitcast %"struct.Halide::Runtime::Internal::work"* %6 to i64*
  store i64 %63, i64* %64, align 8, !tbaa !34
  store %"struct.Halide::Runtime::Internal::work"* %6, %"struct.Halide::Runtime::Internal::work"** getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 3), align 8, !tbaa !32
  call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 7)) #15
  %65 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 5), align 4, !tbaa !33
  %66 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 4), align 8, !tbaa !23
  %67 = icmp sgt i32 %65, %66
  br i1 %67, label %68, label %69

; <label>:68:                                     ; preds = %47
  call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 8)) #15
  br label %69

; <label>:69:                                     ; preds = %68, %47
  call void @_ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE(%"struct.Halide::Runtime::Internal::work"* nonnull %6) #15
  call void @halide_mutex_unlock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %70 = load i32, i32* %56, align 4, !tbaa !30
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %49) #14
  br label %71

; <label>:71:                                     ; preds = %69, %5
  %72 = phi i32 [ %70, %69 ], [ 0, %5 ]
  ret i32 %72
}

; Function Attrs: nounwind
define weak void @halide_mutex_lock(%struct.halide_mutex*) local_unnamed_addr #0 {
  %2 = alloca %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", align 8
  %3 = getelementptr inbounds %struct.halide_mutex, %struct.halide_mutex* %0, i64 0, i32 0, i64 0
  %4 = cmpxchg weak i64* %3, i64 0, i64 1 acquire monotonic
  %5 = extractvalue { i64, i1 } %4, 1
  br i1 %5, label %57, label %6

; <label>:6:                                      ; preds = %1
  %7 = load atomic i64, i64* %3 monotonic, align 8
  %8 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2 to i8*
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 1
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 2
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 3
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 1
  %14 = ptrtoint %struct.halide_mutex* %0 to i64
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0
  br label %16

; <label>:16:                                     ; preds = %53, %6
  %17 = phi i64 [ %7, %6 ], [ %54, %53 ]
  %18 = phi i32 [ 40, %6 ], [ %55, %53 ]
  %19 = and i64 %17, 1
  %20 = icmp eq i64 %19, 0
  br i1 %20, label %21, label %30

; <label>:21:                                     ; preds = %26, %16
  %22 = phi i64 [ %27, %26 ], [ %17, %16 ]
  %23 = or i64 %22, 1
  %24 = cmpxchg weak i64* %3, i64 %22, i64 %23 acquire monotonic
  %25 = extractvalue { i64, i1 } %24, 1
  br i1 %25, label %57, label %26

; <label>:26:                                     ; preds = %21
  %27 = extractvalue { i64, i1 } %24, 0
  %28 = and i64 %27, 1
  %29 = icmp eq i64 %28, 0
  br i1 %29, label %21, label %30

; <label>:30:                                     ; preds = %26, %16
  %31 = phi i64 [ %17, %16 ], [ %27, %26 ]
  %32 = and i64 %31, 2
  %33 = icmp eq i64 %32, 0
  br i1 %33, label %34, label %48

; <label>:34:                                     ; preds = %30
  %35 = icmp sgt i32 %18, 0
  br i1 %35, label %36, label %41

; <label>:36:                                     ; preds = %34
  %37 = icmp eq i32 %18, 1
  br i1 %37, label %41, label %38

; <label>:38:                                     ; preds = %36
  %39 = add nsw i32 %18, -1
  call void @_ZN6Halide7Runtime8Internal19halide_thread_yieldEv() #13
  %40 = load atomic i64, i64* %3 monotonic, align 8
  br label %53

; <label>:41:                                     ; preds = %36, %34
  %42 = phi i32 [ 0, %36 ], [ %18, %34 ]
  %43 = or i64 %31, 2
  %44 = cmpxchg weak i64* %3, i64 %31, i64 %43 monotonic monotonic
  %45 = extractvalue { i64, i1 } %44, 1
  br i1 %45, label %48, label %46

; <label>:46:                                     ; preds = %41
  %47 = extractvalue { i64, i1 } %44, 0
  br label %53

; <label>:48:                                     ; preds = %41, %30
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %8) #14
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv, void (i8*)** %10, align 8, !tbaa !35
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %12, align 8, !tbaa !37
  store i64* %3, i64** %13, align 8, !tbaa !38
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization30mutex_parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %9, align 8, !tbaa !40
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization28mutex_parking_control_unparkEPvib, i64 (i8*, i32, i1)** %11, align 8, !tbaa !41
  %49 = call i64 @_ZN6Halide7Runtime8Internal15Synchronization4parkEyRNS2_15parking_controlE(i64 %14, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %15) #13
  %50 = icmp eq i64 %49, %14
  br i1 %50, label %56, label %51

; <label>:51:                                     ; preds = %48
  %52 = load atomic i64, i64* %3 monotonic, align 8
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %8) #14
  br label %53

; <label>:53:                                     ; preds = %51, %46, %38
  %54 = phi i64 [ %47, %46 ], [ %52, %51 ], [ %40, %38 ]
  %55 = phi i32 [ %42, %46 ], [ 40, %51 ], [ %39, %38 ]
  br label %16

; <label>:56:                                     ; preds = %48
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %8) #14
  br label %57

; <label>:57:                                     ; preds = %56, %21, %1
  ret void
}

; Function Attrs: nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal27default_desired_num_threadsEv() local_unnamed_addr #0 {
  %1 = tail call i8* @getenv(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.7, i64 0, i64 0)) #13
  %2 = icmp eq i8* %1, null
  br i1 %2, label %3, label %6

; <label>:3:                                      ; preds = %0
  %4 = tail call i8* @getenv(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1.8, i64 0, i64 0)) #13
  %5 = icmp eq i8* %4, null
  br i1 %5, label %9, label %6

; <label>:6:                                      ; preds = %3, %0
  %7 = phi i8* [ %4, %3 ], [ %1, %0 ]
  %8 = tail call i32 @atoi(i8* nonnull %7) #13
  br label %11

; <label>:9:                                      ; preds = %3
  %10 = tail call i32 @halide_host_cpu_count() #13
  br label %11

; <label>:11:                                     ; preds = %9, %6
  %12 = phi i32 [ %8, %6 ], [ %10, %9 ]
  ret i32 %12
}

; Function Attrs: norecurse nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal17clamp_num_threadsEi(i32) local_unnamed_addr #2 {
  %2 = icmp sgt i32 %0, 256
  br i1 %2, label %6, label %3

; <label>:3:                                      ; preds = %1
  %4 = icmp sgt i32 %0, 1
  %5 = select i1 %4, i32 %0, i32 1
  ret i32 %5

; <label>:6:                                      ; preds = %1
  ret i32 256
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal13worker_threadEPv(i8*) #0 {
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  tail call void @_ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE(%"struct.Halide::Runtime::Internal::work"* null) #15
  tail call void @halide_mutex_unlock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  ret void
}

; Function Attrs: nounwind
define weak %struct.halide_thread* @halide_spawn_thread(void (i8*)*, i8*) local_unnamed_addr #0 {
  %3 = tail call i8* @malloc(i64 24) #13
  %4 = bitcast i8* %3 to void (i8*)**
  store void (i8*)* %0, void (i8*)** %4, align 8, !tbaa !42
  %5 = getelementptr inbounds i8, i8* %3, i64 8
  %6 = bitcast i8* %5 to i8**
  store i8* %1, i8** %6, align 8, !tbaa !45
  %7 = getelementptr inbounds i8, i8* %3, i64 16
  %8 = bitcast i8* %7 to i64*
  store i64 0, i64* %8, align 8, !tbaa !46
  %9 = tail call i32 @pthread_create(i64* nonnull %8, i8* null, i8* (i8*)* nonnull @_ZN6Halide7Runtime8Internal19spawn_thread_helperEPv, i8* %3) #13
  %10 = bitcast i8* %3 to %struct.halide_thread*
  ret %struct.halide_thread* %10
}

; Function Attrs: nounwind
define weak void @halide_cond_broadcast(%struct.halide_mutex*) local_unnamed_addr #0 {
  %2 = alloca %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", align 8
  %3 = getelementptr inbounds %struct.halide_mutex, %struct.halide_mutex* %0, i64 0, i32 0, i64 0
  %4 = load atomic i64, i64* %3 monotonic, align 8
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %18, label %6

; <label>:6:                                      ; preds = %1
  %7 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %7) #14
  %8 = inttoptr i64 %4 to %"class.Halide::Runtime::Internal::Synchronization::word_lock"*
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 1
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv, void (i8*)** %10, align 8, !tbaa !35
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 2
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization22parking_control_unparkEPvib, i64 (i8*, i32, i1)** %11, align 8, !tbaa !41
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 3
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 1
  store i64* %3, i64** %13, align 8, !tbaa !47
  %14 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 2
  store %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %8, %"class.Halide::Runtime::Internal::Synchronization::word_lock"** %14, align 8, !tbaa !49
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization34broadcast_parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %9, align 8, !tbaa !40
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization42broadcast_parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %12, align 8, !tbaa !37
  %15 = ptrtoint %struct.halide_mutex* %0 to i64
  %16 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0
  %17 = call i32 @_ZN6Halide7Runtime8Internal15Synchronization14unpark_requeueEyyRNS2_15parking_controlEy(i64 %15, i64 %4, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %16, i64 0) #13
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %7) #14
  br label %18

; <label>:18:                                     ; preds = %6, %1
  ret void
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE(%"struct.Halide::Runtime::Internal::work"*) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %0, i64 0, i32 6
  %3 = icmp eq %"struct.Halide::Runtime::Internal::work"* %0, null
  %4 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %0, i64 0, i32 3
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %0, i64 0, i32 4
  br i1 %3, label %6, label %9

; <label>:6:                                      ; preds = %1
  %7 = load i8, i8* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 11), align 4, !tbaa !50, !range !10
  %8 = icmp eq i8 %7, 0
  br i1 %8, label %56, label %104

; <label>:9:                                      ; preds = %55, %1
  %10 = load i32, i32* %4, align 8, !tbaa !27
  %11 = load i32, i32* %5, align 4, !tbaa !28
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %16, label %13

; <label>:13:                                     ; preds = %9
  %14 = load i32, i32* %2, align 8, !tbaa !31
  %15 = icmp sgt i32 %14, 0
  br i1 %15, label %16, label %104

; <label>:16:                                     ; preds = %13, %9
  %17 = load %"struct.Halide::Runtime::Internal::work"*, %"struct.Halide::Runtime::Internal::work"** getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 3), align 8, !tbaa !32
  %18 = icmp eq %"struct.Halide::Runtime::Internal::work"* %17, null
  br i1 %18, label %54, label %19

; <label>:19:                                     ; preds = %16
  %20 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 1
  %21 = load i32 (i8*, i32, i8*)*, i32 (i8*, i32, i8*)** %20, align 8
  %22 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 2
  %23 = load i8*, i8** %22, align 8
  %24 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 3
  %25 = load i32, i32* %24, align 8
  %26 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 5
  %27 = load i8*, i8** %26, align 8
  %28 = add nsw i32 %25, 1
  store i32 %28, i32* %24, align 8, !tbaa !27
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 4
  %30 = load i32, i32* %29, align 4, !tbaa !28
  %31 = icmp eq i32 %28, %30
  br i1 %31, label %32, label %35

; <label>:32:                                     ; preds = %19
  %33 = bitcast %"struct.Halide::Runtime::Internal::work"* %17 to i64*
  %34 = load i64, i64* %33, align 8, !tbaa !34
  store i64 %34, i64* bitcast (%"struct.Halide::Runtime::Internal::work"** getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 3) to i64*), align 8, !tbaa !32
  br label %35

; <label>:35:                                     ; preds = %32, %19
  %36 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 6
  %37 = load i32, i32* %36, align 8, !tbaa !31
  %38 = add nsw i32 %37, 1
  store i32 %38, i32* %36, align 8, !tbaa !31
  tail call void @halide_mutex_unlock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %39 = tail call i32 @halide_do_task(i8* %23, i32 (i8*, i32, i8*)* %21, i32 %25, i8* %27) #15
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %43, label %41

; <label>:41:                                     ; preds = %35
  %42 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %17, i64 0, i32 7
  store i32 %39, i32* %42, align 4, !tbaa !30
  br label %43

; <label>:43:                                     ; preds = %41, %35
  %44 = load i32, i32* %36, align 8, !tbaa !31
  %45 = add nsw i32 %44, -1
  store i32 %45, i32* %36, align 8, !tbaa !31
  %46 = load i32, i32* %24, align 8, !tbaa !27
  %47 = load i32, i32* %29, align 4, !tbaa !28
  %48 = icmp slt i32 %46, %47
  br i1 %48, label %55, label %49

; <label>:49:                                     ; preds = %43
  %50 = icmp sgt i32 %44, 1
  %51 = icmp eq %"struct.Halide::Runtime::Internal::work"* %17, %0
  %52 = or i1 %51, %50
  br i1 %52, label %55, label %53

; <label>:53:                                     ; preds = %49
  tail call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 6)) #15
  br label %55

; <label>:54:                                     ; preds = %16
  tail call void @halide_cond_wait(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 6), %struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  br label %55

; <label>:55:                                     ; preds = %54, %53, %49, %43
  br label %9

; <label>:56:                                     ; preds = %101, %6
  %57 = load %"struct.Halide::Runtime::Internal::work"*, %"struct.Halide::Runtime::Internal::work"** getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 3), align 8, !tbaa !32
  %58 = icmp eq %"struct.Halide::Runtime::Internal::work"* %57, null
  br i1 %58, label %59, label %68

; <label>:59:                                     ; preds = %56
  %60 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 4), align 8, !tbaa !23
  %61 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 5), align 4, !tbaa !33
  %62 = icmp sgt i32 %60, %61
  br i1 %62, label %64, label %63

; <label>:63:                                     ; preds = %59
  tail call void @halide_cond_wait(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 7), %struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  br label %101

; <label>:64:                                     ; preds = %59
  %65 = add nsw i32 %60, -1
  store i32 %65, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 4), align 8, !tbaa !23
  tail call void @halide_cond_wait(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 8), %struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %66 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 4), align 8, !tbaa !23
  %67 = add nsw i32 %66, 1
  store i32 %67, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 4), align 8, !tbaa !23
  br label %101

; <label>:68:                                     ; preds = %56
  %69 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 1
  %70 = load i32 (i8*, i32, i8*)*, i32 (i8*, i32, i8*)** %69, align 8
  %71 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 2
  %72 = load i8*, i8** %71, align 8
  %73 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 3
  %74 = load i32, i32* %73, align 8
  %75 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 5
  %76 = load i8*, i8** %75, align 8
  %77 = add nsw i32 %74, 1
  store i32 %77, i32* %73, align 8, !tbaa !27
  %78 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 4
  %79 = load i32, i32* %78, align 4, !tbaa !28
  %80 = icmp eq i32 %77, %79
  br i1 %80, label %81, label %84

; <label>:81:                                     ; preds = %68
  %82 = bitcast %"struct.Halide::Runtime::Internal::work"* %57 to i64*
  %83 = load i64, i64* %82, align 8, !tbaa !34
  store i64 %83, i64* bitcast (%"struct.Halide::Runtime::Internal::work"** getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 3) to i64*), align 8, !tbaa !32
  br label %84

; <label>:84:                                     ; preds = %81, %68
  %85 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 6
  %86 = load i32, i32* %85, align 8, !tbaa !31
  %87 = add nsw i32 %86, 1
  store i32 %87, i32* %85, align 8, !tbaa !31
  tail call void @halide_mutex_unlock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %88 = tail call i32 @halide_do_task(i8* %72, i32 (i8*, i32, i8*)* %70, i32 %74, i8* %76) #15
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %92, label %90

; <label>:90:                                     ; preds = %84
  %91 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work", %"struct.Halide::Runtime::Internal::work"* %57, i64 0, i32 7
  store i32 %88, i32* %91, align 4, !tbaa !30
  br label %92

; <label>:92:                                     ; preds = %90, %84
  %93 = load i32, i32* %85, align 8, !tbaa !31
  %94 = add nsw i32 %93, -1
  store i32 %94, i32* %85, align 8, !tbaa !31
  %95 = load i32, i32* %73, align 8, !tbaa !27
  %96 = load i32, i32* %78, align 4, !tbaa !28
  %97 = icmp slt i32 %95, %96
  %98 = icmp sgt i32 %93, 1
  %99 = or i1 %97, %98
  br i1 %99, label %101, label %100

; <label>:100:                                    ; preds = %92
  tail call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 6)) #15
  br label %101

; <label>:101:                                    ; preds = %100, %92, %64, %63
  %102 = load i8, i8* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 11), align 4, !tbaa !50, !range !10
  %103 = icmp eq i8 %102, 0
  br i1 %103, label %56, label %104

; <label>:104:                                    ; preds = %101, %13, %6
  ret void
}

; Function Attrs: nounwind
define weak void @halide_mutex_unlock(%struct.halide_mutex*) local_unnamed_addr #0 {
  %2 = alloca %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", align 8
  %3 = getelementptr inbounds %struct.halide_mutex, %struct.halide_mutex* %0, i64 0, i32 0, i64 0
  %4 = cmpxchg weak i64* %3, i64 1, i64 0 release monotonic
  %5 = extractvalue { i64, i1 } %4, 1
  br i1 %5, label %19, label %6

; <label>:6:                                      ; preds = %1
  %7 = cmpxchg i64* %3, i64 1, i64 0 release monotonic
  %8 = extractvalue { i64, i1 } %7, 1
  br i1 %8, label %19, label %9

; <label>:9:                                      ; preds = %6
  %10 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %10) #14
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 0
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 1
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv, void (i8*)** %12, align 8, !tbaa !35
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 2
  %14 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 3
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %14, align 8, !tbaa !37
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 1
  store i64* %3, i64** %15, align 8, !tbaa !38
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization30mutex_parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %11, align 8, !tbaa !40
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization28mutex_parking_control_unparkEPvib, i64 (i8*, i32, i1)** %13, align 8, !tbaa !41
  %16 = ptrtoint %struct.halide_mutex* %0 to i64
  %17 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0
  %18 = call i64 @_ZN6Halide7Runtime8Internal15Synchronization10unpark_oneEyRNS2_15parking_controlE(i64 %16, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %17) #13
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %10) #14
  br label %19

; <label>:19:                                     ; preds = %9, %6, %1
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv(i8*) #2 {
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb(i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* dereferenceable(16), i1 zeroext, i1 zeroext) #2 {
  ret void
}

; Function Attrs: nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal15Synchronization30mutex_parking_control_validateEPvRNS2_15validate_actionE(i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* dereferenceable(16)) #0 {
  %3 = getelementptr inbounds i8, i8* %0, i64 32
  %4 = bitcast i8* %3 to i64**
  %5 = load i64*, i64** %4, align 8, !tbaa !38
  %6 = load atomic i64, i64* %5 monotonic, align 8
  %7 = icmp eq i64 %6, 3
  ret i1 %7
}

; Function Attrs: nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization28mutex_parking_control_unparkEPvib(i8*, i32, i1 zeroext) #0 {
  %4 = select i1 %2, i64 2, i64 0
  %5 = getelementptr inbounds i8, i8* %0, i64 32
  %6 = bitcast i8* %5 to i64**
  %7 = load i64*, i64** %6, align 8, !tbaa !38
  store atomic i64 %4, i64* %7 release, align 8
  ret i64 0
}

; Function Attrs: nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization10unpark_oneEyRNS2_15parking_controlE(i64, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* dereferenceable(32)) local_unnamed_addr #0 {
  %3 = tail call dereferenceable(24) %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* @_ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy(i64 %0) #15
  %4 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 1
  %5 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %4, align 8, !tbaa !3
  br label %6

; <label>:6:                                      ; preds = %11, %2
  %7 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %4, %2 ], [ %15, %11 ]
  %8 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ null, %2 ], [ %9, %11 ]
  %9 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %5, %2 ], [ %16, %11 ]
  %10 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, null
  br i1 %10, label %60, label %11

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, i64 0, i32 1
  %13 = load atomic i64, i64* %12 monotonic, align 8
  %14 = icmp eq i64 %13, %0
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, i64 0, i32 2
  %16 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %15, align 8, !tbaa !51
  br i1 %14, label %17, label %6

; <label>:17:                                     ; preds = %11
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %16, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %7, align 8, !tbaa !3
  %18 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 2
  %19 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %18, align 8, !tbaa !56
  %20 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %19, %9
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %17
  %22 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %16, null
  br i1 %22, label %36, label %24

; <label>:23:                                     ; preds = %17
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %8, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %18, align 8, !tbaa !56
  br label %36

; <label>:24:                                     ; preds = %24, %21
  %25 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %30, %24 ], [ %16, %21 ]
  %26 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %25, i64 0, i32 1
  %27 = load atomic i64, i64* %26 monotonic, align 8
  %28 = icmp eq i64 %27, %0
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %25, i64 0, i32 2
  %30 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %29, align 8, !tbaa !51
  %31 = icmp ne %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %30, null
  %32 = xor i1 %28, true
  %33 = and i1 %31, %32
  br i1 %33, label %24, label %34

; <label>:34:                                     ; preds = %24
  %35 = zext i1 %28 to i8
  br label %36

; <label>:36:                                     ; preds = %34, %23, %21
  %37 = phi i8 [ 0, %23 ], [ %35, %34 ], [ 0, %21 ]
  %38 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::parking_control", %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1, i64 0, i32 2
  %39 = load i64 (i8*, i32, i1)*, i64 (i8*, i32, i1)** %38, align 8, !tbaa !41
  %40 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1 to i8*
  %41 = icmp ne i8 %37, 0
  %42 = tail call i64 %39(i8* nonnull %40, i32 1, i1 zeroext %41) #13
  %43 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, i64 0, i32 3
  store i64 %42, i64* %43, align 8, !tbaa !59
  %44 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, i64 0, i32 0, i32 0
  %45 = tail call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* nonnull %44) #13
  %46 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0, i32 0
  %47 = atomicrmw and i64* %46, i64 -2 release
  %48 = and i64 %47, 2
  %49 = icmp eq i64 %48, 0
  %50 = icmp ugt i64 %47, 3
  %51 = and i1 %50, %49
  br i1 %51, label %52, label %54

; <label>:52:                                     ; preds = %36
  %53 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* nonnull %53) #13
  br label %54

; <label>:54:                                     ; preds = %52, %36
  %55 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, i64 0, i32 0, i32 2
  store i8 0, i8* %55, align 8, !tbaa !60
  %56 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %9, i64 0, i32 0, i32 1
  %57 = tail call i32 @pthread_cond_signal(%struct.pthread_mutex_t* nonnull %56) #13
  %58 = tail call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* nonnull %44) #13
  %59 = zext i8 %37 to i64
  br label %73

; <label>:60:                                     ; preds = %6
  %61 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::parking_control", %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1, i64 0, i32 2
  %62 = load i64 (i8*, i32, i1)*, i64 (i8*, i32, i1)** %61, align 8, !tbaa !41
  %63 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1 to i8*
  %64 = tail call i64 %62(i8* nonnull %63, i32 0, i1 zeroext false) #13
  %65 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0, i32 0
  %66 = atomicrmw and i64* %65, i64 -2 release
  %67 = and i64 %66, 2
  %68 = icmp eq i64 %67, 0
  %69 = icmp ugt i64 %66, 3
  %70 = and i1 %69, %68
  br i1 %70, label %71, label %73

; <label>:71:                                     ; preds = %60
  %72 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* nonnull %72) #13
  br label %73

; <label>:73:                                     ; preds = %71, %60, %54
  %74 = phi i64 [ %59, %54 ], [ 0, %60 ], [ 0, %71 ]
  ret i64 %74
}

; Function Attrs: nounwind
define linkonce dereferenceable(24) %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* @_ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy(i64) local_unnamed_addr #0 {
  %2 = mul i64 %0, -7046029254386353131
  %3 = lshr i64 %2, 54
  %4 = getelementptr inbounds [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"], [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]* bitcast ([24576 x i8]* @_ZN6Halide7Runtime8Internal15Synchronization13table_storageE to [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]*), i64 0, i64 %3
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4, i64 0, i32 0, i32 0
  %6 = cmpxchg weak i64* %5, i64 0, i64 1 acquire monotonic
  %7 = extractvalue { i64, i1 } %6, 1
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %9) #13
  br label %10

; <label>:10:                                     ; preds = %8, %1
  ret %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4
}

declare i32 @pthread_mutex_lock(%struct.pthread_mutex_t*) local_unnamed_addr #1

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"*) local_unnamed_addr #0 align 2 {
  %2 = getelementptr inbounds %"class.Halide::Runtime::Internal::Synchronization::word_lock", %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %0, i64 0, i32 0
  %3 = load atomic i64, i64* %2 monotonic, align 8
  br label %4

; <label>:4:                                      ; preds = %10, %1
  %5 = phi i64 [ %3, %1 ], [ %14, %10 ]
  %6 = and i64 %5, 2
  %7 = icmp ne i64 %6, 0
  %8 = icmp ult i64 %5, 4
  %9 = or i1 %8, %7
  br i1 %9, label %67, label %10

; <label>:10:                                     ; preds = %4
  %11 = or i64 %5, 2
  %12 = cmpxchg weak i64* %2, i64 %5, i64 %11 acquire monotonic
  %13 = extractvalue { i64, i1 } %12, 1
  %14 = extractvalue { i64, i1 } %12, 0
  br i1 %13, label %15, label %4

; <label>:15:                                     ; preds = %56, %10
  %16 = phi i64 [ %57, %56 ], [ %14, %10 ]
  %17 = and i64 %16, -4
  %18 = inttoptr i64 %17 to %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*
  %19 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %18, i64 0, i32 3
  %20 = load %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %19, align 8, !tbaa !61
  %21 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %20, null
  br i1 %21, label %22, label %33

; <label>:22:                                     ; preds = %28, %15
  %23 = phi %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* [ %25, %28 ], [ %18, %15 ]
  %24 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %23, i64 0, i32 1
  %25 = load %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %24, align 8, !tbaa !63
  %26 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %25, null
  br i1 %26, label %27, label %28

; <label>:27:                                     ; preds = %22
  tail call void @abort() #13
  br label %28

; <label>:28:                                     ; preds = %27, %22
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %25, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %23, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %29, align 8, !tbaa !64
  %30 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %25, i64 0, i32 3
  %31 = load %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %30, align 8, !tbaa !61
  %32 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %31, null
  br i1 %32, label %22, label %33

; <label>:33:                                     ; preds = %28, %15
  %34 = phi %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* [ %20, %15 ], [ %31, %28 ]
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %34, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %19, align 8, !tbaa !61
  %35 = and i64 %16, 1
  %36 = icmp eq i64 %35, 0
  br i1 %36, label %43, label %37

; <label>:37:                                     ; preds = %33
  %38 = and i64 %16, -3
  %39 = cmpxchg weak i64* %2, i64 %16, i64 %38 acq_rel monotonic
  %40 = extractvalue { i64, i1 } %39, 1
  br i1 %40, label %67, label %41

; <label>:41:                                     ; preds = %37
  %42 = extractvalue { i64, i1 } %39, 0
  fence acquire
  br label %56

; <label>:43:                                     ; preds = %33
  %44 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %34, i64 0, i32 2
  %45 = load %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %44, align 8, !tbaa !64
  %46 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %45, null
  br i1 %46, label %47, label %58

; <label>:47:                                     ; preds = %52, %43
  %48 = phi i64 [ %53, %52 ], [ %16, %43 ]
  %49 = and i64 %48, 1
  %50 = cmpxchg weak i64* %2, i64 %48, i64 %49 acq_rel monotonic
  %51 = extractvalue { i64, i1 } %50, 1
  br i1 %51, label %60, label %52

; <label>:52:                                     ; preds = %47
  %53 = extractvalue { i64, i1 } %50, 0
  %54 = icmp ult i64 %53, 4
  br i1 %54, label %47, label %55

; <label>:55:                                     ; preds = %52
  fence acquire
  br label %56

; <label>:56:                                     ; preds = %55, %41
  %57 = phi i64 [ %42, %41 ], [ %53, %55 ]
  br label %15

; <label>:58:                                     ; preds = %43
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %45, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %19, align 8, !tbaa !61
  %59 = atomicrmw and i64* %2, i64 -3 release
  br label %60

; <label>:60:                                     ; preds = %58, %47
  %61 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %34, i64 0, i32 0, i32 0
  %62 = tail call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* nonnull %61) #13
  %63 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %34, i64 0, i32 0, i32 2
  store i8 0, i8* %63, align 8, !tbaa !60
  %64 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %34, i64 0, i32 0, i32 1
  %65 = tail call i32 @pthread_cond_signal(%struct.pthread_mutex_t* nonnull %64) #13
  %66 = tail call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* nonnull %61) #13
  br label %67

; <label>:67:                                     ; preds = %60, %37, %4
  ret void
}

declare i32 @pthread_cond_signal(%struct.pthread_mutex_t*) local_unnamed_addr #1

declare i32 @pthread_mutex_unlock(%struct.pthread_mutex_t*) local_unnamed_addr #1

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"*) local_unnamed_addr #0 align 2 {
  %2 = alloca %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", align 8
  %3 = getelementptr inbounds %"class.Halide::Runtime::Internal::Synchronization::word_lock", %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %0, i64 0, i32 0
  %4 = load atomic i64, i64* %3 monotonic, align 8
  %5 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2 to i8*
  %6 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, i64 0, i32 0, i32 2
  %7 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, i64 0, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, i64 0, i32 0, i32 1
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, i64 0, i32 1
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, i64 0, i32 2
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data", %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, i64 0, i32 3
  %12 = ptrtoint %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2 to i64
  br label %13

; <label>:13:                                     ; preds = %37, %1
  %14 = phi i64 [ %4, %1 ], [ %38, %37 ]
  %15 = phi i32 [ 40, %1 ], [ %39, %37 ]
  %16 = and i64 %14, 1
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %18, label %27

; <label>:18:                                     ; preds = %23, %13
  %19 = phi i64 [ %24, %23 ], [ %14, %13 ]
  %20 = or i64 %19, 1
  %21 = cmpxchg weak i64* %3, i64 %19, i64 %20 acquire monotonic
  %22 = extractvalue { i64, i1 } %21, 1
  br i1 %22, label %72, label %23

; <label>:23:                                     ; preds = %18
  %24 = extractvalue { i64, i1 } %21, 0
  %25 = and i64 %24, 1
  %26 = icmp eq i64 %25, 0
  br i1 %26, label %18, label %27

; <label>:27:                                     ; preds = %23, %13
  %28 = phi i64 [ %14, %13 ], [ %24, %23 ]
  %29 = icmp ugt i64 %28, 3
  %30 = icmp sgt i32 %15, 0
  %31 = and i1 %29, %30
  br i1 %31, label %32, label %40

; <label>:32:                                     ; preds = %27
  %33 = icmp sgt i32 %15, 1
  br i1 %33, label %34, label %40

; <label>:34:                                     ; preds = %32
  %35 = add nsw i32 %15, -1
  call void @_ZN6Halide7Runtime8Internal19halide_thread_yieldEv() #13
  %36 = load atomic i64, i64* %3 monotonic, align 8
  br label %37

; <label>:37:                                     ; preds = %67, %34
  %38 = phi i64 [ %68, %67 ], [ %36, %34 ]
  %39 = phi i32 [ %69, %67 ], [ %35, %34 ]
  br label %13

; <label>:40:                                     ; preds = %32, %27
  %41 = phi i32 [ 0, %32 ], [ %15, %27 ]
  call void @llvm.lifetime.start.p0i8(i64 160, i8* nonnull %5) #14
  store i8 0, i8* %6, align 8, !tbaa !60
  %42 = call i32 @pthread_mutex_init(%struct.pthread_mutex_t* nonnull %7, i8* null) #13
  %43 = call i32 @pthread_cond_init(%struct.pthread_mutex_t* nonnull %8, i8* null) #13
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* null, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %9, align 8, !tbaa !63
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* null, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %10, align 8, !tbaa !64
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* null, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %11, align 8, !tbaa !61
  store i8 1, i8* %6, align 8, !tbaa !60
  %44 = and i64 %28, -4
  %45 = icmp eq i64 %44, 0
  br i1 %45, label %46, label %47

; <label>:46:                                     ; preds = %40
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %2, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %11, align 8, !tbaa !61
  br label %49

; <label>:47:                                     ; preds = %40
  %48 = inttoptr i64 %44 to %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"*
  store %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"* %48, %"struct.Halide::Runtime::Internal::Synchronization::word_lock_queue_data"** %9, align 8, !tbaa !63
  br label %49

; <label>:49:                                     ; preds = %47, %46
  %50 = and i64 %28, 3
  %51 = or i64 %50, %12
  %52 = cmpxchg weak i64* %3, i64 %28, i64 %51 release monotonic
  %53 = extractvalue { i64, i1 } %52, 1
  br i1 %53, label %56, label %54

; <label>:54:                                     ; preds = %49
  %55 = extractvalue { i64, i1 } %52, 0
  br label %67

; <label>:56:                                     ; preds = %49
  %57 = call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* nonnull %7) #13
  %58 = load i8, i8* %6, align 8, !tbaa !60, !range !10
  %59 = icmp eq i8 %58, 0
  br i1 %59, label %64, label %60

; <label>:60:                                     ; preds = %60, %56
  %61 = call i32 @pthread_cond_wait(%struct.pthread_mutex_t* nonnull %8, %struct.pthread_mutex_t* nonnull %7) #13
  %62 = load i8, i8* %6, align 8, !tbaa !60, !range !10
  %63 = icmp eq i8 %62, 0
  br i1 %63, label %64, label %60

; <label>:64:                                     ; preds = %60, %56
  %65 = call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* nonnull %7) #13
  %66 = load atomic i64, i64* %3 monotonic, align 8
  br label %67

; <label>:67:                                     ; preds = %64, %54
  %68 = phi i64 [ %66, %64 ], [ %55, %54 ]
  %69 = phi i32 [ 40, %64 ], [ %41, %54 ]
  %70 = call i32 @pthread_cond_destroy(%struct.pthread_mutex_t* nonnull %8) #13
  %71 = call i32 @pthread_mutex_destroy(%struct.pthread_mutex_t* nonnull %7) #13
  call void @llvm.lifetime.end.p0i8(i64 160, i8* nonnull %5) #14
  br label %37

; <label>:72:                                     ; preds = %18
  ret void
}

declare i32 @pthread_mutex_init(%struct.pthread_mutex_t*, i8*) local_unnamed_addr #1

declare i32 @pthread_cond_init(%struct.pthread_mutex_t*, i8*) local_unnamed_addr #1

declare i32 @pthread_cond_wait(%struct.pthread_mutex_t*, %struct.pthread_mutex_t*) local_unnamed_addr #1

declare i32 @pthread_cond_destroy(%struct.pthread_mutex_t*) local_unnamed_addr #1

declare i32 @pthread_mutex_destroy(%struct.pthread_mutex_t*) local_unnamed_addr #1

; Function Attrs: nounwind
define weak i32 @halide_do_task(i8*, i32 (i8*, i32, i8*)*, i32, i8*) local_unnamed_addr #0 {
  %5 = load i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)*, i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)** @_ZN6Halide7Runtime8Internal14custom_do_taskE, align 8, !tbaa !3
  %6 = tail call i32 %5(i8* %0, i32 (i8*, i32, i8*)* %1, i32 %2, i8* %3) #13
  ret i32 %6
}

; Function Attrs: nounwind
define weak void @halide_cond_wait(%struct.halide_mutex*, %struct.halide_mutex*) local_unnamed_addr #0 {
  %3 = alloca %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", align 8
  %4 = alloca %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", align 8
  %5 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %5) #14
  %6 = getelementptr inbounds %struct.halide_mutex, %struct.halide_mutex* %0, i64 0, i32 0, i64 0
  %7 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 0, i32 1
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 0, i32 2
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 0, i32 3
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %10, align 8, !tbaa !37
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 1
  store i64* %6, i64** %11, align 8, !tbaa !65
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 2
  %13 = bitcast %"class.Halide::Runtime::Internal::Synchronization::word_lock"** %12 to %struct.halide_mutex**
  store %struct.halide_mutex* %1, %struct.halide_mutex** %13, align 8, !tbaa !67
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization29wait_parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %7, align 8, !tbaa !40
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization33wait_parking_control_before_sleepEPv, void (i8*)** %8, align 8, !tbaa !35
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization27wait_parking_control_unparkEPvib, i64 (i8*, i32, i1)** %9, align 8, !tbaa !41
  %14 = ptrtoint %struct.halide_mutex* %0 to i64
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %4, i64 0, i32 0
  %16 = call i64 @_ZN6Halide7Runtime8Internal15Synchronization4parkEyRNS2_15parking_controlE(i64 %14, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %15) #13
  %17 = ptrtoint %struct.halide_mutex* %1 to i64
  %18 = icmp eq i64 %16, %17
  %19 = getelementptr inbounds %struct.halide_mutex, %struct.halide_mutex* %1, i64 0, i32 0, i64 0
  br i1 %18, label %73, label %20

; <label>:20:                                     ; preds = %2
  %21 = cmpxchg weak i64* %19, i64 0, i64 1 acquire monotonic
  %22 = extractvalue { i64, i1 } %21, 1
  br i1 %22, label %78, label %23

; <label>:23:                                     ; preds = %20
  %24 = load atomic i64, i64* %19 monotonic, align 8
  %25 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3 to i8*
  %26 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3, i64 0, i32 0, i32 0
  %27 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3, i64 0, i32 0, i32 1
  %28 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3, i64 0, i32 0, i32 2
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3, i64 0, i32 0, i32 3
  %30 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3, i64 0, i32 1
  %31 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %3, i64 0, i32 0
  br label %32

; <label>:32:                                     ; preds = %69, %23
  %33 = phi i64 [ %24, %23 ], [ %70, %69 ]
  %34 = phi i32 [ 40, %23 ], [ %71, %69 ]
  %35 = and i64 %33, 1
  %36 = icmp eq i64 %35, 0
  br i1 %36, label %37, label %46

; <label>:37:                                     ; preds = %42, %32
  %38 = phi i64 [ %43, %42 ], [ %33, %32 ]
  %39 = or i64 %38, 1
  %40 = cmpxchg weak i64* %19, i64 %38, i64 %39 acquire monotonic
  %41 = extractvalue { i64, i1 } %40, 1
  br i1 %41, label %78, label %42

; <label>:42:                                     ; preds = %37
  %43 = extractvalue { i64, i1 } %40, 0
  %44 = and i64 %43, 1
  %45 = icmp eq i64 %44, 0
  br i1 %45, label %37, label %46

; <label>:46:                                     ; preds = %42, %32
  %47 = phi i64 [ %33, %32 ], [ %43, %42 ]
  %48 = and i64 %47, 2
  %49 = icmp eq i64 %48, 0
  br i1 %49, label %50, label %64

; <label>:50:                                     ; preds = %46
  %51 = icmp sgt i32 %34, 0
  br i1 %51, label %52, label %57

; <label>:52:                                     ; preds = %50
  %53 = icmp eq i32 %34, 1
  br i1 %53, label %57, label %54

; <label>:54:                                     ; preds = %52
  %55 = add nsw i32 %34, -1
  call void @_ZN6Halide7Runtime8Internal19halide_thread_yieldEv() #13
  %56 = load atomic i64, i64* %19 monotonic, align 8
  br label %69

; <label>:57:                                     ; preds = %52, %50
  %58 = phi i32 [ 0, %52 ], [ %34, %50 ]
  %59 = or i64 %47, 2
  %60 = cmpxchg weak i64* %19, i64 %47, i64 %59 monotonic monotonic
  %61 = extractvalue { i64, i1 } %60, 1
  br i1 %61, label %64, label %62

; <label>:62:                                     ; preds = %57
  %63 = extractvalue { i64, i1 } %60, 0
  br label %69

; <label>:64:                                     ; preds = %57, %46
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %25) #14
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv, void (i8*)** %27, align 8, !tbaa !35
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %29, align 8, !tbaa !37
  store i64* %19, i64** %30, align 8, !tbaa !38
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization30mutex_parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %26, align 8, !tbaa !40
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization28mutex_parking_control_unparkEPvib, i64 (i8*, i32, i1)** %28, align 8, !tbaa !41
  %65 = call i64 @_ZN6Halide7Runtime8Internal15Synchronization4parkEyRNS2_15parking_controlE(i64 %17, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %31) #13
  %66 = icmp eq i64 %65, %17
  br i1 %66, label %72, label %67

; <label>:67:                                     ; preds = %64
  %68 = load atomic i64, i64* %19 monotonic, align 8
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %25) #14
  br label %69

; <label>:69:                                     ; preds = %67, %62, %54
  %70 = phi i64 [ %63, %62 ], [ %68, %67 ], [ %56, %54 ]
  %71 = phi i32 [ %58, %62 ], [ 40, %67 ], [ %55, %54 ]
  br label %32

; <label>:72:                                     ; preds = %64
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %25) #14
  br label %78

; <label>:73:                                     ; preds = %2
  %74 = load atomic i64, i64* %19 monotonic, align 8
  %75 = and i64 %74, 1
  %76 = icmp eq i64 %75, 0
  br i1 %76, label %77, label %78

; <label>:77:                                     ; preds = %73
  call void @halide_print(i8* null, i8* getelementptr inbounds ([102 x i8], [102 x i8]* @.str.4, i64 0, i64 0)) #13
  call void @abort() #13
  br label %78

; <label>:78:                                     ; preds = %77, %73, %72, %37, %20
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %5) #14
  ret void
}

; Function Attrs: nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal15Synchronization29wait_parking_control_validateEPvRNS2_15validate_actionE(i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* dereferenceable(16)) #0 {
  %3 = getelementptr inbounds i8, i8* %0, i64 32
  %4 = bitcast i8* %3 to i64**
  %5 = load i64*, i64** %4, align 8, !tbaa !65
  %6 = load atomic i64, i64* %5 monotonic, align 8
  %7 = icmp eq i64 %6, 0
  %8 = getelementptr inbounds i8, i8* %0, i64 40
  %9 = bitcast i8* %8 to i64*
  %10 = load i64, i64* %9, align 8, !tbaa !67
  br i1 %7, label %11, label %12

; <label>:11:                                     ; preds = %2
  store atomic i64 %10, i64* %5 monotonic, align 8
  br label %16

; <label>:12:                                     ; preds = %2
  %13 = icmp eq i64 %6, %10
  br i1 %13, label %16, label %14

; <label>:14:                                     ; preds = %12
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %1, i64 0, i32 2
  store i64 %10, i64* %15, align 8, !tbaa !68
  br label %16

; <label>:16:                                     ; preds = %14, %12, %11
  %17 = phi i1 [ false, %14 ], [ true, %12 ], [ true, %11 ]
  ret i1 %17
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization33wait_parking_control_before_sleepEPv(i8*) #0 {
  %2 = alloca %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", align 8
  %3 = getelementptr inbounds i8, i8* %0, i64 40
  %4 = bitcast i8* %3 to %"class.Halide::Runtime::Internal::Synchronization::word_lock"**
  %5 = load %"class.Halide::Runtime::Internal::Synchronization::word_lock"*, %"class.Halide::Runtime::Internal::Synchronization::word_lock"** %4, align 8, !tbaa !67
  %6 = getelementptr inbounds %"class.Halide::Runtime::Internal::Synchronization::word_lock", %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %5, i64 0, i32 0
  %7 = cmpxchg weak i64* %6, i64 1, i64 0 release monotonic
  %8 = extractvalue { i64, i1 } %7, 1
  br i1 %8, label %22, label %9

; <label>:9:                                      ; preds = %1
  %10 = cmpxchg i64* %6, i64 1, i64 0 release monotonic
  %11 = extractvalue { i64, i1 } %10, 1
  br i1 %11, label %22, label %12

; <label>:12:                                     ; preds = %9
  %13 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %13) #14
  %14 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 0
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 1
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv, void (i8*)** %15, align 8, !tbaa !35
  %16 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 2
  %17 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0, i32 3
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %17, align 8, !tbaa !37
  %18 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 1
  store i64* %6, i64** %18, align 8, !tbaa !38
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization30mutex_parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %14, align 8, !tbaa !40
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization28mutex_parking_control_unparkEPvib, i64 (i8*, i32, i1)** %16, align 8, !tbaa !41
  %19 = ptrtoint %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %5 to i64
  %20 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::mutex_parking_control"* %2, i64 0, i32 0
  %21 = call i64 @_ZN6Halide7Runtime8Internal15Synchronization10unpark_oneEyRNS2_15parking_controlE(i64 %19, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %20) #13
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %13) #14
  br label %22

; <label>:22:                                     ; preds = %12, %9, %1
  ret void
}

; Function Attrs: nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization27wait_parking_control_unparkEPvib(i8*, i32, i1 zeroext) #0 {
  br i1 %2, label %8, label %4

; <label>:4:                                      ; preds = %3
  %5 = getelementptr inbounds i8, i8* %0, i64 32
  %6 = bitcast i8* %5 to i64**
  %7 = load i64*, i64** %6, align 8, !tbaa !65
  store atomic i64 0, i64* %7 monotonic, align 8
  br label %8

; <label>:8:                                      ; preds = %4, %3
  ret i64 0
}

; Function Attrs: nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization4parkEyRNS2_15parking_controlE(i64, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* dereferenceable(32)) local_unnamed_addr #0 {
  %3 = alloca %"struct.Halide::Runtime::Internal::Synchronization::queue_data", align 8
  %4 = alloca %"struct.Halide::Runtime::Internal::Synchronization::validate_action", align 8
  %5 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 160, i8* nonnull %5) #14
  %6 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, i64 0, i32 0, i32 2
  store i8 0, i8* %6, align 8, !tbaa !60
  %7 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, i64 0, i32 0, i32 0
  %8 = call i32 @pthread_mutex_init(%struct.pthread_mutex_t* nonnull %7, i8* null) #13
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, i64 0, i32 0, i32 1
  %10 = call i32 @pthread_cond_init(%struct.pthread_mutex_t* nonnull %9, i8* null) #13
  store i8 0, i8* %6, align 8, !tbaa !60
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, i64 0, i32 1
  store i64 0, i64* %11, align 8, !tbaa !70
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* null, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %12, align 8, !tbaa !51
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, i64 0, i32 3
  store i64 0, i64* %13, align 8, !tbaa !59
  %14 = call dereferenceable(24) %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* @_ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy(i64 %0) #15
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %4, i64 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %15) #14
  store i8 0, i8* %15, align 8, !tbaa !71
  %16 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %4, i64 0, i32 2
  store i64 0, i64* %16, align 8, !tbaa !68
  %17 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::parking_control", %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1, i64 0, i32 0
  %18 = load i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)*, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %17, align 8, !tbaa !40
  %19 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1 to i8*
  %20 = call zeroext i1 %18(i8* nonnull %19, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* nonnull dereferenceable(16) %4) #13
  br i1 %20, label %30, label %21

; <label>:21:                                     ; preds = %2
  %22 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 0, i32 0
  %23 = atomicrmw and i64* %22, i64 -2 release
  %24 = and i64 %23, 2
  %25 = icmp eq i64 %24, 0
  %26 = icmp ugt i64 %23, 3
  %27 = and i1 %26, %25
  br i1 %27, label %28, label %62

; <label>:28:                                     ; preds = %21
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 0
  call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* nonnull %29) #13
  br label %62

; <label>:30:                                     ; preds = %2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* null, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %12, align 8, !tbaa !51
  store i64 %0, i64* %11, align 8, !tbaa !70
  store i8 1, i8* %6, align 8, !tbaa !60
  %31 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 1
  %32 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %31, align 8, !tbaa !72
  %33 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %32, null
  br i1 %33, label %38, label %34

; <label>:34:                                     ; preds = %30
  %35 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 2
  %36 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %35, align 8, !tbaa !56
  %37 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %36, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %37, align 8, !tbaa !51
  br label %40

; <label>:38:                                     ; preds = %30
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %31, align 8, !tbaa !72
  %39 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 2
  br label %40

; <label>:40:                                     ; preds = %38, %34
  %41 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %39, %38 ], [ %35, %34 ]
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %3, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %41, align 8, !tbaa !56
  %42 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 0, i32 0
  %43 = atomicrmw and i64* %42, i64 -2 release
  %44 = and i64 %43, 2
  %45 = icmp eq i64 %44, 0
  %46 = icmp ugt i64 %43, 3
  %47 = and i1 %46, %45
  br i1 %47, label %48, label %50

; <label>:48:                                     ; preds = %40
  %49 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %14, i64 0, i32 0
  call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* nonnull %49) #13
  br label %50

; <label>:50:                                     ; preds = %48, %40
  %51 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::parking_control", %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %1, i64 0, i32 1
  %52 = load void (i8*)*, void (i8*)** %51, align 8, !tbaa !35
  call void %52(i8* nonnull %19) #13
  %53 = call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* nonnull %7) #13
  %54 = load i8, i8* %6, align 8, !tbaa !60, !range !10
  %55 = icmp eq i8 %54, 0
  br i1 %55, label %60, label %56

; <label>:56:                                     ; preds = %56, %50
  %57 = call i32 @pthread_cond_wait(%struct.pthread_mutex_t* nonnull %9, %struct.pthread_mutex_t* nonnull %7) #13
  %58 = load i8, i8* %6, align 8, !tbaa !60, !range !10
  %59 = icmp eq i8 %58, 0
  br i1 %59, label %60, label %56

; <label>:60:                                     ; preds = %56, %50
  %61 = call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* nonnull %7) #13
  br label %62

; <label>:62:                                     ; preds = %60, %28, %21
  %63 = phi i64* [ %13, %60 ], [ %16, %21 ], [ %16, %28 ]
  %64 = load i64, i64* %63, align 8, !tbaa !11
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %15) #14
  %65 = call i32 @pthread_cond_destroy(%struct.pthread_mutex_t* nonnull %9) #13
  %66 = call i32 @pthread_mutex_destroy(%struct.pthread_mutex_t* nonnull %7) #13
  call void @llvm.lifetime.end.p0i8(i64 160, i8* nonnull %5) #14
  ret i64 %64
}

; Function Attrs: norecurse nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization22parking_control_unparkEPvib(i8*, i32, i1 zeroext) #2 {
  ret i64 0
}

; Function Attrs: nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal15Synchronization34broadcast_parking_control_validateEPvRNS2_15validate_actionE(i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* dereferenceable(16)) #0 {
  %3 = getelementptr inbounds i8, i8* %0, i64 32
  %4 = bitcast i8* %3 to i64**
  %5 = load i64*, i64** %4, align 8, !tbaa !47
  %6 = load atomic i64, i64* %5 monotonic, align 8
  %7 = getelementptr inbounds i8, i8* %0, i64 40
  %8 = bitcast i8* %7 to i64*
  %9 = load i64, i64* %8, align 8, !tbaa !49
  %10 = icmp eq i64 %6, %9
  br i1 %10, label %11, label %30

; <label>:11:                                     ; preds = %2
  %12 = bitcast i8* %7 to %"class.Halide::Runtime::Internal::Synchronization::word_lock"**
  store atomic i64 0, i64* %5 monotonic, align 8
  %13 = load %"class.Halide::Runtime::Internal::Synchronization::word_lock"*, %"class.Halide::Runtime::Internal::Synchronization::word_lock"** %12, align 8, !tbaa !49
  %14 = getelementptr inbounds %"class.Halide::Runtime::Internal::Synchronization::word_lock", %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %13, i64 0, i32 0
  %15 = load atomic i64, i64* %14 monotonic, align 8
  %16 = and i64 %15, 1
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %27, label %18

; <label>:18:                                     ; preds = %23, %11
  %19 = phi i64 [ %24, %23 ], [ %15, %11 ]
  %20 = or i64 %19, 2
  %21 = cmpxchg weak i64* %14, i64 %19, i64 %20 monotonic monotonic
  %22 = extractvalue { i64, i1 } %21, 1
  br i1 %22, label %27, label %23

; <label>:23:                                     ; preds = %18
  %24 = extractvalue { i64, i1 } %21, 0
  %25 = and i64 %24, 1
  %26 = icmp eq i64 %25, 0
  br i1 %26, label %27, label %18

; <label>:27:                                     ; preds = %23, %18, %11
  %28 = phi i8 [ 1, %11 ], [ 1, %23 ], [ 0, %18 ]
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %1, i64 0, i32 0
  store i8 %28, i8* %29, align 8, !tbaa !71
  br label %30

; <label>:30:                                     ; preds = %27, %2
  %31 = phi i1 [ true, %27 ], [ false, %2 ]
  ret i1 %31
}

; Function Attrs: norecurse nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization42broadcast_parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb(i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* dereferenceable(16), i1 zeroext, i1 zeroext) #2 {
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %1, i64 0, i32 0
  %6 = load i8, i8* %5, align 8, !tbaa !71, !range !10
  %7 = icmp eq i8 %6, 0
  %8 = xor i1 %3, true
  %9 = or i1 %7, %8
  br i1 %9, label %16, label %10

; <label>:10:                                     ; preds = %4
  %11 = getelementptr inbounds i8, i8* %0, i64 40
  %12 = bitcast i8* %11 to %"class.Halide::Runtime::Internal::Synchronization::word_lock"**
  %13 = load %"class.Halide::Runtime::Internal::Synchronization::word_lock"*, %"class.Halide::Runtime::Internal::Synchronization::word_lock"** %12, align 8, !tbaa !49
  %14 = getelementptr inbounds %"class.Halide::Runtime::Internal::Synchronization::word_lock", %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %13, i64 0, i32 0
  %15 = atomicrmw or i64* %14, i64 2 monotonic
  br label %16

; <label>:16:                                     ; preds = %10, %4
  ret void
}

; Function Attrs: nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal15Synchronization14unpark_requeueEyyRNS2_15parking_controlEy(i64, i64, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* dereferenceable(32), i64) local_unnamed_addr #0 {
  %5 = alloca %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", align 8
  %6 = alloca %"struct.Halide::Runtime::Internal::Synchronization::validate_action", align 8
  %7 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %7) #14
  call void @_ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy(%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* nonnull sret %5, i64 %0, i64 %1) #15
  %8 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %6, i64 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %8) #14
  store i8 0, i8* %8, align 8, !tbaa !71
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::validate_action", %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* %6, i64 0, i32 2
  store i64 0, i64* %9, align 8, !tbaa !68
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::parking_control", %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %2, i64 0, i32 0
  %11 = load i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)*, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %10, align 8, !tbaa !40
  %12 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %2 to i8*
  %13 = call zeroext i1 %11(i8* nonnull %12, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* nonnull dereferenceable(16) %6) #13
  br i1 %13, label %15, label %14

; <label>:14:                                     ; preds = %4
  call void @_ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE(%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* nonnull dereferenceable(16) %5) #15
  br label %124

; <label>:15:                                     ; preds = %4
  %16 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %5, i64 0, i32 0
  %17 = load %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %16, align 8, !tbaa !73
  %18 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %17, i64 0, i32 1
  %19 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %18, align 8, !tbaa !3
  %20 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %19, null
  br i1 %20, label %103, label %21

; <label>:21:                                     ; preds = %15
  %22 = load i8, i8* %8, align 8
  %23 = icmp eq i8 %22, 0
  %24 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %17, i64 0, i32 2
  br i1 %23, label %56, label %25

; <label>:25:                                     ; preds = %49, %21
  %26 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %54, %49 ], [ null, %21 ]
  %27 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %53, %49 ], [ null, %21 ]
  %28 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %52, %49 ], [ null, %21 ]
  %29 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %35, %49 ], [ %19, %21 ]
  %30 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %51, %49 ], [ null, %21 ]
  %31 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %50, %49 ], [ %18, %21 ]
  %32 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %29, i64 0, i32 1
  %33 = load atomic i64, i64* %32 monotonic, align 8
  %34 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %29, i64 0, i32 2
  %35 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %34, align 8, !tbaa !51
  %36 = icmp eq i64 %33, %0
  br i1 %36, label %37, label %49

; <label>:37:                                     ; preds = %25
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %35, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %31, align 8, !tbaa !3
  %38 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %24, align 8, !tbaa !56
  %39 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %38, %29
  br i1 %39, label %40, label %41

; <label>:40:                                     ; preds = %37
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %30, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %24, align 8, !tbaa !56
  br label %41

; <label>:41:                                     ; preds = %40, %37
  %42 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %26, null
  br i1 %42, label %49, label %43

; <label>:43:                                     ; preds = %41
  %44 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %28, null
  br i1 %44, label %47, label %45

; <label>:45:                                     ; preds = %43
  %46 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %27, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %29, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %46, align 8, !tbaa !51
  br label %47

; <label>:47:                                     ; preds = %45, %43
  %48 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %28, %45 ], [ %29, %43 ]
  store atomic i64 %1, i64* %32 monotonic, align 8
  br label %49

; <label>:49:                                     ; preds = %47, %41, %25
  %50 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %31, %41 ], [ %31, %47 ], [ %34, %25 ]
  %51 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %30, %41 ], [ %30, %47 ], [ %29, %25 ]
  %52 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %28, %41 ], [ %48, %47 ], [ %28, %25 ]
  %53 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %27, %41 ], [ %29, %47 ], [ %27, %25 ]
  %54 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %29, %41 ], [ %26, %47 ], [ %26, %25 ]
  %55 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %35, null
  br i1 %55, label %83, label %25

; <label>:56:                                     ; preds = %77, %21
  %57 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %81, %77 ], [ null, %21 ]
  %58 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %80, %77 ], [ null, %21 ]
  %59 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %65, %77 ], [ %19, %21 ]
  %60 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %79, %77 ], [ null, %21 ]
  %61 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %78, %77 ], [ %18, %21 ]
  %62 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %59, i64 0, i32 1
  %63 = load atomic i64, i64* %62 monotonic, align 8
  %64 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %59, i64 0, i32 2
  %65 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %64, align 8, !tbaa !51
  %66 = icmp eq i64 %63, %0
  br i1 %66, label %67, label %77

; <label>:67:                                     ; preds = %56
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %65, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %61, align 8, !tbaa !3
  %68 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %24, align 8, !tbaa !56
  %69 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %68, %59
  br i1 %69, label %70, label %71

; <label>:70:                                     ; preds = %67
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %60, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %24, align 8, !tbaa !56
  br label %71

; <label>:71:                                     ; preds = %70, %67
  %72 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %58, null
  br i1 %72, label %75, label %73

; <label>:73:                                     ; preds = %71
  %74 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %57, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %59, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %74, align 8, !tbaa !51
  br label %75

; <label>:75:                                     ; preds = %73, %71
  %76 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %58, %73 ], [ %59, %71 ]
  store atomic i64 %1, i64* %62 monotonic, align 8
  br label %77

; <label>:77:                                     ; preds = %75, %56
  %78 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %61, %75 ], [ %64, %56 ]
  %79 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %60, %75 ], [ %59, %56 ]
  %80 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %76, %75 ], [ %58, %56 ]
  %81 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %59, %75 ], [ %57, %56 ]
  %82 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %65, null
  br i1 %82, label %83, label %56

; <label>:83:                                     ; preds = %77, %49
  %84 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %80, %77 ], [ %52, %49 ]
  %85 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %81, %77 ], [ %53, %49 ]
  %86 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ null, %77 ], [ %54, %49 ]
  %87 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %84, null
  br i1 %87, label %103, label %88

; <label>:88:                                     ; preds = %83
  %89 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %85, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* null, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %89, align 8, !tbaa !51
  %90 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %5, i64 0, i32 1
  %91 = load %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %90, align 8, !tbaa !75
  %92 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %91, i64 0, i32 1
  %93 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %92, align 8, !tbaa !72
  %94 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %93, null
  br i1 %94, label %95, label %97

; <label>:95:                                     ; preds = %88
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %84, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %92, align 8, !tbaa !72
  %96 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %91, i64 0, i32 2
  br label %101

; <label>:97:                                     ; preds = %88
  %98 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %91, i64 0, i32 2
  %99 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %98, align 8, !tbaa !56
  %100 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %99, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %84, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %100, align 8, !tbaa !51
  br label %101

; <label>:101:                                    ; preds = %97, %95
  %102 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %98, %97 ], [ %96, %95 ]
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %85, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %102, align 8, !tbaa !56
  br label %103

; <label>:103:                                    ; preds = %101, %83, %15
  %104 = phi i1 [ true, %101 ], [ false, %83 ], [ false, %15 ]
  %105 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %86, %101 ], [ %86, %83 ], [ null, %15 ]
  %106 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::parking_control", %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* %2, i64 0, i32 3
  %107 = load void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)*, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %106, align 8, !tbaa !37
  %108 = icmp ne %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %105, null
  call void %107(i8* nonnull %12, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* nonnull dereferenceable(16) %6, i1 zeroext %108, i1 zeroext %104) #13
  br i1 %108, label %109, label %117

; <label>:109:                                    ; preds = %103
  %110 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %105, i64 0, i32 3
  store i64 %3, i64* %110, align 8, !tbaa !59
  %111 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %105, i64 0, i32 0, i32 0
  %112 = call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* nonnull %111) #13
  call void @_ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE(%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* nonnull dereferenceable(16) %5) #15
  %113 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %105, i64 0, i32 0, i32 2
  store i8 0, i8* %113, align 8, !tbaa !60
  %114 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %105, i64 0, i32 0, i32 1
  %115 = call i32 @pthread_cond_signal(%struct.pthread_mutex_t* nonnull %114) #13
  %116 = call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* nonnull %111) #13
  br label %118

; <label>:117:                                    ; preds = %103
  call void @_ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE(%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* nonnull dereferenceable(16) %5) #15
  br label %118

; <label>:118:                                    ; preds = %117, %109
  %119 = load i8, i8* %8, align 8
  %120 = and i8 %119, 1
  %121 = icmp ne i8 %120, 0
  %122 = and i1 %108, %121
  %123 = zext i1 %122 to i32
  br label %124

; <label>:124:                                    ; preds = %118, %14
  %125 = phi i32 [ %123, %118 ], [ 0, %14 ]
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %8) #14
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %7) #14
  ret i32 %125
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy(%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* noalias sret, i64, i64) local_unnamed_addr #0 {
  %4 = mul i64 %1, -7046029254386353131
  %5 = lshr i64 %4, 54
  %6 = mul i64 %2, -7046029254386353131
  %7 = lshr i64 %6, 54
  %8 = icmp eq i64 %5, %7
  br i1 %8, label %9, label %16

; <label>:9:                                      ; preds = %3
  %10 = getelementptr inbounds [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"], [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]* bitcast ([24576 x i8]* @_ZN6Halide7Runtime8Internal15Synchronization13table_storageE to [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]*), i64 0, i64 %5
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %10, i64 0, i32 0, i32 0
  %12 = cmpxchg weak i64* %11, i64 0, i64 1 acquire monotonic
  %13 = extractvalue { i64, i1 } %12, 1
  br i1 %13, label %46, label %14

; <label>:14:                                     ; preds = %9
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %10, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %15) #13
  br label %46

; <label>:16:                                     ; preds = %3
  %17 = icmp ult i64 %5, %7
  br i1 %17, label %18, label %32

; <label>:18:                                     ; preds = %16
  %19 = getelementptr inbounds [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"], [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]* bitcast ([24576 x i8]* @_ZN6Halide7Runtime8Internal15Synchronization13table_storageE to [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]*), i64 0, i64 %5
  %20 = getelementptr inbounds [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"], [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]* bitcast ([24576 x i8]* @_ZN6Halide7Runtime8Internal15Synchronization13table_storageE to [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]*), i64 0, i64 %7
  %21 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %19, i64 0, i32 0, i32 0
  %22 = cmpxchg weak i64* %21, i64 0, i64 1 acquire monotonic
  %23 = extractvalue { i64, i1 } %22, 1
  br i1 %23, label %26, label %24

; <label>:24:                                     ; preds = %18
  %25 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %19, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %25) #13
  br label %26

; <label>:26:                                     ; preds = %24, %18
  %27 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %20, i64 0, i32 0, i32 0
  %28 = cmpxchg weak i64* %27, i64 0, i64 1 acquire monotonic
  %29 = extractvalue { i64, i1 } %28, 1
  br i1 %29, label %46, label %30

; <label>:30:                                     ; preds = %26
  %31 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %20, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %31) #13
  br label %46

; <label>:32:                                     ; preds = %16
  %33 = getelementptr inbounds [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"], [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]* bitcast ([24576 x i8]* @_ZN6Halide7Runtime8Internal15Synchronization13table_storageE to [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]*), i64 0, i64 %7
  %34 = getelementptr inbounds [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"], [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]* bitcast ([24576 x i8]* @_ZN6Halide7Runtime8Internal15Synchronization13table_storageE to [1024 x %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"]*), i64 0, i64 %5
  %35 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %33, i64 0, i32 0, i32 0
  %36 = cmpxchg weak i64* %35, i64 0, i64 1 acquire monotonic
  %37 = extractvalue { i64, i1 } %36, 1
  br i1 %37, label %40, label %38

; <label>:38:                                     ; preds = %32
  %39 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %33, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %39) #13
  br label %40

; <label>:40:                                     ; preds = %38, %32
  %41 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %34, i64 0, i32 0, i32 0
  %42 = cmpxchg weak i64* %41, i64 0, i64 1 acquire monotonic
  %43 = extractvalue { i64, i1 } %42, 1
  br i1 %43, label %46, label %44

; <label>:44:                                     ; preds = %40
  %45 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %34, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %45) #13
  br label %46

; <label>:46:                                     ; preds = %44, %40, %30, %26, %14, %9
  %47 = phi %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* [ %10, %9 ], [ %10, %14 ], [ %19, %26 ], [ %19, %30 ], [ %34, %40 ], [ %34, %44 ]
  %48 = phi %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* [ %10, %9 ], [ %10, %14 ], [ %20, %26 ], [ %20, %30 ], [ %33, %40 ], [ %33, %44 ]
  %49 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %0, i64 0, i32 0
  store %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %47, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %49, align 8, !tbaa !3
  %50 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %0, i64 0, i32 1
  store %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %48, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %50, align 8, !tbaa !3
  ret void
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE(%"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* dereferenceable(16)) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %0, i64 0, i32 0
  %3 = load %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %2, align 8, !tbaa !73
  %4 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair", %"struct.Halide::Runtime::Internal::Synchronization::bucket_pair"* %0, i64 0, i32 1
  %5 = load %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %4, align 8, !tbaa !75
  %6 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, %5
  br i1 %6, label %7, label %16

; <label>:7:                                      ; preds = %1
  %8 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0, i32 0
  %9 = atomicrmw and i64* %8, i64 -2 release
  %10 = and i64 %9, 2
  %11 = icmp eq i64 %10, 0
  %12 = icmp ugt i64 %9, 3
  %13 = and i1 %12, %11
  br i1 %13, label %14, label %56

; <label>:14:                                     ; preds = %7
  %15 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %15) #13
  br label %56

; <label>:16:                                     ; preds = %1
  %17 = icmp ugt %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, %5
  br i1 %17, label %18, label %37

; <label>:18:                                     ; preds = %16
  %19 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0, i32 0
  %20 = atomicrmw and i64* %19, i64 -2 release
  %21 = and i64 %20, 2
  %22 = icmp eq i64 %21, 0
  %23 = icmp ugt i64 %20, 3
  %24 = and i1 %23, %22
  br i1 %24, label %25, label %27

; <label>:25:                                     ; preds = %18
  %26 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %3, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %26) #13
  br label %27

; <label>:27:                                     ; preds = %25, %18
  %28 = load %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %4, align 8, !tbaa !75
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %28, i64 0, i32 0, i32 0
  %30 = atomicrmw and i64* %29, i64 -2 release
  %31 = and i64 %30, 2
  %32 = icmp eq i64 %31, 0
  %33 = icmp ugt i64 %30, 3
  %34 = and i1 %33, %32
  br i1 %34, label %35, label %56

; <label>:35:                                     ; preds = %27
  %36 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %28, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %36) #13
  br label %56

; <label>:37:                                     ; preds = %16
  %38 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %5, i64 0, i32 0, i32 0
  %39 = atomicrmw and i64* %38, i64 -2 release
  %40 = and i64 %39, 2
  %41 = icmp eq i64 %40, 0
  %42 = icmp ugt i64 %39, 3
  %43 = and i1 %42, %41
  br i1 %43, label %44, label %46

; <label>:44:                                     ; preds = %37
  %45 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %5, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %45) #13
  br label %46

; <label>:46:                                     ; preds = %44, %37
  %47 = load %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"*, %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"** %2, align 8, !tbaa !73
  %48 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %47, i64 0, i32 0, i32 0
  %49 = atomicrmw and i64* %48, i64 -2 release
  %50 = and i64 %49, 2
  %51 = icmp eq i64 %50, 0
  %52 = icmp ugt i64 %49, 3
  %53 = and i1 %52, %51
  br i1 %53, label %54, label %56

; <label>:54:                                     ; preds = %46
  %55 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %47, i64 0, i32 0
  tail call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* %55) #13
  br label %56

; <label>:56:                                     ; preds = %54, %46, %35, %27, %14, %7
  ret void
}

; Function Attrs: nounwind
define linkonce i8* @_ZN6Halide7Runtime8Internal19spawn_thread_helperEPv(i8*) #0 {
  %2 = bitcast i8* %0 to void (i8*)**
  %3 = load void (i8*)*, void (i8*)** %2, align 8, !tbaa !42
  %4 = getelementptr inbounds i8, i8* %0, i64 8
  %5 = bitcast i8* %4 to i8**
  %6 = load i8*, i8** %5, align 8, !tbaa !45
  tail call void %3(i8* %6) #13
  ret i8* null
}

declare i32 @pthread_create(i64*, i8*, i8* (i8*)*, i8*) local_unnamed_addr #1

declare i8* @getenv(i8*) local_unnamed_addr #1

declare i32 @atoi(i8*) local_unnamed_addr #1

; Function Attrs: nounwind
define weak void @halide_thread_pool_cleanup() #0 {
  tail call void @halide_shutdown_thread_pool() #15
  ret void
}

; Function Attrs: nounwind
define weak void @halide_shutdown_thread_pool() local_unnamed_addr #0 {
  %1 = load i8, i8* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 12), align 1, !tbaa !17, !range !10
  %2 = icmp eq i8 %1, 0
  br i1 %2, label %16, label %3

; <label>:3:                                      ; preds = %0
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  store i8 1, i8* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 11), align 4, !tbaa !50
  tail call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 6)) #15
  tail call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 7)) #15
  tail call void @halide_cond_broadcast(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 8)) #15
  tail call void @halide_mutex_unlock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %4 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 10), align 8, !tbaa !21
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %8, label %6

; <label>:6:                                      ; preds = %8, %3
  %7 = tail call i8* @memset(i8* nonnull bitcast (i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 2) to i8*), i32 0, i64 2100) #13
  br label %16

; <label>:8:                                      ; preds = %8, %3
  %9 = phi i64 [ %12, %8 ], [ 0, %3 ]
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 9, i64 %9
  %11 = load %struct.halide_thread*, %struct.halide_thread** %10, align 8, !tbaa !3
  tail call void @halide_join_thread(%struct.halide_thread* %11) #15
  %12 = add nuw nsw i64 %9, 1
  %13 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 10), align 8, !tbaa !21
  %14 = sext i32 %13 to i64
  %15 = icmp slt i64 %12, %14
  br i1 %15, label %8, label %6

; <label>:16:                                     ; preds = %6, %0
  ret void
}

declare i8* @memset(i8*, i32, i64) local_unnamed_addr #1

; Function Attrs: nounwind
define weak void @halide_join_thread(%struct.halide_thread*) local_unnamed_addr #0 {
  %2 = alloca i8*, align 8
  %3 = bitcast %struct.halide_thread* %0 to %"struct.Halide::Runtime::Internal::spawned_thread"*
  %4 = bitcast i8** %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4) #14
  store i8* null, i8** %2, align 8, !tbaa !3
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::spawned_thread", %"struct.Halide::Runtime::Internal::spawned_thread"* %3, i64 0, i32 2
  %6 = load i64, i64* %5, align 8, !tbaa !46
  %7 = call i32 @pthread_join(i64 %6, i8** nonnull %2) #13
  %8 = bitcast %struct.halide_thread* %0 to i8*
  call void @free(i8* %8) #13
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4) #14
  ret void
}

declare i32 @pthread_join(i64, i8**) local_unnamed_addr #1

; Function Attrs: norecurse nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal15Synchronization24parking_control_validateEPvRNS2_15validate_actionE(i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"* dereferenceable(16)) #2 {
  ret i1 true
}

; Function Attrs: nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization10unpark_allEyy(i64, i64) local_unnamed_addr #0 {
  %3 = alloca [16 x %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*], align 8
  %4 = tail call dereferenceable(24) %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* @_ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy(i64 %0) #15
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4, i64 0, i32 1
  %6 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %5, align 8, !tbaa !3
  %7 = bitcast [16 x %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*]* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %7) #14
  %8 = getelementptr inbounds [16 x %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*], [16 x %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*]* %3, i64 0, i64 0
  %9 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %6, null
  br i1 %9, label %62, label %10

; <label>:10:                                     ; preds = %2
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4, i64 0, i32 2
  br label %12

; <label>:12:                                     ; preds = %56, %10
  %13 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ null, %10 ], [ %60, %56 ]
  %14 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %6, %10 ], [ %21, %56 ]
  %15 = phi i64 [ 16, %10 ], [ %59, %56 ]
  %16 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %8, %10 ], [ %58, %56 ]
  %17 = phi i64 [ 0, %10 ], [ %57, %56 ]
  %18 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %14, i64 0, i32 1
  %19 = load atomic i64, i64* %18 monotonic, align 8
  %20 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %14, i64 0, i32 2
  %21 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %20, align 8, !tbaa !51
  %22 = icmp eq i64 %19, %0
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %21, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %5, align 8, !tbaa !3
  br i1 %22, label %23, label %56

; <label>:23:                                     ; preds = %12
  %24 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %11, align 8, !tbaa !56
  %25 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %24, %14
  br i1 %25, label %26, label %27

; <label>:26:                                     ; preds = %23
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %13, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %11, align 8, !tbaa !56
  br label %27

; <label>:27:                                     ; preds = %26, %23
  %28 = icmp eq i64 %17, %15
  br i1 %28, label %29, label %48

; <label>:29:                                     ; preds = %27
  %30 = shl i64 %15, 4
  %31 = call i8* @malloc(i64 %30) #13
  %32 = bitcast i8* %31 to %"struct.Halide::Runtime::Internal::Synchronization::queue_data"**
  %33 = icmp eq i64 %15, 0
  br i1 %33, label %34, label %37

; <label>:34:                                     ; preds = %37, %29
  %35 = shl i64 %15, 1
  %36 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %16, %8
  br i1 %36, label %48, label %46

; <label>:37:                                     ; preds = %37, %29
  %38 = phi i64 [ %44, %37 ], [ 0, %29 ]
  %39 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %16, i64 %38
  %40 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %39 to i64*
  %41 = load i64, i64* %40, align 8, !tbaa !3
  %42 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %32, i64 %38
  %43 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %42 to i64*
  store i64 %41, i64* %43, align 8, !tbaa !3
  %44 = add nuw i64 %38, 1
  %45 = icmp eq i64 %44, %15
  br i1 %45, label %34, label %37

; <label>:46:                                     ; preds = %34
  %47 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %16 to i8*
  call void @free(i8* %47) #13
  br label %48

; <label>:48:                                     ; preds = %46, %34, %27
  %49 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %16, %27 ], [ %32, %34 ], [ %32, %46 ]
  %50 = phi i64 [ %15, %27 ], [ %35, %34 ], [ %35, %46 ]
  %51 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %14, i64 0, i32 3
  store i64 %1, i64* %51, align 8, !tbaa !59
  %52 = add i64 %17, 1
  %53 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %49, i64 %17
  store %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %14, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %53, align 8, !tbaa !3
  %54 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %14, i64 0, i32 0, i32 0
  %55 = call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* nonnull %54) #13
  br label %56

; <label>:56:                                     ; preds = %48, %12
  %57 = phi i64 [ %52, %48 ], [ %17, %12 ]
  %58 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %49, %48 ], [ %16, %12 ]
  %59 = phi i64 [ %50, %48 ], [ %15, %12 ]
  %60 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* [ %13, %48 ], [ %14, %12 ]
  %61 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %21, null
  br i1 %61, label %62, label %12

; <label>:62:                                     ; preds = %56, %2
  %63 = phi i64 [ 0, %2 ], [ %57, %56 ]
  %64 = phi %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** [ %8, %2 ], [ %58, %56 ]
  %65 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4, i64 0, i32 0, i32 0
  %66 = atomicrmw and i64* %65, i64 -2 release
  %67 = and i64 %66, 2
  %68 = icmp eq i64 %67, 0
  %69 = icmp ugt i64 %66, 3
  %70 = and i1 %69, %68
  br i1 %70, label %71, label %73

; <label>:71:                                     ; preds = %62
  %72 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket", %"struct.Halide::Runtime::Internal::Synchronization::hash_bucket"* %4, i64 0, i32 0
  call void @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv(%"class.Halide::Runtime::Internal::Synchronization::word_lock"* nonnull %72) #13
  br label %73

; <label>:73:                                     ; preds = %71, %62
  %74 = icmp eq i64 %63, 0
  br i1 %74, label %85, label %76

; <label>:75:                                     ; preds = %76
  br i1 %74, label %85, label %87

; <label>:76:                                     ; preds = %76, %73
  %77 = phi i64 [ %83, %76 ], [ 0, %73 ]
  %78 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %64, i64 %77
  %79 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %78, align 8, !tbaa !3
  %80 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %79, i64 0, i32 0, i32 2
  store i8 0, i8* %80, align 8, !tbaa !60
  %81 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %79, i64 0, i32 0, i32 1
  %82 = call i32 @pthread_cond_signal(%struct.pthread_mutex_t* nonnull %81) #13
  %83 = add nuw i64 %77, 1
  %84 = icmp eq i64 %83, %63
  br i1 %84, label %75, label %76

; <label>:85:                                     ; preds = %87, %75, %73
  %86 = icmp eq %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %64, %8
  br i1 %86, label %97, label %95

; <label>:87:                                     ; preds = %87, %75
  %88 = phi i64 [ %93, %87 ], [ 0, %75 ]
  %89 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %64, i64 %88
  %90 = load %"struct.Halide::Runtime::Internal::Synchronization::queue_data"*, %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %89, align 8, !tbaa !3
  %91 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::queue_data", %"struct.Halide::Runtime::Internal::Synchronization::queue_data"* %90, i64 0, i32 0, i32 0
  %92 = call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* %91) #13
  %93 = add nuw i64 %88, 1
  %94 = icmp eq i64 %93, %63
  br i1 %94, label %85, label %87

; <label>:95:                                     ; preds = %85
  %96 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::queue_data"** %64 to i8*
  call void @free(i8* %96) #13
  br label %97

; <label>:97:                                     ; preds = %95, %85
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %7) #14
  ret i64 %63
}

; Function Attrs: nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal15Synchronization29signal_parking_control_unparkEPvib(i8*, i32, i1 zeroext) #0 {
  br i1 %2, label %8, label %4

; <label>:4:                                      ; preds = %3
  %5 = getelementptr inbounds i8, i8* %0, i64 32
  %6 = bitcast i8* %5 to i64**
  %7 = load i64*, i64** %6, align 8, !tbaa !76
  store atomic i64 0, i64* %7 monotonic, align 8
  br label %8

; <label>:8:                                      ; preds = %4, %3
  ret i64 0
}

; Function Attrs: nounwind
define weak void @halide_cond_signal(%struct.halide_mutex*) local_unnamed_addr #0 {
  %2 = alloca %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", align 8
  %3 = getelementptr inbounds %struct.halide_mutex, %struct.halide_mutex* %0, i64 0, i32 0, i64 0
  %4 = load atomic i64, i64* %3 monotonic, align 8
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %18, label %6

; <label>:6:                                      ; preds = %1
  %7 = bitcast %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %7) #14
  %8 = inttoptr i64 %4 to %"class.Halide::Runtime::Internal::Synchronization::word_lock"*
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 0
  store i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)* @_ZN6Halide7Runtime8Internal15Synchronization24parking_control_validateEPvRNS2_15validate_actionE, i1 (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*)** %9, align 8, !tbaa !40
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 1
  store void (i8*)* @_ZN6Halide7Runtime8Internal15Synchronization28parking_control_before_sleepEPv, void (i8*)** %10, align 8, !tbaa !35
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 2
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0, i32 3
  store void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)* @_ZN6Halide7Runtime8Internal15Synchronization32parking_control_requeue_callbackEPvRKNS2_15validate_actionEbb, void (i8*, %"struct.Halide::Runtime::Internal::Synchronization::validate_action"*, i1, i1)** %12, align 8, !tbaa !37
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 1
  store i64* %3, i64** %13, align 8, !tbaa !76
  %14 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 2
  store %"class.Halide::Runtime::Internal::Synchronization::word_lock"* %8, %"class.Halide::Runtime::Internal::Synchronization::word_lock"** %14, align 8, !tbaa !78
  store i64 (i8*, i32, i1)* @_ZN6Halide7Runtime8Internal15Synchronization29signal_parking_control_unparkEPvib, i64 (i8*, i32, i1)** %11, align 8, !tbaa !41
  %15 = ptrtoint %struct.halide_mutex* %0 to i64
  %16 = getelementptr inbounds %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control", %"struct.Halide::Runtime::Internal::Synchronization::wait_parking_control"* %2, i64 0, i32 0
  %17 = call i64 @_ZN6Halide7Runtime8Internal15Synchronization10unpark_oneEyRNS2_15parking_controlE(i64 %15, %"struct.Halide::Runtime::Internal::Synchronization::parking_control"* nonnull dereferenceable(32) %16) #13
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %7) #14
  br label %18

; <label>:18:                                     ; preds = %6, %1
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_set_num_threads(i32) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 0
  br i1 %2, label %3, label %4

; <label>:3:                                      ; preds = %1
  tail call void @halide_error(i8* null, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.2, i64 0, i64 0)) #13
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  br label %8

; <label>:4:                                      ; preds = %1
  tail call void @halide_mutex_lock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  %5 = icmp eq i32 %0, 0
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %4
  %7 = tail call i32 @_ZN6Halide7Runtime8Internal27default_desired_num_threadsEv() #15
  br label %8

; <label>:8:                                      ; preds = %6, %4, %3
  %9 = phi i32 [ %7, %6 ], [ %0, %4 ], [ %0, %3 ]
  %10 = load i32, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  %11 = tail call i32 @_ZN6Halide7Runtime8Internal17clamp_num_threadsEi(i32 %9) #15
  store i32 %11, i32* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 1), align 8, !tbaa !22
  tail call void @halide_mutex_unlock(%struct.halide_mutex* getelementptr inbounds (%"struct.Halide::Runtime::Internal::work_queue_t", %"struct.Halide::Runtime::Internal::work_queue_t"* @_ZN6Halide7Runtime8Internal10work_queueE, i64 0, i32 0)) #15
  ret i32 %10
}

; Function Attrs: norecurse nounwind
define weak i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)* @halide_set_custom_do_task(i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)*) local_unnamed_addr #2 {
  %2 = load i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)*, i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)** @_ZN6Halide7Runtime8Internal14custom_do_taskE, align 8, !tbaa !3
  store i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)* %0, i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)** @_ZN6Halide7Runtime8Internal14custom_do_taskE, align 8, !tbaa !3
  ret i32 (i8*, i32 (i8*, i32, i8*)*, i32, i8*)* %2
}

; Function Attrs: norecurse nounwind
define weak i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)* @halide_set_custom_do_par_for(i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)*) local_unnamed_addr #2 {
  %2 = load i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)*, i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)** @_ZN6Halide7Runtime8Internal17custom_do_par_forE, align 8, !tbaa !3
  store i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)* %0, i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)** @_ZN6Halide7Runtime8Internal17custom_do_par_forE, align 8, !tbaa !3
  ret i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)* %2
}

; Function Attrs: nounwind
define weak i32 @halide_do_par_for(i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*) local_unnamed_addr #0 {
  %6 = load i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)*, i32 (i8*, i32 (i8*, i32, i8*)*, i32, i32, i8*)** @_ZN6Halide7Runtime8Internal17custom_do_par_forE, align 8, !tbaa !3
  %7 = tail call i32 %6(i8* %0, i32 (i8*, i32, i8*)* %1, i32 %2, i32 %3, i8* %4) #13
  ret i32 %7
}

; Function Attrs: nounwind
define weak i8* @halide_default_get_symbol(i8*) #0 {
  %2 = tail call i8* @dlsym(i8* inttoptr (i64 -2 to i8*), i8* %0) #13
  ret i8* %2
}

declare i8* @dlsym(i8*, i8*) local_unnamed_addr #1

; Function Attrs: nounwind
define weak i8* @halide_default_load_library(i8*) #0 {
  %2 = tail call i8* @dlopen(i8* %0, i32 5) #13
  ret i8* %2
}

declare i8* @dlopen(i8*, i32) local_unnamed_addr #1

; Function Attrs: nounwind
define weak i8* @halide_default_get_library_symbol(i8*, i8*) #0 {
  %3 = icmp eq i8* %0, null
  %4 = select i1 %3, i8* inttoptr (i64 -2 to i8*), i8* %0
  %5 = tail call i8* @dlsym(i8* %4, i8* %1) #13
  ret i8* %5
}

; Function Attrs: norecurse nounwind
define weak i8* (i8*)* @halide_set_custom_get_symbol(i8* (i8*)*) local_unnamed_addr #2 {
  %2 = load i8* (i8*)*, i8* (i8*)** @_ZN6Halide7Runtime8Internal17custom_get_symbolE, align 8, !tbaa !3
  store i8* (i8*)* %0, i8* (i8*)** @_ZN6Halide7Runtime8Internal17custom_get_symbolE, align 8, !tbaa !3
  ret i8* (i8*)* %2
}

; Function Attrs: norecurse nounwind
define weak i8* (i8*)* @halide_set_custom_load_library(i8* (i8*)*) local_unnamed_addr #2 {
  %2 = load i8* (i8*)*, i8* (i8*)** @_ZN6Halide7Runtime8Internal19custom_load_libraryE, align 8, !tbaa !3
  store i8* (i8*)* %0, i8* (i8*)** @_ZN6Halide7Runtime8Internal19custom_load_libraryE, align 8, !tbaa !3
  ret i8* (i8*)* %2
}

; Function Attrs: norecurse nounwind
define weak i8* (i8*, i8*)* @halide_set_custom_get_library_symbol(i8* (i8*, i8*)*) local_unnamed_addr #2 {
  %2 = load i8* (i8*, i8*)*, i8* (i8*, i8*)** @_ZN6Halide7Runtime8Internal25custom_get_library_symbolE, align 8, !tbaa !3
  store i8* (i8*, i8*)* %0, i8* (i8*, i8*)** @_ZN6Halide7Runtime8Internal25custom_get_library_symbolE, align 8, !tbaa !3
  ret i8* (i8*, i8*)* %2
}

; Function Attrs: nounwind
define weak i8* @halide_get_symbol(i8*) local_unnamed_addr #0 {
  %2 = load i8* (i8*)*, i8* (i8*)** @_ZN6Halide7Runtime8Internal17custom_get_symbolE, align 8, !tbaa !3
  %3 = tail call i8* %2(i8* %0) #13
  ret i8* %3
}

; Function Attrs: nounwind
define weak i8* @halide_load_library(i8*) local_unnamed_addr #0 {
  %2 = load i8* (i8*)*, i8* (i8*)** @_ZN6Halide7Runtime8Internal19custom_load_libraryE, align 8, !tbaa !3
  %3 = tail call i8* %2(i8* %0) #13
  ret i8* %3
}

; Function Attrs: nounwind
define weak i8* @halide_get_library_symbol(i8*, i8*) local_unnamed_addr #0 {
  %3 = load i8* (i8*, i8*)*, i8* (i8*, i8*)** @_ZN6Halide7Runtime8Internal25custom_get_library_symbolE, align 8, !tbaa !3
  %4 = tail call i8* %3(i8* %0, i8* %1) #13
  ret i8* %4
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_get_dimensions(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 5
  %3 = load i32, i32* %2, align 4, !tbaa !79
  ret i32 %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i8* @_halide_buffer_get_host(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 2
  %3 = load i8*, i8** %2, align 8, !tbaa !83
  ret i8* %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i64 @_halide_buffer_get_device(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 0
  %3 = load i64, i64* %2, align 8, !tbaa !84
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce %struct.halide_device_interface_t* @_halide_buffer_get_device_interface(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 1
  %3 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %2, align 8, !tbaa !85
  ret %struct.halide_device_interface_t* %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_get_min(%struct.halide_buffer_t*, i32) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %4 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %3, align 8, !tbaa !86
  %5 = sext i32 %1 to i64
  %6 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %4, i64 %5, i32 0
  %7 = load i32, i32* %6, align 4, !tbaa !87
  ret i32 %7
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_get_max(%struct.halide_buffer_t*, i32) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %4 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %3, align 8, !tbaa !86
  %5 = sext i32 %1 to i64
  %6 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %4, i64 %5, i32 0
  %7 = load i32, i32* %6, align 4, !tbaa !87
  %8 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %4, i64 %5, i32 1
  %9 = load i32, i32* %8, align 4, !tbaa !89
  %10 = add i32 %7, -1
  %11 = add i32 %10, %9
  ret i32 %11
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_get_extent(%struct.halide_buffer_t*, i32) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %4 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %3, align 8, !tbaa !86
  %5 = sext i32 %1 to i64
  %6 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %4, i64 %5, i32 1
  %7 = load i32, i32* %6, align 4, !tbaa !89
  ret i32 %7
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_get_stride(%struct.halide_buffer_t*, i32) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %4 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %3, align 8, !tbaa !86
  %5 = sext i32 %1 to i64
  %6 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %4, i64 %5, i32 2
  %7 = load i32, i32* %6, align 4, !tbaa !90
  ret i32 %7
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_set_host_dirty(%struct.halide_buffer_t*, i1 zeroext) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 3
  %4 = load i64, i64* %3, align 8, !tbaa !91
  %5 = and i64 %4, -2
  %6 = or i64 %4, 1
  %7 = select i1 %1, i64 %6, i64 %5
  store i64 %7, i64* %3, align 8, !tbaa !91
  ret i32 0
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_halide_buffer_set_device_dirty(%struct.halide_buffer_t*, i1 zeroext) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 3
  %4 = load i64, i64* %3, align 8, !tbaa !91
  %5 = and i64 %4, -3
  %6 = or i64 %4, 2
  %7 = select i1 %1, i64 %6, i64 %5
  store i64 %7, i64* %3, align 8, !tbaa !91
  ret i32 0
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce zeroext i1 @_halide_buffer_get_host_dirty(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 3
  %3 = load i64, i64* %2, align 8, !tbaa !91
  %4 = and i64 %3, 1
  %5 = icmp ne i64 %4, 0
  ret i1 %5
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce zeroext i1 @_halide_buffer_get_device_dirty(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 3
  %3 = load i64, i64* %2, align 8, !tbaa !91
  %4 = and i64 %3, 2
  %5 = icmp ne i64 %4, 0
  ret i1 %5
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce %struct.halide_dimension_t* @_halide_buffer_get_shape(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %3 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %2, align 8, !tbaa !86
  ret %struct.halide_dimension_t* %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce zeroext i1 @_halide_buffer_is_bounds_query(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 2
  %3 = load i8*, i8** %2, align 8, !tbaa !83
  %4 = icmp eq i8* %3, null
  br i1 %4, label %5, label %9

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !84
  %8 = icmp eq i64 %7, 0
  br label %9

; <label>:9:                                      ; preds = %5, %1
  %10 = phi i1 [ false, %1 ], [ %8, %5 ]
  ret i1 %10
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce zeroext i8 @_halide_buffer_get_type_code(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 0
  %3 = load i8, i8* %2, align 8, !tbaa !92
  ret i8 %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce zeroext i8 @_halide_buffer_get_type_bits(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 1
  %3 = load i8, i8* %2, align 1, !tbaa !93
  ret i8 %3
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce zeroext i16 @_halide_buffer_get_type_lanes(%struct.halide_buffer_t*) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 2
  %3 = load i16, i16* %2, align 2, !tbaa !94
  ret i16 %3
}

; Function Attrs: alwaysinline nounwind
define linkonce %struct.halide_buffer_t* @_halide_buffer_init(%struct.halide_buffer_t*, %struct.halide_dimension_t*, i8*, i64, %struct.halide_device_interface_t*, i32, i32, i32, %struct.halide_dimension_t*, i64) local_unnamed_addr #5 {
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 2
  store i8* %2, i8** %11, align 8, !tbaa !83
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 0
  store i64 %3, i64* %12, align 8, !tbaa !84
  %13 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 1
  store %struct.halide_device_interface_t* %4, %struct.halide_device_interface_t** %13, align 8, !tbaa !85
  %14 = trunc i32 %5 to i8
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 0
  store i8 %14, i8* %15, align 8, !tbaa !92
  %16 = trunc i32 %6 to i8
  %17 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 1
  store i8 %16, i8* %17, align 1, !tbaa !93
  %18 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 2
  store i16 1, i16* %18, align 2, !tbaa !94
  %19 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 5
  store i32 %7, i32* %19, align 4, !tbaa !79
  %20 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  store %struct.halide_dimension_t* %1, %struct.halide_dimension_t** %20, align 8, !tbaa !86
  %21 = icmp ne %struct.halide_dimension_t* %8, %1
  %22 = icmp sgt i32 %7, 0
  %23 = and i1 %21, %22
  br i1 %23, label %24, label %38

; <label>:24:                                     ; preds = %10
  %25 = zext i32 %7 to i64
  %26 = bitcast %struct.halide_dimension_t* %1 to i8*
  %27 = bitcast %struct.halide_dimension_t* %8 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %26, i8* align 4 %27, i64 16, i1 false), !tbaa.struct !95
  %28 = icmp eq i32 %7, 1
  br i1 %28, label %38, label %29

; <label>:29:                                     ; preds = %29, %24
  %30 = phi i64 [ %36, %29 ], [ 1, %24 ]
  %31 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %20, align 8, !tbaa !86
  %32 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %8, i64 %30
  %33 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %31, i64 %30
  %34 = bitcast %struct.halide_dimension_t* %33 to i8*
  %35 = bitcast %struct.halide_dimension_t* %32 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %34, i8* align 4 %35, i64 16, i1 false), !tbaa.struct !95
  %36 = add nuw nsw i64 %30, 1
  %37 = icmp eq i64 %36, %25
  br i1 %37, label %38, label %29

; <label>:38:                                     ; preds = %29, %24, %10
  %39 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 3
  store i64 %9, i64* %39, align 8, !tbaa !91
  ret %struct.halide_buffer_t* %0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #3

; Function Attrs: alwaysinline nounwind
define linkonce %struct.halide_buffer_t* @_halide_buffer_init_from_buffer(%struct.halide_buffer_t*, %struct.halide_dimension_t*, %struct.halide_buffer_t*) local_unnamed_addr #5 {
  %4 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 2
  %5 = bitcast i8** %4 to i64*
  %6 = load i64, i64* %5, align 8, !tbaa !83
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 2
  %8 = bitcast i8** %7 to i64*
  store i64 %6, i64* %8, align 8, !tbaa !83
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !84
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 0
  store i64 %10, i64* %11, align 8, !tbaa !84
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 1
  %13 = bitcast %struct.halide_device_interface_t** %12 to i64*
  %14 = load i64, i64* %13, align 8, !tbaa !85
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 1
  %16 = bitcast %struct.halide_device_interface_t** %15 to i64*
  store i64 %14, i64* %16, align 8, !tbaa !85
  %17 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 4, i32 0
  %18 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4, i32 0
  %19 = bitcast i8* %18 to i32*
  %20 = bitcast i8* %17 to i32*
  %21 = load i32, i32* %19, align 2
  store i32 %21, i32* %20, align 8
  %22 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 5
  %23 = load i32, i32* %22, align 4, !tbaa !79
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 5
  store i32 %23, i32* %24, align 4, !tbaa !79
  %25 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  store %struct.halide_dimension_t* %1, %struct.halide_dimension_t** %25, align 8, !tbaa !86
  %26 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 3
  %27 = load i64, i64* %26, align 8, !tbaa !91
  %28 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 3
  store i64 %27, i64* %28, align 8, !tbaa !91
  %29 = icmp sgt i32 %23, 0
  br i1 %29, label %30, label %37

; <label>:30:                                     ; preds = %3
  %31 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 6
  %32 = bitcast %struct.halide_dimension_t** %31 to i8**
  %33 = load i8*, i8** %32, align 8, !tbaa !86
  %34 = bitcast %struct.halide_dimension_t* %1 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %34, i8* align 4 %33, i64 16, i1 false), !tbaa.struct !95
  %35 = load i32, i32* %24, align 4, !tbaa !79
  %36 = icmp sgt i32 %35, 1
  br i1 %36, label %38, label %37

; <label>:37:                                     ; preds = %38, %30, %3
  ret %struct.halide_buffer_t* %0

; <label>:38:                                     ; preds = %38, %30
  %39 = phi i64 [ %46, %38 ], [ 1, %30 ]
  %40 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %25, align 8, !tbaa !86
  %41 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %31, align 8, !tbaa !86
  %42 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %41, i64 %39
  %43 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %40, i64 %39
  %44 = bitcast %struct.halide_dimension_t* %43 to i8*
  %45 = bitcast %struct.halide_dimension_t* %42 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %44, i8* align 4 %45, i64 16, i1 false), !tbaa.struct !95
  %46 = add nuw nsw i64 %39, 1
  %47 = load i32, i32* %24, align 4, !tbaa !79
  %48 = sext i32 %47 to i64
  %49 = icmp slt i64 %46, %48
  br i1 %49, label %38, label %37
}

; Function Attrs: alwaysinline nounwind
define linkonce %struct.halide_buffer_t* @_halide_buffer_crop(i8*, %struct.halide_buffer_t*, %struct.halide_dimension_t*, %struct.halide_buffer_t*, i32*, i32*) local_unnamed_addr #5 {
  %7 = bitcast %struct.halide_buffer_t* %1 to i8*
  %8 = bitcast %struct.halide_buffer_t* %3 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %7, i8* align 8 %8, i64 56, i1 false), !tbaa.struct !97
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 6
  store %struct.halide_dimension_t* %2, %struct.halide_dimension_t** %9, align 8, !tbaa !86
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 5
  %11 = load i32, i32* %10, align 4, !tbaa !79
  %12 = icmp sgt i32 %11, 0
  br i1 %12, label %13, label %16

; <label>:13:                                     ; preds = %6
  %14 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %15 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %14, align 8, !tbaa !86
  br label %21

; <label>:16:                                     ; preds = %21, %6
  %17 = phi i64 [ 0, %6 ], [ %46, %21 ]
  %18 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 2
  %19 = load i8*, i8** %18, align 8, !tbaa !83
  %20 = icmp eq i8* %19, null
  br i1 %20, label %59, label %51

; <label>:21:                                     ; preds = %21, %13
  %22 = phi %struct.halide_dimension_t* [ %2, %13 ], [ %32, %21 ]
  %23 = phi %struct.halide_dimension_t* [ %15, %13 ], [ %38, %21 ]
  %24 = phi i64 [ 0, %13 ], [ %47, %21 ]
  %25 = phi i64 [ 0, %13 ], [ %46, %21 ]
  %26 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %23, i64 %24
  %27 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %22, i64 %24
  %28 = bitcast %struct.halide_dimension_t* %27 to i8*
  %29 = bitcast %struct.halide_dimension_t* %26 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %28, i8* align 4 %29, i64 16, i1 false), !tbaa.struct !95
  %30 = getelementptr inbounds i32, i32* %4, i64 %24
  %31 = load i32, i32* %30, align 4, !tbaa !96
  %32 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %9, align 8, !tbaa !86
  %33 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %32, i64 %24, i32 0
  store i32 %31, i32* %33, align 4, !tbaa !87
  %34 = getelementptr inbounds i32, i32* %5, i64 %24
  %35 = load i32, i32* %34, align 4, !tbaa !96
  %36 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %32, i64 %24, i32 1
  store i32 %35, i32* %36, align 4, !tbaa !89
  %37 = load i32, i32* %30, align 4, !tbaa !96
  %38 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %14, align 8, !tbaa !86
  %39 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %38, i64 %24, i32 0
  %40 = load i32, i32* %39, align 4, !tbaa !87
  %41 = sub nsw i32 %37, %40
  %42 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %38, i64 %24, i32 2
  %43 = load i32, i32* %42, align 4, !tbaa !90
  %44 = mul nsw i32 %41, %43
  %45 = sext i32 %44 to i64
  %46 = add nsw i64 %25, %45
  %47 = add nuw nsw i64 %24, 1
  %48 = load i32, i32* %10, align 4, !tbaa !79
  %49 = sext i32 %48 to i64
  %50 = icmp slt i64 %47, %49
  br i1 %50, label %21, label %16

; <label>:51:                                     ; preds = %16
  %52 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  %53 = load i8, i8* %52, align 1, !tbaa !99
  %54 = zext i8 %53 to i64
  %55 = add nuw nsw i64 %54, 7
  %56 = lshr i64 %55, 3
  %57 = mul nsw i64 %56, %17
  %58 = getelementptr inbounds i8, i8* %19, i64 %57
  store i8* %58, i8** %18, align 8, !tbaa !83
  br label %59

; <label>:59:                                     ; preds = %51, %16
  %60 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  store %struct.halide_device_interface_t* null, %struct.halide_device_interface_t** %60, align 8, !tbaa !85
  %61 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  store i64 0, i64* %61, align 8, !tbaa !84
  %62 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  %63 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %62, align 8, !tbaa !85
  %64 = icmp eq %struct.halide_device_interface_t* %63, null
  br i1 %64, label %69, label %65

; <label>:65:                                     ; preds = %59
  %66 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %63, i64 0, i32 9
  %67 = load i32 (i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*)** %66, align 8, !tbaa !100
  %68 = tail call i32 %67(i8* %0, %struct.halide_buffer_t* nonnull %3, %struct.halide_buffer_t* nonnull %1) #13
  br label %69

; <label>:69:                                     ; preds = %65, %59
  ret %struct.halide_buffer_t* %1
}

; Function Attrs: alwaysinline nounwind
define linkonce void @_halide_buffer_retire_crop_after_extern_stage(i8*, i8*) local_unnamed_addr #5 {
  %3 = bitcast i8* %1 to %struct.halide_buffer_t**
  %4 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %3, align 8, !tbaa !3
  %5 = getelementptr inbounds i8, i8* %1, i64 8
  %6 = bitcast i8* %5 to %struct.halide_buffer_t**
  %7 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %6, align 8, !tbaa !3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !84
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %11, label %13

; <label>:11:                                     ; preds = %2
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 3
  br label %44

; <label>:13:                                     ; preds = %2
  %14 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !84
  %16 = icmp eq i64 %15, 0
  %17 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 3
  %18 = load i64, i64* %17, align 8, !tbaa !91
  %19 = and i64 %18, 2
  %20 = icmp ne i64 %19, 0
  br i1 %16, label %21, label %33

; <label>:21:                                     ; preds = %13
  %22 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 1
  br i1 %20, label %23, label %28

; <label>:23:                                     ; preds = %21
  %24 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %22, align 8, !tbaa !85
  %25 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %24, i64 0, i32 4
  %26 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %25, align 8, !tbaa !102
  %27 = tail call i32 %26(i8* %0, %struct.halide_buffer_t* nonnull %4) #13
  br label %28

; <label>:28:                                     ; preds = %23, %21
  %29 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %22, align 8, !tbaa !85
  %30 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %29, i64 0, i32 1
  %31 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %30, align 8, !tbaa !103
  %32 = tail call i32 %31(i8* %0, %struct.halide_buffer_t* nonnull %4) #13
  br label %44

; <label>:33:                                     ; preds = %13
  br i1 %20, label %34, label %38

; <label>:34:                                     ; preds = %33
  %35 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 3
  %36 = load i64, i64* %35, align 8, !tbaa !91
  %37 = or i64 %36, 2
  store i64 %37, i64* %35, align 8, !tbaa !91
  br label %38

; <label>:38:                                     ; preds = %34, %33
  %39 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 1
  %40 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %39, align 8, !tbaa !85
  %41 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %40, i64 0, i32 11
  %42 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %41, align 8, !tbaa !104
  %43 = tail call i32 %42(i8* %0, %struct.halide_buffer_t* nonnull %4) #13
  br label %44

; <label>:44:                                     ; preds = %38, %28, %11
  %45 = phi i64* [ %12, %11 ], [ %17, %28 ], [ %17, %38 ]
  %46 = load i64, i64* %45, align 8, !tbaa !91
  %47 = and i64 %46, 1
  %48 = icmp eq i64 %47, 0
  br i1 %48, label %53, label %49

; <label>:49:                                     ; preds = %44
  %50 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 3
  %51 = load i64, i64* %50, align 8, !tbaa !91
  %52 = or i64 %51, 1
  store i64 %52, i64* %50, align 8, !tbaa !91
  br label %53

; <label>:53:                                     ; preds = %49, %44
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce void @_halide_buffer_retire_crops_after_extern_stage(i8*, i8*) local_unnamed_addr #5 {
  %3 = bitcast i8* %1 to %struct.halide_buffer_t**
  %4 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %3, align 8, !tbaa !3
  %5 = icmp eq %struct.halide_buffer_t* %4, null
  br i1 %5, label %60, label %6

; <label>:6:                                      ; preds = %56, %2
  %7 = phi %struct.halide_buffer_t* [ %58, %56 ], [ %4, %2 ]
  %8 = phi %struct.halide_buffer_t** [ %57, %56 ], [ %3, %2 ]
  %9 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %8, i64 1
  %10 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %9, align 8, !tbaa !3
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %6
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 3
  br label %47

; <label>:16:                                     ; preds = %6
  %17 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %10, i64 0, i32 0
  %18 = load i64, i64* %17, align 8, !tbaa !84
  %19 = icmp eq i64 %18, 0
  %20 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 3
  %21 = load i64, i64* %20, align 8, !tbaa !91
  %22 = and i64 %21, 2
  %23 = icmp ne i64 %22, 0
  br i1 %19, label %24, label %36

; <label>:24:                                     ; preds = %16
  %25 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 1
  br i1 %23, label %26, label %31

; <label>:26:                                     ; preds = %24
  %27 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %25, align 8, !tbaa !85
  %28 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %27, i64 0, i32 4
  %29 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %28, align 8, !tbaa !102
  %30 = tail call i32 %29(i8* %0, %struct.halide_buffer_t* nonnull %7) #13
  br label %31

; <label>:31:                                     ; preds = %26, %24
  %32 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %25, align 8, !tbaa !85
  %33 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %32, i64 0, i32 1
  %34 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %33, align 8, !tbaa !103
  %35 = tail call i32 %34(i8* %0, %struct.halide_buffer_t* nonnull %7) #13
  br label %47

; <label>:36:                                     ; preds = %16
  br i1 %23, label %37, label %41

; <label>:37:                                     ; preds = %36
  %38 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %10, i64 0, i32 3
  %39 = load i64, i64* %38, align 8, !tbaa !91
  %40 = or i64 %39, 2
  store i64 %40, i64* %38, align 8, !tbaa !91
  br label %41

; <label>:41:                                     ; preds = %37, %36
  %42 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 1
  %43 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %42, align 8, !tbaa !85
  %44 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %43, i64 0, i32 11
  %45 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %44, align 8, !tbaa !104
  %46 = tail call i32 %45(i8* %0, %struct.halide_buffer_t* nonnull %7) #13
  br label %47

; <label>:47:                                     ; preds = %41, %31, %14
  %48 = phi i64* [ %15, %14 ], [ %20, %31 ], [ %20, %41 ]
  %49 = load i64, i64* %48, align 8, !tbaa !91
  %50 = and i64 %49, 1
  %51 = icmp eq i64 %50, 0
  br i1 %51, label %56, label %52

; <label>:52:                                     ; preds = %47
  %53 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %10, i64 0, i32 3
  %54 = load i64, i64* %53, align 8, !tbaa !91
  %55 = or i64 %54, 1
  store i64 %55, i64* %53, align 8, !tbaa !91
  br label %56

; <label>:56:                                     ; preds = %52, %47
  %57 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %8, i64 2
  %58 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %57, align 8, !tbaa !3
  %59 = icmp eq %struct.halide_buffer_t* %58, null
  br i1 %59, label %60, label %6

; <label>:60:                                     ; preds = %56, %2
  ret void
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce %struct.halide_buffer_t* @_halide_buffer_set_bounds(%struct.halide_buffer_t*, i32, i32, i32) local_unnamed_addr #4 {
  %5 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %6 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %5, align 8, !tbaa !86
  %7 = sext i32 %1 to i64
  %8 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %6, i64 %7, i32 0
  store i32 %2, i32* %8, align 4, !tbaa !87
  %9 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %6, i64 %7, i32 1
  store i32 %3, i32* %9, align 4, !tbaa !89
  ret %struct.halide_buffer_t* %0
}

; Function Attrs: alwaysinline nounwind
define linkonce void @call_destructor(i8*, void (i8*, i8*)*, i8**, i1 zeroext) #5 comdat {
  %5 = load i8*, i8** %2, align 8, !tbaa !3
  store i8* null, i8** %2, align 8, !tbaa !3
  %6 = icmp eq i8* %5, null
  %7 = xor i1 %3, true
  %8 = or i1 %6, %7
  br i1 %8, label %10, label %9

; <label>:9:                                      ; preds = %4
  tail call void %1(i8* %0, i8* nonnull %5) #13
  br label %10

; <label>:10:                                     ; preds = %9, %4
  ret void
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @sqrt_f32(float %x) #6 {
  %y = tail call float @llvm.sqrt.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.sqrt.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @sqrt_f64(double %x) #6 {
  %y = tail call double @llvm.sqrt.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.sqrt.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @sin_f32(float %x) #6 {
  %y = tail call float @llvm.sin.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.sin.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @sin_f64(double %x) #6 {
  %y = tail call double @llvm.sin.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.sin.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @cos_f32(float %x) #6 {
  %y = tail call float @llvm.cos.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.cos.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @cos_f64(double %x) #6 {
  %y = tail call double @llvm.cos.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.cos.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @exp_f32(float %x) #6 {
  %y = tail call float @llvm.exp.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.exp.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @exp_f64(double %x) #6 {
  %y = tail call double @llvm.exp.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.exp.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @log_f32(float %x) #6 {
  %y = tail call float @llvm.log.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.log.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @log_f64(double %x) #6 {
  %y = tail call double @llvm.log.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.log.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @abs_f32(float %x) #6 {
  %y = tail call float @llvm.fabs.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.fabs.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @abs_f64(double %x) #6 {
  %y = tail call double @llvm.fabs.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.fabs.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @floor_f32(float %x) #6 {
  %y = tail call float @llvm.floor.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.floor.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @floor_f64(double %x) #6 {
  %y = tail call double @llvm.floor.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.floor.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @ceil_f32(float %x) #6 {
  %y = tail call float @ceilf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @ceilf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @ceil_f64(double %x) #6 {
  %y = tail call double @ceil(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @ceil(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @round_f32(float %x) #6 {
  %y = tail call float @llvm.nearbyint.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.nearbyint.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @round_f64(double %x) #6 {
  %y = tail call double @llvm.nearbyint.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.nearbyint.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @trunc_f32(float %x) #6 {
  %y = tail call float @llvm.trunc.f32(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.trunc.f32(float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @trunc_f64(double %x) #6 {
  %y = tail call double @llvm.trunc.f64(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.trunc.f64(double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @pow_f32(float %x, float %y) #6 {
  %z = tail call float @llvm.pow.f32(float %x, float %y) #8
  ret float %z
}

; Function Attrs: nounwind readnone speculatable
declare float @llvm.pow.f32(float, float) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @pow_f64(double %x, double %y) #6 {
  %z = tail call double @llvm.pow.f64(double %x, double %y) #8
  ret double %z
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.pow.f64(double, double) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @asin_f32(float %x) #6 {
  %y = tail call float @asinf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @asinf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @asin_f64(double %x) #6 {
  %y = tail call double @asin(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @asin(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @acos_f32(float %x) #6 {
  %y = tail call float @acosf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @acosf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @acos_f64(double %x) #6 {
  %y = tail call double @acos(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @acos(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @tan_f32(float %x) #6 {
  %y = tail call float @tanf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @tanf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @tan_f64(double %x) #6 {
  %y = tail call double @tan(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @tan(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @atan_f32(float %x) #6 {
  %y = tail call float @atanf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @atanf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @atan_f64(double %x) #6 {
  %y = tail call double @atan(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @atan(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @atan2_f32(float %y, float %x) #6 {
  %z = tail call float @atan2f(float %y, float %x) #8
  ret float %z
}

; Function Attrs: nounwind readnone
declare float @atan2f(float, float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @atan2_f64(double %y, double %x) #6 {
  %z = tail call double @atan2(double %y, double %x) #8
  ret double %z
}

; Function Attrs: nounwind readnone
declare double @atan2(double, double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @sinh_f32(float %x) #6 {
  %y = tail call float @sinhf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @sinhf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @sinh_f64(double %x) #6 {
  %y = tail call double @sinh(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @sinh(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @asinh_f32(float %x) #6 {
  %y = tail call float @asinhf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @asinhf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @asinh_f64(double %x) #6 {
  %y = tail call double @asinh(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @asinh(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @cosh_f32(float %x) #6 {
  %y = tail call float @coshf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @coshf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @cosh_f64(double %x) #6 {
  %y = tail call double @cosh(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @cosh(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @acosh_f32(float %x) #6 {
  %y = tail call float @acoshf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @acoshf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @acosh_f64(double %x) #6 {
  %y = tail call double @acosh(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @acosh(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @tanh_f32(float %x) #6 {
  %y = tail call float @tanhf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @tanhf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @tanh_f64(double %x) #6 {
  %y = tail call double @tanh(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @tanh(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @atanh_f32(float %x) #6 {
  %y = tail call float @atanhf(float %x) #8
  ret float %y
}

; Function Attrs: nounwind readnone
declare float @atanhf(float) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @atanh_f64(double %x) #6 {
  %y = tail call double @atanh(double %x) #8
  ret double %y
}

; Function Attrs: nounwind readnone
declare double @atanh(double) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @inf_f32() #6 {
  ret float 0x7FF0000000000000
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @neg_inf_f32() #6 {
  ret float 0xFFF0000000000000
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @nan_f32() #6 {
  ret float 0x7FF8000000000000
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @inf_f64() #6 {
  ret double 0x7FF0000000000000
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @neg_inf_f64() #6 {
  ret double 0xFFF0000000000000
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr double @nan_f64() #6 {
  ret double 0x7FF8000000000000
}

; Function Attrs: norecurse nounwind
define weak void @halide_set_gpu_device(i32) local_unnamed_addr #2 {
  store i32 %0, i32* @_ZN6Halide7Runtime8Internal17halide_gpu_deviceE, align 4, !tbaa !96
  store i8 1, i8* @_ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE, align 1, !tbaa !8
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_get_gpu_device(i8*) local_unnamed_addr #0 {
  br label %2

; <label>:2:                                      ; preds = %2, %1
  %3 = atomicrmw xchg i32* @_ZN6Halide7Runtime8Internal22halide_gpu_device_lockE, i32 1 seq_cst
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %2

; <label>:5:                                      ; preds = %2
  %6 = load i8, i8* @_ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE, align 1, !tbaa !8, !range !10
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %5
  %9 = load i32, i32* @_ZN6Halide7Runtime8Internal17halide_gpu_deviceE, align 4, !tbaa !96
  br label %17

; <label>:10:                                     ; preds = %5
  %11 = tail call i8* @getenv(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.9, i64 0, i64 0)) #13
  %12 = icmp eq i8* %11, null
  br i1 %12, label %15, label %13

; <label>:13:                                     ; preds = %10
  %14 = tail call i32 @atoi(i8* nonnull %11) #13
  br label %15

; <label>:15:                                     ; preds = %13, %10
  %16 = phi i32 [ %14, %13 ], [ -1, %10 ]
  store i32 %16, i32* @_ZN6Halide7Runtime8Internal17halide_gpu_deviceE, align 4, !tbaa !96
  store i8 1, i8* @_ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE, align 1, !tbaa !8
  br label %17

; <label>:17:                                     ; preds = %15, %8
  %18 = phi i32 [ %9, %8 ], [ %16, %15 ]
  store atomic i32 0, i32* @_ZN6Halide7Runtime8Internal22halide_gpu_device_lockE release, align 4
  ret i32 %18
}

; Function Attrs: nounwind
define weak i32 @halide_default_trace(i8*, %struct.halide_trace_event_t*) #0 {
  %3 = alloca [4096 x i8], align 1
  %4 = atomicrmw add i32* @_ZZ20halide_default_traceE3ids, i32 1 seq_cst
  %5 = tail call i32 @halide_get_trace_file(i8* %0) #15
  %6 = icmp sgt i32 %5, 0
  br i1 %6, label %7, label %249

; <label>:7:                                      ; preds = %2
  %8 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 4
  %9 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 4, i32 2
  %10 = load i16, i16* %9, align 2, !tbaa !105
  %11 = zext i16 %10 to i32
  %12 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 4, i32 1
  %13 = load i8, i8* %12, align 1, !tbaa !99
  %14 = zext i8 %13 to i32
  %15 = add nuw nsw i32 %14, 7
  %16 = lshr i32 %15, 3
  %17 = mul nuw nsw i32 %16, %11
  %18 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 8
  %19 = load i32, i32* %18, align 8, !tbaa !108
  %20 = shl i32 %19, 2
  %21 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 0
  %22 = load i8*, i8** %21, align 8, !tbaa !109
  %23 = tail call i64 @strlen(i8* %22) #13
  %24 = trunc i64 %23 to i32
  %25 = add i32 %24, 1
  %26 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 3
  %27 = load i8*, i8** %26, align 8, !tbaa !110
  %28 = icmp eq i8* %27, null
  br i1 %28, label %33, label %29

; <label>:29:                                     ; preds = %7
  %30 = tail call i64 @strlen(i8* nonnull %27) #13
  %31 = trunc i64 %30 to i32
  %32 = add i32 %31, 1
  br label %33

; <label>:33:                                     ; preds = %29, %7
  %34 = phi i32 [ %32, %29 ], [ 1, %7 ]
  %35 = add i32 %20, 31
  %36 = add i32 %35, %17
  %37 = add i32 %36, %25
  %38 = add i32 %37, %34
  %39 = and i32 %38, -4
  %40 = load %"class.Halide::Runtime::Internal::TraceBuffer"*, %"class.Halide::Runtime::Internal::TraceBuffer"** @_ZN6Halide7Runtime8Internal19halide_trace_bufferE, align 8, !tbaa !3
  %41 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %40, i64 0, i32 0, i32 0
  %42 = icmp ult i32 %39, 1048577
  %43 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %40, i64 0, i32 1
  %44 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %40, i64 0, i32 2
  %45 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %40, i64 0, i32 3, i64 0
  br i1 %42, label %46, label %78

; <label>:46:                                     ; preds = %52, %33
  %47 = load volatile i32, i32* %41, align 4, !tbaa !111
  %48 = and i32 %47, 1073741823
  %49 = add nuw nsw i32 %48, 1
  %50 = cmpxchg i32* %41, i32 %48, i32 %49 seq_cst seq_cst
  %51 = extractvalue { i32, i1 } %50, 1
  br i1 %51, label %53, label %52

; <label>:52:                                     ; preds = %76, %75, %67, %46
  br label %46

; <label>:53:                                     ; preds = %46
  %54 = atomicrmw add i32* %43, i32 %39 seq_cst
  %55 = add i32 %54, %39
  %56 = icmp ugt i32 %55, 1048576
  br i1 %56, label %57, label %110

; <label>:57:                                     ; preds = %53
  %58 = atomicrmw add i32* %44, i32 %39 seq_cst
  %59 = atomicrmw sub i32* %41, i32 1 seq_cst
  br label %60

; <label>:60:                                     ; preds = %60, %57
  %61 = atomicrmw or i32* %41, i32 1073741824 seq_cst
  %62 = cmpxchg i32* %41, i32 1073741824, i32 -2147483648 seq_cst seq_cst
  %63 = extractvalue { i32, i1 } %62, 1
  br i1 %63, label %64, label %60

; <label>:64:                                     ; preds = %60
  %65 = load i32, i32* %43, align 4, !tbaa !113
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %76, label %67

; <label>:67:                                     ; preds = %64
  %68 = load i32, i32* %44, align 4, !tbaa !115
  %69 = sub i32 %65, %68
  store i32 %69, i32* %43, align 4, !tbaa !113
  %70 = zext i32 %69 to i64
  %71 = tail call i64 @write(i32 %5, i8* nonnull %45, i64 %70) #13
  %72 = trunc i64 %71 to i32
  %73 = icmp eq i32 %69, %72
  store i32 0, i32* %43, align 4, !tbaa !113
  store i32 0, i32* %44, align 4, !tbaa !115
  %74 = atomicrmw and i32* %41, i32 2147483647 seq_cst
  br i1 %73, label %52, label %75

; <label>:75:                                     ; preds = %67
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([121 x i8], [121 x i8]* @.str.32, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %52

; <label>:76:                                     ; preds = %64
  %77 = atomicrmw and i32* %41, i32 2147483647 seq_cst
  br label %52

; <label>:78:                                     ; preds = %84, %33
  %79 = load volatile i32, i32* %41, align 4, !tbaa !111
  %80 = and i32 %79, 1073741823
  %81 = add nuw nsw i32 %80, 1
  %82 = cmpxchg i32* %41, i32 %80, i32 %81 seq_cst seq_cst
  %83 = extractvalue { i32, i1 } %82, 1
  br i1 %83, label %85, label %84

; <label>:84:                                     ; preds = %108, %107, %99, %78
  br label %78

; <label>:85:                                     ; preds = %78
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([97 x i8], [97 x i8]* @.str.31, i64 0, i64 0)) #13
  tail call void @abort() #13
  %86 = atomicrmw add i32* %43, i32 %39 seq_cst
  %87 = add i32 %86, %39
  %88 = icmp ugt i32 %87, 1048576
  br i1 %88, label %89, label %110

; <label>:89:                                     ; preds = %85
  %90 = atomicrmw add i32* %44, i32 %39 seq_cst
  %91 = atomicrmw sub i32* %41, i32 1 seq_cst
  br label %92

; <label>:92:                                     ; preds = %92, %89
  %93 = atomicrmw or i32* %41, i32 1073741824 seq_cst
  %94 = cmpxchg i32* %41, i32 1073741824, i32 -2147483648 seq_cst seq_cst
  %95 = extractvalue { i32, i1 } %94, 1
  br i1 %95, label %96, label %92

; <label>:96:                                     ; preds = %92
  %97 = load i32, i32* %43, align 4, !tbaa !113
  %98 = icmp eq i32 %97, 0
  br i1 %98, label %108, label %99

; <label>:99:                                     ; preds = %96
  %100 = load i32, i32* %44, align 4, !tbaa !115
  %101 = sub i32 %97, %100
  store i32 %101, i32* %43, align 4, !tbaa !113
  %102 = zext i32 %101 to i64
  %103 = tail call i64 @write(i32 %5, i8* nonnull %45, i64 %102) #13
  %104 = trunc i64 %103 to i32
  %105 = icmp eq i32 %101, %104
  store i32 0, i32* %43, align 4, !tbaa !113
  store i32 0, i32* %44, align 4, !tbaa !115
  %106 = atomicrmw and i32* %41, i32 2147483647 seq_cst
  br i1 %105, label %84, label %107

; <label>:107:                                    ; preds = %99
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([121 x i8], [121 x i8]* @.str.32, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %84

; <label>:108:                                    ; preds = %96
  %109 = atomicrmw and i32* %41, i32 2147483647 seq_cst
  br label %84

; <label>:110:                                    ; preds = %85, %53
  %111 = phi i32 [ %54, %53 ], [ %86, %85 ]
  %112 = zext i32 %111 to i64
  %113 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %40, i64 0, i32 3, i64 %112
  %114 = icmp ugt i32 %39, 4096
  br i1 %114, label %115, label %132

; <label>:115:                                    ; preds = %110
  %116 = tail call i8* @halide_malloc(i8* null, i64 1024) #13
  %117 = ptrtoint i8* %116 to i64
  %118 = icmp eq i8* %116, null
  br i1 %118, label %121, label %119

; <label>:119:                                    ; preds = %115
  %120 = getelementptr inbounds i8, i8* %116, i64 1023
  store i8 0, i8* %120, align 1, !tbaa !7
  br label %121

; <label>:121:                                    ; preds = %119, %115
  %122 = phi i8* [ %120, %119 ], [ null, %115 ]
  %123 = zext i32 %39 to i64
  %124 = tail call i8* @halide_uint64_to_string(i8* %116, i8* %122, i64 %123, i32 1) #13
  %125 = tail call i8* @halide_string_to_string(i8* %124, i8* %122, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i64 0, i64 0)) #13
  br i1 %118, label %126, label %127

; <label>:126:                                    ; preds = %121
  tail call void @halide_error(i8* null, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.33, i64 0, i64 0)) #13
  br label %131

; <label>:127:                                    ; preds = %121
  %128 = ptrtoint i8* %125 to i64
  %129 = sub i64 1, %117
  %130 = add i64 %129, %128
  tail call void @halide_msan_annotate_memory_is_initialized(i8* null, i8* nonnull %116, i64 %130) #13
  tail call void @halide_print(i8* null, i8* nonnull %116) #13
  br label %131

; <label>:131:                                    ; preds = %127, %126
  tail call void @halide_free(i8* null, i8* %116) #13
  br label %132

; <label>:132:                                    ; preds = %131, %110
  %133 = bitcast i8* %113 to i32*
  store i32 %39, i32* %133, align 4, !tbaa !116
  %134 = getelementptr inbounds i8, i8* %113, i64 4
  %135 = bitcast i8* %134 to i32*
  store i32 %4, i32* %135, align 4, !tbaa !118
  %136 = getelementptr inbounds i8, i8* %113, i64 8
  %137 = bitcast %struct.halide_type_t* %8 to i32*
  %138 = bitcast i8* %136 to i32*
  %139 = load i32, i32* %137, align 2
  store i32 %139, i32* %138, align 4
  %140 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 5
  %141 = load i32, i32* %140, align 4, !tbaa !119
  %142 = getelementptr inbounds i8, i8* %113, i64 12
  %143 = bitcast i8* %142 to i32*
  store i32 %141, i32* %143, align 4, !tbaa !120
  %144 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 6
  %145 = load i32, i32* %144, align 8, !tbaa !121
  %146 = getelementptr inbounds i8, i8* %113, i64 16
  %147 = bitcast i8* %146 to i32*
  store i32 %145, i32* %147, align 4, !tbaa !122
  %148 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 7
  %149 = load i32, i32* %148, align 4, !tbaa !123
  %150 = getelementptr inbounds i8, i8* %113, i64 20
  %151 = bitcast i8* %150 to i32*
  store i32 %149, i32* %151, align 4, !tbaa !124
  %152 = load i32, i32* %18, align 8, !tbaa !108
  %153 = getelementptr inbounds i8, i8* %113, i64 24
  %154 = bitcast i8* %153 to i32*
  store i32 %152, i32* %154, align 4, !tbaa !125
  %155 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 2
  %156 = load i32*, i32** %155, align 8, !tbaa !126
  %157 = icmp eq i32* %156, null
  br i1 %157, label %163, label %158

; <label>:158:                                    ; preds = %132
  %159 = bitcast i32* %156 to i8*
  %160 = getelementptr inbounds i8, i8* %113, i64 28
  %161 = zext i32 %20 to i64
  %162 = tail call i8* @memcpy(i8* nonnull %160, i8* %159, i64 %161) #13
  br label %163

; <label>:163:                                    ; preds = %158, %132
  %164 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 1
  %165 = load i8*, i8** %164, align 8, !tbaa !127
  %166 = icmp eq i8* %165, null
  %167 = getelementptr inbounds i8, i8* %113, i64 28
  %168 = bitcast i8* %167 to i32*
  br i1 %166, label %176, label %169

; <label>:169:                                    ; preds = %163
  %170 = load i32, i32* %154, align 4, !tbaa !125
  %171 = sext i32 %170 to i64
  %172 = getelementptr inbounds i32, i32* %168, i64 %171
  %173 = bitcast i32* %172 to i8*
  %174 = zext i32 %17 to i64
  %175 = tail call i8* @memcpy(i8* nonnull %173, i8* nonnull %165, i64 %174) #13
  br label %176

; <label>:176:                                    ; preds = %169, %163
  %177 = load i32, i32* %154, align 4, !tbaa !125
  %178 = sext i32 %177 to i64
  %179 = getelementptr inbounds i32, i32* %168, i64 %178
  %180 = bitcast i32* %179 to i8*
  %181 = getelementptr inbounds i8, i8* %113, i64 10
  %182 = bitcast i8* %181 to i16*
  %183 = load i16, i16* %182, align 2, !tbaa !128
  %184 = zext i16 %183 to i32
  %185 = getelementptr inbounds i8, i8* %113, i64 9
  %186 = load i8, i8* %185, align 1, !tbaa !99
  %187 = zext i8 %186 to i32
  %188 = add nuw nsw i32 %187, 7
  %189 = lshr i32 %188, 3
  %190 = mul nuw nsw i32 %189, %184
  %191 = zext i32 %190 to i64
  %192 = getelementptr inbounds i8, i8* %180, i64 %191
  %193 = load i8*, i8** %21, align 8, !tbaa !109
  %194 = zext i32 %25 to i64
  %195 = tail call i8* @memcpy(i8* %192, i8* %193, i64 %194) #13
  %196 = load i32, i32* %154, align 4, !tbaa !125
  %197 = sext i32 %196 to i64
  %198 = getelementptr inbounds i32, i32* %168, i64 %197
  %199 = bitcast i32* %198 to i8*
  %200 = load i16, i16* %182, align 2, !tbaa !128
  %201 = zext i16 %200 to i32
  %202 = load i8, i8* %185, align 1, !tbaa !99
  %203 = zext i8 %202 to i32
  %204 = add nuw nsw i32 %203, 7
  %205 = lshr i32 %204, 3
  %206 = mul nuw nsw i32 %205, %201
  %207 = zext i32 %206 to i64
  %208 = getelementptr inbounds i8, i8* %199, i64 %207
  br label %209

; <label>:209:                                    ; preds = %209, %176
  %210 = phi i8* [ %208, %176 ], [ %211, %209 ]
  %211 = getelementptr inbounds i8, i8* %210, i64 1
  %212 = load i8, i8* %210, align 1, !tbaa !7
  %213 = icmp eq i8 %212, 0
  br i1 %213, label %214, label %209

; <label>:214:                                    ; preds = %209
  %215 = load i8*, i8** %26, align 8, !tbaa !110
  %216 = icmp eq i8* %215, null
  %217 = select i1 %216, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.1.11, i64 0, i64 0), i8* %215
  %218 = zext i32 %34 to i64
  %219 = tail call i8* @memcpy(i8* nonnull %211, i8* %217, i64 %218) #13
  %220 = load %"class.Halide::Runtime::Internal::TraceBuffer"*, %"class.Halide::Runtime::Internal::TraceBuffer"** @_ZN6Halide7Runtime8Internal19halide_trace_bufferE, align 8, !tbaa !3
  fence seq_cst
  %221 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %220, i64 0, i32 0, i32 0
  %222 = atomicrmw sub i32* %221, i32 1 seq_cst
  %223 = load i32, i32* %140, align 4, !tbaa !119
  %224 = icmp eq i32 %223, 9
  br i1 %224, label %225, label %510

; <label>:225:                                    ; preds = %214
  %226 = load %"class.Halide::Runtime::Internal::TraceBuffer"*, %"class.Halide::Runtime::Internal::TraceBuffer"** @_ZN6Halide7Runtime8Internal19halide_trace_bufferE, align 8, !tbaa !3
  %227 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %226, i64 0, i32 0, i32 0
  br label %228

; <label>:228:                                    ; preds = %228, %225
  %229 = atomicrmw or i32* %227, i32 1073741824 seq_cst
  %230 = cmpxchg i32* %227, i32 1073741824, i32 -2147483648 seq_cst seq_cst
  %231 = extractvalue { i32, i1 } %230, 1
  br i1 %231, label %232, label %228

; <label>:232:                                    ; preds = %228
  %233 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %226, i64 0, i32 1
  %234 = load i32, i32* %233, align 4, !tbaa !113
  %235 = icmp eq i32 %234, 0
  br i1 %235, label %247, label %236

; <label>:236:                                    ; preds = %232
  %237 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %226, i64 0, i32 2
  %238 = load i32, i32* %237, align 4, !tbaa !115
  %239 = sub i32 %234, %238
  store i32 %239, i32* %233, align 4, !tbaa !113
  %240 = getelementptr inbounds %"class.Halide::Runtime::Internal::TraceBuffer", %"class.Halide::Runtime::Internal::TraceBuffer"* %226, i64 0, i32 3, i64 0
  %241 = zext i32 %239 to i64
  %242 = tail call i64 @write(i32 %5, i8* nonnull %240, i64 %241) #13
  %243 = trunc i64 %242 to i32
  %244 = icmp eq i32 %239, %243
  store i32 0, i32* %233, align 4, !tbaa !113
  store i32 0, i32* %237, align 4, !tbaa !115
  %245 = atomicrmw and i32* %227, i32 2147483647 seq_cst
  br i1 %244, label %510, label %246

; <label>:246:                                    ; preds = %236
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([121 x i8], [121 x i8]* @.str.32, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %510

; <label>:247:                                    ; preds = %232
  %248 = atomicrmw and i32* %227, i32 2147483647 seq_cst
  br label %510

; <label>:249:                                    ; preds = %2
  %250 = getelementptr inbounds [4096 x i8], [4096 x i8]* %3, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 4096, i8* nonnull %250) #14
  %251 = getelementptr inbounds [4096 x i8], [4096 x i8]* %3, i64 0, i64 4095
  store i8 0, i8* %251, align 1, !tbaa !7
  %252 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 4, i32 1
  %253 = load i8, i8* %252, align 1, !tbaa !129
  %254 = zext i8 %253 to i32
  br label %255

; <label>:255:                                    ; preds = %255, %249
  %256 = phi i32 [ 8, %249 ], [ %258, %255 ]
  %257 = icmp slt i32 %256, %254
  %258 = shl i32 %256, 1
  br i1 %257, label %255, label %259

; <label>:259:                                    ; preds = %255
  %260 = ptrtoint [4096 x i8]* %3 to i64
  %261 = icmp slt i32 %256, 65
  br i1 %261, label %263, label %262

; <label>:262:                                    ; preds = %259
  call void @halide_print(i8* %0, i8* getelementptr inbounds ([117 x i8], [117 x i8]* @.str.2.12, i64 0, i64 0)) #13
  call void @abort() #13
  br label %263

; <label>:263:                                    ; preds = %262, %259
  %264 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 5
  %265 = load i32, i32* %264, align 4, !tbaa !119
  %266 = icmp slt i32 %265, 2
  %267 = zext i32 %265 to i64
  %268 = getelementptr inbounds [11 x i8*], [11 x i8*]* @_ZZ20halide_default_traceE11event_types, i64 0, i64 %267
  %269 = load i8*, i8** %268, align 8, !tbaa !3
  %270 = call i8* @halide_string_to_string(i8* nonnull %250, i8* nonnull %251, i8* nonnull %269) #13
  %271 = call i8* @halide_string_to_string(i8* %270, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i64 0, i64 0)) #13
  %272 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 0
  %273 = load i8*, i8** %272, align 8, !tbaa !109
  %274 = icmp eq i8* %273, null
  br i1 %274, label %275, label %277

; <label>:275:                                    ; preds = %263
  %276 = call i8* @halide_string_to_string(i8* %271, i8* nonnull %251, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.34, i64 0, i64 0)) #13
  br label %279

; <label>:277:                                    ; preds = %263
  %278 = call i8* @halide_string_to_string(i8* %271, i8* nonnull %251, i8* nonnull %273) #13
  br label %279

; <label>:279:                                    ; preds = %277, %275
  %280 = phi i8* [ %278, %277 ], [ %276, %275 ]
  %281 = call i8* @halide_string_to_string(i8* %280, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.15, i64 0, i64 0)) #13
  %282 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 7
  %283 = load i32, i32* %282, align 4, !tbaa !123
  %284 = sext i32 %283 to i64
  %285 = call i8* @halide_int64_to_string(i8* %281, i8* nonnull %251, i64 %284, i32 1) #13
  %286 = call i8* @halide_string_to_string(i8* %285, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.16, i64 0, i64 0)) #13
  %287 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 4, i32 2
  %288 = load i16, i16* %287, align 2, !tbaa !105
  %289 = icmp ugt i16 %288, 1
  br i1 %289, label %290, label %292

; <label>:290:                                    ; preds = %279
  %291 = call i8* @halide_string_to_string(i8* %286, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.17, i64 0, i64 0)) #13
  br label %292

; <label>:292:                                    ; preds = %290, %279
  %293 = phi i8* [ %291, %290 ], [ %286, %279 ]
  %294 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 8
  %295 = load i32, i32* %294, align 8, !tbaa !108
  %296 = icmp sgt i32 %295, 0
  br i1 %296, label %297, label %299

; <label>:297:                                    ; preds = %292
  %298 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 2
  br label %306

; <label>:299:                                    ; preds = %322, %292
  %300 = phi i8* [ %293, %292 ], [ %328, %322 ]
  %301 = load i16, i16* %287, align 2, !tbaa !105
  %302 = icmp ugt i16 %301, 1
  %303 = select i1 %302, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.21, i64 0, i64 0)
  %304 = call i8* @halide_string_to_string(i8* %300, i8* nonnull %251, i8* nonnull %303) #13
  %305 = ptrtoint i8* %304 to i64
  br i1 %266, label %333, label %478

; <label>:306:                                    ; preds = %322, %297
  %307 = phi i64 [ 0, %297 ], [ %329, %322 ]
  %308 = phi i8* [ %293, %297 ], [ %328, %322 ]
  %309 = icmp eq i64 %307, 0
  br i1 %309, label %322, label %310

; <label>:310:                                    ; preds = %306
  %311 = load i16, i16* %287, align 2, !tbaa !105
  %312 = icmp ugt i16 %311, 1
  br i1 %312, label %313, label %318

; <label>:313:                                    ; preds = %310
  %314 = zext i16 %311 to i32
  %315 = trunc i64 %307 to i32
  %316 = urem i32 %315, %314
  %317 = icmp eq i32 %316, 0
  br i1 %317, label %319, label %318

; <label>:318:                                    ; preds = %313, %310
  br label %319

; <label>:319:                                    ; preds = %318, %313
  %320 = phi i8* [ getelementptr inbounds ([3 x i8], [3 x i8]* @.str.19, i64 0, i64 0), %318 ], [ getelementptr inbounds ([5 x i8], [5 x i8]* @.str.18, i64 0, i64 0), %313 ]
  %321 = call i8* @halide_string_to_string(i8* %308, i8* nonnull %251, i8* nonnull %320) #13
  br label %322

; <label>:322:                                    ; preds = %319, %306
  %323 = phi i8* [ %308, %306 ], [ %321, %319 ]
  %324 = load i32*, i32** %298, align 8, !tbaa !126
  %325 = getelementptr inbounds i32, i32* %324, i64 %307
  %326 = load i32, i32* %325, align 4, !tbaa !96
  %327 = sext i32 %326 to i64
  %328 = call i8* @halide_int64_to_string(i8* %323, i8* nonnull %251, i64 %327, i32 1) #13
  %329 = add nuw nsw i64 %307, 1
  %330 = load i32, i32* %294, align 8, !tbaa !108
  %331 = sext i32 %330 to i64
  %332 = icmp slt i64 %329, %331
  br i1 %332, label %306, label %299

; <label>:333:                                    ; preds = %299
  %334 = load i16, i16* %287, align 2, !tbaa !105
  %335 = icmp ugt i16 %334, 1
  %336 = select i1 %335, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.22, i64 0, i64 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.23, i64 0, i64 0)
  %337 = call i8* @halide_string_to_string(i8* %304, i8* nonnull %251, i8* nonnull %336) #13
  %338 = ptrtoint i8* %337 to i64
  %339 = load i16, i16* %287, align 2, !tbaa !105
  %340 = icmp eq i16 %339, 0
  br i1 %340, label %478, label %341

; <label>:341:                                    ; preds = %333
  %342 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 4, i32 0
  %343 = icmp sgt i32 %256, 15
  %344 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 1
  %345 = bitcast i8** %344 to i8***
  %346 = icmp eq i32 %256, 32
  %347 = bitcast i8** %344 to i16**
  %348 = bitcast i8** %344 to float**
  %349 = icmp eq i32 %256, 16
  br label %352

; <label>:350:                                    ; preds = %468
  %351 = icmp ugt i16 %471, 1
  br i1 %351, label %474, label %478

; <label>:352:                                    ; preds = %468, %341
  %353 = phi i64 [ 0, %341 ], [ %470, %468 ]
  %354 = phi i64 [ %338, %341 ], [ %469, %468 ]
  %355 = icmp eq i64 %353, 0
  br i1 %355, label %360, label %356

; <label>:356:                                    ; preds = %352
  %357 = inttoptr i64 %354 to i8*
  %358 = call i8* @halide_string_to_string(i8* %357, i8* nonnull %251, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.19, i64 0, i64 0)) #13
  %359 = ptrtoint i8* %358 to i64
  br label %360

; <label>:360:                                    ; preds = %356, %352
  %361 = phi i64 [ %354, %352 ], [ %359, %356 ]
  %362 = load i8, i8* %342, align 8, !tbaa !130
  switch i8 %362, label %468 [
    i8 0, label %363
    i8 1, label %397
    i8 2, label %431
    i8 3, label %461
  ]

; <label>:363:                                    ; preds = %360
  switch i32 %256, label %380 [
    i32 8, label %364
    i32 16, label %372
  ]

; <label>:364:                                    ; preds = %363
  %365 = load i8*, i8** %344, align 8, !tbaa !127
  %366 = getelementptr inbounds i8, i8* %365, i64 %353
  %367 = load i8, i8* %366, align 1, !tbaa !7
  %368 = inttoptr i64 %361 to i8*
  %369 = sext i8 %367 to i64
  %370 = call i8* @halide_int64_to_string(i8* %368, i8* nonnull %251, i64 %369, i32 1) #13
  %371 = ptrtoint i8* %370 to i64
  br label %468

; <label>:372:                                    ; preds = %363
  %373 = load i16*, i16** %347, align 8, !tbaa !127
  %374 = getelementptr inbounds i16, i16* %373, i64 %353
  %375 = load i16, i16* %374, align 2, !tbaa !98
  %376 = inttoptr i64 %361 to i8*
  %377 = sext i16 %375 to i64
  %378 = call i8* @halide_int64_to_string(i8* %376, i8* nonnull %251, i64 %377, i32 1) #13
  %379 = ptrtoint i8* %378 to i64
  br label %468

; <label>:380:                                    ; preds = %363
  %381 = load i8*, i8** %344, align 8, !tbaa !127
  br i1 %346, label %382, label %390

; <label>:382:                                    ; preds = %380
  %383 = bitcast i8* %381 to i32*
  %384 = getelementptr inbounds i32, i32* %383, i64 %353
  %385 = load i32, i32* %384, align 4, !tbaa !96
  %386 = inttoptr i64 %361 to i8*
  %387 = sext i32 %385 to i64
  %388 = call i8* @halide_int64_to_string(i8* %386, i8* nonnull %251, i64 %387, i32 1) #13
  %389 = ptrtoint i8* %388 to i64
  br label %468

; <label>:390:                                    ; preds = %380
  %391 = bitcast i8* %381 to i64*
  %392 = getelementptr inbounds i64, i64* %391, i64 %353
  %393 = load i64, i64* %392, align 8, !tbaa !11
  %394 = inttoptr i64 %361 to i8*
  %395 = call i8* @halide_int64_to_string(i8* %394, i8* nonnull %251, i64 %393, i32 1) #13
  %396 = ptrtoint i8* %395 to i64
  br label %468

; <label>:397:                                    ; preds = %360
  switch i32 %256, label %414 [
    i32 8, label %398
    i32 16, label %406
  ]

; <label>:398:                                    ; preds = %397
  %399 = load i8*, i8** %344, align 8, !tbaa !127
  %400 = getelementptr inbounds i8, i8* %399, i64 %353
  %401 = load i8, i8* %400, align 1, !tbaa !7
  %402 = inttoptr i64 %361 to i8*
  %403 = zext i8 %401 to i64
  %404 = call i8* @halide_int64_to_string(i8* %402, i8* nonnull %251, i64 %403, i32 1) #13
  %405 = ptrtoint i8* %404 to i64
  br label %468

; <label>:406:                                    ; preds = %397
  %407 = load i16*, i16** %347, align 8, !tbaa !127
  %408 = getelementptr inbounds i16, i16* %407, i64 %353
  %409 = load i16, i16* %408, align 2, !tbaa !98
  %410 = inttoptr i64 %361 to i8*
  %411 = zext i16 %409 to i64
  %412 = call i8* @halide_int64_to_string(i8* %410, i8* nonnull %251, i64 %411, i32 1) #13
  %413 = ptrtoint i8* %412 to i64
  br label %468

; <label>:414:                                    ; preds = %397
  %415 = load i8*, i8** %344, align 8, !tbaa !127
  br i1 %346, label %416, label %424

; <label>:416:                                    ; preds = %414
  %417 = bitcast i8* %415 to i32*
  %418 = getelementptr inbounds i32, i32* %417, i64 %353
  %419 = load i32, i32* %418, align 4, !tbaa !96
  %420 = inttoptr i64 %361 to i8*
  %421 = zext i32 %419 to i64
  %422 = call i8* @halide_uint64_to_string(i8* %420, i8* nonnull %251, i64 %421, i32 1) #13
  %423 = ptrtoint i8* %422 to i64
  br label %468

; <label>:424:                                    ; preds = %414
  %425 = bitcast i8* %415 to i64*
  %426 = getelementptr inbounds i64, i64* %425, i64 %353
  %427 = load i64, i64* %426, align 8, !tbaa !11
  %428 = inttoptr i64 %361 to i8*
  %429 = call i8* @halide_uint64_to_string(i8* %428, i8* nonnull %251, i64 %427, i32 1) #13
  %430 = ptrtoint i8* %429 to i64
  br label %468

; <label>:431:                                    ; preds = %360
  br i1 %343, label %434, label %432

; <label>:432:                                    ; preds = %431
  call void @halide_print(i8* %0, i8* getelementptr inbounds ([119 x i8], [119 x i8]* @.str.24, i64 0, i64 0)) #13
  call void @abort() #13
  %433 = load i8*, i8** %344, align 8, !tbaa !127
  br label %453

; <label>:434:                                    ; preds = %431
  br i1 %346, label %435, label %443

; <label>:435:                                    ; preds = %434
  %436 = load float*, float** %348, align 8, !tbaa !127
  %437 = getelementptr inbounds float, float* %436, i64 %353
  %438 = load float, float* %437, align 4, !tbaa !131
  %439 = inttoptr i64 %361 to i8*
  %440 = fpext float %438 to double
  %441 = call i8* @halide_double_to_string(i8* %439, i8* nonnull %251, double %440, i32 0) #13
  %442 = ptrtoint i8* %441 to i64
  br label %468

; <label>:443:                                    ; preds = %434
  %444 = load i8*, i8** %344, align 8, !tbaa !127
  br i1 %349, label %445, label %453

; <label>:445:                                    ; preds = %443
  %446 = bitcast i8* %444 to i16*
  %447 = getelementptr inbounds i16, i16* %446, i64 %353
  %448 = load i16, i16* %447, align 2, !tbaa !98
  %449 = call double @halide_float16_bits_to_double(i16 zeroext %448) #13
  %450 = inttoptr i64 %361 to i8*
  %451 = call i8* @halide_double_to_string(i8* %450, i8* nonnull %251, double %449, i32 1) #13
  %452 = ptrtoint i8* %451 to i64
  br label %468

; <label>:453:                                    ; preds = %443, %432
  %454 = phi i8* [ %433, %432 ], [ %444, %443 ]
  %455 = bitcast i8* %454 to double*
  %456 = getelementptr inbounds double, double* %455, i64 %353
  %457 = load double, double* %456, align 8, !tbaa !133
  %458 = inttoptr i64 %361 to i8*
  %459 = call i8* @halide_double_to_string(i8* %458, i8* nonnull %251, double %457, i32 1) #13
  %460 = ptrtoint i8* %459 to i64
  br label %468

; <label>:461:                                    ; preds = %360
  %462 = load i8**, i8*** %345, align 8, !tbaa !127
  %463 = getelementptr inbounds i8*, i8** %462, i64 %353
  %464 = load i8*, i8** %463, align 8, !tbaa !3
  %465 = inttoptr i64 %361 to i8*
  %466 = call i8* @halide_pointer_to_string(i8* %465, i8* nonnull %251, i8* %464) #13
  %467 = ptrtoint i8* %466 to i64
  br label %468

; <label>:468:                                    ; preds = %461, %453, %445, %435, %424, %416, %406, %398, %390, %382, %372, %364, %360
  %469 = phi i64 [ %361, %360 ], [ %467, %461 ], [ %442, %435 ], [ %452, %445 ], [ %460, %453 ], [ %423, %416 ], [ %430, %424 ], [ %413, %406 ], [ %405, %398 ], [ %389, %382 ], [ %396, %390 ], [ %379, %372 ], [ %371, %364 ]
  %470 = add nuw nsw i64 %353, 1
  %471 = load i16, i16* %287, align 2, !tbaa !105
  %472 = zext i16 %471 to i64
  %473 = icmp ult i64 %470, %472
  br i1 %473, label %352, label %350

; <label>:474:                                    ; preds = %350
  %475 = inttoptr i64 %469 to i8*
  %476 = call i8* @halide_string_to_string(i8* %475, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0)) #13
  %477 = ptrtoint i8* %476 to i64
  br label %478

; <label>:478:                                    ; preds = %474, %350, %333, %299
  %479 = phi i64 [ %477, %474 ], [ %469, %350 ], [ %305, %299 ], [ %338, %333 ]
  %480 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %1, i64 0, i32 3
  %481 = load i8*, i8** %480, align 8, !tbaa !110
  %482 = icmp eq i8* %481, null
  br i1 %482, label %499, label %483

; <label>:483:                                    ; preds = %478
  %484 = load i8, i8* %481, align 1, !tbaa !7
  %485 = icmp eq i8 %484, 0
  br i1 %485, label %499, label %486

; <label>:486:                                    ; preds = %483
  %487 = inttoptr i64 %479 to i8*
  %488 = call i8* @halide_string_to_string(i8* %487, i8* nonnull %251, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @.str.26, i64 0, i64 0)) #13
  %489 = load i8*, i8** %480, align 8, !tbaa !110
  %490 = icmp eq i8* %489, null
  br i1 %490, label %491, label %493

; <label>:491:                                    ; preds = %486
  %492 = call i8* @halide_string_to_string(i8* %488, i8* nonnull %251, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.34, i64 0, i64 0)) #13
  br label %495

; <label>:493:                                    ; preds = %486
  %494 = call i8* @halide_string_to_string(i8* %488, i8* nonnull %251, i8* nonnull %489) #13
  br label %495

; <label>:495:                                    ; preds = %493, %491
  %496 = phi i8* [ %494, %493 ], [ %492, %491 ]
  %497 = call i8* @halide_string_to_string(i8* %496, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.27, i64 0, i64 0)) #13
  %498 = ptrtoint i8* %497 to i64
  br label %499

; <label>:499:                                    ; preds = %495, %483, %478
  %500 = phi i64 [ %479, %478 ], [ %479, %483 ], [ %498, %495 ]
  %501 = inttoptr i64 %500 to i8*
  %502 = call i8* @halide_string_to_string(i8* %501, i8* nonnull %251, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i64 0, i64 0)) #13
  %503 = ptrtoint i8* %502 to i64
  %504 = sub i64 1, %260
  %505 = add i64 %504, %503
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %250, i64 %505) #13
  br label %506

; <label>:506:                                    ; preds = %506, %499
  %507 = atomicrmw xchg i32* @_ZN6Halide7Runtime8Internal22halide_trace_file_lockE, i32 1 seq_cst
  %508 = icmp eq i32 %507, 0
  br i1 %508, label %509, label %506

; <label>:509:                                    ; preds = %506
  call void @halide_print(i8* %0, i8* nonnull %250) #13
  store atomic i32 0, i32* @_ZN6Halide7Runtime8Internal22halide_trace_file_lockE release, align 4
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %250, i64 %505) #13
  call void @llvm.lifetime.end.p0i8(i64 4096, i8* nonnull %250) #14
  br label %510

; <label>:510:                                    ; preds = %509, %247, %246, %236, %214
  ret i32 %4
}

; Function Attrs: nounwind
define weak i32 @halide_get_trace_file(i8*) local_unnamed_addr #0 {
  br label %2

; <label>:2:                                      ; preds = %2, %1
  %3 = atomicrmw xchg i32* @_ZN6Halide7Runtime8Internal22halide_trace_file_lockE, i32 1 seq_cst
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %2

; <label>:5:                                      ; preds = %2
  %6 = load i32, i32* @_ZN6Halide7Runtime8Internal17halide_trace_fileE, align 4, !tbaa !96
  %7 = icmp slt i32 %6, 0
  br i1 %7, label %8, label %22

; <label>:8:                                      ; preds = %5
  %9 = tail call i8* @getenv(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.28, i64 0, i64 0)) #13
  %10 = icmp eq i8* %9, null
  br i1 %10, label %21, label %11

; <label>:11:                                     ; preds = %8
  %12 = tail call i8* @fopen(i8* nonnull %9, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.29, i64 0, i64 0)) #13
  %13 = icmp eq i8* %12, null
  br i1 %13, label %14, label %15

; <label>:14:                                     ; preds = %11
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([116 x i8], [116 x i8]* @.str.30, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %15

; <label>:15:                                     ; preds = %14, %11
  %16 = tail call i32 @fileno(i8* %12) #13
  tail call void @halide_set_trace_file(i32 %16) #15
  store i8* %12, i8** @_ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE, align 8, !tbaa !3
  %17 = load %"class.Halide::Runtime::Internal::TraceBuffer"*, %"class.Halide::Runtime::Internal::TraceBuffer"** @_ZN6Halide7Runtime8Internal19halide_trace_bufferE, align 8, !tbaa !3
  %18 = icmp eq %"class.Halide::Runtime::Internal::TraceBuffer"* %17, null
  br i1 %18, label %19, label %22

; <label>:19:                                     ; preds = %15
  %20 = tail call i8* @malloc(i64 1048588) #13
  store i8* %20, i8** bitcast (%"class.Halide::Runtime::Internal::TraceBuffer"** @_ZN6Halide7Runtime8Internal19halide_trace_bufferE to i8**), align 8, !tbaa !3
  br label %22

; <label>:21:                                     ; preds = %8
  tail call void @halide_set_trace_file(i32 0) #15
  br label %22

; <label>:22:                                     ; preds = %21, %19, %15, %5
  %23 = load i32, i32* @_ZN6Halide7Runtime8Internal17halide_trace_fileE, align 4, !tbaa !96
  store atomic i32 0, i32* @_ZN6Halide7Runtime8Internal22halide_trace_file_lockE release, align 4
  ret i32 %23
}

declare i8* @memcpy(i8*, i8*, i64) local_unnamed_addr #1

declare i8* @fopen(i8*, i8*) local_unnamed_addr #1

declare i32 @fileno(i8*) local_unnamed_addr #1

; Function Attrs: norecurse nounwind
define weak void @halide_set_trace_file(i32) local_unnamed_addr #2 {
  store i32 %0, i32* @_ZN6Halide7Runtime8Internal17halide_trace_fileE, align 4, !tbaa !96
  ret void
}

; Function Attrs: nounwind
define weak void @halide_trace_cleanup() #0 {
  %1 = tail call i32 @halide_shutdown_trace() #15
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_shutdown_trace() local_unnamed_addr #0 {
  %1 = load i8*, i8** @_ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE, align 8, !tbaa !3
  %2 = icmp eq i8* %1, null
  br i1 %2, label %9, label %3

; <label>:3:                                      ; preds = %0
  %4 = tail call i32 @fclose(i8* nonnull %1) #13
  store i32 0, i32* @_ZN6Halide7Runtime8Internal17halide_trace_fileE, align 4, !tbaa !96
  store i8 0, i8* @_ZN6Halide7Runtime8Internal29halide_trace_file_initializedE, align 1, !tbaa !8
  store i8* null, i8** @_ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE, align 8, !tbaa !3
  %5 = load %"class.Halide::Runtime::Internal::TraceBuffer"*, %"class.Halide::Runtime::Internal::TraceBuffer"** @_ZN6Halide7Runtime8Internal19halide_trace_bufferE, align 8, !tbaa !3
  %6 = icmp eq %"class.Halide::Runtime::Internal::TraceBuffer"* %5, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = bitcast %"class.Halide::Runtime::Internal::TraceBuffer"* %5 to i8*
  tail call void @free(i8* %8) #13
  br label %9

; <label>:9:                                      ; preds = %7, %3, %0
  %10 = phi i32 [ %4, %3 ], [ %4, %7 ], [ 0, %0 ]
  ret i32 %10
}

declare i32 @fclose(i8*) local_unnamed_addr #1

; Function Attrs: norecurse nounwind
define weak i32 (i8*, %struct.halide_trace_event_t*)* @halide_set_custom_trace(i32 (i8*, %struct.halide_trace_event_t*)*) local_unnamed_addr #2 {
  %2 = load i32 (i8*, %struct.halide_trace_event_t*)*, i32 (i8*, %struct.halide_trace_event_t*)** @_ZN6Halide7Runtime8Internal19halide_custom_traceE, align 8, !tbaa !3
  store i32 (i8*, %struct.halide_trace_event_t*)* %0, i32 (i8*, %struct.halide_trace_event_t*)** @_ZN6Halide7Runtime8Internal19halide_custom_traceE, align 8, !tbaa !3
  ret i32 (i8*, %struct.halide_trace_event_t*)* %2
}

; Function Attrs: nounwind
define weak i32 @halide_trace(i8*, %struct.halide_trace_event_t*) local_unnamed_addr #0 {
  %3 = load i32 (i8*, %struct.halide_trace_event_t*)*, i32 (i8*, %struct.halide_trace_event_t*)** @_ZN6Halide7Runtime8Internal19halide_custom_traceE, align 8, !tbaa !3
  %4 = tail call i32 %3(i8* %0, %struct.halide_trace_event_t* %1) #13
  ret i32 %4
}

; Function Attrs: nounwind
define weak i32 @halide_trace_helper(i8*, i8*, i8*, i32*, i32, i32, i32, i32, i32, i32, i32, i8*) local_unnamed_addr #0 {
  %13 = alloca %struct.halide_trace_event_t, align 8
  %14 = bitcast %struct.halide_trace_event_t* %13 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %14) #14
  %15 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 4, i32 0
  %16 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 4, i32 1
  %17 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 4, i32 2
  %18 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 0
  store i8* %1, i8** %18, align 8, !tbaa !109
  %19 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 1
  store i8* %2, i8** %19, align 8, !tbaa !127
  %20 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 2
  store i32* %3, i32** %20, align 8, !tbaa !126
  %21 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 3
  store i8* %11, i8** %21, align 8, !tbaa !110
  %22 = trunc i32 %4 to i8
  store i8 %22, i8* %15, align 8, !tbaa !130
  %23 = trunc i32 %5 to i8
  store i8 %23, i8* %16, align 1, !tbaa !129
  %24 = trunc i32 %6 to i16
  store i16 %24, i16* %17, align 2, !tbaa !105
  %25 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 5
  store i32 %7, i32* %25, align 4, !tbaa !119
  %26 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 6
  store i32 %8, i32* %26, align 8, !tbaa !121
  %27 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 7
  store i32 %9, i32* %27, align 4, !tbaa !123
  %28 = getelementptr inbounds %struct.halide_trace_event_t, %struct.halide_trace_event_t* %13, i64 0, i32 8
  store i32 %10, i32* %28, align 8, !tbaa !108
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %14, i64 56) #13
  %29 = add nsw i32 %5, 7
  %30 = sdiv i32 %29, 8
  %31 = mul nsw i32 %30, %6
  %32 = sext i32 %31 to i64
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* %2, i64 %32) #13
  %33 = bitcast i32* %3 to i8*
  %34 = sext i32 %10 to i64
  %35 = shl nsw i64 %34, 2
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* %33, i64 %35) #13
  %36 = call i32 @halide_trace(i8* %0, %struct.halide_trace_event_t* nonnull %13) #15
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %14) #14
  ret i32 %36
}

; Function Attrs: norecurse nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal9ends_withEPKcS3_(i8*, i8*) local_unnamed_addr #2 {
  br label %3

; <label>:3:                                      ; preds = %3, %2
  %4 = phi i8* [ %0, %2 ], [ %7, %3 ]
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, 0
  %7 = getelementptr inbounds i8, i8* %4, i64 1
  br i1 %6, label %8, label %3

; <label>:8:                                      ; preds = %8, %3
  %9 = phi i8* [ %12, %8 ], [ %1, %3 ]
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = icmp eq i8 %10, 0
  %12 = getelementptr inbounds i8, i8* %9, i64 1
  br i1 %11, label %13, label %8

; <label>:13:                                     ; preds = %8
  %14 = icmp eq i8* %9, %1
  %15 = icmp eq i8* %4, %0
  %16 = or i1 %15, %14
  br i1 %16, label %30, label %17

; <label>:17:                                     ; preds = %17, %13
  %18 = phi i8* [ %21, %17 ], [ %9, %13 ]
  %19 = phi i8* [ %20, %17 ], [ %4, %13 ]
  %20 = getelementptr inbounds i8, i8* %19, i64 -1
  %21 = getelementptr inbounds i8, i8* %18, i64 -1
  %22 = icmp eq i8* %21, %1
  %23 = icmp eq i8* %20, %0
  %24 = load i8, i8* %20, align 1, !tbaa !7
  %25 = load i8, i8* %21, align 1, !tbaa !7
  %26 = icmp eq i8 %24, %25
  %27 = or i1 %23, %22
  %28 = xor i1 %26, true
  %29 = or i1 %27, %28
  br i1 %29, label %30, label %17

; <label>:30:                                     ; preds = %17, %13
  %31 = phi i1 [ true, %13 ], [ %26, %17 ]
  %32 = phi i1 [ true, %13 ], [ %27, %17 ]
  %33 = and i1 %32, %31
  ret i1 %33
}

; Function Attrs: nounwind
define weak i32 @halide_debug_to_file(i8*, i8*, i32, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %5 = alloca [4 x %struct.halide_dimension_t], align 4
  %6 = alloca %"struct.Halide::Runtime::Internal::halide_tiff_header", align 2
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca [256 x i8], align 1
  %10 = alloca [129 x i8], align 1
  %11 = alloca [8 x i32], align 4
  %12 = alloca [4 x i32], align 4
  %13 = alloca [2 x i32], align 4
  %14 = alloca [2 x i32], align 4
  %15 = alloca [5 x i32], align 4
  %16 = alloca [4096 x i8], align 1
  %17 = alloca [4 x i32], align 4
  %18 = alloca i64, align 8
  %19 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 5
  %20 = load i32, i32* %19, align 4, !tbaa !79
  %21 = icmp sgt i32 %20, 4
  br i1 %21, label %22, label %23

; <label>:22:                                     ; preds = %4
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.str.35, i64 0, i64 0)) #13
  br label %625

; <label>:23:                                     ; preds = %4
  %24 = tail call i32 @halide_copy_to_host(i8* %0, %struct.halide_buffer_t* nonnull %3) #13
  %25 = tail call i8* @fopen(i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1.36, i64 0, i64 0)) #13
  %26 = icmp eq i8* %25, null
  br i1 %26, label %622, label %27

; <label>:27:                                     ; preds = %23
  %28 = bitcast [4 x %struct.halide_dimension_t]* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %28) #14
  %29 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 0
  store i32 0, i32* %29, align 4, !tbaa !87
  %30 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  store i32 0, i32* %30, align 4, !tbaa !89
  %31 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 2
  store i32 0, i32* %31, align 4, !tbaa !90
  %32 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 3
  store i32 0, i32* %32, align 4, !tbaa !135
  %33 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 0
  store i32 0, i32* %33, align 4, !tbaa !87
  %34 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  store i32 0, i32* %34, align 4, !tbaa !89
  %35 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 2
  store i32 0, i32* %35, align 4, !tbaa !90
  %36 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 3
  store i32 0, i32* %36, align 4, !tbaa !135
  %37 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 0
  store i32 0, i32* %37, align 4, !tbaa !87
  %38 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  store i32 0, i32* %38, align 4, !tbaa !89
  %39 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 2
  store i32 0, i32* %39, align 4, !tbaa !90
  %40 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 3
  store i32 0, i32* %40, align 4, !tbaa !135
  %41 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 0
  store i32 0, i32* %41, align 4, !tbaa !87
  %42 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  store i32 0, i32* %42, align 4, !tbaa !89
  %43 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 2
  store i32 0, i32* %43, align 4, !tbaa !90
  %44 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 3
  store i32 0, i32* %44, align 4, !tbaa !135
  %45 = load i32, i32* %19, align 4, !tbaa !79
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %47, label %53

; <label>:47:                                     ; preds = %27
  %48 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %49 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %48, align 8, !tbaa !86
  %50 = sext i32 %45 to i64
  br label %56

; <label>:51:                                     ; preds = %56
  %52 = icmp slt i32 %45, 4
  br i1 %52, label %53, label %71

; <label>:53:                                     ; preds = %51, %27
  %54 = phi i64 [ %66, %51 ], [ 1, %27 ]
  %55 = sext i32 %45 to i64
  br label %79

; <label>:56:                                     ; preds = %56, %47
  %57 = phi i64 [ 0, %47 ], [ %67, %56 ]
  %58 = phi i64 [ 1, %47 ], [ %66, %56 ]
  %59 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %49, i64 %57
  %60 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 %57
  %61 = bitcast %struct.halide_dimension_t* %60 to i8*
  %62 = bitcast %struct.halide_dimension_t* %59 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 %61, i8* align 4 %62, i64 16, i1 false), !tbaa.struct !95
  %63 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 %57, i32 1
  %64 = load i32, i32* %63, align 4, !tbaa !89
  %65 = sext i32 %64 to i64
  %66 = mul i64 %58, %65
  %67 = add nuw nsw i64 %57, 1
  %68 = icmp slt i64 %67, %50
  %69 = icmp ult i64 %67, 4
  %70 = and i1 %69, %68
  br i1 %70, label %56, label %51

; <label>:71:                                     ; preds = %79, %51
  %72 = phi i64 [ %66, %51 ], [ %54, %79 ]
  %73 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  %74 = load i8, i8* %73, align 1, !tbaa !99
  %75 = zext i8 %74 to i32
  %76 = add nuw nsw i32 %75, 7
  %77 = lshr i32 %76, 3
  %78 = call zeroext i1 @_ZN6Halide7Runtime8Internal9ends_withEPKcS3_(i8* %1, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2.37, i64 0, i64 0)) #15
  br i1 %78, label %88, label %86

; <label>:79:                                     ; preds = %79, %53
  %80 = phi i64 [ %55, %53 ], [ %84, %79 ]
  %81 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 %80, i32 0
  store i32 0, i32* %81, align 4, !tbaa !87
  %82 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 %80, i32 1
  store i32 1, i32* %82, align 4, !tbaa !89
  %83 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 %80, i32 2
  store i32 0, i32* %83, align 4, !tbaa !90
  %84 = add nsw i64 %80, 1
  %85 = icmp slt i64 %80, 3
  br i1 %85, label %79, label %71

; <label>:86:                                     ; preds = %71
  %87 = call zeroext i1 @_ZN6Halide7Runtime8Internal9ends_withEPKcS3_(i8* %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3.38, i64 0, i64 0)) #15
  br i1 %87, label %88, label %233

; <label>:88:                                     ; preds = %86, %71
  %89 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  %90 = load i32, i32* %89, align 4, !tbaa !89
  %91 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  %92 = load i32, i32* %91, align 4, !tbaa !89
  %93 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  %94 = load i32, i32* %93, align 4, !tbaa !89
  %95 = icmp ult i32 %94, 2
  %96 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  %97 = load i32, i32* %96, align 4, !tbaa !89
  %98 = icmp slt i32 %97, 5
  %99 = and i1 %95, %98
  %100 = select i1 %99, i32 1, i32 %97
  %101 = select i1 %99, i32 %97, i32 %94
  %102 = bitcast %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 210, i8* nonnull %102) #14
  %103 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 0
  store i16 18761, i16* %103, align 2, !tbaa !136
  %104 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 1
  store i16 42, i16* %104, align 2, !tbaa !138
  %105 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 2
  store i32 8, i32* %105, align 2, !tbaa !139
  %106 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 3
  store i16 15, i16* %106, align 2, !tbaa !140
  %107 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 0, i32 0
  store i16 256, i16* %107, align 2, !tbaa !141
  %108 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 0, i32 1
  store i16 4, i16* %108, align 2, !tbaa !143
  %109 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 0, i32 2
  store i32 1, i32* %109, align 2, !tbaa !144
  %110 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 0, i32 3, i32 0
  store i32 %90, i32* %110, align 2, !tbaa !7
  %111 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 1, i32 0
  store i16 257, i16* %111, align 2, !tbaa !141
  %112 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 1, i32 1
  store i16 4, i16* %112, align 2, !tbaa !143
  %113 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 1, i32 2
  store i32 1, i32* %113, align 2, !tbaa !144
  %114 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 1, i32 3, i32 0
  store i32 %92, i32* %114, align 2, !tbaa !7
  %115 = trunc i32 %76 to i16
  %116 = and i16 %115, 504
  %117 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 2, i32 0
  store i16 258, i16* %117, align 2, !tbaa !141
  %118 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 2, i32 1
  store i16 3, i16* %118, align 2, !tbaa !143
  %119 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 2, i32 2
  store i32 1, i32* %119, align 2, !tbaa !144
  %120 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 2, i32 3
  %121 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %120 to i16*
  store i16 %116, i16* %121, align 2, !tbaa !7
  %122 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 3, i32 0
  store i16 259, i16* %122, align 2, !tbaa !141
  %123 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 3, i32 1
  store i16 3, i16* %123, align 2, !tbaa !143
  %124 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 3, i32 2
  store i32 1, i32* %124, align 2, !tbaa !144
  %125 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 3, i32 3
  %126 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %125 to i16*
  store i16 1, i16* %126, align 2, !tbaa !7
  %127 = icmp sgt i32 %101, 2
  %128 = select i1 %127, i16 2, i16 1
  %129 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 4, i32 0
  store i16 262, i16* %129, align 2, !tbaa !141
  %130 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 4, i32 1
  store i16 3, i16* %130, align 2, !tbaa !143
  %131 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 4, i32 2
  store i32 1, i32* %131, align 2, !tbaa !144
  %132 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 4, i32 3
  %133 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %132 to i16*
  store i16 %128, i16* %133, align 2, !tbaa !7
  %134 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 5, i32 0
  store i16 273, i16* %134, align 2, !tbaa !141
  %135 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 5, i32 1
  store i16 4, i16* %135, align 2, !tbaa !143
  %136 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 5, i32 2
  store i32 %101, i32* %136, align 2, !tbaa !144
  %137 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 5, i32 3, i32 0
  store i32 210, i32* %137, align 2, !tbaa !7
  %138 = trunc i32 %101 to i16
  %139 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 6, i32 0
  store i16 277, i16* %139, align 2, !tbaa !141
  %140 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 6, i32 1
  store i16 3, i16* %140, align 2, !tbaa !143
  %141 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 6, i32 2
  store i32 1, i32* %141, align 2, !tbaa !144
  %142 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 6, i32 3
  %143 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %142 to i16*
  store i16 %138, i16* %143, align 2, !tbaa !7
  %144 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 7, i32 0
  store i16 278, i16* %144, align 2, !tbaa !141
  %145 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 7, i32 1
  store i16 4, i16* %145, align 2, !tbaa !143
  %146 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 7, i32 2
  store i32 1, i32* %146, align 2, !tbaa !144
  %147 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 7, i32 3, i32 0
  store i32 %92, i32* %147, align 2, !tbaa !7
  %148 = icmp eq i32 %101, 1
  %149 = shl i32 %101, 2
  %150 = add i32 %149, 210
  %151 = trunc i64 %72 to i32
  %152 = mul i32 %77, %151
  %153 = select i1 %148, i32 %152, i32 %150
  %154 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 8, i32 0
  store i16 279, i16* %154, align 2
  %155 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 8, i32 1
  store i16 4, i16* %155, align 2
  %156 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 8, i32 2
  store i32 %101, i32* %156, align 2
  %157 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 8, i32 3, i32 0
  store i32 %153, i32* %157, align 2
  %158 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 9, i32 0
  store i16 282, i16* %158, align 2, !tbaa !141
  %159 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 9, i32 1
  store i16 5, i16* %159, align 2, !tbaa !143
  %160 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 9, i32 2
  store i32 1, i32* %160, align 2, !tbaa !144
  %161 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 9, i32 3, i32 0
  store i32 194, i32* %161, align 2, !tbaa !7
  %162 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 10, i32 0
  store i16 283, i16* %162, align 2, !tbaa !141
  %163 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 10, i32 1
  store i16 5, i16* %163, align 2, !tbaa !143
  %164 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 10, i32 2
  store i32 1, i32* %164, align 2, !tbaa !144
  %165 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 10, i32 3, i32 0
  store i32 202, i32* %165, align 2, !tbaa !7
  %166 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 11, i32 0
  store i16 284, i16* %166, align 2, !tbaa !141
  %167 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 11, i32 1
  store i16 3, i16* %167, align 2, !tbaa !143
  %168 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 11, i32 2
  store i32 1, i32* %168, align 2, !tbaa !144
  %169 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 11, i32 3
  %170 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %169 to i16*
  store i16 2, i16* %170, align 2, !tbaa !7
  %171 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 12, i32 0
  store i16 296, i16* %171, align 2, !tbaa !141
  %172 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 12, i32 1
  store i16 3, i16* %172, align 2, !tbaa !143
  %173 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 12, i32 2
  store i32 1, i32* %173, align 2, !tbaa !144
  %174 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 12, i32 3
  %175 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %174 to i16*
  store i16 1, i16* %175, align 2, !tbaa !7
  %176 = sext i32 %2 to i64
  %177 = getelementptr inbounds [10 x i16], [10 x i16]* @_ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE, i64 0, i64 %176
  %178 = load i16, i16* %177, align 2, !tbaa !98
  %179 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 13, i32 0
  store i16 339, i16* %179, align 2, !tbaa !141
  %180 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 13, i32 1
  store i16 3, i16* %180, align 2, !tbaa !143
  %181 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 13, i32 2
  store i32 1, i32* %181, align 2, !tbaa !144
  %182 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 13, i32 3
  %183 = bitcast %"class.Halide::Runtime::Internal::SharedExclusiveSpinLock"* %182 to i16*
  store i16 %178, i16* %183, align 2, !tbaa !7
  %184 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 14, i32 0
  store i16 -32539, i16* %184, align 2, !tbaa !141
  %185 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 14, i32 1
  store i16 4, i16* %185, align 2, !tbaa !143
  %186 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 14, i32 2
  store i32 1, i32* %186, align 2, !tbaa !144
  %187 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 4, i64 14, i32 3, i32 0
  store i32 %100, i32* %187, align 2, !tbaa !7
  %188 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 5
  store i32 0, i32* %188, align 2, !tbaa !145
  %189 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 6, i64 0
  store i32 1, i32* %189, align 2, !tbaa !96
  %190 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 6, i64 1
  store i32 1, i32* %190, align 2, !tbaa !96
  %191 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 7, i64 0
  store i32 1, i32* %191, align 2, !tbaa !96
  %192 = getelementptr inbounds %"struct.Halide::Runtime::Internal::halide_tiff_header", %"struct.Halide::Runtime::Internal::halide_tiff_header"* %6, i64 0, i32 7, i64 1
  store i32 1, i32* %192, align 2, !tbaa !96
  %193 = call i64 @fwrite(i8* nonnull %102, i64 210, i64 1, i8* nonnull %25) #13
  %194 = icmp eq i64 %193, 0
  br i1 %194, label %230, label %195

; <label>:195:                                    ; preds = %88
  %196 = icmp sgt i32 %101, 1
  br i1 %196, label %197, label %232

; <label>:197:                                    ; preds = %195
  %198 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %198) #14
  %199 = shl i32 %101, 3
  %200 = add i32 %199, 210
  store i32 %200, i32* %7, align 4, !tbaa !96
  %201 = mul i32 %100, %77
  br label %202

; <label>:202:                                    ; preds = %207, %197
  %203 = phi i32 [ 0, %197 ], [ %214, %207 ]
  %204 = call i64 @fwrite(i8* nonnull %198, i64 4, i64 1, i8* nonnull %25) #13
  %205 = icmp eq i64 %204, 0
  br i1 %205, label %206, label %207

; <label>:206:                                    ; preds = %202
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %198) #14
  br label %230

; <label>:207:                                    ; preds = %202
  %208 = load i32, i32* %89, align 4, !tbaa !89
  %209 = load i32, i32* %91, align 4, !tbaa !89
  %210 = mul i32 %201, %208
  %211 = mul i32 %210, %209
  %212 = load i32, i32* %7, align 4, !tbaa !96
  %213 = add nsw i32 %211, %212
  store i32 %213, i32* %7, align 4, !tbaa !96
  %214 = add nuw nsw i32 %203, 1
  %215 = icmp slt i32 %214, %101
  br i1 %215, label %202, label %216

; <label>:216:                                    ; preds = %207
  %217 = bitcast i32* %8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %217) #14
  %218 = mul i32 %208, %100
  %219 = mul i32 %218, %209
  store i32 %219, i32* %8, align 4, !tbaa !96
  %220 = icmp sgt i32 %101, 0
  br i1 %220, label %224, label %223

; <label>:221:                                    ; preds = %224
  %222 = icmp slt i32 %228, %101
  br i1 %222, label %224, label %223

; <label>:223:                                    ; preds = %221, %216
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %217) #14
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %198) #14
  br label %232

; <label>:224:                                    ; preds = %221, %216
  %225 = phi i32 [ %228, %221 ], [ 0, %216 ]
  %226 = call i64 @fwrite(i8* nonnull %217, i64 4, i64 1, i8* nonnull %25) #13
  %227 = icmp eq i64 %226, 0
  %228 = add nuw nsw i32 %225, 1
  br i1 %227, label %229, label %221

; <label>:229:                                    ; preds = %224
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %217) #14
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %198) #14
  br label %230

; <label>:230:                                    ; preds = %229, %206, %88
  %231 = phi i32 [ -4, %206 ], [ -3, %88 ], [ -5, %229 ]
  call void @llvm.lifetime.end.p0i8(i64 210, i8* nonnull %102) #14
  br label %620

; <label>:232:                                    ; preds = %223, %195
  call void @llvm.lifetime.end.p0i8(i64 210, i8* nonnull %102) #14
  br label %439

; <label>:233:                                    ; preds = %86
  %234 = call zeroext i1 @_ZN6Halide7Runtime8Internal9ends_withEPKcS3_(i8* %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4.39, i64 0, i64 0)) #15
  br i1 %234, label %235, label %422

; <label>:235:                                    ; preds = %235, %233
  %236 = phi i8* [ %239, %235 ], [ %1, %233 ]
  %237 = load i8, i8* %236, align 1, !tbaa !7
  %238 = icmp eq i8 %237, 0
  %239 = getelementptr inbounds i8, i8* %236, i64 1
  br i1 %238, label %240, label %235

; <label>:240:                                    ; preds = %240, %235
  %241 = phi i8* [ %242, %240 ], [ %236, %235 ]
  %242 = getelementptr inbounds i8, i8* %241, i64 -1
  %243 = load i8, i8* %242, align 1, !tbaa !7
  %244 = icmp eq i8 %243, 46
  br i1 %244, label %245, label %240

; <label>:245:                                    ; preds = %249, %240
  %246 = phi i64 [ %250, %249 ], [ -1, %240 ]
  %247 = getelementptr inbounds i8, i8* %241, i64 %246
  %248 = icmp eq i8* %247, %1
  br i1 %248, label %254, label %249

; <label>:249:                                    ; preds = %245
  %250 = add nsw i64 %246, -1
  %251 = getelementptr inbounds i8, i8* %241, i64 %250
  %252 = load i8, i8* %251, align 1, !tbaa !7
  %253 = icmp eq i8 %252, 47
  br i1 %253, label %254, label %245

; <label>:254:                                    ; preds = %249, %245
  %255 = trunc i64 %246 to i32
  %256 = xor i32 %255, -1
  %257 = getelementptr inbounds [256 x i8], [256 x i8]* %9, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 256, i8* nonnull %257) #14
  %258 = icmp eq i64 %246, -1
  br i1 %258, label %265, label %259

; <label>:259:                                    ; preds = %254
  %260 = xor i64 %246, -1
  br label %268

; <label>:261:                                    ; preds = %268
  %262 = getelementptr [256 x i8], [256 x i8]* %9, i64 0, i64 %260
  %263 = getelementptr inbounds [256 x i8], [256 x i8]* %9, i64 0, i64 256
  %264 = icmp ult i8* %262, %263
  br i1 %264, label %265, label %280

; <label>:265:                                    ; preds = %261, %254
  %266 = phi i8* [ %262, %261 ], [ %257, %254 ]
  %267 = getelementptr inbounds [256 x i8], [256 x i8]* %9, i64 1, i64 0
  br label %276

; <label>:268:                                    ; preds = %268, %259
  %269 = phi i8* [ %274, %268 ], [ %257, %259 ]
  %270 = phi i64 [ %272, %268 ], [ %246, %259 ]
  %271 = getelementptr inbounds i8, i8* %241, i64 %270
  %272 = add nuw nsw i64 %270, 1
  %273 = load i8, i8* %271, align 1, !tbaa !7
  %274 = getelementptr inbounds i8, i8* %269, i64 1
  store i8 %273, i8* %269, align 1, !tbaa !7
  %275 = icmp eq i64 %272, -1
  br i1 %275, label %261, label %268

; <label>:276:                                    ; preds = %276, %265
  %277 = phi i8* [ %278, %276 ], [ %266, %265 ]
  %278 = getelementptr inbounds i8, i8* %277, i64 1
  store i8 0, i8* %277, align 1, !tbaa !7
  %279 = icmp eq i8* %278, %267
  br i1 %279, label %280, label %276

; <label>:280:                                    ; preds = %276, %261
  %281 = sub i32 6, %255
  %282 = and i32 %281, -8
  %283 = getelementptr inbounds [129 x i8], [129 x i8]* %10, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 129, i8* nonnull %283) #14
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %283, i8* align 1 getelementptr inbounds ([129 x i8], [129 x i8]* @_ZZ20halide_debug_to_fileE6header, i64 0, i64 0), i64 129, i1 false)
  %284 = call i64 @fwrite(i8* nonnull %283, i64 128, i64 1, i8* nonnull %25) #13
  %285 = load i32, i32* %19, align 4, !tbaa !79
  %286 = icmp sgt i32 %285, 0
  br i1 %286, label %289, label %287

; <label>:287:                                    ; preds = %280
  %288 = load i8, i8* %73, align 1, !tbaa !99
  br label %331

; <label>:289:                                    ; preds = %280
  %290 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %291 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %290, align 8, !tbaa !86
  %292 = sext i32 %285 to i64
  br label %293

; <label>:293:                                    ; preds = %306, %289
  %294 = phi i64 [ 0, %289 ], [ %308, %306 ]
  %295 = phi i64 [ 0, %289 ], [ %307, %306 ]
  %296 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %291, i64 %294, i32 2
  %297 = load i32, i32* %296, align 4, !tbaa !90
  %298 = icmp sgt i32 %297, 0
  br i1 %298, label %299, label %306

; <label>:299:                                    ; preds = %293
  %300 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %291, i64 %294, i32 1
  %301 = load i32, i32* %300, align 4, !tbaa !89
  %302 = add nsw i32 %301, -1
  %303 = mul nsw i32 %302, %297
  %304 = sext i32 %303 to i64
  %305 = add nsw i64 %295, %304
  br label %306

; <label>:306:                                    ; preds = %299, %293
  %307 = phi i64 [ %305, %299 ], [ %295, %293 ]
  %308 = add nuw nsw i64 %294, 1
  %309 = icmp eq i64 %308, %292
  br i1 %309, label %310, label %293

; <label>:310:                                    ; preds = %306
  %311 = load i8, i8* %73, align 1, !tbaa !99
  br label %312

; <label>:312:                                    ; preds = %325, %310
  %313 = phi i64 [ 0, %310 ], [ %327, %325 ]
  %314 = phi i64 [ 0, %310 ], [ %326, %325 ]
  %315 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %291, i64 %313, i32 2
  %316 = load i32, i32* %315, align 4, !tbaa !90
  %317 = icmp slt i32 %316, 0
  br i1 %317, label %318, label %325

; <label>:318:                                    ; preds = %312
  %319 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %291, i64 %313, i32 1
  %320 = load i32, i32* %319, align 4, !tbaa !89
  %321 = add nsw i32 %320, -1
  %322 = mul nsw i32 %321, %316
  %323 = sext i32 %322 to i64
  %324 = add nsw i64 %314, %323
  br label %325

; <label>:325:                                    ; preds = %318, %312
  %326 = phi i64 [ %324, %318 ], [ %314, %312 ]
  %327 = add nuw nsw i64 %313, 1
  %328 = icmp eq i64 %327, %292
  br i1 %328, label %329, label %312

; <label>:329:                                    ; preds = %325
  %330 = add nsw i64 %307, 1
  br label %331

; <label>:331:                                    ; preds = %329, %287
  %332 = phi i8 [ %288, %287 ], [ %311, %329 ]
  %333 = phi i64 [ 1, %287 ], [ %330, %329 ]
  %334 = phi i64 [ 0, %287 ], [ %326, %329 ]
  %335 = zext i8 %332 to i64
  %336 = add nuw nsw i64 %335, 7
  %337 = lshr i64 %336, 3
  %338 = sub i64 %333, %334
  %339 = mul i64 %338, %337
  %340 = icmp ugt i64 %339, 4294967295
  br i1 %340, label %341, label %342

; <label>:341:                                    ; preds = %331
  call void @halide_error(i8* %0, i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.5.40, i64 0, i64 0)) #13
  call void @llvm.lifetime.end.p0i8(i64 129, i8* nonnull %283) #14
  call void @llvm.lifetime.end.p0i8(i64 256, i8* nonnull %257) #14
  br label %620

; <label>:342:                                    ; preds = %331
  %343 = icmp sgt i32 %285, 2
  %344 = select i1 %343, i32 %285, i32 2
  %345 = bitcast [8 x i32]* %11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %345) #14
  %346 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 0
  store i32 14, i32* %346, align 4, !tbaa !96
  %347 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 1
  %348 = shl i32 %344, 2
  %349 = add i32 %348, 4
  %350 = and i32 %349, -8
  %351 = trunc i64 %339 to i32
  %352 = add i32 %282, 40
  %353 = add i32 %352, %350
  %354 = add i32 %353, %351
  store i32 %354, i32* %347, align 4, !tbaa !96
  %355 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 2
  store i32 6, i32* %355, align 4, !tbaa !96
  %356 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 3
  store i32 8, i32* %356, align 4, !tbaa !96
  %357 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 4
  %358 = sext i32 %2 to i64
  %359 = getelementptr inbounds [10 x i8], [10 x i8]* @_ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE, i64 0, i64 %358
  %360 = load i8, i8* %359, align 1, !tbaa !7
  %361 = zext i8 %360 to i32
  store i32 %361, i32* %357, align 4, !tbaa !96
  %362 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 5
  store i32 1, i32* %362, align 4, !tbaa !96
  %363 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 6
  store i32 5, i32* %363, align 4, !tbaa !96
  %364 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 7
  store i32 %348, i32* %364, align 4, !tbaa !96
  %365 = call i64 @fwrite(i8* nonnull %345, i64 32, i64 1, i8* nonnull %25) #13
  %366 = icmp eq i64 %365, 0
  br i1 %366, label %415, label %367

; <label>:367:                                    ; preds = %342
  %368 = bitcast [4 x i32]* %12 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %368) #14
  %369 = getelementptr inbounds [4 x i32], [4 x i32]* %12, i64 0, i64 0
  %370 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  %371 = load i32, i32* %370, align 4, !tbaa !89
  store i32 %371, i32* %369, align 4, !tbaa !96
  %372 = getelementptr inbounds [4 x i32], [4 x i32]* %12, i64 0, i64 1
  %373 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  %374 = load i32, i32* %373, align 4, !tbaa !89
  store i32 %374, i32* %372, align 4, !tbaa !96
  %375 = getelementptr inbounds [4 x i32], [4 x i32]* %12, i64 0, i64 2
  %376 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  %377 = load i32, i32* %376, align 4, !tbaa !89
  store i32 %377, i32* %375, align 4, !tbaa !96
  %378 = getelementptr inbounds [4 x i32], [4 x i32]* %12, i64 0, i64 3
  %379 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  %380 = load i32, i32* %379, align 4, !tbaa !89
  store i32 %380, i32* %378, align 4, !tbaa !96
  %381 = sext i32 %350 to i64
  %382 = call i64 @fwrite(i8* nonnull %368, i64 %381, i64 1, i8* nonnull %25) #13
  %383 = icmp eq i64 %382, 0
  br i1 %383, label %411, label %384

; <label>:384:                                    ; preds = %367
  %385 = bitcast [2 x i32]* %13 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %385) #14
  %386 = getelementptr inbounds [2 x i32], [2 x i32]* %13, i64 0, i64 0
  store i32 1, i32* %386, align 4, !tbaa !96
  %387 = getelementptr inbounds [2 x i32], [2 x i32]* %13, i64 0, i64 1
  store i32 %256, i32* %387, align 4, !tbaa !96
  %388 = call i64 @fwrite(i8* nonnull %385, i64 8, i64 1, i8* nonnull %25) #13
  %389 = icmp eq i64 %388, 0
  br i1 %389, label %407, label %390

; <label>:390:                                    ; preds = %384
  %391 = zext i32 %282 to i64
  %392 = call i64 @fwrite(i8* nonnull %257, i64 %391, i64 1, i8* nonnull %25) #13
  %393 = icmp eq i64 %392, 0
  br i1 %393, label %407, label %394

; <label>:394:                                    ; preds = %390
  %395 = add i32 %351, 7
  %396 = and i32 %395, 7
  %397 = xor i32 %396, 7
  %398 = bitcast [2 x i32]* %14 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %398) #14
  %399 = getelementptr inbounds [2 x i32], [2 x i32]* %14, i64 0, i64 0
  %400 = getelementptr inbounds [10 x i8], [10 x i8]* @_ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE, i64 0, i64 %358
  %401 = load i8, i8* %400, align 1, !tbaa !7
  %402 = zext i8 %401 to i32
  store i32 %402, i32* %399, align 4, !tbaa !96
  %403 = getelementptr inbounds [2 x i32], [2 x i32]* %14, i64 0, i64 1
  store i32 %351, i32* %403, align 4, !tbaa !96
  %404 = call i64 @fwrite(i8* nonnull %398, i64 8, i64 1, i8* nonnull %25) #13
  %405 = icmp eq i64 %404, 0
  %406 = zext i1 %405 to i32
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %398) #14
  br label %407

; <label>:407:                                    ; preds = %394, %390, %384
  %408 = phi i32 [ %397, %394 ], [ 0, %384 ], [ 0, %390 ]
  %409 = phi i32 [ %406, %394 ], [ 1, %384 ], [ 1, %390 ]
  %410 = phi i32 [ -11, %394 ], [ -9, %384 ], [ -10, %390 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %385) #14
  br label %411

; <label>:411:                                    ; preds = %407, %367
  %412 = phi i32 [ %408, %407 ], [ 0, %367 ]
  %413 = phi i32 [ %409, %407 ], [ 1, %367 ]
  %414 = phi i32 [ %410, %407 ], [ -8, %367 ]
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %368) #14
  br label %415

; <label>:415:                                    ; preds = %411, %342
  %416 = phi i32 [ %412, %411 ], [ 0, %342 ]
  %417 = phi i32 [ %413, %411 ], [ 1, %342 ]
  %418 = phi i32 [ %414, %411 ], [ -7, %342 ]
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %345) #14
  call void @llvm.lifetime.end.p0i8(i64 129, i8* nonnull %283) #14
  call void @llvm.lifetime.end.p0i8(i64 256, i8* nonnull %257) #14
  %419 = icmp eq i32 %417, 0
  br i1 %419, label %420, label %620

; <label>:420:                                    ; preds = %415
  %421 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  br label %439

; <label>:422:                                    ; preds = %233
  %423 = bitcast [5 x i32]* %15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %423) #14
  %424 = getelementptr inbounds [5 x i32], [5 x i32]* %15, i64 0, i64 0
  %425 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  %426 = load i32, i32* %425, align 4, !tbaa !89
  store i32 %426, i32* %424, align 4, !tbaa !96
  %427 = getelementptr inbounds [5 x i32], [5 x i32]* %15, i64 0, i64 1
  %428 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  %429 = load i32, i32* %428, align 4, !tbaa !89
  store i32 %429, i32* %427, align 4, !tbaa !96
  %430 = getelementptr inbounds [5 x i32], [5 x i32]* %15, i64 0, i64 2
  %431 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  %432 = load i32, i32* %431, align 4, !tbaa !89
  store i32 %432, i32* %430, align 4, !tbaa !96
  %433 = getelementptr inbounds [5 x i32], [5 x i32]* %15, i64 0, i64 3
  %434 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  %435 = load i32, i32* %434, align 4, !tbaa !89
  store i32 %435, i32* %433, align 4, !tbaa !96
  %436 = getelementptr inbounds [5 x i32], [5 x i32]* %15, i64 0, i64 4
  store i32 %2, i32* %436, align 4, !tbaa !96
  %437 = call i64 @fwrite(i8* nonnull %423, i64 20, i64 1, i8* nonnull %25) #13
  %438 = icmp eq i64 %437, 0
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %423) #14
  br i1 %438, label %620, label %439

; <label>:439:                                    ; preds = %422, %420, %232
  %440 = phi i32* [ %421, %420 ], [ %434, %422 ], [ %93, %232 ]
  %441 = phi i32 [ %416, %420 ], [ 0, %422 ], [ 0, %232 ]
  %442 = getelementptr inbounds [4096 x i8], [4096 x i8]* %16, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 4096, i8* nonnull %442) #14
  %443 = udiv i32 4096, %77
  %444 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 0
  %445 = load i32, i32* %440, align 4, !tbaa !89
  %446 = icmp sgt i32 %445, 0
  br i1 %446, label %447, label %605

; <label>:447:                                    ; preds = %439
  %448 = load i32, i32* %444, align 4, !tbaa !87
  %449 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 0
  %450 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  %451 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 0
  %452 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  %453 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 0
  %454 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  %455 = bitcast [4 x i32]* %17 to i8*
  %456 = getelementptr inbounds [4 x i32], [4 x i32]* %17, i64 0, i64 0
  %457 = getelementptr inbounds [4 x i32], [4 x i32]* %17, i64 0, i64 1
  %458 = getelementptr inbounds [4 x i32], [4 x i32]* %17, i64 0, i64 2
  %459 = getelementptr inbounds [4 x i32], [4 x i32]* %17, i64 0, i64 3
  %460 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %461 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 2
  %462 = zext i32 %77 to i64
  %463 = mul nuw nsw i32 %443, %77
  %464 = zext i32 %463 to i64
  %465 = load i32, i32* %449, align 4, !tbaa !87
  %466 = load i32, i32* %450, align 4, !tbaa !89
  br label %467

; <label>:467:                                    ; preds = %586, %447
  %468 = phi i32 [ %448, %447 ], [ %587, %586 ]
  %469 = phi i32 [ %445, %447 ], [ %588, %586 ]
  %470 = phi i32 [ %465, %447 ], [ %589, %586 ]
  %471 = phi i32 [ %466, %447 ], [ %590, %586 ]
  %472 = phi i32 [ %466, %447 ], [ %591, %586 ]
  %473 = phi i32 [ %465, %447 ], [ %592, %586 ]
  %474 = phi i32 [ %448, %447 ], [ %594, %586 ]
  %475 = phi i32 [ 0, %447 ], [ %593, %586 ]
  %476 = icmp sgt i32 %472, 0
  br i1 %476, label %477, label %586

; <label>:477:                                    ; preds = %467
  %478 = load i32, i32* %451, align 4, !tbaa !87
  %479 = load i32, i32* %452, align 4, !tbaa !89
  br label %480

; <label>:480:                                    ; preds = %572, %477
  %481 = phi i32 [ %573, %572 ], [ %470, %477 ]
  %482 = phi i32 [ %574, %572 ], [ %471, %477 ]
  %483 = phi i32 [ %575, %572 ], [ %478, %477 ]
  %484 = phi i32 [ %576, %572 ], [ %479, %477 ]
  %485 = phi i32 [ %577, %572 ], [ %479, %477 ]
  %486 = phi i32 [ %578, %572 ], [ %478, %477 ]
  %487 = phi i32 [ %580, %572 ], [ %473, %477 ]
  %488 = phi i32 [ %579, %572 ], [ %475, %477 ]
  %489 = icmp sgt i32 %485, 0
  br i1 %489, label %490, label %572

; <label>:490:                                    ; preds = %480
  %491 = load i32, i32* %453, align 4, !tbaa !87
  %492 = load i32, i32* %454, align 4, !tbaa !89
  br label %493

; <label>:493:                                    ; preds = %560, %490
  %494 = phi i32 [ %561, %560 ], [ %483, %490 ]
  %495 = phi i32 [ %562, %560 ], [ %484, %490 ]
  %496 = phi i32 [ %563, %560 ], [ %492, %490 ]
  %497 = phi i32 [ %564, %560 ], [ %491, %490 ]
  %498 = phi i32 [ %566, %560 ], [ %486, %490 ]
  %499 = phi i32 [ %565, %560 ], [ %488, %490 ]
  %500 = icmp sgt i32 %496, 0
  br i1 %500, label %501, label %560

; <label>:501:                                    ; preds = %550, %493
  %502 = phi i32 [ %552, %550 ], [ %497, %493 ]
  %503 = phi i32 [ %551, %550 ], [ %499, %493 ]
  %504 = add nsw i32 %503, 1
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %455) #14
  store i32 %502, i32* %456, align 4, !tbaa !96
  store i32 %498, i32* %457, align 4, !tbaa !96
  store i32 %487, i32* %458, align 4, !tbaa !96
  store i32 %474, i32* %459, align 4, !tbaa !96
  %505 = load i32, i32* %19, align 4, !tbaa !79
  %506 = icmp sgt i32 %505, 0
  br i1 %506, label %507, label %533

; <label>:507:                                    ; preds = %501
  %508 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %460, align 8, !tbaa !86
  %509 = sext i32 %505 to i64
  %510 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %508, i64 0, i32 2
  %511 = load i32, i32* %510, align 4, !tbaa !90
  %512 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %508, i64 0, i32 0
  %513 = load i32, i32* %512, align 4, !tbaa !87
  %514 = sub nsw i32 %502, %513
  %515 = mul nsw i32 %514, %511
  %516 = sext i32 %515 to i64
  %517 = icmp eq i32 %505, 1
  br i1 %517, label %533, label %518

; <label>:518:                                    ; preds = %518, %507
  %519 = phi i64 [ %531, %518 ], [ 1, %507 ]
  %520 = phi i64 [ %530, %518 ], [ %516, %507 ]
  %521 = getelementptr inbounds [4 x i32], [4 x i32]* %17, i64 0, i64 %519
  %522 = load i32, i32* %521, align 4, !tbaa !96
  %523 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %508, i64 %519, i32 2
  %524 = load i32, i32* %523, align 4, !tbaa !90
  %525 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %508, i64 %519, i32 0
  %526 = load i32, i32* %525, align 4, !tbaa !87
  %527 = sub nsw i32 %522, %526
  %528 = mul nsw i32 %527, %524
  %529 = sext i32 %528 to i64
  %530 = add nsw i64 %520, %529
  %531 = add nuw nsw i64 %519, 1
  %532 = icmp eq i64 %531, %509
  br i1 %532, label %533, label %518

; <label>:533:                                    ; preds = %518, %507, %501
  %534 = phi i64 [ 0, %501 ], [ %516, %507 ], [ %530, %518 ]
  %535 = load i8*, i8** %461, align 8, !tbaa !83
  %536 = load i8, i8* %73, align 1, !tbaa !99
  %537 = zext i8 %536 to i64
  %538 = add nuw nsw i64 %537, 7
  %539 = lshr i64 %538, 3
  %540 = mul nsw i64 %539, %534
  %541 = getelementptr inbounds i8, i8* %535, i64 %540
  %542 = mul nsw i32 %503, %77
  %543 = sext i32 %542 to i64
  %544 = getelementptr inbounds [4096 x i8], [4096 x i8]* %16, i64 0, i64 %543
  %545 = call i8* @memcpy(i8* nonnull %544, i8* %541, i64 %462) #13
  %546 = icmp eq i32 %504, %443
  br i1 %546, label %547, label %550

; <label>:547:                                    ; preds = %533
  %548 = call i64 @fwrite(i8* nonnull %442, i64 %464, i64 1, i8* nonnull %25) #13
  %549 = icmp eq i64 %548, 0
  br i1 %549, label %597, label %550

; <label>:550:                                    ; preds = %547, %533
  %551 = phi i32 [ 0, %547 ], [ %504, %533 ]
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %455) #14
  %552 = add nsw i32 %502, 1
  %553 = load i32, i32* %454, align 4, !tbaa !89
  %554 = load i32, i32* %453, align 4, !tbaa !87
  %555 = add nsw i32 %554, %553
  %556 = icmp slt i32 %552, %555
  br i1 %556, label %501, label %557

; <label>:557:                                    ; preds = %550
  %558 = load i32, i32* %452, align 4, !tbaa !89
  %559 = load i32, i32* %451, align 4, !tbaa !87
  br label %560

; <label>:560:                                    ; preds = %557, %493
  %561 = phi i32 [ %494, %493 ], [ %559, %557 ]
  %562 = phi i32 [ %495, %493 ], [ %558, %557 ]
  %563 = phi i32 [ %496, %493 ], [ %553, %557 ]
  %564 = phi i32 [ %497, %493 ], [ %554, %557 ]
  %565 = phi i32 [ %499, %493 ], [ %551, %557 ]
  %566 = add nsw i32 %498, 1
  %567 = add nsw i32 %561, %562
  %568 = icmp slt i32 %566, %567
  br i1 %568, label %493, label %569

; <label>:569:                                    ; preds = %560
  %570 = load i32, i32* %450, align 4, !tbaa !89
  %571 = load i32, i32* %449, align 4, !tbaa !87
  br label %572

; <label>:572:                                    ; preds = %569, %480
  %573 = phi i32 [ %481, %480 ], [ %571, %569 ]
  %574 = phi i32 [ %482, %480 ], [ %570, %569 ]
  %575 = phi i32 [ %483, %480 ], [ %561, %569 ]
  %576 = phi i32 [ %484, %480 ], [ %562, %569 ]
  %577 = phi i32 [ %485, %480 ], [ %562, %569 ]
  %578 = phi i32 [ %486, %480 ], [ %561, %569 ]
  %579 = phi i32 [ %488, %480 ], [ %565, %569 ]
  %580 = add nsw i32 %487, 1
  %581 = add nsw i32 %573, %574
  %582 = icmp slt i32 %580, %581
  br i1 %582, label %480, label %583

; <label>:583:                                    ; preds = %572
  %584 = load i32, i32* %440, align 4, !tbaa !89
  %585 = load i32, i32* %444, align 4, !tbaa !87
  br label %586

; <label>:586:                                    ; preds = %583, %467
  %587 = phi i32 [ %468, %467 ], [ %585, %583 ]
  %588 = phi i32 [ %469, %467 ], [ %584, %583 ]
  %589 = phi i32 [ %470, %467 ], [ %573, %583 ]
  %590 = phi i32 [ %471, %467 ], [ %574, %583 ]
  %591 = phi i32 [ %472, %467 ], [ %574, %583 ]
  %592 = phi i32 [ %473, %467 ], [ %573, %583 ]
  %593 = phi i32 [ %475, %467 ], [ %579, %583 ]
  %594 = add nsw i32 %474, 1
  %595 = add nsw i32 %587, %588
  %596 = icmp slt i32 %594, %595
  br i1 %596, label %467, label %598

; <label>:597:                                    ; preds = %547
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %455) #14
  br label %618

; <label>:598:                                    ; preds = %586
  %599 = icmp sgt i32 %593, 0
  br i1 %599, label %600, label %605

; <label>:600:                                    ; preds = %598
  %601 = mul nsw i32 %593, %77
  %602 = sext i32 %601 to i64
  %603 = call i64 @fwrite(i8* nonnull %442, i64 %602, i64 1, i8* nonnull %25) #13
  %604 = icmp eq i64 %603, 0
  br i1 %604, label %618, label %605

; <label>:605:                                    ; preds = %600, %598, %439
  %606 = bitcast i64* %18 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %606) #14
  store i64 0, i64* %18, align 8, !tbaa !11
  %607 = icmp eq i32 %441, 0
  br i1 %607, label %615, label %608

; <label>:608:                                    ; preds = %605
  %609 = icmp ugt i32 %441, 8
  br i1 %609, label %610, label %611

; <label>:610:                                    ; preds = %608
  call void @halide_error(i8* %0, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.6.41, i64 0, i64 0)) #13
  br label %616

; <label>:611:                                    ; preds = %608
  %612 = zext i32 %441 to i64
  %613 = call i64 @fwrite(i8* nonnull %606, i64 %612, i64 1, i8* nonnull %25) #13
  %614 = icmp eq i64 %613, 0
  br i1 %614, label %616, label %615

; <label>:615:                                    ; preds = %611, %605
  br label %616

; <label>:616:                                    ; preds = %615, %611, %610
  %617 = phi i32 [ -15, %610 ], [ 0, %615 ], [ -16, %611 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %606) #14
  br label %618

; <label>:618:                                    ; preds = %616, %600, %597
  %619 = phi i32 [ %617, %616 ], [ -13, %597 ], [ -14, %600 ]
  call void @llvm.lifetime.end.p0i8(i64 4096, i8* nonnull %442) #14
  br label %620

; <label>:620:                                    ; preds = %618, %422, %415, %341, %230
  %621 = phi i32 [ %619, %618 ], [ %418, %415 ], [ -12, %422 ], [ %231, %230 ], [ -6, %341 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %28) #14
  br label %622

; <label>:622:                                    ; preds = %620, %23
  %623 = phi i32 [ %621, %620 ], [ -2, %23 ]
  %624 = call i32 @fclose(i8* %25) #13
  br label %625

; <label>:625:                                    ; preds = %622, %22
  %626 = phi i32 [ -1, %22 ], [ %623, %622 ]
  ret i32 %626
}

declare i64 @fwrite(i8*, i64, i64, i8*) local_unnamed_addr #1

; Function Attrs: nounwind
define weak void @halide_cache_cleanup() #0 {
  tail call void @halide_memoization_cache_cleanup() #15
  ret void
}

; Function Attrs: nounwind
define weak void @halide_memoization_cache_cleanup() local_unnamed_addr #0 {
  br label %2

; <label>:1:                                      ; preds = %13
  store i64 0, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE, align 8, !tbaa !3
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE, align 8, !tbaa !3
  ret void

; <label>:2:                                      ; preds = %13, %0
  %3 = phi i64 [ 0, %0 ], [ %14, %13 ]
  %4 = getelementptr inbounds [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*], [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*]* @_ZN6Halide7Runtime8Internal13cache_entriesE, i64 0, i64 %3
  %5 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %4, align 8, !tbaa !3
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %4, align 8, !tbaa !3
  %6 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %5, null
  br i1 %6, label %13, label %7

; <label>:7:                                      ; preds = %7, %2
  %8 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %11, %7 ], [ %5, %2 ]
  %9 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"* %8 to i8*
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %8, i64 0, i32 0
  %11 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %10, align 8, !tbaa !146
  tail call void @_ZN6Halide7Runtime8Internal10CacheEntry7destroyEv(%"struct.Halide::Runtime::Internal::CacheEntry"* nonnull %8) #15
  tail call void @halide_free(i8* null, i8* %9) #13
  %12 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %11, null
  br i1 %12, label %13, label %7

; <label>:13:                                     ; preds = %7, %2
  %14 = add nuw nsw i64 %3, 1
  %15 = icmp eq i64 %14, 256
  br i1 %15, label %1, label %2
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal10CacheEntry7destroyEv(%"struct.Halide::Runtime::Internal::CacheEntry"*) local_unnamed_addr #0 align 2 {
  %2 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 8
  %3 = load i32, i32* %2, align 8, !tbaa !148
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 11
  br label %10

; <label>:7:                                      ; preds = %10, %1
  %8 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 3
  %9 = load i8*, i8** %8, align 8, !tbaa !149
  tail call void @halide_free(i8* null, i8* %9) #13
  ret void

; <label>:10:                                     ; preds = %10, %5
  %11 = phi i64 [ 0, %5 ], [ %20, %10 ]
  %12 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %6, align 8, !tbaa !150
  %13 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %12, i64 %11
  %14 = tail call i32 @halide_device_free(i8* null, %struct.halide_buffer_t* %13) #13
  %15 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %6, align 8, !tbaa !150
  %16 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %15, i64 %11, i32 2
  %17 = load i8*, i8** %16, align 8, !tbaa !83
  %18 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %17) #15
  %19 = bitcast %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %18 to i8*
  tail call void @halide_free(i8* null, i8* %19) #13
  %20 = add nuw nsw i64 %11, 1
  %21 = load i32, i32* %2, align 8, !tbaa !148
  %22 = zext i32 %21 to i64
  %23 = icmp ult i64 %20, %22
  br i1 %23, label %10, label %7
}

; Function Attrs: nounwind
define linkonce %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8*) local_unnamed_addr #0 {
  %2 = tail call i32 @_ZN6Halide7Runtime8Internal23halide_malloc_alignmentEv() #13
  %3 = add nsw i32 %2, -1
  %4 = sext i32 %3 to i64
  %5 = add nsw i64 %4, 16
  %6 = xor i64 %4, -1
  %7 = and i64 %5, %6
  %8 = sub nsw i64 0, %7
  %9 = getelementptr inbounds i8, i8* %0, i64 %8
  %10 = bitcast i8* %9 to %"struct.Halide::Runtime::Internal::CacheBlockHeader"*
  ret %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %10
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx(%"struct.Halide::Runtime::Internal::device_copy"* dereferenceable(416), i32, i64, i64) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %1, -1
  br i1 %5, label %6, label %20

; <label>:6:                                      ; preds = %4
  %7 = sext i32 %1 to i64
  br label %8

; <label>:8:                                      ; preds = %14, %6
  %9 = phi i64 [ %7, %6 ], [ %15, %14 ]
  %10 = phi i32 [ %1, %6 ], [ %16, %14 ]
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 3, i64 %9
  %12 = load i64, i64* %11, align 8, !tbaa !11
  %13 = icmp eq i64 %12, 1
  br i1 %13, label %14, label %18

; <label>:14:                                     ; preds = %8
  %15 = add nsw i64 %9, -1
  %16 = add nsw i32 %10, -1
  %17 = icmp sgt i64 %9, 0
  br i1 %17, label %8, label %20

; <label>:18:                                     ; preds = %8
  %19 = trunc i64 %9 to i32
  br label %20

; <label>:20:                                     ; preds = %18, %14, %4
  %21 = phi i32 [ %1, %4 ], [ %19, %18 ], [ %16, %14 ]
  %22 = icmp eq i32 %21, -1
  br i1 %22, label %32, label %23

; <label>:23:                                     ; preds = %20
  %24 = sext i32 %21 to i64
  %25 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 3, i64 %24
  %26 = load i64, i64* %25, align 8, !tbaa !11
  %27 = icmp eq i64 %26, 0
  br i1 %27, label %55, label %28

; <label>:28:                                     ; preds = %23
  %29 = add nsw i32 %21, -1
  %30 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 4, i64 %24
  %31 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 5, i64 %24
  br label %44

; <label>:32:                                     ; preds = %20
  %33 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 0
  %34 = load i64, i64* %33, align 8, !tbaa !151
  %35 = add i64 %34, %2
  %36 = inttoptr i64 %35 to i8*
  %37 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 1
  %38 = load i64, i64* %37, align 8, !tbaa !153
  %39 = add i64 %38, %3
  %40 = inttoptr i64 %39 to i8*
  %41 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 6
  %42 = load i64, i64* %41, align 8, !tbaa !154
  %43 = tail call i8* @memcpy(i8* %40, i8* %36, i64 %42) #13
  br label %55

; <label>:44:                                     ; preds = %44, %28
  %45 = phi i64 [ 0, %28 ], [ %52, %44 ]
  %46 = phi i64 [ %2, %28 ], [ %49, %44 ]
  %47 = phi i64 [ %3, %28 ], [ %51, %44 ]
  tail call void @_ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx(%"struct.Halide::Runtime::Internal::device_copy"* nonnull dereferenceable(416) %0, i32 %29, i64 %46, i64 %47) #15
  %48 = load i64, i64* %30, align 8, !tbaa !11
  %49 = add i64 %48, %46
  %50 = load i64, i64* %31, align 8, !tbaa !11
  %51 = add i64 %50, %47
  %52 = add nuw i64 %45, 1
  %53 = load i64, i64* %25, align 8, !tbaa !11
  %54 = icmp ult i64 %52, %53
  br i1 %54, label %44, label %55

; <label>:55:                                     ; preds = %44, %32, %23
  ret void
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv(%"struct.Halide::Runtime::Internal::device_copy"* dereferenceable(416), i8*) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 0
  %4 = load i64, i64* %3, align 8, !tbaa !151
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 1
  %6 = load i64, i64* %5, align 8, !tbaa !153
  %7 = icmp eq i64 %4, %6
  br i1 %7, label %11, label %8

; <label>:8:                                      ; preds = %2
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %0, i64 0, i32 2
  %10 = load i64, i64* %9, align 8, !tbaa !155
  tail call void @_ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx(%"struct.Halide::Runtime::Internal::device_copy"* nonnull dereferenceable(416) %0, i32 15, i64 %10, i64 0) #15
  br label %11

; <label>:11:                                     ; preds = %8, %2
  ret void
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b(%"struct.Halide::Runtime::Internal::device_copy"* noalias sret, %struct.halide_buffer_t*, i1 zeroext, %struct.halide_buffer_t*, i1 zeroext) local_unnamed_addr #0 {
  %6 = alloca %"struct.Halide::Runtime::Internal::device_copy", align 8
  %7 = bitcast %"struct.Halide::Runtime::Internal::device_copy"* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 416, i8* nonnull %7) #14
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 2
  %9 = bitcast i8** %8 to i64*
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = select i1 %2, i64* %9, i64* %10
  %12 = load i64, i64* %11, align 8, !tbaa !7
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 0
  store i64 %12, i64* %13, align 8, !tbaa !151
  %14 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 2
  %15 = bitcast i8** %14 to i64*
  %16 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 0
  %17 = select i1 %4, i64* %15, i64* %16
  %18 = load i64, i64* %17, align 8, !tbaa !7
  %19 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 1
  store i64 %18, i64* %19, align 8, !tbaa !153
  %20 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 4, i32 1
  %21 = load i8, i8* %20, align 1, !tbaa !99
  %22 = zext i8 %21 to i32
  %23 = add nuw nsw i32 %22, 7
  %24 = lshr i32 %23, 3
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 6
  store i64 %25, i64* %26, align 8, !tbaa !154
  %27 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 0
  store i64 1, i64* %27, align 8, !tbaa !11
  %28 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 0
  store i64 0, i64* %28, align 8, !tbaa !11
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 0
  store i64 0, i64* %29, align 8, !tbaa !11
  %30 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 1
  store i64 1, i64* %30, align 8, !tbaa !11
  %31 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 1
  store i64 0, i64* %31, align 8, !tbaa !11
  %32 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 1
  store i64 0, i64* %32, align 8, !tbaa !11
  %33 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 2
  store i64 1, i64* %33, align 8, !tbaa !11
  %34 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 2
  store i64 0, i64* %34, align 8, !tbaa !11
  %35 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 2
  store i64 0, i64* %35, align 8, !tbaa !11
  %36 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 3
  store i64 1, i64* %36, align 8, !tbaa !11
  %37 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 3
  store i64 0, i64* %37, align 8, !tbaa !11
  %38 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 3
  store i64 0, i64* %38, align 8, !tbaa !11
  %39 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 4
  store i64 1, i64* %39, align 8, !tbaa !11
  %40 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 4
  store i64 0, i64* %40, align 8, !tbaa !11
  %41 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 4
  store i64 0, i64* %41, align 8, !tbaa !11
  %42 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 5
  store i64 1, i64* %42, align 8, !tbaa !11
  %43 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 5
  store i64 0, i64* %43, align 8, !tbaa !11
  %44 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 5
  store i64 0, i64* %44, align 8, !tbaa !11
  %45 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 6
  store i64 1, i64* %45, align 8, !tbaa !11
  %46 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 6
  store i64 0, i64* %46, align 8, !tbaa !11
  %47 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 6
  store i64 0, i64* %47, align 8, !tbaa !11
  %48 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 7
  store i64 1, i64* %48, align 8, !tbaa !11
  %49 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 7
  store i64 0, i64* %49, align 8, !tbaa !11
  %50 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 7
  store i64 0, i64* %50, align 8, !tbaa !11
  %51 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 8
  store i64 1, i64* %51, align 8, !tbaa !11
  %52 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 8
  store i64 0, i64* %52, align 8, !tbaa !11
  %53 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 8
  store i64 0, i64* %53, align 8, !tbaa !11
  %54 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 9
  store i64 1, i64* %54, align 8, !tbaa !11
  %55 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 9
  store i64 0, i64* %55, align 8, !tbaa !11
  %56 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 9
  store i64 0, i64* %56, align 8, !tbaa !11
  %57 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 10
  store i64 1, i64* %57, align 8, !tbaa !11
  %58 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 10
  store i64 0, i64* %58, align 8, !tbaa !11
  %59 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 10
  store i64 0, i64* %59, align 8, !tbaa !11
  %60 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 11
  store i64 1, i64* %60, align 8, !tbaa !11
  %61 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 11
  store i64 0, i64* %61, align 8, !tbaa !11
  %62 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 11
  store i64 0, i64* %62, align 8, !tbaa !11
  %63 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 12
  store i64 1, i64* %63, align 8, !tbaa !11
  %64 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 12
  store i64 0, i64* %64, align 8, !tbaa !11
  %65 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 12
  store i64 0, i64* %65, align 8, !tbaa !11
  %66 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 13
  store i64 1, i64* %66, align 8, !tbaa !11
  %67 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 13
  store i64 0, i64* %67, align 8, !tbaa !11
  %68 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 13
  store i64 0, i64* %68, align 8, !tbaa !11
  %69 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 14
  store i64 1, i64* %69, align 8, !tbaa !11
  %70 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 14
  store i64 0, i64* %70, align 8, !tbaa !11
  %71 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 14
  store i64 0, i64* %71, align 8, !tbaa !11
  %72 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 15
  store i64 1, i64* %72, align 8, !tbaa !11
  %73 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 15
  store i64 0, i64* %73, align 8, !tbaa !11
  %74 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 15
  store i64 0, i64* %74, align 8, !tbaa !11
  %75 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 2
  store i64 0, i64* %75, align 8, !tbaa !155
  %76 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 5
  %77 = load i32, i32* %76, align 4, !tbaa !79
  %78 = icmp sgt i32 %77, 0
  br i1 %78, label %79, label %86

; <label>:79:                                     ; preds = %5
  %80 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 6
  %81 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %80, align 8, !tbaa !86
  %82 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %83 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %82, align 8, !tbaa !86
  %84 = sext i32 %77 to i64
  br label %93

; <label>:85:                                     ; preds = %93
  store i64 %105, i64* %75, align 8, !tbaa !155
  br label %86

; <label>:86:                                     ; preds = %85, %5
  %87 = phi i64 [ %105, %85 ], [ 0, %5 ]
  %88 = load i64, i64* %26, align 8, !tbaa !154
  %89 = mul i64 %87, %88
  store i64 %89, i64* %75, align 8, !tbaa !155
  %90 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 5
  %91 = load i32, i32* %90, align 4, !tbaa !79
  %92 = icmp eq i32 %77, %91
  br i1 %92, label %108, label %117

; <label>:93:                                     ; preds = %93, %79
  %94 = phi i64 [ 0, %79 ], [ %106, %93 ]
  %95 = phi i64 [ 0, %79 ], [ %105, %93 ]
  %96 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %81, i64 %94, i32 2
  %97 = load i32, i32* %96, align 4, !tbaa !90
  %98 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %83, i64 %94, i32 0
  %99 = load i32, i32* %98, align 4, !tbaa !87
  %100 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %81, i64 %94, i32 0
  %101 = load i32, i32* %100, align 4, !tbaa !87
  %102 = sub nsw i32 %99, %101
  %103 = mul nsw i32 %102, %97
  %104 = sext i32 %103 to i64
  %105 = add i64 %95, %104
  %106 = add nuw nsw i64 %94, 1
  %107 = icmp slt i64 %106, %84
  br i1 %107, label %93, label %85

; <label>:108:                                    ; preds = %86
  %109 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  %110 = load i8, i8* %109, align 1, !tbaa !99
  %111 = zext i8 %110 to i32
  %112 = add nuw nsw i32 %111, 7
  %113 = lshr i32 %112, 3
  %114 = icmp ne i32 %24, %113
  %115 = icmp sgt i32 %77, 16
  %116 = or i1 %115, %114
  br i1 %116, label %117, label %119

; <label>:117:                                    ; preds = %108, %86
  %118 = bitcast %"struct.Halide::Runtime::Internal::device_copy"* %0 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* align 8 %118, i8 0, i64 416, i1 false)
  br label %246

; <label>:119:                                    ; preds = %108
  %120 = icmp eq i64 %88, 0
  br i1 %120, label %128, label %121

; <label>:121:                                    ; preds = %119
  br i1 %78, label %122, label %244

; <label>:122:                                    ; preds = %121
  %123 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %124 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %123, align 8, !tbaa !86
  %125 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 6
  %126 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %125, align 8, !tbaa !86
  %127 = zext i32 %77 to i64
  br label %136

; <label>:128:                                    ; preds = %119
  %129 = bitcast %"struct.Halide::Runtime::Internal::device_copy"* %0 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* align 8 %129, i8 0, i64 416, i1 false)
  br label %246

; <label>:130:                                    ; preds = %169
  %131 = load i64, i64* %26, align 8, !tbaa !154
  %132 = load i64, i64* %28, align 8, !tbaa !11
  %133 = icmp eq i64 %131, %132
  br i1 %133, label %134, label %244

; <label>:134:                                    ; preds = %130
  %135 = load i64, i64* %29, align 8, !tbaa !11
  br label %191

; <label>:136:                                    ; preds = %169, %122
  %137 = phi i64 [ 0, %122 ], [ %176, %169 ]
  %138 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %124, i64 %137, i32 2
  %139 = load i32, i32* %138, align 4, !tbaa !90
  %140 = mul nsw i32 %139, %24
  %141 = sext i32 %140 to i64
  %142 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %126, i64 %137, i32 2
  %143 = load i32, i32* %142, align 4, !tbaa !90
  %144 = mul nsw i32 %143, %24
  %145 = sext i32 %144 to i64
  %146 = icmp eq i64 %137, 0
  br i1 %146, label %163, label %147

; <label>:147:                                    ; preds = %136
  %148 = icmp eq i32 %140, 0
  br i1 %148, label %149, label %151

; <label>:149:                                    ; preds = %147
  %150 = trunc i64 %137 to i32
  br label %163

; <label>:151:                                    ; preds = %157, %147
  %152 = phi i64 [ %158, %157 ], [ 0, %147 ]
  %153 = phi i32 [ %159, %157 ], [ 0, %147 ]
  %154 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 %152
  %155 = load i64, i64* %154, align 8, !tbaa !11
  %156 = icmp ugt i64 %155, %141
  br i1 %156, label %161, label %157

; <label>:157:                                    ; preds = %151
  %158 = add nuw nsw i64 %152, 1
  %159 = add nuw nsw i32 %153, 1
  %160 = icmp ult i64 %158, %137
  br i1 %160, label %151, label %163

; <label>:161:                                    ; preds = %151
  %162 = trunc i64 %152 to i32
  br label %163

; <label>:163:                                    ; preds = %161, %157, %149, %136
  %164 = phi i32 [ 0, %136 ], [ %150, %149 ], [ %162, %161 ], [ %159, %157 ]
  %165 = zext i32 %164 to i64
  %166 = icmp ugt i64 %137, %165
  br i1 %166, label %167, label %169

; <label>:167:                                    ; preds = %163
  %168 = sext i32 %164 to i64
  br label %178

; <label>:169:                                    ; preds = %178, %163
  %170 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %124, i64 %137, i32 1
  %171 = load i32, i32* %170, align 4, !tbaa !89
  %172 = sext i32 %171 to i64
  %173 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 %165
  store i64 %172, i64* %173, align 8, !tbaa !11
  %174 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 %165
  store i64 %141, i64* %174, align 8, !tbaa !11
  %175 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 %165
  store i64 %145, i64* %175, align 8, !tbaa !11
  %176 = add nuw nsw i64 %137, 1
  %177 = icmp eq i64 %176, %127
  br i1 %177, label %130, label %136

; <label>:178:                                    ; preds = %178, %167
  %179 = phi i64 [ %137, %167 ], [ %180, %178 ]
  %180 = add nsw i64 %179, -1
  %181 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 %180
  %182 = load i64, i64* %181, align 8, !tbaa !11
  %183 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 3, i64 %179
  store i64 %182, i64* %183, align 8, !tbaa !11
  %184 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 %180
  %185 = load i64, i64* %184, align 8, !tbaa !11
  %186 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 5, i64 %179
  store i64 %185, i64* %186, align 8, !tbaa !11
  %187 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 %180
  %188 = load i64, i64* %187, align 8, !tbaa !11
  %189 = getelementptr inbounds %"struct.Halide::Runtime::Internal::device_copy", %"struct.Halide::Runtime::Internal::device_copy"* %6, i64 0, i32 4, i64 %179
  store i64 %188, i64* %189, align 8, !tbaa !11
  %190 = icmp sgt i64 %180, %168
  br i1 %190, label %178, label %169

; <label>:191:                                    ; preds = %195, %134
  %192 = phi i64 [ %135, %134 ], [ %200, %195 ]
  %193 = phi i64 [ %132, %134 ], [ %197, %195 ]
  %194 = icmp eq i64 %193, %192
  br i1 %194, label %195, label %244

; <label>:195:                                    ; preds = %191
  %196 = load i64, i64* %27, align 8, !tbaa !11
  %197 = mul i64 %196, %192
  store i64 %197, i64* %26, align 8, !tbaa !154
  %198 = load i64, i64* %30, align 8, !tbaa !11
  store i64 %198, i64* %27, align 8, !tbaa !11
  %199 = load i64, i64* %31, align 8, !tbaa !11
  store i64 %199, i64* %28, align 8, !tbaa !11
  %200 = load i64, i64* %32, align 8, !tbaa !11
  store i64 %200, i64* %29, align 8, !tbaa !11
  %201 = load i64, i64* %33, align 8, !tbaa !11
  store i64 %201, i64* %30, align 8, !tbaa !11
  %202 = load i64, i64* %34, align 8, !tbaa !11
  store i64 %202, i64* %31, align 8, !tbaa !11
  %203 = load i64, i64* %35, align 8, !tbaa !11
  store i64 %203, i64* %32, align 8, !tbaa !11
  %204 = load i64, i64* %36, align 8, !tbaa !11
  store i64 %204, i64* %33, align 8, !tbaa !11
  %205 = load i64, i64* %37, align 8, !tbaa !11
  store i64 %205, i64* %34, align 8, !tbaa !11
  %206 = load i64, i64* %38, align 8, !tbaa !11
  store i64 %206, i64* %35, align 8, !tbaa !11
  %207 = load i64, i64* %39, align 8, !tbaa !11
  store i64 %207, i64* %36, align 8, !tbaa !11
  %208 = load i64, i64* %40, align 8, !tbaa !11
  store i64 %208, i64* %37, align 8, !tbaa !11
  %209 = load i64, i64* %41, align 8, !tbaa !11
  store i64 %209, i64* %38, align 8, !tbaa !11
  %210 = load i64, i64* %42, align 8, !tbaa !11
  store i64 %210, i64* %39, align 8, !tbaa !11
  %211 = load i64, i64* %43, align 8, !tbaa !11
  store i64 %211, i64* %40, align 8, !tbaa !11
  %212 = load i64, i64* %44, align 8, !tbaa !11
  store i64 %212, i64* %41, align 8, !tbaa !11
  %213 = load i64, i64* %45, align 8, !tbaa !11
  store i64 %213, i64* %42, align 8, !tbaa !11
  %214 = load i64, i64* %46, align 8, !tbaa !11
  store i64 %214, i64* %43, align 8, !tbaa !11
  %215 = load i64, i64* %47, align 8, !tbaa !11
  store i64 %215, i64* %44, align 8, !tbaa !11
  %216 = load i64, i64* %48, align 8, !tbaa !11
  store i64 %216, i64* %45, align 8, !tbaa !11
  %217 = load i64, i64* %49, align 8, !tbaa !11
  store i64 %217, i64* %46, align 8, !tbaa !11
  %218 = load i64, i64* %50, align 8, !tbaa !11
  store i64 %218, i64* %47, align 8, !tbaa !11
  %219 = load i64, i64* %51, align 8, !tbaa !11
  store i64 %219, i64* %48, align 8, !tbaa !11
  %220 = load i64, i64* %52, align 8, !tbaa !11
  store i64 %220, i64* %49, align 8, !tbaa !11
  %221 = load i64, i64* %53, align 8, !tbaa !11
  store i64 %221, i64* %50, align 8, !tbaa !11
  %222 = load i64, i64* %54, align 8, !tbaa !11
  store i64 %222, i64* %51, align 8, !tbaa !11
  %223 = load i64, i64* %55, align 8, !tbaa !11
  store i64 %223, i64* %52, align 8, !tbaa !11
  %224 = load i64, i64* %56, align 8, !tbaa !11
  store i64 %224, i64* %53, align 8, !tbaa !11
  %225 = load i64, i64* %57, align 8, !tbaa !11
  store i64 %225, i64* %54, align 8, !tbaa !11
  %226 = load i64, i64* %58, align 8, !tbaa !11
  store i64 %226, i64* %55, align 8, !tbaa !11
  %227 = load i64, i64* %59, align 8, !tbaa !11
  store i64 %227, i64* %56, align 8, !tbaa !11
  %228 = load i64, i64* %60, align 8, !tbaa !11
  store i64 %228, i64* %57, align 8, !tbaa !11
  %229 = load i64, i64* %61, align 8, !tbaa !11
  store i64 %229, i64* %58, align 8, !tbaa !11
  %230 = load i64, i64* %62, align 8, !tbaa !11
  store i64 %230, i64* %59, align 8, !tbaa !11
  %231 = load i64, i64* %63, align 8, !tbaa !11
  store i64 %231, i64* %60, align 8, !tbaa !11
  %232 = load i64, i64* %64, align 8, !tbaa !11
  store i64 %232, i64* %61, align 8, !tbaa !11
  %233 = load i64, i64* %65, align 8, !tbaa !11
  store i64 %233, i64* %62, align 8, !tbaa !11
  %234 = load i64, i64* %66, align 8, !tbaa !11
  store i64 %234, i64* %63, align 8, !tbaa !11
  %235 = load i64, i64* %67, align 8, !tbaa !11
  store i64 %235, i64* %64, align 8, !tbaa !11
  %236 = load i64, i64* %68, align 8, !tbaa !11
  store i64 %236, i64* %65, align 8, !tbaa !11
  %237 = load i64, i64* %69, align 8, !tbaa !11
  store i64 %237, i64* %66, align 8, !tbaa !11
  %238 = load i64, i64* %70, align 8, !tbaa !11
  store i64 %238, i64* %67, align 8, !tbaa !11
  %239 = load i64, i64* %71, align 8, !tbaa !11
  store i64 %239, i64* %68, align 8, !tbaa !11
  %240 = load i64, i64* %72, align 8, !tbaa !11
  store i64 %240, i64* %69, align 8, !tbaa !11
  %241 = load i64, i64* %73, align 8, !tbaa !11
  store i64 %241, i64* %70, align 8, !tbaa !11
  %242 = load i64, i64* %74, align 8, !tbaa !11
  store i64 %242, i64* %71, align 8, !tbaa !11
  store i64 1, i64* %72, align 8, !tbaa !11
  store i64 0, i64* %73, align 8, !tbaa !11
  store i64 0, i64* %74, align 8, !tbaa !11
  %243 = icmp eq i64 %197, %199
  br i1 %243, label %191, label %244

; <label>:244:                                    ; preds = %195, %191, %130, %121
  %245 = bitcast %"struct.Halide::Runtime::Internal::device_copy"* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %245, i8* nonnull align 8 %7, i64 416, i1 false), !tbaa.struct !156
  br label %246

; <label>:246:                                    ; preds = %244, %128, %117
  call void @llvm.lifetime.end.p0i8(i64 416, i8* nonnull %7) #14
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #3

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal24make_host_to_device_copyEPK15halide_buffer_t(%"struct.Halide::Runtime::Internal::device_copy"* noalias sret, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @_ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b(%"struct.Halide::Runtime::Internal::device_copy"* sret %0, %struct.halide_buffer_t* %1, i1 zeroext true, %struct.halide_buffer_t* %1, i1 zeroext false) #15
  ret void
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal24make_device_to_host_copyEPK15halide_buffer_t(%"struct.Halide::Runtime::Internal::device_copy"* noalias sret, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @_ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b(%"struct.Halide::Runtime::Internal::device_copy"* sret %0, %struct.halide_buffer_t* %1, i1 zeroext false, %struct.halide_buffer_t* %1, i1 zeroext true) #15
  ret void
}

; Function Attrs: nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m(i8*, i8*, i64) local_unnamed_addr #0 {
  %4 = tail call i32 @memcmp(i8* %0, i8* %1, i64 %2) #13
  %5 = icmp eq i32 %4, 0
  ret i1 %5
}

declare i32 @memcmp(i8*, i8*, i64) local_unnamed_addr #1

; Function Attrs: norecurse nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t*, %struct.halide_dimension_t*) local_unnamed_addr #2 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 5
  %4 = load i32, i32* %3, align 4, !tbaa !79
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %6, label %38

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %0, i64 0, i32 6
  %8 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %7, align 8, !tbaa !86
  %9 = sext i32 %4 to i64
  br label %12

; <label>:10:                                     ; preds = %31
  %11 = icmp slt i64 %37, %9
  br i1 %11, label %12, label %38

; <label>:12:                                     ; preds = %10, %6
  %13 = phi i64 [ 0, %6 ], [ %37, %10 ]
  %14 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %8, i64 %13, i32 0
  %15 = load i32, i32* %14, align 4, !tbaa !87
  %16 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %1, i64 %13, i32 0
  %17 = load i32, i32* %16, align 4, !tbaa !87
  %18 = icmp eq i32 %15, %17
  br i1 %18, label %19, label %38

; <label>:19:                                     ; preds = %12
  %20 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %8, i64 %13, i32 1
  %21 = load i32, i32* %20, align 4, !tbaa !89
  %22 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %1, i64 %13, i32 1
  %23 = load i32, i32* %22, align 4, !tbaa !89
  %24 = icmp eq i32 %21, %23
  br i1 %24, label %25, label %38

; <label>:25:                                     ; preds = %19
  %26 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %8, i64 %13, i32 2
  %27 = load i32, i32* %26, align 4, !tbaa !90
  %28 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %1, i64 %13, i32 2
  %29 = load i32, i32* %28, align 4, !tbaa !90
  %30 = icmp eq i32 %27, %29
  br i1 %30, label %31, label %38

; <label>:31:                                     ; preds = %25
  %32 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %8, i64 %13, i32 3
  %33 = load i32, i32* %32, align 4, !tbaa !135
  %34 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %1, i64 %13, i32 3
  %35 = load i32, i32* %34, align 4, !tbaa !135
  %36 = icmp eq i32 %33, %35
  %37 = add nuw nsw i64 %13, 1
  br i1 %36, label %10, label %38

; <label>:38:                                     ; preds = %31, %25, %19, %12, %10, %2
  %39 = phi i1 [ true, %2 ], [ false, %31 ], [ false, %12 ], [ false, %19 ], [ false, %25 ], [ true, %10 ]
  ret i1 %39
}

; Function Attrs: alwaysinline nounwind
define linkonce i64 @_ZN6Halide7Runtime8Internal12header_bytesEv() local_unnamed_addr #5 {
  %1 = tail call i32 @_ZN6Halide7Runtime8Internal23halide_malloc_alignmentEv() #13
  %2 = add nsw i32 %1, -1
  %3 = sext i32 %2 to i64
  %4 = add nsw i64 %3, 16
  %5 = xor i64 %3, -1
  %6 = and i64 %4, %5
  ret i64 %6
}

; Function Attrs: nounwind
define linkonce zeroext i1 @_ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_(%"struct.Halide::Runtime::Internal::CacheEntry"*, i8*, i64, i32, %struct.halide_buffer_t*, i32, %struct.halide_buffer_t**) local_unnamed_addr #0 align 2 {
  %8 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 0
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %8, align 8, !tbaa !146
  %9 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 1
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %9, align 8, !tbaa !157
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 2
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %10, align 8, !tbaa !158
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 4
  store i64 %2, i64* %11, align 8, !tbaa !159
  %12 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 6
  store i32 %3, i32* %12, align 8, !tbaa !160
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 7
  store i32 0, i32* %13, align 4, !tbaa !161
  %14 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 8
  store i32 %5, i32* %14, align 8, !tbaa !148
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 5
  %16 = load i32, i32* %15, align 4, !tbaa !79
  %17 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 9
  store i32 %16, i32* %17, align 4, !tbaa !162
  %18 = zext i32 %5 to i64
  %19 = mul nuw nsw i64 %18, 56
  %20 = sext i32 %16 to i64
  %21 = add i32 %5, 1
  %22 = zext i32 %21 to i64
  %23 = shl nuw nsw i64 %22, 4
  %24 = mul i64 %23, %20
  %25 = add i64 %24, %19
  %26 = add i64 %25, %2
  %27 = tail call i8* @halide_malloc(i8* null, i64 %26) #13
  %28 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 3
  store i8* %27, i8** %28, align 8, !tbaa !149
  %29 = icmp eq i8* %27, null
  br i1 %29, label %119, label %30

; <label>:30:                                     ; preds = %7
  %31 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 11
  %32 = bitcast %struct.halide_buffer_t** %31 to i8**
  store i8* %27, i8** %32, align 8, !tbaa !150
  %33 = getelementptr inbounds i8, i8* %27, i64 %19
  %34 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 10
  %35 = bitcast %struct.halide_dimension_t** %34 to i8**
  store i8* %33, i8** %35, align 8, !tbaa !163
  %36 = getelementptr inbounds i8, i8* %27, i64 %25
  %37 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %0, i64 0, i32 5
  store i8* %36, i8** %37, align 8, !tbaa !164
  %38 = load i64, i64* %11, align 8, !tbaa !159
  %39 = icmp eq i64 %38, 0
  br i1 %39, label %44, label %40

; <label>:40:                                     ; preds = %30
  %41 = load i8, i8* %1, align 1, !tbaa !7
  store i8 %41, i8* %36, align 1, !tbaa !7
  %42 = load i64, i64* %11, align 8, !tbaa !159
  %43 = icmp ugt i64 %42, 1
  br i1 %43, label %49, label %44

; <label>:44:                                     ; preds = %49, %40, %30
  %45 = load i32, i32* %17, align 4, !tbaa !162
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %47, label %58

; <label>:47:                                     ; preds = %44
  %48 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 6
  br label %61

; <label>:49:                                     ; preds = %49, %40
  %50 = phi i64 [ %55, %49 ], [ 1, %40 ]
  %51 = load i8*, i8** %37, align 8, !tbaa !164
  %52 = getelementptr inbounds i8, i8* %1, i64 %50
  %53 = load i8, i8* %52, align 1, !tbaa !7
  %54 = getelementptr inbounds i8, i8* %51, i64 %50
  store i8 %53, i8* %54, align 1, !tbaa !7
  %55 = add nuw i64 %50, 1
  %56 = load i64, i64* %11, align 8, !tbaa !159
  %57 = icmp ult i64 %55, %56
  br i1 %57, label %49, label %44

; <label>:58:                                     ; preds = %61, %44
  %59 = load i32, i32* %14, align 8, !tbaa !148
  %60 = icmp eq i32 %59, 0
  br i1 %60, label %119, label %77

; <label>:61:                                     ; preds = %61, %47
  %62 = phi i64 [ 0, %47 ], [ %69, %61 ]
  %63 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %48, align 8, !tbaa !86
  %64 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %63, i64 %62
  %65 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %34, align 8, !tbaa !163
  %66 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %65, i64 %62
  %67 = bitcast %struct.halide_dimension_t* %66 to i8*
  %68 = bitcast %struct.halide_dimension_t* %64 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %67, i8* align 4 %68, i64 16, i1 false), !tbaa.struct !95
  %69 = add nuw nsw i64 %62, 1
  %70 = load i32, i32* %17, align 4, !tbaa !162
  %71 = sext i32 %70 to i64
  %72 = icmp slt i64 %69, %71
  br i1 %72, label %61, label %58

; <label>:73:                                     ; preds = %103, %95, %77
  %74 = load i32, i32* %14, align 8, !tbaa !148
  %75 = zext i32 %74 to i64
  %76 = icmp ult i64 %86, %75
  br i1 %76, label %77, label %119

; <label>:77:                                     ; preds = %73, %58
  %78 = phi i64 [ %86, %73 ], [ 0, %58 ]
  %79 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %6, i64 %78
  %80 = bitcast %struct.halide_buffer_t** %79 to i8**
  %81 = load i8*, i8** %80, align 8, !tbaa !3
  %82 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %31, align 8, !tbaa !150
  %83 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %82, i64 %78
  %84 = bitcast %struct.halide_buffer_t* %83 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %84, i8* align 8 %81, i64 56, i1 false), !tbaa.struct !97
  %85 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %34, align 8, !tbaa !163
  %86 = add nuw nsw i64 %78, 1
  %87 = load i32, i32* %17, align 4, !tbaa !162
  %88 = trunc i64 %86 to i32
  %89 = mul i32 %87, %88
  %90 = zext i32 %89 to i64
  %91 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %85, i64 %90
  %92 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %31, align 8, !tbaa !150
  %93 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %92, i64 %78, i32 6
  store %struct.halide_dimension_t* %91, %struct.halide_dimension_t** %93, align 8, !tbaa !86
  %94 = icmp sgt i32 %87, 0
  br i1 %94, label %95, label %73

; <label>:95:                                     ; preds = %77
  %96 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %79, align 8, !tbaa !3
  %97 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %96, i64 0, i32 6
  %98 = bitcast %struct.halide_dimension_t** %97 to i8**
  %99 = load i8*, i8** %98, align 8, !tbaa !86
  %100 = bitcast %struct.halide_dimension_t* %91 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %100, i8* align 4 %99, i64 16, i1 false), !tbaa.struct !95
  %101 = load i32, i32* %17, align 4, !tbaa !162
  %102 = icmp sgt i32 %101, 1
  br i1 %102, label %103, label %73

; <label>:103:                                    ; preds = %103, %95
  %104 = phi i64 [ %115, %103 ], [ 1, %95 ]
  %105 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %31, align 8, !tbaa !150
  %106 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %105, i64 %78, i32 6
  %107 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %106, align 8, !tbaa !86
  %108 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %79, align 8, !tbaa !3
  %109 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %108, i64 0, i32 6
  %110 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %109, align 8, !tbaa !86
  %111 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %110, i64 %104
  %112 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %107, i64 %104
  %113 = bitcast %struct.halide_dimension_t* %112 to i8*
  %114 = bitcast %struct.halide_dimension_t* %111 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %113, i8* align 4 %114, i64 16, i1 false), !tbaa.struct !95
  %115 = add nuw nsw i64 %104, 1
  %116 = load i32, i32* %17, align 4, !tbaa !162
  %117 = sext i32 %116 to i64
  %118 = icmp slt i64 %115, %117
  br i1 %118, label %103, label %73

; <label>:119:                                    ; preds = %73, %58, %7
  %120 = phi i1 [ false, %7 ], [ true, %58 ], [ true, %73 ]
  ret i1 %120
}

; Function Attrs: norecurse nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal8djb_hashEPKhm(i8*, i64) local_unnamed_addr #2 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %6, %2
  %5 = phi i32 [ 5381, %2 ], [ %13, %6 ]
  ret i32 %5

; <label>:6:                                      ; preds = %6, %2
  %7 = phi i64 [ %14, %6 ], [ 0, %2 ]
  %8 = phi i32 [ %13, %6 ], [ 5381, %2 ]
  %9 = mul i32 %8, 33
  %10 = getelementptr inbounds i8, i8* %0, i64 %7
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i32
  %13 = add i32 %9, %12
  %14 = add nuw i64 %7, 1
  %15 = icmp eq i64 %14, %1
  br i1 %15, label %4, label %6
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal11prune_cacheEv() local_unnamed_addr #0 {
  %1 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE, align 8, !tbaa !3
  %2 = load i64, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  %3 = load i64, i64* @_ZN6Halide7Runtime8Internal14max_cache_sizeE, align 8, !tbaa !11
  %4 = icmp sgt i64 %2, %3
  %5 = icmp ne %"struct.Halide::Runtime::Internal::CacheEntry"* %1, null
  %6 = and i1 %5, %4
  br i1 %6, label %7, label %150

; <label>:7:                                      ; preds = %144, %0
  %8 = phi i64 [ %145, %144 ], [ %3, %0 ]
  %9 = phi i64 [ %146, %144 ], [ %2, %0 ]
  %10 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %12, %144 ], [ %1, %0 ]
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 1
  %12 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %11, align 8, !tbaa !157
  %13 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 7
  %14 = load i32, i32* %13, align 4, !tbaa !161
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %144

; <label>:16:                                     ; preds = %7
  %17 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 6
  %18 = load i32, i32* %17, align 8, !tbaa !160
  %19 = and i32 %18, 255
  %20 = zext i32 %19 to i64
  %21 = getelementptr inbounds [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*], [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*]* @_ZN6Halide7Runtime8Internal13cache_entriesE, i64 0, i64 %20
  %22 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %21, align 8, !tbaa !3
  %23 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %22, %10
  br i1 %23, label %24, label %28

; <label>:24:                                     ; preds = %16
  %25 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"* %10 to i64*
  %26 = load i64, i64* %25, align 8, !tbaa !146
  %27 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %21 to i64*
  store i64 %26, i64* %27, align 8, !tbaa !3
  br label %40

; <label>:28:                                     ; preds = %31, %16
  %29 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %33, %31 ], [ %22, %16 ]
  %30 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %29, null
  br i1 %30, label %35, label %31

; <label>:31:                                     ; preds = %28
  %32 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %29, i64 0, i32 0
  %33 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %32, align 8, !tbaa !146
  %34 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %33, %10
  br i1 %34, label %36, label %28

; <label>:35:                                     ; preds = %28
  tail call void @halide_print(i8* null, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @.str.4.43, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %36

; <label>:36:                                     ; preds = %35, %31
  %37 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"* %10 to i64*
  %38 = load i64, i64* %37, align 8, !tbaa !146
  %39 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"* %29 to i64*
  store i64 %38, i64* %39, align 8, !tbaa !146
  br label %40

; <label>:40:                                     ; preds = %36, %24
  %41 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE, align 8, !tbaa !3
  %42 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %41, %10
  br i1 %42, label %43, label %44

; <label>:43:                                     ; preds = %40
  store %"struct.Halide::Runtime::Internal::CacheEntry"* %12, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE, align 8, !tbaa !3
  br label %44

; <label>:44:                                     ; preds = %43, %40
  %45 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %12, null
  br i1 %45, label %52, label %46

; <label>:46:                                     ; preds = %44
  %47 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 2
  %48 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %47 to i64*
  %49 = load i64, i64* %48, align 8, !tbaa !158
  %50 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %12, i64 0, i32 2
  %51 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %50 to i64*
  store i64 %49, i64* %51, align 8, !tbaa !158
  br label %52

; <label>:52:                                     ; preds = %46, %44
  %53 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE, align 8, !tbaa !3
  %54 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %53, %10
  %55 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 2
  br i1 %54, label %58, label %56

; <label>:56:                                     ; preds = %52
  %57 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %55, align 8, !tbaa !158
  br label %62

; <label>:58:                                     ; preds = %52
  %59 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %55 to i64*
  %60 = load i64, i64* %59, align 8, !tbaa !158
  store i64 %60, i64* bitcast (%"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE to i64*), align 8, !tbaa !3
  %61 = inttoptr i64 %60 to %"struct.Halide::Runtime::Internal::CacheEntry"*
  br label %62

; <label>:62:                                     ; preds = %58, %56
  %63 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %57, %56 ], [ %61, %58 ]
  %64 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %63, null
  br i1 %64, label %66, label %65

; <label>:65:                                     ; preds = %62
  store %"struct.Halide::Runtime::Internal::CacheEntry"* %12, %"struct.Halide::Runtime::Internal::CacheEntry"** %55, align 8, !tbaa !158
  br label %66

; <label>:66:                                     ; preds = %65, %62
  %67 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 8
  %68 = load i32, i32* %67, align 8, !tbaa !148
  %69 = icmp eq i32 %68, 0
  br i1 %69, label %76, label %70

; <label>:70:                                     ; preds = %66
  %71 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %10, i64 0, i32 11
  %72 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %71, align 8, !tbaa !150
  %73 = load i64, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  %74 = zext i32 %68 to i64
  br label %80

; <label>:75:                                     ; preds = %132
  store i64 %141, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  br label %76

; <label>:76:                                     ; preds = %75, %66
  tail call void @_ZN6Halide7Runtime8Internal10CacheEntry7destroyEv(%"struct.Halide::Runtime::Internal::CacheEntry"* nonnull %10) #15
  %77 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"* %10 to i8*
  tail call void @halide_free(i8* null, i8* %77) #13
  %78 = load i64, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  %79 = load i64, i64* @_ZN6Halide7Runtime8Internal14max_cache_sizeE, align 8, !tbaa !11
  br label %144

; <label>:80:                                     ; preds = %132, %70
  %81 = phi i64 [ 0, %70 ], [ %142, %132 ]
  %82 = phi i64 [ %73, %70 ], [ %141, %132 ]
  %83 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %72, i64 %81, i32 5
  %84 = load i32, i32* %83, align 4, !tbaa !79
  %85 = icmp sgt i32 %84, 0
  br i1 %85, label %89, label %86

; <label>:86:                                     ; preds = %80
  %87 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %72, i64 %81, i32 4, i32 1
  %88 = load i8, i8* %87, align 1, !tbaa !99
  br label %132

; <label>:89:                                     ; preds = %80
  %90 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %72, i64 %81, i32 6
  %91 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %90, align 8, !tbaa !86
  %92 = sext i32 %84 to i64
  br label %93

; <label>:93:                                     ; preds = %106, %89
  %94 = phi i64 [ 0, %89 ], [ %108, %106 ]
  %95 = phi i64 [ 0, %89 ], [ %107, %106 ]
  %96 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %91, i64 %94, i32 2
  %97 = load i32, i32* %96, align 4, !tbaa !90
  %98 = icmp sgt i32 %97, 0
  br i1 %98, label %99, label %106

; <label>:99:                                     ; preds = %93
  %100 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %91, i64 %94, i32 1
  %101 = load i32, i32* %100, align 4, !tbaa !89
  %102 = add nsw i32 %101, -1
  %103 = mul nsw i32 %102, %97
  %104 = sext i32 %103 to i64
  %105 = add nsw i64 %95, %104
  br label %106

; <label>:106:                                    ; preds = %99, %93
  %107 = phi i64 [ %105, %99 ], [ %95, %93 ]
  %108 = add nuw nsw i64 %94, 1
  %109 = icmp eq i64 %108, %92
  br i1 %109, label %110, label %93

; <label>:110:                                    ; preds = %106
  %111 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %72, i64 %81, i32 4, i32 1
  %112 = load i8, i8* %111, align 1, !tbaa !99
  br label %113

; <label>:113:                                    ; preds = %126, %110
  %114 = phi i64 [ 0, %110 ], [ %128, %126 ]
  %115 = phi i64 [ 0, %110 ], [ %127, %126 ]
  %116 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %91, i64 %114, i32 2
  %117 = load i32, i32* %116, align 4, !tbaa !90
  %118 = icmp slt i32 %117, 0
  br i1 %118, label %119, label %126

; <label>:119:                                    ; preds = %113
  %120 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %91, i64 %114, i32 1
  %121 = load i32, i32* %120, align 4, !tbaa !89
  %122 = add nsw i32 %121, -1
  %123 = mul nsw i32 %122, %117
  %124 = sext i32 %123 to i64
  %125 = add nsw i64 %115, %124
  br label %126

; <label>:126:                                    ; preds = %119, %113
  %127 = phi i64 [ %125, %119 ], [ %115, %113 ]
  %128 = add nuw nsw i64 %114, 1
  %129 = icmp eq i64 %128, %92
  br i1 %129, label %130, label %113

; <label>:130:                                    ; preds = %126
  %131 = add nsw i64 %107, 1
  br label %132

; <label>:132:                                    ; preds = %130, %86
  %133 = phi i8 [ %88, %86 ], [ %112, %130 ]
  %134 = phi i64 [ 1, %86 ], [ %131, %130 ]
  %135 = phi i64 [ 0, %86 ], [ %127, %130 ]
  %136 = zext i8 %133 to i64
  %137 = add nuw nsw i64 %136, 7
  %138 = lshr i64 %137, 3
  %139 = sub i64 %134, %135
  %140 = mul i64 %139, %138
  %141 = sub i64 %82, %140
  %142 = add nuw nsw i64 %81, 1
  %143 = icmp ult i64 %142, %74
  br i1 %143, label %80, label %75

; <label>:144:                                    ; preds = %76, %7
  %145 = phi i64 [ %79, %76 ], [ %8, %7 ]
  %146 = phi i64 [ %78, %76 ], [ %9, %7 ]
  %147 = icmp sgt i64 %146, %145
  %148 = icmp ne %"struct.Halide::Runtime::Internal::CacheEntry"* %12, null
  %149 = and i1 %148, %147
  br i1 %149, label %7, label %150

; <label>:150:                                    ; preds = %144, %0
  ret void
}

; Function Attrs: nounwind
define weak void @halide_memoization_cache_set_size(i64) local_unnamed_addr #0 {
  %2 = icmp eq i64 %0, 0
  %3 = select i1 %2, i64 1048576, i64 %0
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  store i64 %3, i64* @_ZN6Halide7Runtime8Internal14max_cache_sizeE, align 8, !tbaa !11
  tail call void @_ZN6Halide7Runtime8Internal11prune_cacheEv() #15
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_memoization_cache_lookup(i8*, i8*, i32, %struct.halide_buffer_t*, i32, %struct.halide_buffer_t**) local_unnamed_addr #0 {
  %7 = sext i32 %2 to i64
  %8 = tail call i32 @_ZN6Halide7Runtime8Internal8djb_hashEPKhm(i8* %1, i64 %7) #15
  %9 = and i32 %8, 255
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  %10 = zext i32 %9 to i64
  %11 = getelementptr inbounds [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*], [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*]* @_ZN6Halide7Runtime8Internal13cache_entriesE, i64 0, i64 %10
  %12 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %11, align 8, !tbaa !3
  %13 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %12, null
  br i1 %13, label %57, label %14

; <label>:14:                                     ; preds = %6
  %15 = icmp sgt i32 %4, 0
  br i1 %15, label %16, label %61

; <label>:16:                                     ; preds = %14
  %17 = sext i32 %4 to i64
  br label %18

; <label>:18:                                     ; preds = %39, %16
  %19 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %41, %39 ], [ %12, %16 ]
  %20 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 6
  %21 = load i32, i32* %20, align 8, !tbaa !160
  %22 = icmp eq i32 %21, %8
  br i1 %22, label %23, label %39

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 4
  %25 = load i64, i64* %24, align 8, !tbaa !159
  %26 = icmp eq i64 %25, %7
  br i1 %26, label %27, label %39

; <label>:27:                                     ; preds = %23
  %28 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 5
  %29 = load i8*, i8** %28, align 8, !tbaa !164
  %30 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m(i8* %29, i8* %1, i64 %7) #15
  br i1 %30, label %31, label %39

; <label>:31:                                     ; preds = %27
  %32 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 10
  %33 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %32, align 8, !tbaa !163
  %34 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t* %3, %struct.halide_dimension_t* %33) #15
  br i1 %34, label %35, label %39

; <label>:35:                                     ; preds = %31
  %36 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 8
  %37 = load i32, i32* %36, align 8, !tbaa !148
  %38 = icmp eq i32 %37, %4
  br i1 %38, label %54, label %39

; <label>:39:                                     ; preds = %56, %35, %31, %27, %23, %18
  %40 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 0
  %41 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %40, align 8, !tbaa !3
  %42 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %41, null
  br i1 %42, label %57, label %18

; <label>:43:                                     ; preds = %54, %43
  %44 = phi i64 [ 0, %54 ], [ %51, %43 ]
  %45 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %44
  %46 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %45, align 8, !tbaa !3
  %47 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %55, align 8, !tbaa !150
  %48 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %47, i64 %44, i32 6
  %49 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %48, align 8, !tbaa !86
  %50 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t* %46, %struct.halide_dimension_t* %49) #15
  %51 = add nuw nsw i64 %44, 1
  %52 = icmp slt i64 %51, %17
  %53 = and i1 %50, %52
  br i1 %53, label %43, label %56

; <label>:54:                                     ; preds = %35
  %55 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %19, i64 0, i32 11
  br label %43

; <label>:56:                                     ; preds = %43
  br i1 %50, label %82, label %39

; <label>:57:                                     ; preds = %144, %39, %6
  %58 = icmp sgt i32 %4, 0
  br i1 %58, label %59, label %251

; <label>:59:                                     ; preds = %57
  %60 = sext i32 %4 to i64
  br label %148

; <label>:61:                                     ; preds = %144, %14
  %62 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %146, %144 ], [ %12, %14 ]
  %63 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %62, i64 0, i32 6
  %64 = load i32, i32* %63, align 8, !tbaa !160
  %65 = icmp eq i32 %64, %8
  br i1 %65, label %66, label %144

; <label>:66:                                     ; preds = %61
  %67 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %62, i64 0, i32 4
  %68 = load i64, i64* %67, align 8, !tbaa !159
  %69 = icmp eq i64 %68, %7
  br i1 %69, label %70, label %144

; <label>:70:                                     ; preds = %66
  %71 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %62, i64 0, i32 5
  %72 = load i8*, i8** %71, align 8, !tbaa !164
  %73 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m(i8* %72, i8* %1, i64 %7) #15
  br i1 %73, label %74, label %144

; <label>:74:                                     ; preds = %70
  %75 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %62, i64 0, i32 10
  %76 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %75, align 8, !tbaa !163
  %77 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t* %3, %struct.halide_dimension_t* %76) #15
  br i1 %77, label %78, label %144

; <label>:78:                                     ; preds = %74
  %79 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %62, i64 0, i32 8
  %80 = load i32, i32* %79, align 8, !tbaa !148
  %81 = icmp eq i32 %80, %4
  br i1 %81, label %82, label %144

; <label>:82:                                     ; preds = %78, %56
  %83 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %19, %56 ], [ %62, %78 ]
  %84 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE, align 8, !tbaa !3
  %85 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %83, %84
  br i1 %85, label %126, label %86

; <label>:86:                                     ; preds = %82
  %87 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %83, i64 0, i32 1
  %88 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %87, align 8, !tbaa !157
  %89 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %88, null
  br i1 %89, label %90, label %91

; <label>:90:                                     ; preds = %86
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([103 x i8], [103 x i8]* @.str.5.44, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %91

; <label>:91:                                     ; preds = %90, %86
  %92 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %83, i64 0, i32 2
  %93 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %92, align 8, !tbaa !158
  %94 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %93, null
  br i1 %94, label %101, label %95

; <label>:95:                                     ; preds = %91
  %96 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %87 to i64*
  %97 = load i64, i64* %96, align 8, !tbaa !157
  %98 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %93, i64 0, i32 1
  %99 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %98 to i64*
  store i64 %97, i64* %99, align 8, !tbaa !157
  %100 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %87, align 8, !tbaa !157
  br label %109

; <label>:101:                                    ; preds = %91
  %102 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE, align 8, !tbaa !3
  %103 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %102, %83
  br i1 %103, label %105, label %104

; <label>:104:                                    ; preds = %101
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([105 x i8], [105 x i8]* @.str.6.45, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %105

; <label>:105:                                    ; preds = %104, %101
  %106 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %87 to i64*
  %107 = load i64, i64* %106, align 8, !tbaa !157
  store i64 %107, i64* bitcast (%"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE to i64*), align 8, !tbaa !3
  %108 = inttoptr i64 %107 to %"struct.Halide::Runtime::Internal::CacheEntry"*
  br label %109

; <label>:109:                                    ; preds = %105, %95
  %110 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %108, %105 ], [ %100, %95 ]
  %111 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %110, null
  br i1 %111, label %112, label %114

; <label>:112:                                    ; preds = %109
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([103 x i8], [103 x i8]* @.str.7.46, i64 0, i64 0)) #13
  tail call void @abort() #13
  %113 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %87, align 8, !tbaa !157
  br label %114

; <label>:114:                                    ; preds = %112, %109
  %115 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %110, %109 ], [ %113, %112 ]
  %116 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %92 to i64*
  %117 = load i64, i64* %116, align 8, !tbaa !158
  %118 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %115, i64 0, i32 2
  %119 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %118 to i64*
  store i64 %117, i64* %119, align 8, !tbaa !158
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %87, align 8, !tbaa !157
  %120 = load i64, i64* bitcast (%"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE to i64*), align 8, !tbaa !3
  store i64 %120, i64* %116, align 8, !tbaa !158
  %121 = icmp eq i64 %120, 0
  br i1 %121, label %125, label %122

; <label>:122:                                    ; preds = %114
  %123 = inttoptr i64 %120 to %"struct.Halide::Runtime::Internal::CacheEntry"*
  %124 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %123, i64 0, i32 1
  store %"struct.Halide::Runtime::Internal::CacheEntry"* %83, %"struct.Halide::Runtime::Internal::CacheEntry"** %124, align 8, !tbaa !157
  br label %125

; <label>:125:                                    ; preds = %122, %114
  store %"struct.Halide::Runtime::Internal::CacheEntry"* %83, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE, align 8, !tbaa !3
  br label %126

; <label>:126:                                    ; preds = %125, %82
  br i1 %15, label %127, label %130

; <label>:127:                                    ; preds = %126
  %128 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %83, i64 0, i32 11
  %129 = zext i32 %4 to i64
  br label %134

; <label>:130:                                    ; preds = %134, %126
  %131 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %83, i64 0, i32 7
  %132 = load i32, i32* %131, align 4, !tbaa !161
  %133 = add i32 %132, %4
  store i32 %133, i32* %131, align 4, !tbaa !161
  br label %251

; <label>:134:                                    ; preds = %134, %127
  %135 = phi i64 [ 0, %127 ], [ %142, %134 ]
  %136 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %135
  %137 = bitcast %struct.halide_buffer_t** %136 to i8**
  %138 = load i8*, i8** %137, align 8, !tbaa !3
  %139 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %128, align 8, !tbaa !150
  %140 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %139, i64 %135
  %141 = bitcast %struct.halide_buffer_t* %140 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %138, i8* align 8 %141, i64 56, i1 false), !tbaa.struct !97
  %142 = add nuw nsw i64 %135, 1
  %143 = icmp eq i64 %142, %129
  br i1 %143, label %130, label %134

; <label>:144:                                    ; preds = %78, %74, %70, %66, %61
  %145 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %62, i64 0, i32 0
  %146 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %145, align 8, !tbaa !3
  %147 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %146, null
  br i1 %147, label %57, label %61

; <label>:148:                                    ; preds = %237, %59
  %149 = phi i64 [ 0, %59 ], [ %249, %237 ]
  %150 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %149
  %151 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %150, align 8, !tbaa !3
  %152 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %151, i64 0, i32 5
  %153 = load i32, i32* %152, align 4, !tbaa !79
  %154 = icmp sgt i32 %153, 0
  br i1 %154, label %158, label %155

; <label>:155:                                    ; preds = %148
  %156 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %151, i64 0, i32 4, i32 1
  %157 = load i8, i8* %156, align 1, !tbaa !99
  br label %201

; <label>:158:                                    ; preds = %148
  %159 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %151, i64 0, i32 6
  %160 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %159, align 8, !tbaa !86
  %161 = sext i32 %153 to i64
  br label %162

; <label>:162:                                    ; preds = %175, %158
  %163 = phi i64 [ 0, %158 ], [ %177, %175 ]
  %164 = phi i64 [ 0, %158 ], [ %176, %175 ]
  %165 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %160, i64 %163, i32 2
  %166 = load i32, i32* %165, align 4, !tbaa !90
  %167 = icmp sgt i32 %166, 0
  br i1 %167, label %168, label %175

; <label>:168:                                    ; preds = %162
  %169 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %160, i64 %163, i32 1
  %170 = load i32, i32* %169, align 4, !tbaa !89
  %171 = add nsw i32 %170, -1
  %172 = mul nsw i32 %171, %166
  %173 = sext i32 %172 to i64
  %174 = add nsw i64 %164, %173
  br label %175

; <label>:175:                                    ; preds = %168, %162
  %176 = phi i64 [ %174, %168 ], [ %164, %162 ]
  %177 = add nuw nsw i64 %163, 1
  %178 = icmp eq i64 %177, %161
  br i1 %178, label %179, label %162

; <label>:179:                                    ; preds = %175
  %180 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %151, i64 0, i32 4, i32 1
  %181 = load i8, i8* %180, align 1, !tbaa !99
  br label %182

; <label>:182:                                    ; preds = %195, %179
  %183 = phi i64 [ 0, %179 ], [ %197, %195 ]
  %184 = phi i64 [ 0, %179 ], [ %196, %195 ]
  %185 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %160, i64 %183, i32 2
  %186 = load i32, i32* %185, align 4, !tbaa !90
  %187 = icmp slt i32 %186, 0
  br i1 %187, label %188, label %195

; <label>:188:                                    ; preds = %182
  %189 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %160, i64 %183, i32 1
  %190 = load i32, i32* %189, align 4, !tbaa !89
  %191 = add nsw i32 %190, -1
  %192 = mul nsw i32 %191, %186
  %193 = sext i32 %192 to i64
  %194 = add nsw i64 %184, %193
  br label %195

; <label>:195:                                    ; preds = %188, %182
  %196 = phi i64 [ %194, %188 ], [ %184, %182 ]
  %197 = add nuw nsw i64 %183, 1
  %198 = icmp eq i64 %197, %161
  br i1 %198, label %199, label %182

; <label>:199:                                    ; preds = %195
  %200 = add nsw i64 %176, 1
  br label %201

; <label>:201:                                    ; preds = %199, %155
  %202 = phi i8 [ %157, %155 ], [ %181, %199 ]
  %203 = phi i64 [ 1, %155 ], [ %200, %199 ]
  %204 = phi i64 [ 0, %155 ], [ %196, %199 ]
  %205 = zext i8 %202 to i64
  %206 = add nuw nsw i64 %205, 7
  %207 = lshr i64 %206, 3
  %208 = sub i64 %203, %204
  %209 = mul i64 %208, %207
  %210 = tail call i32 @_ZN6Halide7Runtime8Internal23halide_malloc_alignmentEv() #13
  %211 = add nsw i32 %210, -1
  %212 = sext i32 %211 to i64
  %213 = add nsw i64 %212, 16
  %214 = xor i64 %212, -1
  %215 = and i64 %213, %214
  %216 = add i64 %215, %209
  %217 = tail call i8* @halide_malloc(i8* %0, i64 %216) #13
  %218 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %151, i64 0, i32 2
  store i8* %217, i8** %218, align 8, !tbaa !83
  %219 = icmp eq i8* %217, null
  br i1 %219, label %220, label %237

; <label>:220:                                    ; preds = %201
  %221 = trunc i64 %149 to i32
  %222 = icmp eq i32 %221, 0
  br i1 %222, label %251, label %223

; <label>:223:                                    ; preds = %220
  %224 = and i64 %149, 4294967295
  br label %225

; <label>:225:                                    ; preds = %225, %223
  %226 = phi i64 [ %224, %223 ], [ %227, %225 ]
  %227 = add nsw i64 %226, -1
  %228 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %227
  %229 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %228, align 8, !tbaa !3
  %230 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %229, i64 0, i32 2
  %231 = load i8*, i8** %230, align 8, !tbaa !83
  %232 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %231) #15
  %233 = bitcast %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %232 to i8*
  tail call void @halide_free(i8* %0, i8* %233) #13
  %234 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %228, align 8, !tbaa !3
  %235 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %234, i64 0, i32 2
  store i8* null, i8** %235, align 8, !tbaa !83
  %236 = icmp sgt i64 %226, 1
  br i1 %236, label %225, label %251

; <label>:237:                                    ; preds = %201
  %238 = tail call i32 @_ZN6Halide7Runtime8Internal23halide_malloc_alignmentEv() #13
  %239 = add nsw i32 %238, -1
  %240 = sext i32 %239 to i64
  %241 = add nsw i64 %240, 16
  %242 = xor i64 %240, -1
  %243 = and i64 %241, %242
  %244 = load i8*, i8** %218, align 8, !tbaa !83
  %245 = getelementptr inbounds i8, i8* %244, i64 %243
  store i8* %245, i8** %218, align 8, !tbaa !83
  %246 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %245) #15
  %247 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheBlockHeader", %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %246, i64 0, i32 1
  store i32 %8, i32* %247, align 8, !tbaa !165
  %248 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheBlockHeader", %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %246, i64 0, i32 0
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %248, align 8, !tbaa !167
  %249 = add nuw nsw i64 %149, 1
  %250 = icmp slt i64 %249, %60
  br i1 %250, label %148, label %251

; <label>:251:                                    ; preds = %237, %225, %220, %130, %57
  %252 = phi i32 [ 0, %130 ], [ -1, %220 ], [ 1, %57 ], [ -1, %225 ], [ 1, %237 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  ret i32 %252
}

; Function Attrs: nounwind
define weak i32 @halide_memoization_cache_store(i8*, i8*, i32, %struct.halide_buffer_t*, i32, %struct.halide_buffer_t**) local_unnamed_addr #0 {
  %7 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, align 8, !tbaa !3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %7, i64 0, i32 2
  %9 = load i8*, i8** %8, align 8, !tbaa !83
  %10 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %9) #15
  %11 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheBlockHeader", %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %10, i64 0, i32 1
  %12 = load i32, i32* %11, align 8, !tbaa !165
  %13 = and i32 %12, 255
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*], [256 x %"struct.Halide::Runtime::Internal::CacheEntry"*]* @_ZN6Halide7Runtime8Internal13cache_entriesE, i64 0, i64 %14
  %16 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %15, align 8, !tbaa !3
  %17 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %16, null
  br i1 %17, label %71, label %18

; <label>:18:                                     ; preds = %6
  %19 = sext i32 %2 to i64
  %20 = icmp sgt i32 %4, 0
  br i1 %20, label %21, label %75

; <label>:21:                                     ; preds = %18
  %22 = sext i32 %4 to i64
  br label %23

; <label>:23:                                     ; preds = %44, %21
  %24 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %46, %44 ], [ %16, %21 ]
  %25 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 6
  %26 = load i32, i32* %25, align 8, !tbaa !160
  %27 = icmp eq i32 %26, %12
  br i1 %27, label %28, label %44

; <label>:28:                                     ; preds = %23
  %29 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 4
  %30 = load i64, i64* %29, align 8, !tbaa !159
  %31 = icmp eq i64 %30, %19
  br i1 %31, label %32, label %44

; <label>:32:                                     ; preds = %28
  %33 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 5
  %34 = load i8*, i8** %33, align 8, !tbaa !164
  %35 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m(i8* %34, i8* %1, i64 %19) #15
  br i1 %35, label %36, label %44

; <label>:36:                                     ; preds = %32
  %37 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 10
  %38 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %37, align 8, !tbaa !163
  %39 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t* %3, %struct.halide_dimension_t* %38) #15
  br i1 %39, label %40, label %44

; <label>:40:                                     ; preds = %36
  %41 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 8
  %42 = load i32, i32* %41, align 8, !tbaa !148
  %43 = icmp eq i32 %42, %4
  br i1 %43, label %67, label %44

; <label>:44:                                     ; preds = %70, %40, %36, %32, %28, %23
  %45 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 0
  %46 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %45, align 8, !tbaa !3
  %47 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %46, null
  br i1 %47, label %71, label %23

; <label>:48:                                     ; preds = %67, %48
  %49 = phi %struct.halide_buffer_t* [ %69, %67 ], [ %57, %48 ]
  %50 = phi i64 [ 0, %67 ], [ %64, %48 ]
  %51 = phi i8 [ 1, %67 ], [ %63, %48 ]
  %52 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %50
  %53 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %52, align 8, !tbaa !3
  %54 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %49, i64 %50, i32 6
  %55 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %54, align 8, !tbaa !86
  %56 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t* %53, %struct.halide_dimension_t* %55) #15
  %57 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %68, align 8, !tbaa !150
  %58 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %57, i64 %50, i32 2
  %59 = load i8*, i8** %58, align 8, !tbaa !83
  %60 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %53, i64 0, i32 2
  %61 = load i8*, i8** %60, align 8, !tbaa !83
  %62 = icmp eq i8* %59, %61
  %63 = select i1 %62, i8 0, i8 %51
  %64 = add nuw nsw i64 %50, 1
  %65 = icmp slt i64 %64, %22
  %66 = and i1 %56, %65
  br i1 %66, label %48, label %70

; <label>:67:                                     ; preds = %40
  %68 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %24, i64 0, i32 11
  %69 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %68, align 8, !tbaa !150
  br label %48

; <label>:70:                                     ; preds = %48
  br i1 %56, label %96, label %44

; <label>:71:                                     ; preds = %113, %44, %6
  %72 = icmp sgt i32 %4, 0
  br i1 %72, label %73, label %117

; <label>:73:                                     ; preds = %71
  %74 = zext i32 %4 to i64
  br label %123

; <label>:75:                                     ; preds = %113, %18
  %76 = phi %"struct.Halide::Runtime::Internal::CacheEntry"* [ %115, %113 ], [ %16, %18 ]
  %77 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %76, i64 0, i32 6
  %78 = load i32, i32* %77, align 8, !tbaa !160
  %79 = icmp eq i32 %78, %12
  br i1 %79, label %80, label %113

; <label>:80:                                     ; preds = %75
  %81 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %76, i64 0, i32 4
  %82 = load i64, i64* %81, align 8, !tbaa !159
  %83 = icmp eq i64 %82, %19
  br i1 %83, label %84, label %113

; <label>:84:                                     ; preds = %80
  %85 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %76, i64 0, i32 5
  %86 = load i8*, i8** %85, align 8, !tbaa !164
  %87 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m(i8* %86, i8* %1, i64 %19) #15
  br i1 %87, label %88, label %113

; <label>:88:                                     ; preds = %84
  %89 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %76, i64 0, i32 10
  %90 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %89, align 8, !tbaa !163
  %91 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t(%struct.halide_buffer_t* %3, %struct.halide_dimension_t* %90) #15
  br i1 %91, label %92, label %113

; <label>:92:                                     ; preds = %88
  %93 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %76, i64 0, i32 8
  %94 = load i32, i32* %93, align 8, !tbaa !148
  %95 = icmp eq i32 %94, %4
  br i1 %95, label %100, label %113

; <label>:96:                                     ; preds = %70
  %97 = and i8 %63, 1
  %98 = icmp eq i8 %97, 0
  br i1 %98, label %99, label %100

; <label>:99:                                     ; preds = %96
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([99 x i8], [99 x i8]* @.str.9.47, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %100

; <label>:100:                                    ; preds = %99, %96, %92
  br i1 %20, label %101, label %242

; <label>:101:                                    ; preds = %100
  %102 = zext i32 %4 to i64
  br label %103

; <label>:103:                                    ; preds = %103, %101
  %104 = phi i64 [ 0, %101 ], [ %111, %103 ]
  %105 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %104
  %106 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %105, align 8, !tbaa !3
  %107 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %106, i64 0, i32 2
  %108 = load i8*, i8** %107, align 8, !tbaa !83
  %109 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %108) #15
  %110 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheBlockHeader", %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %109, i64 0, i32 0
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %110, align 8, !tbaa !167
  %111 = add nuw nsw i64 %104, 1
  %112 = icmp eq i64 %111, %102
  br i1 %112, label %242, label %103

; <label>:113:                                    ; preds = %92, %88, %84, %80, %75
  %114 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %76, i64 0, i32 0
  %115 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %114, align 8, !tbaa !3
  %116 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %115, null
  br i1 %116, label %71, label %75

; <label>:117:                                    ; preds = %177, %71
  %118 = phi i64 [ 0, %71 ], [ %186, %177 ]
  %119 = load i64, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  %120 = add i64 %119, %118
  store i64 %120, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  tail call void @_ZN6Halide7Runtime8Internal11prune_cacheEv() #15
  %121 = tail call i8* @halide_malloc(i8* null, i64 80) #13
  %122 = icmp ne i8* %121, null
  br i1 %122, label %189, label %193

; <label>:123:                                    ; preds = %177, %73
  %124 = phi i64 [ 0, %73 ], [ %187, %177 ]
  %125 = phi i64 [ 0, %73 ], [ %186, %177 ]
  %126 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %124
  %127 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %126, align 8, !tbaa !3
  %128 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %127, i64 0, i32 5
  %129 = load i32, i32* %128, align 4, !tbaa !79
  %130 = icmp sgt i32 %129, 0
  br i1 %130, label %134, label %131

; <label>:131:                                    ; preds = %123
  %132 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %127, i64 0, i32 4, i32 1
  %133 = load i8, i8* %132, align 1, !tbaa !99
  br label %177

; <label>:134:                                    ; preds = %123
  %135 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %127, i64 0, i32 6
  %136 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %135, align 8, !tbaa !86
  %137 = sext i32 %129 to i64
  br label %138

; <label>:138:                                    ; preds = %151, %134
  %139 = phi i64 [ 0, %134 ], [ %153, %151 ]
  %140 = phi i64 [ 0, %134 ], [ %152, %151 ]
  %141 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %136, i64 %139, i32 2
  %142 = load i32, i32* %141, align 4, !tbaa !90
  %143 = icmp sgt i32 %142, 0
  br i1 %143, label %144, label %151

; <label>:144:                                    ; preds = %138
  %145 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %136, i64 %139, i32 1
  %146 = load i32, i32* %145, align 4, !tbaa !89
  %147 = add nsw i32 %146, -1
  %148 = mul nsw i32 %147, %142
  %149 = sext i32 %148 to i64
  %150 = add nsw i64 %140, %149
  br label %151

; <label>:151:                                    ; preds = %144, %138
  %152 = phi i64 [ %150, %144 ], [ %140, %138 ]
  %153 = add nuw nsw i64 %139, 1
  %154 = icmp eq i64 %153, %137
  br i1 %154, label %155, label %138

; <label>:155:                                    ; preds = %151
  %156 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %127, i64 0, i32 4, i32 1
  %157 = load i8, i8* %156, align 1, !tbaa !99
  br label %158

; <label>:158:                                    ; preds = %171, %155
  %159 = phi i64 [ 0, %155 ], [ %173, %171 ]
  %160 = phi i64 [ 0, %155 ], [ %172, %171 ]
  %161 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %136, i64 %159, i32 2
  %162 = load i32, i32* %161, align 4, !tbaa !90
  %163 = icmp slt i32 %162, 0
  br i1 %163, label %164, label %171

; <label>:164:                                    ; preds = %158
  %165 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %136, i64 %159, i32 1
  %166 = load i32, i32* %165, align 4, !tbaa !89
  %167 = add nsw i32 %166, -1
  %168 = mul nsw i32 %167, %162
  %169 = sext i32 %168 to i64
  %170 = add nsw i64 %160, %169
  br label %171

; <label>:171:                                    ; preds = %164, %158
  %172 = phi i64 [ %170, %164 ], [ %160, %158 ]
  %173 = add nuw nsw i64 %159, 1
  %174 = icmp eq i64 %173, %137
  br i1 %174, label %175, label %158

; <label>:175:                                    ; preds = %171
  %176 = add nsw i64 %152, 1
  br label %177

; <label>:177:                                    ; preds = %175, %131
  %178 = phi i8 [ %133, %131 ], [ %157, %175 ]
  %179 = phi i64 [ 1, %131 ], [ %176, %175 ]
  %180 = phi i64 [ 0, %131 ], [ %172, %175 ]
  %181 = zext i8 %178 to i64
  %182 = add nuw nsw i64 %181, 7
  %183 = lshr i64 %182, 3
  %184 = sub i64 %179, %180
  %185 = mul i64 %184, %183
  %186 = add i64 %185, %125
  %187 = add nuw nsw i64 %124, 1
  %188 = icmp eq i64 %187, %74
  br i1 %188, label %117, label %123

; <label>:189:                                    ; preds = %117
  %190 = bitcast i8* %121 to %"struct.Halide::Runtime::Internal::CacheEntry"*
  %191 = sext i32 %2 to i64
  %192 = tail call zeroext i1 @_ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_(%"struct.Halide::Runtime::Internal::CacheEntry"* %190, i8* %1, i64 %191, i32 %12, %struct.halide_buffer_t* %3, i32 %4, %struct.halide_buffer_t** %5) #15
  br i1 %192, label %210, label %193

; <label>:193:                                    ; preds = %189, %117
  %194 = load i64, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  %195 = sub i64 %194, %118
  store i64 %195, i64* @_ZN6Halide7Runtime8Internal18current_cache_sizeE, align 8, !tbaa !11
  br i1 %72, label %196, label %198

; <label>:196:                                    ; preds = %193
  %197 = zext i32 %4 to i64
  br label %199

; <label>:198:                                    ; preds = %199, %193
  br i1 %122, label %209, label %242

; <label>:199:                                    ; preds = %199, %196
  %200 = phi i64 [ 0, %196 ], [ %207, %199 ]
  %201 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %200
  %202 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %201, align 8, !tbaa !3
  %203 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %202, i64 0, i32 2
  %204 = load i8*, i8** %203, align 8, !tbaa !83
  %205 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %204) #15
  %206 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheBlockHeader", %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %205, i64 0, i32 0
  store %"struct.Halide::Runtime::Internal::CacheEntry"* null, %"struct.Halide::Runtime::Internal::CacheEntry"** %206, align 8, !tbaa !167
  %207 = add nuw nsw i64 %200, 1
  %208 = icmp eq i64 %207, %197
  br i1 %208, label %198, label %199

; <label>:209:                                    ; preds = %198
  tail call void @halide_free(i8* %0, i8* nonnull %121) #13
  br label %242

; <label>:210:                                    ; preds = %189
  %211 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %15 to i64*
  %212 = load i64, i64* %211, align 8, !tbaa !3
  %213 = bitcast i8* %121 to i64*
  store i64 %212, i64* %213, align 8, !tbaa !146
  %214 = load i64, i64* bitcast (%"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE to i64*), align 8, !tbaa !3
  %215 = getelementptr inbounds i8, i8* %121, i64 16
  %216 = bitcast i8* %215 to i64*
  store i64 %214, i64* %216, align 8, !tbaa !158
  %217 = icmp eq i64 %214, 0
  br i1 %217, label %222, label %218

; <label>:218:                                    ; preds = %210
  %219 = inttoptr i64 %214 to %"struct.Halide::Runtime::Internal::CacheEntry"*
  %220 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %219, i64 0, i32 1
  %221 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %220 to i8**
  store i8* %121, i8** %221, align 8, !tbaa !157
  br label %222

; <label>:222:                                    ; preds = %218, %210
  store i8* %121, i8** bitcast (%"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal18most_recently_usedE to i8**), align 8, !tbaa !3
  %223 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE, align 8, !tbaa !3
  %224 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %223, null
  br i1 %224, label %225, label %226

; <label>:225:                                    ; preds = %222
  store i8* %121, i8** bitcast (%"struct.Halide::Runtime::Internal::CacheEntry"** @_ZN6Halide7Runtime8Internal19least_recently_usedE to i8**), align 8, !tbaa !3
  br label %226

; <label>:226:                                    ; preds = %225, %222
  %227 = bitcast %"struct.Halide::Runtime::Internal::CacheEntry"** %15 to i8**
  store i8* %121, i8** %227, align 8, !tbaa !3
  %228 = getelementptr inbounds i8, i8* %121, i64 52
  %229 = bitcast i8* %228 to i32*
  store i32 %4, i32* %229, align 4, !tbaa !161
  br i1 %72, label %230, label %242

; <label>:230:                                    ; preds = %226
  %231 = zext i32 %4 to i64
  br label %232

; <label>:232:                                    ; preds = %232, %230
  %233 = phi i64 [ 0, %230 ], [ %240, %232 ]
  %234 = getelementptr inbounds %struct.halide_buffer_t*, %struct.halide_buffer_t** %5, i64 %233
  %235 = load %struct.halide_buffer_t*, %struct.halide_buffer_t** %234, align 8, !tbaa !3
  %236 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %235, i64 0, i32 2
  %237 = load i8*, i8** %236, align 8, !tbaa !83
  %238 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %237) #15
  %239 = bitcast %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %238 to i8**
  store i8* %121, i8** %239, align 8, !tbaa !167
  %240 = add nuw nsw i64 %233, 1
  %241 = icmp eq i64 %240, %231
  br i1 %241, label %242, label %232

; <label>:242:                                    ; preds = %232, %226, %209, %198, %103, %100
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  ret i32 0
}

; Function Attrs: nounwind
define weak void @halide_memoization_cache_release(i8*, i8*) local_unnamed_addr #0 {
  %3 = tail call %"struct.Halide::Runtime::Internal::CacheBlockHeader"* @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh(i8* %1) #15
  %4 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheBlockHeader", %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %3, i64 0, i32 0
  %5 = load %"struct.Halide::Runtime::Internal::CacheEntry"*, %"struct.Halide::Runtime::Internal::CacheEntry"** %4, align 8, !tbaa !167
  %6 = icmp eq %"struct.Halide::Runtime::Internal::CacheEntry"* %5, null
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %2
  %8 = bitcast %"struct.Halide::Runtime::Internal::CacheBlockHeader"* %3 to i8*
  tail call void @halide_free(i8* %0, i8* %8) #13
  br label %18

; <label>:9:                                      ; preds = %2
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  %10 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CacheEntry", %"struct.Halide::Runtime::Internal::CacheEntry"* %5, i64 0, i32 7
  %11 = load i32, i32* %10, align 4, !tbaa !161
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @.str.12.48, i64 0, i64 0)) #13
  tail call void @abort() #13
  %14 = load i32, i32* %10, align 4, !tbaa !161
  br label %15

; <label>:15:                                     ; preds = %13, %9
  %16 = phi i32 [ %11, %9 ], [ %14, %13 ]
  %17 = add i32 %16, -1
  store i32 %17, i32* %10, align 4, !tbaa !161
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal16memoization_lockE) #13
  br label %18

; <label>:18:                                     ; preds = %15, %7
  ret void
}

; Function Attrs: norecurse nounwind
define weak i8* @halide_string_to_string(i8*, i8*, i8*) local_unnamed_addr #2 {
  %4 = icmp ult i8* %0, %1
  br i1 %4, label %6, label %15

; <label>:5:                                      ; preds = %11
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %15

; <label>:6:                                      ; preds = %11, %3
  %7 = phi i8* [ %13, %11 ], [ %2, %3 ]
  %8 = phi i8* [ %12, %11 ], [ %0, %3 ]
  %9 = load i8, i8* %7, align 1, !tbaa !7
  store i8 %9, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %15, label %11

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds i8, i8* %8, i64 1
  %13 = getelementptr inbounds i8, i8* %7, i64 1
  %14 = icmp eq i8* %12, %1
  br i1 %14, label %5, label %6

; <label>:15:                                     ; preds = %6, %5, %3
  %16 = phi i8* [ %1, %5 ], [ %0, %3 ], [ %8, %6 ]
  ret i8* %16
}

; Function Attrs: nounwind
define weak i8* @halide_uint64_to_string(i8*, i8*, i64, i32) local_unnamed_addr #0 {
  %5 = alloca [32 x i8], align 1
  %6 = getelementptr inbounds [32 x i8], [32 x i8]* %5, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %6) #14
  %7 = getelementptr inbounds [32 x i8], [32 x i8]* %5, i64 0, i64 31
  store i8 0, i8* %7, align 1, !tbaa !7
  %8 = getelementptr inbounds [32 x i8], [32 x i8]* %5, i64 0, i64 30
  %9 = icmp sgt i32 %3, 0
  %10 = icmp ne i64 %2, 0
  %11 = or i1 %9, %10
  br i1 %11, label %16, label %12

; <label>:12:                                     ; preds = %16, %4
  %13 = phi i8* [ %8, %4 ], [ %25, %16 ]
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  %15 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* nonnull %14) #15
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %6) #14
  ret i8* %15

; <label>:16:                                     ; preds = %16, %4
  %17 = phi i64 [ %20, %16 ], [ %2, %4 ]
  %18 = phi i8* [ %25, %16 ], [ %8, %4 ]
  %19 = phi i32 [ %26, %16 ], [ 0, %4 ]
  %20 = udiv i64 %17, 10
  %21 = mul i64 %20, -10
  %22 = add i64 %21, %17
  %23 = trunc i64 %22 to i8
  %24 = add i8 %23, 48
  store i8 %24, i8* %18, align 1, !tbaa !7
  %25 = getelementptr inbounds i8, i8* %18, i64 -1
  %26 = add nuw nsw i32 %19, 1
  %27 = icmp slt i32 %26, %3
  %28 = icmp ugt i64 %17, 9
  %29 = or i1 %27, %28
  br i1 %29, label %16, label %12
}

; Function Attrs: nounwind
define weak i8* @halide_int64_to_string(i8*, i8*, i64, i32) local_unnamed_addr #0 {
  %5 = icmp slt i64 %2, 0
  %6 = icmp ult i8* %0, %1
  %7 = and i1 %6, %5
  br i1 %7, label %8, label %11

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %0, i64 1
  store i8 45, i8* %0, align 1, !tbaa !7
  %10 = sub nsw i64 0, %2
  br label %11

; <label>:11:                                     ; preds = %8, %4
  %12 = phi i64 [ %10, %8 ], [ %2, %4 ]
  %13 = phi i8* [ %9, %8 ], [ %0, %4 ]
  %14 = tail call i8* @halide_uint64_to_string(i8* %13, i8* %1, i64 %12, i32 %3) #15
  ret i8* %14
}

; Function Attrs: nounwind
define weak i8* @halide_double_to_string(i8*, i8*, double, i32) local_unnamed_addr #0 {
  %5 = alloca double, align 8
  %6 = alloca i64, align 8
  %7 = alloca [512 x i8], align 1
  store double %2, double* %5, align 8, !tbaa !133
  %8 = bitcast i64* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %8) #14
  store i64 0, i64* %6, align 8, !tbaa !11
  %9 = bitcast double* %5 to i8*
  %10 = call i8* @memcpy(i8* nonnull %8, i8* nonnull %9, i64 8) #13
  %11 = load i64, i64* %6, align 8, !tbaa !11
  %12 = and i64 %11, 4503599627370495
  %13 = lshr i64 %11, 52
  %14 = trunc i64 %13 to i32
  %15 = and i32 %14, 2047
  %16 = lshr i64 %11, 63
  %17 = trunc i64 %16 to i32
  %18 = icmp eq i32 %15, 2047
  br i1 %18, label %19, label %32

; <label>:19:                                     ; preds = %4
  %20 = icmp eq i64 %12, 0
  %21 = icmp ne i32 %17, 0
  br i1 %20, label %27, label %22

; <label>:22:                                     ; preds = %19
  br i1 %21, label %23, label %25

; <label>:23:                                     ; preds = %22
  %24 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.57, i64 0, i64 0)) #15
  br label %181

; <label>:25:                                     ; preds = %22
  %26 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1.58, i64 0, i64 0)) #15
  br label %181

; <label>:27:                                     ; preds = %19
  br i1 %21, label %28, label %30

; <label>:28:                                     ; preds = %27
  %29 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2.59, i64 0, i64 0)) #15
  br label %181

; <label>:30:                                     ; preds = %27
  %31 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3.60, i64 0, i64 0)) #15
  br label %181

; <label>:32:                                     ; preds = %4
  %33 = icmp eq i32 %15, 0
  %34 = icmp eq i64 %12, 0
  %35 = and i1 %34, %33
  br i1 %35, label %36, label %49

; <label>:36:                                     ; preds = %32
  %37 = icmp eq i32 %3, 0
  %38 = icmp ne i32 %17, 0
  br i1 %37, label %44, label %39

; <label>:39:                                     ; preds = %36
  br i1 %38, label %40, label %42

; <label>:40:                                     ; preds = %39
  %41 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.4.61, i64 0, i64 0)) #15
  br label %181

; <label>:42:                                     ; preds = %39
  %43 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.5.62, i64 0, i64 0)) #15
  br label %181

; <label>:44:                                     ; preds = %36
  br i1 %38, label %45, label %47

; <label>:45:                                     ; preds = %44
  %46 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.6.63, i64 0, i64 0)) #15
  br label %181

; <label>:47:                                     ; preds = %44
  %48 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.7.64, i64 0, i64 0)) #15
  br label %181

; <label>:49:                                     ; preds = %32
  %50 = icmp eq i32 %17, 0
  br i1 %50, label %55, label %51

; <label>:51:                                     ; preds = %49
  %52 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8.65, i64 0, i64 0)) #15
  %53 = load double, double* %5, align 8, !tbaa !133
  %54 = fsub double -0.000000e+00, %53
  store double %54, double* %5, align 8, !tbaa !133
  br label %55

; <label>:55:                                     ; preds = %51, %49
  %56 = phi i8* [ %52, %51 ], [ %0, %49 ]
  %57 = icmp eq i32 %3, 0
  br i1 %57, label %102, label %58

; <label>:58:                                     ; preds = %55
  %59 = load double, double* %5, align 8, !tbaa !133
  %60 = fcmp olt double %59, 1.000000e+00
  br i1 %60, label %61, label %68

; <label>:61:                                     ; preds = %61, %58
  %62 = phi i32 [ %65, %61 ], [ 0, %58 ]
  %63 = phi double [ %64, %61 ], [ %59, %58 ]
  %64 = fmul double %63, 1.000000e+01
  %65 = add nsw i32 %62, -1
  %66 = fcmp olt double %64, 1.000000e+00
  br i1 %66, label %61, label %67

; <label>:67:                                     ; preds = %61
  store double %64, double* %5, align 8, !tbaa !133
  br label %68

; <label>:68:                                     ; preds = %67, %58
  %69 = phi double [ %64, %67 ], [ %59, %58 ]
  %70 = phi i32 [ %65, %67 ], [ 0, %58 ]
  %71 = fcmp ult double %69, 1.000000e+01
  br i1 %71, label %79, label %72

; <label>:72:                                     ; preds = %72, %68
  %73 = phi i32 [ %76, %72 ], [ %70, %68 ]
  %74 = phi double [ %75, %72 ], [ %69, %68 ]
  %75 = fdiv double %74, 1.000000e+01
  %76 = add nsw i32 %73, 1
  %77 = fcmp ult double %75, 1.000000e+01
  br i1 %77, label %78, label %72

; <label>:78:                                     ; preds = %72
  store double %75, double* %5, align 8, !tbaa !133
  br label %79

; <label>:79:                                     ; preds = %78, %68
  %80 = phi double [ %75, %78 ], [ %69, %68 ]
  %81 = phi i32 [ %76, %78 ], [ %70, %68 ]
  %82 = fmul double %80, 1.000000e+06
  %83 = fadd double %82, 5.000000e-01
  %84 = fptoui double %83 to i64
  %85 = udiv i64 %84, 1000000
  %86 = mul i64 %85, -1000000
  %87 = add i64 %86, %84
  %88 = call i8* @halide_int64_to_string(i8* %56, i8* %1, i64 %85, i32 1) #15
  %89 = call i8* @halide_string_to_string(i8* %88, i8* %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9.66, i64 0, i64 0)) #15
  %90 = call i8* @halide_int64_to_string(i8* %89, i8* %1, i64 %87, i32 6) #15
  %91 = icmp sgt i32 %81, -1
  br i1 %91, label %92, label %94

; <label>:92:                                     ; preds = %79
  %93 = call i8* @halide_string_to_string(i8* %90, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.10.67, i64 0, i64 0)) #15
  br label %97

; <label>:94:                                     ; preds = %79
  %95 = call i8* @halide_string_to_string(i8* %90, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.11.68, i64 0, i64 0)) #15
  %96 = sub nsw i32 0, %81
  br label %97

; <label>:97:                                     ; preds = %94, %92
  %98 = phi i32 [ %81, %92 ], [ %96, %94 ]
  %99 = phi i8* [ %93, %92 ], [ %95, %94 ]
  %100 = sext i32 %98 to i64
  %101 = call i8* @halide_int64_to_string(i8* %99, i8* %1, i64 %100, i32 2) #15
  br label %181

; <label>:102:                                    ; preds = %55
  br i1 %33, label %103, label %105

; <label>:103:                                    ; preds = %102
  %104 = call i8* @halide_double_to_string(i8* %56, i8* %1, double 0.000000e+00, i32 0) #15
  br label %181

; <label>:105:                                    ; preds = %102
  %106 = or i64 %12, 4503599627370496
  %107 = add nsw i32 %15, -1075
  %108 = icmp ult i32 %15, 1075
  br i1 %108, label %109, label %139

; <label>:109:                                    ; preds = %105
  %110 = icmp ult i32 %15, 1023
  br i1 %110, label %117, label %111

; <label>:111:                                    ; preds = %109
  %112 = sub nsw i32 1075, %15
  %113 = zext i32 %112 to i64
  %114 = lshr i64 %106, %113
  %115 = shl i64 %114, %113
  %116 = sub i64 %106, %115
  br label %117

; <label>:117:                                    ; preds = %111, %109
  %118 = phi i64 [ %114, %111 ], [ 0, %109 ]
  %119 = phi i64 [ %116, %111 ], [ %106, %109 ]
  %120 = uitofp i64 %119 to double
  %121 = zext i32 %107 to i64
  %122 = shl i64 %121, 52
  %123 = add i64 %122, 4696837146684686336
  %124 = bitcast i64 %123 to double
  %125 = fmul double %124, %120
  %126 = fadd double %125, 5.000000e-01
  %127 = fptoui double %126 to i64
  %128 = uitofp i64 %127 to double
  %129 = fcmp oeq double %126, %128
  %130 = and i64 %127, 1
  %131 = icmp ne i64 %130, 0
  %132 = and i1 %131, %129
  %133 = sext i1 %132 to i64
  %134 = add i64 %133, %127
  %135 = icmp eq i64 %134, 1000000
  %136 = zext i1 %135 to i64
  %137 = add i64 %118, %136
  %138 = select i1 %135, i64 0, i64 %134
  br label %139

; <label>:139:                                    ; preds = %117, %105
  %140 = phi i64 [ %137, %117 ], [ %106, %105 ]
  %141 = phi i32 [ 0, %117 ], [ %107, %105 ]
  %142 = phi i64 [ %138, %117 ], [ 0, %105 ]
  %143 = getelementptr inbounds [512 x i8], [512 x i8]* %7, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 512, i8* nonnull %143) #14
  %144 = getelementptr inbounds [512 x i8], [512 x i8]* %7, i64 0, i64 512
  %145 = getelementptr inbounds [512 x i8], [512 x i8]* %7, i64 0, i64 480
  %146 = call i8* @halide_int64_to_string(i8* nonnull %145, i8* nonnull %144, i64 %140, i32 1) #15
  %147 = icmp sgt i32 %141, 0
  br i1 %147, label %148, label %152

; <label>:148:                                    ; preds = %177, %139
  %149 = phi i32 [ %179, %177 ], [ 0, %139 ]
  %150 = phi i8* [ %178, %177 ], [ %145, %139 ]
  %151 = icmp eq i8* %146, %150
  br i1 %151, label %177, label %158

; <label>:152:                                    ; preds = %177, %139
  %153 = phi i8* [ %145, %139 ], [ %178, %177 ]
  %154 = call i8* @halide_string_to_string(i8* %56, i8* %1, i8* %153) #15
  %155 = call i8* @halide_string_to_string(i8* %154, i8* %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9.66, i64 0, i64 0)) #15
  %156 = call i8* @halide_int64_to_string(i8* %155, i8* %1, i64 %142, i32 6) #15
  call void @llvm.lifetime.end.p0i8(i64 512, i8* nonnull %143) #14
  br label %181

; <label>:157:                                    ; preds = %158
  br i1 %168, label %175, label %177

; <label>:158:                                    ; preds = %158, %148
  %159 = phi i8* [ %161, %158 ], [ %146, %148 ]
  %160 = phi i32 [ %170, %158 ], [ 0, %148 ]
  %161 = getelementptr inbounds i8, i8* %159, i64 -1
  %162 = load i8, i8* %161, align 1, !tbaa !7
  %163 = add i8 %162, -48
  %164 = sext i8 %163 to i32
  %165 = shl nsw i32 %164, 1
  %166 = or i32 %165, %160
  %167 = trunc i32 %166 to i8
  %168 = icmp sgt i8 %167, 9
  %169 = add nsw i32 %166, 246
  %170 = zext i1 %168 to i32
  %171 = select i1 %168, i32 %169, i32 %166
  %172 = trunc i32 %171 to i8
  %173 = add i8 %172, 48
  store i8 %173, i8* %161, align 1, !tbaa !7
  %174 = icmp eq i8* %161, %150
  br i1 %174, label %157, label %158

; <label>:175:                                    ; preds = %157
  %176 = getelementptr inbounds i8, i8* %150, i64 -1
  store i8 49, i8* %176, align 1, !tbaa !7
  br label %177

; <label>:177:                                    ; preds = %175, %157, %148
  %178 = phi i8* [ %176, %175 ], [ %150, %157 ], [ %150, %148 ]
  %179 = add nuw nsw i32 %149, 1
  %180 = icmp eq i32 %179, %141
  br i1 %180, label %152, label %148

; <label>:181:                                    ; preds = %152, %103, %97, %47, %45, %42, %40, %30, %28, %25, %23
  %182 = phi i8* [ %24, %23 ], [ %26, %25 ], [ %29, %28 ], [ %31, %30 ], [ %41, %40 ], [ %43, %42 ], [ %46, %45 ], [ %48, %47 ], [ %104, %103 ], [ %101, %97 ], [ %156, %152 ]
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %8) #14
  ret i8* %182
}

; Function Attrs: nounwind
define weak i8* @halide_pointer_to_string(i8*, i8*, i8*) local_unnamed_addr #0 {
  %4 = alloca [20 x i8], align 1
  %5 = getelementptr inbounds [20 x i8], [20 x i8]* %4, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %5) #14
  call void @llvm.memset.p0i8.i64(i8* nonnull align 1 %5, i8 0, i64 20, i1 false)
  %6 = getelementptr inbounds [20 x i8], [20 x i8]* %4, i64 0, i64 18
  %7 = ptrtoint i8* %2 to i64
  br label %8

; <label>:8:                                      ; preds = %8, %3
  %9 = phi i32 [ 0, %3 ], [ %18, %8 ]
  %10 = phi i64 [ %7, %3 ], [ %16, %8 ]
  %11 = phi i8* [ %6, %3 ], [ %15, %8 ]
  %12 = and i64 %10, 15
  %13 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.12.71, i64 0, i64 %12
  %14 = load i8, i8* %13, align 1, !tbaa !7
  %15 = getelementptr inbounds i8, i8* %11, i64 -1
  store i8 %14, i8* %11, align 1, !tbaa !7
  %16 = lshr i64 %10, 4
  %17 = icmp ne i64 %16, 0
  %18 = add nuw nsw i32 %9, 1
  %19 = icmp ult i32 %18, 16
  %20 = and i1 %17, %19
  br i1 %20, label %8, label %21

; <label>:21:                                     ; preds = %8
  %22 = getelementptr inbounds i8, i8* %11, i64 -2
  store i8 120, i8* %15, align 1, !tbaa !7
  store i8 48, i8* %22, align 1, !tbaa !7
  %23 = call i8* @halide_string_to_string(i8* %0, i8* %1, i8* nonnull %22) #15
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %5) #14
  ret i8* %23
}

; Function Attrs: nounwind
define weak i8* @halide_type_to_string(i8*, i8*, %struct.halide_type_t*) local_unnamed_addr #0 {
  %4 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %2, i64 0, i32 0
  %5 = load i8, i8* %4, align 2, !tbaa !168
  switch i8 %5, label %9 [
    i8 0, label %10
    i8 1, label %6
    i8 2, label %7
    i8 3, label %8
  ]

; <label>:6:                                      ; preds = %3
  br label %10

; <label>:7:                                      ; preds = %3
  br label %10

; <label>:8:                                      ; preds = %3
  br label %10

; <label>:9:                                      ; preds = %3
  br label %10

; <label>:10:                                     ; preds = %9, %8, %7, %6, %3
  %11 = phi i8* [ getelementptr inbounds ([14 x i8], [14 x i8]* @.str.17.72, i64 0, i64 0), %9 ], [ getelementptr inbounds ([7 x i8], [7 x i8]* @.str.16.73, i64 0, i64 0), %8 ], [ getelementptr inbounds ([6 x i8], [6 x i8]* @.str.15.74, i64 0, i64 0), %7 ], [ getelementptr inbounds ([5 x i8], [5 x i8]* @.str.14.75, i64 0, i64 0), %6 ], [ getelementptr inbounds ([4 x i8], [4 x i8]* @.str.13.76, i64 0, i64 0), %3 ]
  %12 = tail call i8* @halide_string_to_string(i8* %0, i8* %1, i8* nonnull %11) #15
  %13 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %2, i64 0, i32 1
  %14 = load i8, i8* %13, align 1, !tbaa !99
  %15 = zext i8 %14 to i64
  %16 = tail call i8* @halide_uint64_to_string(i8* %12, i8* %1, i64 %15, i32 1) #15
  %17 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %2, i64 0, i32 2
  %18 = load i16, i16* %17, align 2, !tbaa !169
  %19 = icmp eq i16 %18, 1
  br i1 %19, label %25, label %20

; <label>:20:                                     ; preds = %10
  %21 = tail call i8* @halide_string_to_string(i8* %16, i8* %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.18.77, i64 0, i64 0)) #15
  %22 = load i16, i16* %17, align 2, !tbaa !169
  %23 = zext i16 %22 to i64
  %24 = tail call i8* @halide_uint64_to_string(i8* %21, i8* %1, i64 %23, i32 1) #15
  br label %25

; <label>:25:                                     ; preds = %20, %10
  %26 = phi i8* [ %24, %20 ], [ %16, %10 ]
  ret i8* %26
}

; Function Attrs: nounwind
define weak i8* @halide_buffer_to_string(i8*, i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %2, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.78, i64 0, i64 0)) #15
  br label %62

; <label>:7:                                      ; preds = %3
  %8 = tail call i8* @halide_string_to_string(i8* %0, i8* %1, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.20.79, i64 0, i64 0)) #15
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !84
  %11 = tail call i8* @halide_uint64_to_string(i8* %8, i8* %1, i64 %10, i32 1) #15
  %12 = tail call i8* @halide_string_to_string(i8* %11, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.80, i64 0, i64 0)) #15
  %13 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 1
  %14 = bitcast %struct.halide_device_interface_t** %13 to i8**
  %15 = load i8*, i8** %14, align 8, !tbaa !85
  %16 = tail call i8* @halide_pointer_to_string(i8* %12, i8* %1, i8* %15) #15
  %17 = tail call i8* @halide_string_to_string(i8* %16, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.80, i64 0, i64 0)) #15
  %18 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 2
  %19 = load i8*, i8** %18, align 8, !tbaa !83
  %20 = tail call i8* @halide_pointer_to_string(i8* %17, i8* %1, i8* %19) #15
  %21 = tail call i8* @halide_string_to_string(i8* %20, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.80, i64 0, i64 0)) #15
  %22 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 3
  %23 = load i64, i64* %22, align 8, !tbaa !91
  %24 = tail call i8* @halide_uint64_to_string(i8* %21, i8* %1, i64 %23, i32 1) #15
  %25 = tail call i8* @halide_string_to_string(i8* %24, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.80, i64 0, i64 0)) #15
  %26 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4
  %27 = tail call i8* @halide_type_to_string(i8* %25, i8* %1, %struct.halide_type_t* nonnull %26) #15
  %28 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 5
  %29 = load i32, i32* %28, align 4, !tbaa !79
  %30 = icmp sgt i32 %29, 0
  br i1 %30, label %31, label %33

; <label>:31:                                     ; preds = %7
  %32 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 6
  br label %36

; <label>:33:                                     ; preds = %36, %7
  %34 = phi i8* [ %27, %7 ], [ %57, %36 ]
  %35 = tail call i8* @halide_string_to_string(i8* %34, i8* %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.24.81, i64 0, i64 0)) #15
  br label %62

; <label>:36:                                     ; preds = %36, %31
  %37 = phi i64 [ 0, %31 ], [ %58, %36 ]
  %38 = phi i8* [ %27, %31 ], [ %57, %36 ]
  %39 = tail call i8* @halide_string_to_string(i8* %38, i8* %1, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.22.82, i64 0, i64 0)) #15
  %40 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %32, align 8, !tbaa !86
  %41 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %40, i64 %37, i32 0
  %42 = load i32, i32* %41, align 4, !tbaa !87
  %43 = sext i32 %42 to i64
  %44 = tail call i8* @halide_int64_to_string(i8* %39, i8* %1, i64 %43, i32 1) #15
  %45 = tail call i8* @halide_string_to_string(i8* %44, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.80, i64 0, i64 0)) #15
  %46 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %32, align 8, !tbaa !86
  %47 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %46, i64 %37, i32 1
  %48 = load i32, i32* %47, align 4, !tbaa !89
  %49 = sext i32 %48 to i64
  %50 = tail call i8* @halide_int64_to_string(i8* %45, i8* %1, i64 %49, i32 1) #15
  %51 = tail call i8* @halide_string_to_string(i8* %50, i8* %1, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.80, i64 0, i64 0)) #15
  %52 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %32, align 8, !tbaa !86
  %53 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %52, i64 %37, i32 2
  %54 = load i32, i32* %53, align 4, !tbaa !90
  %55 = sext i32 %54 to i64
  %56 = tail call i8* @halide_int64_to_string(i8* %51, i8* %1, i64 %55, i32 1) #15
  %57 = tail call i8* @halide_string_to_string(i8* %56, i8* %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.23.83, i64 0, i64 0)) #15
  %58 = add nuw nsw i64 %37, 1
  %59 = load i32, i32* %28, align 4, !tbaa !79
  %60 = sext i32 %59 to i64
  %61 = icmp slt i64 %58, %60
  br i1 %61, label %36, label %33

; <label>:62:                                     ; preds = %33, %5
  %63 = phi i8* [ %6, %5 ], [ %35, %33 ]
  ret i8* %63
}

; Function Attrs: alwaysinline norecurse nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal23halide_malloc_alignmentEv() local_unnamed_addr #4 {
  ret i32 32
}

; Function Attrs: nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %4 = load i64, i64* %3, align 8, !tbaa !91
  %5 = and i64 %4, 2
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %24, label %7

; <label>:7:                                      ; preds = %2
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = and i64 %4, 1
  %11 = icmp eq i64 %10, 0
  br i1 %11, label %12, label %24

; <label>:12:                                     ; preds = %7
  %13 = icmp eq %struct.halide_device_interface_t* %9, null
  br i1 %13, label %24, label %14

; <label>:14:                                     ; preds = %12
  %15 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %9, i64 0, i32 14
  %16 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %15, align 8, !tbaa !170
  %17 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %16, i64 0, i32 6
  %18 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %17, align 8, !tbaa !171
  %19 = tail call i32 %18(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %24

; <label>:21:                                     ; preds = %14
  %22 = load i64, i64* %3, align 8, !tbaa !91
  %23 = and i64 %22, -3
  store i64 %23, i64* %3, align 8, !tbaa !91
  tail call void @halide_msan_annotate_buffer_is_initialized(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  br label %24

; <label>:24:                                     ; preds = %21, %14, %12, %7, %2
  %25 = phi i32 [ 0, %2 ], [ 0, %21 ], [ -14, %7 ], [ -19, %12 ], [ -14, %14 ]
  ret i32 %25
}

; Function Attrs: nounwind
define weak void @halide_device_release(i8*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %1, i64 0, i32 14
  %4 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %3, align 8, !tbaa !170
  %5 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %4, i64 0, i32 5
  %6 = load i32 (i8*)*, i32 (i8*)** %5, align 8, !tbaa !173
  %7 = tail call i32 %6(i8* %0) #13
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_copy_to_host(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  %3 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.9.88, i64 0, i64 0)) #13
  br label %29

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp ne %struct.halide_device_interface_t* %8, null
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp ne i64 %11, 0
  %13 = xor i1 %12, true
  %14 = or i1 %9, %13
  br i1 %14, label %17, label %15

; <label>:15:                                     ; preds = %6
  %16 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %29

; <label>:17:                                     ; preds = %6
  %18 = xor i1 %9, true
  %19 = or i1 %12, %18
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %17
  %21 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %29

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %24 = load i64, i64* %23, align 8, !tbaa !91
  %25 = and i64 %24, 3
  %26 = icmp eq i64 %25, 3
  br i1 %26, label %27, label %32

; <label>:27:                                     ; preds = %22
  %28 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %29

; <label>:29:                                     ; preds = %27, %20, %15, %4
  %30 = phi i32 [ %5, %4 ], [ %21, %20 ], [ %16, %15 ], [ %28, %27 ]
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %34

; <label>:32:                                     ; preds = %29, %22
  %33 = tail call i32 @_ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t(i8* %0, %struct.halide_buffer_t* %1) #15
  br label %34

; <label>:34:                                     ; preds = %32, %29
  %35 = phi i32 [ %33, %32 ], [ %30, %29 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  ret i32 %35
}

; Function Attrs: nounwind
define linkonce i32 @copy_to_device_already_locked(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.10.89, i64 0, i64 0)) #13
  br label %30

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = icmp ne %struct.halide_device_interface_t* %9, null
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp ne i64 %12, 0
  %14 = xor i1 %13, true
  %15 = or i1 %10, %14
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %7
  %17 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %30

; <label>:18:                                     ; preds = %7
  %19 = xor i1 %10, true
  %20 = or i1 %13, %19
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %18
  %22 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %30

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %25 = load i64, i64* %24, align 8, !tbaa !91
  %26 = and i64 %25, 3
  %27 = icmp eq i64 %26, 3
  br i1 %27, label %28, label %33

; <label>:28:                                     ; preds = %23
  %29 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %5
  %31 = phi i32 [ %6, %5 ], [ %22, %21 ], [ %17, %16 ], [ %29, %28 ]
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %72

; <label>:33:                                     ; preds = %30, %23
  %34 = icmp eq %struct.halide_device_interface_t* %2, null
  br i1 %34, label %35, label %41

; <label>:35:                                     ; preds = %33
  %36 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %37 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %36, align 8, !tbaa !85
  %38 = icmp eq %struct.halide_device_interface_t* %37, null
  br i1 %38, label %39, label %41

; <label>:39:                                     ; preds = %35
  %40 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %72

; <label>:41:                                     ; preds = %35, %33
  %42 = phi %struct.halide_device_interface_t* [ %2, %33 ], [ %37, %35 ]
  %43 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %44 = load i64, i64* %43, align 8, !tbaa !84
  %45 = icmp eq i64 %44, 0
  br i1 %45, label %51, label %46

; <label>:46:                                     ; preds = %41
  %47 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %48 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %47, align 8, !tbaa !85
  %49 = icmp eq %struct.halide_device_interface_t* %48, %42
  br i1 %49, label %54, label %50

; <label>:50:                                     ; preds = %46
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([61 x i8], [61 x i8]* @.str.12.90, i64 0, i64 0)) #13
  br label %72

; <label>:51:                                     ; preds = %41
  %52 = tail call i32 @halide_device_malloc(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* nonnull %42) #15
  %53 = icmp eq i32 %52, 0
  br i1 %53, label %54, label %72

; <label>:54:                                     ; preds = %51, %46
  %55 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %56 = load i64, i64* %55, align 8, !tbaa !91
  %57 = and i64 %56, 1
  %58 = icmp eq i64 %57, 0
  br i1 %58, label %72, label %59

; <label>:59:                                     ; preds = %54
  %60 = and i64 %56, 2
  %61 = icmp eq i64 %60, 0
  br i1 %61, label %62, label %72

; <label>:62:                                     ; preds = %59
  %63 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %42, i64 0, i32 14
  %64 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %63, align 8, !tbaa !170
  %65 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %64, i64 0, i32 7
  %66 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %65, align 8, !tbaa !174
  %67 = tail call i32 %66(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %68 = icmp eq i32 %67, 0
  br i1 %68, label %69, label %72

; <label>:69:                                     ; preds = %62
  %70 = load i64, i64* %55, align 8, !tbaa !91
  %71 = and i64 %70, -2
  store i64 %71, i64* %55, align 8, !tbaa !91
  br label %72

; <label>:72:                                     ; preds = %69, %62, %59, %54, %51, %50, %39, %30
  %73 = phi i32 [ %40, %39 ], [ -42, %50 ], [ %31, %30 ], [ 0, %69 ], [ 0, %54 ], [ %52, %51 ], [ -15, %59 ], [ -15, %62 ]
  ret i32 %73
}

; Function Attrs: nounwind
define weak i32 @halide_device_malloc(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.18.91, i64 0, i64 0)) #13
  br label %30

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = icmp ne %struct.halide_device_interface_t* %9, null
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp ne i64 %12, 0
  %14 = xor i1 %13, true
  %15 = or i1 %10, %14
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %7
  %17 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %30

; <label>:18:                                     ; preds = %7
  %19 = xor i1 %10, true
  %20 = or i1 %13, %19
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %18
  %22 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %30

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %25 = load i64, i64* %24, align 8, !tbaa !91
  %26 = and i64 %25, 3
  %27 = icmp eq i64 %26, 3
  br i1 %27, label %28, label %36

; <label>:28:                                     ; preds = %23
  %29 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %5
  %31 = phi i32 [ %6, %5 ], [ %22, %21 ], [ %17, %16 ], [ %29, %28 ]
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %56

; <label>:33:                                     ; preds = %30
  %34 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %35 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %34, align 8, !tbaa !85
  br label %36

; <label>:36:                                     ; preds = %33, %23
  %37 = phi %struct.halide_device_interface_t* [ %35, %33 ], [ %9, %23 ]
  %38 = icmp eq %struct.halide_device_interface_t* %37, null
  %39 = icmp eq %struct.halide_device_interface_t* %37, %2
  %40 = or i1 %38, %39
  br i1 %40, label %42, label %41

; <label>:41:                                     ; preds = %36
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.str.20.92, i64 0, i64 0)) #13
  br label %56

; <label>:42:                                     ; preds = %36
  %43 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %2, i64 0, i32 14
  %44 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %45 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %44, i64 0, i32 0
  %46 = load void ()*, void ()** %45, align 8, !tbaa !175
  tail call void %46() #13
  %47 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %48 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %47, i64 0, i32 2
  %49 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %48, align 8, !tbaa !176
  %50 = tail call i32 %49(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %51 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %52 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %51, i64 0, i32 1
  %53 = load void ()*, void ()** %52, align 8, !tbaa !177
  tail call void %53() #13
  %54 = icmp eq i32 %50, 0
  %55 = select i1 %54, i32 0, i32 -16
  br label %56

; <label>:56:                                     ; preds = %42, %41, %30
  %57 = phi i32 [ %31, %30 ], [ -42, %41 ], [ %55, %42 ]
  ret i32 %57
}

; Function Attrs: nounwind
define weak i32 @halide_copy_to_device(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  %4 = tail call i32 @copy_to_device_already_locked(i8* %0, %struct.halide_buffer_t* %1, %struct.halide_device_interface_t* %2) #15
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  ret i32 %4
}

; Function Attrs: nounwind
define weak i32 @halide_device_sync(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.17.93, i64 0, i64 0)) #13
  br label %29

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp ne %struct.halide_device_interface_t* %8, null
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp ne i64 %11, 0
  %13 = xor i1 %12, true
  %14 = or i1 %9, %13
  br i1 %14, label %17, label %15

; <label>:15:                                     ; preds = %6
  %16 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %29

; <label>:17:                                     ; preds = %6
  %18 = xor i1 %9, true
  %19 = or i1 %12, %18
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %17
  %21 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %29

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %24 = load i64, i64* %23, align 8, !tbaa !91
  %25 = and i64 %24, 3
  %26 = icmp eq i64 %25, 3
  br i1 %26, label %27, label %35

; <label>:27:                                     ; preds = %22
  %28 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %29

; <label>:29:                                     ; preds = %27, %20, %15, %4
  %30 = phi i32 [ %5, %4 ], [ %21, %20 ], [ %16, %15 ], [ %28, %27 ]
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %48

; <label>:32:                                     ; preds = %29
  %33 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %34 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %33, align 8, !tbaa !85
  br label %35

; <label>:35:                                     ; preds = %32, %22
  %36 = phi %struct.halide_device_interface_t* [ %34, %32 ], [ %8, %22 ]
  %37 = icmp eq %struct.halide_device_interface_t* %36, null
  br i1 %37, label %38, label %40

; <label>:38:                                     ; preds = %35
  %39 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %48

; <label>:40:                                     ; preds = %35
  %41 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %36, i64 0, i32 14
  %42 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %41, align 8, !tbaa !170
  %43 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %42, i64 0, i32 4
  %44 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %43, align 8, !tbaa !178
  %45 = tail call i32 %44(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %46 = icmp eq i32 %45, 0
  %47 = select i1 %46, i32 0, i32 -17
  br label %48

; <label>:48:                                     ; preds = %40, %38, %29
  %49 = phi i32 [ %30, %29 ], [ %39, %38 ], [ %47, %40 ]
  ret i32 %49
}

; Function Attrs: nounwind
define weak i32 @halide_device_free(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.21.96, i64 0, i64 0)) #13
  br label %29

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp ne %struct.halide_device_interface_t* %8, null
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp ne i64 %11, 0
  %13 = xor i1 %12, true
  %14 = or i1 %9, %13
  br i1 %14, label %17, label %15

; <label>:15:                                     ; preds = %6
  %16 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %29

; <label>:17:                                     ; preds = %6
  %18 = xor i1 %9, true
  %19 = or i1 %12, %18
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %17
  %21 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %29

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %24 = load i64, i64* %23, align 8, !tbaa !91
  %25 = and i64 %24, 3
  %26 = icmp eq i64 %25, 3
  br i1 %26, label %27, label %35

; <label>:27:                                     ; preds = %22
  %28 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %29

; <label>:29:                                     ; preds = %27, %20, %15, %4
  %30 = phi i32 [ %5, %4 ], [ %21, %20 ], [ %16, %15 ], [ %28, %27 ]
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %61

; <label>:32:                                     ; preds = %29
  %33 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %34 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %33, align 8, !tbaa !85
  br label %35

; <label>:35:                                     ; preds = %32, %22
  %36 = phi %struct.halide_device_interface_t* [ %34, %32 ], [ %8, %22 ]
  %37 = icmp eq %struct.halide_device_interface_t* %36, null
  br i1 %37, label %57, label %38

; <label>:38:                                     ; preds = %35
  %39 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %36, i64 0, i32 14
  %40 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %41 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %40, i64 0, i32 0
  %42 = load void ()*, void ()** %41, align 8, !tbaa !175
  tail call void %42() #13
  %43 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %44 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %43, i64 0, i32 3
  %45 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %44, align 8, !tbaa !179
  %46 = tail call i32 %45(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %47 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %48 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %47, i64 0, i32 1
  %49 = load void ()*, void ()** %48, align 8, !tbaa !177
  tail call void %49() #13
  %50 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %51 = load i64, i64* %50, align 8, !tbaa !84
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %54, label %53

; <label>:53:                                     ; preds = %38
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.22.97, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %54

; <label>:54:                                     ; preds = %53, %38
  %55 = icmp eq i32 %46, 0
  %56 = select i1 %55, i32 0, i32 -18
  br label %61

; <label>:57:                                     ; preds = %35
  %58 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %59 = load i64, i64* %58, align 8, !tbaa !91
  %60 = and i64 %59, -3
  store i64 %60, i64* %58, align 8, !tbaa !91
  br label %61

; <label>:61:                                     ; preds = %57, %54, %29
  %62 = phi i32 [ %30, %29 ], [ 0, %57 ], [ %56, %54 ]
  ret i32 %62
}

; Function Attrs: nounwind
define weak void @halide_device_free_as_destructor(i8*, i8*) local_unnamed_addr #0 {
  %3 = bitcast i8* %1 to %struct.halide_buffer_t*
  %4 = tail call i32 @halide_device_free(i8* %0, %struct.halide_buffer_t* %3) #15
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_device_and_host_malloc(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.23.98, i64 0, i64 0)) #13
  br label %30

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = icmp ne %struct.halide_device_interface_t* %9, null
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp ne i64 %12, 0
  %14 = xor i1 %13, true
  %15 = or i1 %10, %14
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %7
  %17 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %30

; <label>:18:                                     ; preds = %7
  %19 = xor i1 %10, true
  %20 = or i1 %13, %19
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %18
  %22 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %30

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %25 = load i64, i64* %24, align 8, !tbaa !91
  %26 = and i64 %25, 3
  %27 = icmp eq i64 %26, 3
  br i1 %27, label %28, label %36

; <label>:28:                                     ; preds = %23
  %29 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %5
  %31 = phi i32 [ %6, %5 ], [ %22, %21 ], [ %17, %16 ], [ %29, %28 ]
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %56

; <label>:33:                                     ; preds = %30
  %34 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %35 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %34, align 8, !tbaa !85
  br label %36

; <label>:36:                                     ; preds = %33, %23
  %37 = phi %struct.halide_device_interface_t* [ %35, %33 ], [ %9, %23 ]
  %38 = icmp eq %struct.halide_device_interface_t* %37, null
  %39 = icmp eq %struct.halide_device_interface_t* %37, %2
  %40 = or i1 %38, %39
  br i1 %40, label %42, label %41

; <label>:41:                                     ; preds = %36
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @.str.25.99, i64 0, i64 0)) #13
  br label %56

; <label>:42:                                     ; preds = %36
  %43 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %2, i64 0, i32 14
  %44 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %45 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %44, i64 0, i32 0
  %46 = load void ()*, void ()** %45, align 8, !tbaa !175
  tail call void %46() #13
  %47 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %48 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %47, i64 0, i32 8
  %49 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %48, align 8, !tbaa !180
  %50 = tail call i32 %49(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %51 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %52 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %51, i64 0, i32 1
  %53 = load void ()*, void ()** %52, align 8, !tbaa !177
  tail call void %53() #13
  %54 = icmp eq i32 %50, 0
  br i1 %54, label %56, label %55

; <label>:55:                                     ; preds = %42
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.26.100, i64 0, i64 0)) #13
  br label %56

; <label>:56:                                     ; preds = %55, %42, %41, %30
  %57 = phi i32 [ %31, %30 ], [ -42, %41 ], [ -16, %55 ], [ 0, %42 ]
  ret i32 %57
}

; Function Attrs: nounwind
define weak i32 @halide_device_and_host_free(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.27.101, i64 0, i64 0)) #13
  br label %29

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp ne %struct.halide_device_interface_t* %8, null
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp ne i64 %11, 0
  %13 = xor i1 %12, true
  %14 = or i1 %9, %13
  br i1 %14, label %17, label %15

; <label>:15:                                     ; preds = %6
  %16 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %29

; <label>:17:                                     ; preds = %6
  %18 = xor i1 %9, true
  %19 = or i1 %12, %18
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %17
  %21 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %29

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %24 = load i64, i64* %23, align 8, !tbaa !91
  %25 = and i64 %24, 3
  %26 = icmp eq i64 %25, 3
  br i1 %26, label %27, label %35

; <label>:27:                                     ; preds = %22
  %28 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %29

; <label>:29:                                     ; preds = %27, %20, %15, %4
  %30 = phi i32 [ %5, %4 ], [ %21, %20 ], [ %16, %15 ], [ %28, %27 ]
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %66

; <label>:32:                                     ; preds = %29
  %33 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %34 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %33, align 8, !tbaa !85
  br label %35

; <label>:35:                                     ; preds = %32, %22
  %36 = phi %struct.halide_device_interface_t* [ %34, %32 ], [ %8, %22 ]
  %37 = icmp eq %struct.halide_device_interface_t* %36, null
  br i1 %37, label %57, label %38

; <label>:38:                                     ; preds = %35
  %39 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %36, i64 0, i32 14
  %40 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %41 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %40, i64 0, i32 0
  %42 = load void ()*, void ()** %41, align 8, !tbaa !175
  tail call void %42() #13
  %43 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %44 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %43, i64 0, i32 9
  %45 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %44, align 8, !tbaa !181
  %46 = tail call i32 %45(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %47 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %48 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %47, i64 0, i32 1
  %49 = load void ()*, void ()** %48, align 8, !tbaa !177
  tail call void %49() #13
  %50 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %51 = load i64, i64* %50, align 8, !tbaa !84
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %54, label %53

; <label>:53:                                     ; preds = %38
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.28.102, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %54

; <label>:54:                                     ; preds = %53, %38
  %55 = icmp eq i32 %46, 0
  %56 = select i1 %55, i32 0, i32 -18
  br label %66

; <label>:57:                                     ; preds = %35
  %58 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 2
  %59 = load i8*, i8** %58, align 8, !tbaa !83
  %60 = icmp eq i8* %59, null
  br i1 %60, label %62, label %61

; <label>:61:                                     ; preds = %57
  tail call void @halide_free(i8* %0, i8* nonnull %59) #13
  store i8* null, i8** %58, align 8, !tbaa !83
  br label %62

; <label>:62:                                     ; preds = %61, %57
  %63 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %64 = load i64, i64* %63, align 8, !tbaa !91
  %65 = and i64 %64, -3
  store i64 %65, i64* %63, align 8, !tbaa !91
  br label %66

; <label>:66:                                     ; preds = %62, %54, %29
  %67 = phi i32 [ %30, %29 ], [ 0, %62 ], [ %56, %54 ]
  ret i32 %67
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_and_host_malloc(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.29.103, i64 0, i64 0)) #13
  br label %30

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = icmp ne %struct.halide_device_interface_t* %9, null
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp ne i64 %12, 0
  %14 = xor i1 %13, true
  %15 = or i1 %10, %14
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %7
  %17 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %30

; <label>:18:                                     ; preds = %7
  %19 = xor i1 %10, true
  %20 = or i1 %13, %19
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %18
  %22 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %30

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %25 = load i64, i64* %24, align 8, !tbaa !91
  %26 = and i64 %25, 3
  %27 = icmp eq i64 %26, 3
  br i1 %27, label %28, label %33

; <label>:28:                                     ; preds = %23
  %29 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %5
  %31 = phi i32 [ %6, %5 ], [ %22, %21 ], [ %17, %16 ], [ %29, %28 ]
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %100

; <label>:33:                                     ; preds = %30, %23
  %34 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 5
  %35 = load i32, i32* %34, align 4, !tbaa !79
  %36 = icmp sgt i32 %35, 0
  br i1 %36, label %40, label %37

; <label>:37:                                     ; preds = %33
  %38 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 4, i32 1
  %39 = load i8, i8* %38, align 1, !tbaa !99
  br label %83

; <label>:40:                                     ; preds = %33
  %41 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 6
  %42 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %41, align 8, !tbaa !86
  %43 = sext i32 %35 to i64
  br label %44

; <label>:44:                                     ; preds = %57, %40
  %45 = phi i64 [ 0, %40 ], [ %59, %57 ]
  %46 = phi i64 [ 0, %40 ], [ %58, %57 ]
  %47 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %42, i64 %45, i32 2
  %48 = load i32, i32* %47, align 4, !tbaa !90
  %49 = icmp sgt i32 %48, 0
  br i1 %49, label %50, label %57

; <label>:50:                                     ; preds = %44
  %51 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %42, i64 %45, i32 1
  %52 = load i32, i32* %51, align 4, !tbaa !89
  %53 = add nsw i32 %52, -1
  %54 = mul nsw i32 %53, %48
  %55 = sext i32 %54 to i64
  %56 = add nsw i64 %46, %55
  br label %57

; <label>:57:                                     ; preds = %50, %44
  %58 = phi i64 [ %56, %50 ], [ %46, %44 ]
  %59 = add nuw nsw i64 %45, 1
  %60 = icmp eq i64 %59, %43
  br i1 %60, label %61, label %44

; <label>:61:                                     ; preds = %57
  %62 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 4, i32 1
  %63 = load i8, i8* %62, align 1, !tbaa !99
  br label %64

; <label>:64:                                     ; preds = %77, %61
  %65 = phi i64 [ 0, %61 ], [ %79, %77 ]
  %66 = phi i64 [ 0, %61 ], [ %78, %77 ]
  %67 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %42, i64 %65, i32 2
  %68 = load i32, i32* %67, align 4, !tbaa !90
  %69 = icmp slt i32 %68, 0
  br i1 %69, label %70, label %77

; <label>:70:                                     ; preds = %64
  %71 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %42, i64 %65, i32 1
  %72 = load i32, i32* %71, align 4, !tbaa !89
  %73 = add nsw i32 %72, -1
  %74 = mul nsw i32 %73, %68
  %75 = sext i32 %74 to i64
  %76 = add nsw i64 %66, %75
  br label %77

; <label>:77:                                     ; preds = %70, %64
  %78 = phi i64 [ %76, %70 ], [ %66, %64 ]
  %79 = add nuw nsw i64 %65, 1
  %80 = icmp eq i64 %79, %43
  br i1 %80, label %81, label %64

; <label>:81:                                     ; preds = %77
  %82 = add nsw i64 %58, 1
  br label %83

; <label>:83:                                     ; preds = %81, %37
  %84 = phi i8 [ %39, %37 ], [ %63, %81 ]
  %85 = phi i64 [ 1, %37 ], [ %82, %81 ]
  %86 = phi i64 [ 0, %37 ], [ %78, %81 ]
  %87 = zext i8 %84 to i64
  %88 = add nuw nsw i64 %87, 7
  %89 = lshr i64 %88, 3
  %90 = sub i64 %85, %86
  %91 = mul i64 %90, %89
  %92 = tail call i8* @halide_malloc(i8* %0, i64 %91) #13
  %93 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 2
  store i8* %92, i8** %93, align 8, !tbaa !83
  %94 = icmp eq i8* %92, null
  br i1 %94, label %100, label %95

; <label>:95:                                     ; preds = %83
  %96 = tail call i32 @halide_device_malloc(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* %2) #15
  %97 = icmp eq i32 %96, 0
  br i1 %97, label %100, label %98

; <label>:98:                                     ; preds = %95
  %99 = load i8*, i8** %93, align 8, !tbaa !83
  tail call void @halide_free(i8* %0, i8* %99) #13
  store i8* null, i8** %93, align 8, !tbaa !83
  br label %100

; <label>:100:                                    ; preds = %98, %95, %83, %30
  %101 = phi i32 [ %31, %30 ], [ -1, %83 ], [ 0, %95 ], [ %96, %98 ]
  ret i32 %101
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_and_host_free(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.30.104, i64 0, i64 0)) #13
  br label %30

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = icmp ne %struct.halide_device_interface_t* %9, null
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp ne i64 %12, 0
  %14 = xor i1 %13, true
  %15 = or i1 %10, %14
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %7
  %17 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %30

; <label>:18:                                     ; preds = %7
  %19 = xor i1 %10, true
  %20 = or i1 %13, %19
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %18
  %22 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %30

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %25 = load i64, i64* %24, align 8, !tbaa !91
  %26 = and i64 %25, 3
  %27 = icmp eq i64 %26, 3
  br i1 %27, label %28, label %33

; <label>:28:                                     ; preds = %23
  %29 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %5
  %31 = phi i32 [ %6, %5 ], [ %22, %21 ], [ %17, %16 ], [ %29, %28 ]
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %43

; <label>:33:                                     ; preds = %30, %23
  %34 = tail call i32 @halide_device_free(i8* %0, %struct.halide_buffer_t* %1) #15
  %35 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 2
  %36 = load i8*, i8** %35, align 8, !tbaa !83
  %37 = icmp eq i8* %36, null
  br i1 %37, label %39, label %38

; <label>:38:                                     ; preds = %33
  tail call void @halide_free(i8* %0, i8* nonnull %36) #13
  store i8* null, i8** %35, align 8, !tbaa !83
  br label %39

; <label>:39:                                     ; preds = %38, %33
  %40 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %41 = load i64, i64* %40, align 8, !tbaa !91
  %42 = and i64 %41, -4
  store i64 %42, i64* %40, align 8, !tbaa !91
  br label %43

; <label>:43:                                     ; preds = %39, %30
  %44 = phi i32 [ %34, %39 ], [ %31, %30 ]
  ret i32 %44
}

; Function Attrs: nounwind
define weak i32 @halide_device_wrap_native(i8*, %struct.halide_buffer_t*, i64, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %5 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %4
  %7 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.31.105, i64 0, i64 0)) #13
  br label %31

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %10 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %9, align 8, !tbaa !85
  %11 = icmp ne %struct.halide_device_interface_t* %10, null
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %13 = load i64, i64* %12, align 8, !tbaa !84
  %14 = icmp ne i64 %13, 0
  %15 = xor i1 %14, true
  %16 = or i1 %11, %15
  br i1 %16, label %19, label %17

; <label>:17:                                     ; preds = %8
  %18 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %31

; <label>:19:                                     ; preds = %8
  %20 = xor i1 %11, true
  %21 = or i1 %14, %20
  br i1 %21, label %24, label %22

; <label>:22:                                     ; preds = %19
  %23 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %31

; <label>:24:                                     ; preds = %19
  %25 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %26 = load i64, i64* %25, align 8, !tbaa !91
  %27 = and i64 %26, 3
  %28 = icmp eq i64 %27, 3
  br i1 %28, label %29, label %37

; <label>:29:                                     ; preds = %24
  %30 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %31

; <label>:31:                                     ; preds = %29, %22, %17, %6
  %32 = phi i32 [ %7, %6 ], [ %23, %22 ], [ %18, %17 ], [ %30, %29 ]
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %58

; <label>:34:                                     ; preds = %31
  %35 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %36 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %35, align 8, !tbaa !85
  br label %37

; <label>:37:                                     ; preds = %34, %24
  %38 = phi %struct.halide_device_interface_t** [ %35, %34 ], [ %9, %24 ]
  %39 = phi %struct.halide_device_interface_t* [ %36, %34 ], [ %10, %24 ]
  %40 = icmp eq %struct.halide_device_interface_t* %39, null
  %41 = icmp eq %struct.halide_device_interface_t* %39, %3
  %42 = or i1 %40, %41
  br i1 %42, label %44, label %43

; <label>:43:                                     ; preds = %37
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.32.106, i64 0, i64 0)) #13
  br label %58

; <label>:44:                                     ; preds = %37
  %45 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %3, i64 0, i32 14
  %46 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %45, align 8, !tbaa !170
  %47 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %46, i64 0, i32 0
  %48 = load void ()*, void ()** %47, align 8, !tbaa !175
  tail call void %48() #13
  store %struct.halide_device_interface_t* %3, %struct.halide_device_interface_t** %38, align 8, !tbaa !85
  %49 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %45, align 8, !tbaa !170
  %50 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %49, i64 0, i32 14
  %51 = load i32 (i8*, %struct.halide_buffer_t*, i64)*, i32 (i8*, %struct.halide_buffer_t*, i64)** %50, align 8, !tbaa !182
  %52 = tail call i32 %51(i8* %0, %struct.halide_buffer_t* nonnull %1, i64 %2) #13
  %53 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %45, align 8, !tbaa !170
  %54 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %53, i64 0, i32 1
  %55 = load void ()*, void ()** %54, align 8, !tbaa !177
  tail call void %55() #13
  %56 = icmp eq i32 %52, 0
  %57 = select i1 %56, i32 0, i32 -16
  br label %58

; <label>:58:                                     ; preds = %44, %43, %31
  %59 = phi i32 [ %32, %31 ], [ -42, %43 ], [ %57, %44 ]
  ret i32 %59
}

; Function Attrs: nounwind
define weak i32 @halide_device_detach_native(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.33.107, i64 0, i64 0)) #13
  br label %29

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp ne %struct.halide_device_interface_t* %8, null
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp ne i64 %11, 0
  %13 = xor i1 %12, true
  %14 = or i1 %9, %13
  br i1 %14, label %17, label %15

; <label>:15:                                     ; preds = %6
  %16 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %29

; <label>:17:                                     ; preds = %6
  %18 = xor i1 %9, true
  %19 = or i1 %12, %18
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %17
  %21 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %29

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %24 = load i64, i64* %23, align 8, !tbaa !91
  %25 = and i64 %24, 3
  %26 = icmp eq i64 %25, 3
  br i1 %26, label %27, label %35

; <label>:27:                                     ; preds = %22
  %28 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %29

; <label>:29:                                     ; preds = %27, %20, %15, %4
  %30 = phi i32 [ %5, %4 ], [ %21, %20 ], [ %16, %15 ], [ %28, %27 ]
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %57

; <label>:32:                                     ; preds = %29
  %33 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %34 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %33, align 8, !tbaa !85
  br label %35

; <label>:35:                                     ; preds = %32, %22
  %36 = phi %struct.halide_device_interface_t* [ %34, %32 ], [ %8, %22 ]
  %37 = icmp eq %struct.halide_device_interface_t* %36, null
  br i1 %37, label %57, label %38

; <label>:38:                                     ; preds = %35
  %39 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %36, i64 0, i32 14
  %40 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %41 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %40, i64 0, i32 0
  %42 = load void ()*, void ()** %41, align 8, !tbaa !175
  tail call void %42() #13
  %43 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %44 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %43, i64 0, i32 15
  %45 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %44, align 8, !tbaa !183
  %46 = tail call i32 %45(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  %47 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %39, align 8, !tbaa !170
  %48 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %47, i64 0, i32 1
  %49 = load void ()*, void ()** %48, align 8, !tbaa !177
  tail call void %49() #13
  %50 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %51 = load i64, i64* %50, align 8, !tbaa !84
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %54, label %53

; <label>:53:                                     ; preds = %38
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([104 x i8], [104 x i8]* @.str.34.108, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %54

; <label>:54:                                     ; preds = %53, %38
  %55 = icmp eq i32 %46, 0
  %56 = select i1 %55, i32 0, i32 -33
  ret i32 %56

; <label>:57:                                     ; preds = %35, %29
  %58 = phi i32 [ 0, %35 ], [ %30, %29 ]
  ret i32 %58
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_wrap_native(i8*, %struct.halide_buffer_t*, i64) local_unnamed_addr #0 {
  %4 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.35.109, i64 0, i64 0)) #13
  br label %30

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %9 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %8, align 8, !tbaa !85
  %10 = icmp ne %struct.halide_device_interface_t* %9, null
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !84
  %13 = icmp ne i64 %12, 0
  %14 = xor i1 %13, true
  %15 = or i1 %10, %14
  br i1 %15, label %18, label %16

; <label>:16:                                     ; preds = %7
  %17 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %30

; <label>:18:                                     ; preds = %7
  %19 = xor i1 %10, true
  %20 = or i1 %13, %19
  br i1 %20, label %23, label %21

; <label>:21:                                     ; preds = %18
  %22 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %30

; <label>:23:                                     ; preds = %18
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %25 = load i64, i64* %24, align 8, !tbaa !91
  %26 = and i64 %25, 3
  %27 = icmp eq i64 %26, 3
  br i1 %27, label %28, label %37

; <label>:28:                                     ; preds = %23
  %29 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %5
  %31 = phi i32 [ %6, %5 ], [ %22, %21 ], [ %17, %16 ], [ %29, %28 ]
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %44

; <label>:33:                                     ; preds = %30
  %34 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %35 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %34, align 8, !tbaa !85
  %36 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  br label %37

; <label>:37:                                     ; preds = %33, %23
  %38 = phi i64* [ %36, %33 ], [ %11, %23 ]
  %39 = phi %struct.halide_device_interface_t* [ %35, %33 ], [ %9, %23 ]
  %40 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %39, i64 0, i32 14
  %41 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %40, align 8, !tbaa !170
  %42 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %41, i64 0, i32 0
  %43 = load void ()*, void ()** %42, align 8, !tbaa !175
  tail call void %43() #13
  store i64 %2, i64* %38, align 8, !tbaa !84
  br label %44

; <label>:44:                                     ; preds = %37, %30
  %45 = phi i32 [ 0, %37 ], [ %31, %30 ]
  ret i32 %45
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_detach_native(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = icmp eq %struct.halide_buffer_t* %1, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = tail call i32 @halide_error_buffer_is_null(i8* %0, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.36, i64 0, i64 0)) #13
  br label %29

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp ne %struct.halide_device_interface_t* %8, null
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp ne i64 %11, 0
  %13 = xor i1 %12, true
  %14 = or i1 %9, %13
  br i1 %14, label %17, label %15

; <label>:15:                                     ; preds = %6
  %16 = tail call i32 @halide_error_no_device_interface(i8* %0) #13
  br label %29

; <label>:17:                                     ; preds = %6
  %18 = xor i1 %9, true
  %19 = or i1 %12, %18
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %17
  %21 = tail call i32 @halide_error_device_interface_no_device(i8* %0) #13
  br label %29

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %24 = load i64, i64* %23, align 8, !tbaa !91
  %25 = and i64 %24, 3
  %26 = icmp eq i64 %25, 3
  br i1 %26, label %27, label %35

; <label>:27:                                     ; preds = %22
  %28 = tail call i32 @halide_error_host_and_device_dirty(i8* %0) #13
  br label %29

; <label>:29:                                     ; preds = %27, %20, %15, %4
  %30 = phi i32 [ %5, %4 ], [ %21, %20 ], [ %16, %15 ], [ %28, %27 ]
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %46

; <label>:32:                                     ; preds = %29
  %33 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %34 = load i64, i64* %33, align 8, !tbaa !84
  br label %35

; <label>:35:                                     ; preds = %32, %22
  %36 = phi i64* [ %33, %32 ], [ %10, %22 ]
  %37 = phi i64 [ %34, %32 ], [ %11, %22 ]
  %38 = icmp eq i64 %37, 0
  br i1 %38, label %46, label %39

; <label>:39:                                     ; preds = %35
  %40 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %41 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %40, align 8, !tbaa !85
  %42 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %41, i64 0, i32 14
  %43 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %42, align 8, !tbaa !170
  %44 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %43, i64 0, i32 1
  %45 = load void ()*, void ()** %44, align 8, !tbaa !177
  tail call void %45() #13
  store i64 0, i64* %36, align 8, !tbaa !84
  store %struct.halide_device_interface_t* null, %struct.halide_device_interface_t** %40, align 8, !tbaa !85
  br label %46

; <label>:46:                                     ; preds = %39, %35, %29
  %47 = phi i32 [ 0, %39 ], [ %30, %29 ], [ 0, %35 ]
  ret i32 %47
}

; Function Attrs: nounwind
define weak void @halide_device_and_host_free_as_destructor(i8*, i8*) local_unnamed_addr #0 {
  %3 = bitcast i8* %1 to %struct.halide_buffer_t*
  %4 = tail call i32 @halide_device_and_host_free(i8* %0, %struct.halide_buffer_t* %3) #15
  ret void
}

; Function Attrs: norecurse nounwind
define weak void @halide_device_host_nop_free(i8*, i8*) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: nounwind
define weak i32 @halide_default_buffer_copy(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %5 = alloca %"struct.Halide::Runtime::Internal::device_copy", align 8
  %6 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !84
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %9, label %11

; <label>:9:                                      ; preds = %4
  %10 = icmp eq %struct.halide_device_interface_t* %2, null
  br label %44

; <label>:11:                                     ; preds = %4
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 3
  %13 = load i64, i64* %12, align 8, !tbaa !91
  %14 = and i64 %13, 2
  %15 = icmp eq i64 %14, 0
  br i1 %15, label %16, label %20

; <label>:16:                                     ; preds = %11
  %17 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 2
  %18 = load i8*, i8** %17, align 8, !tbaa !83
  %19 = icmp eq i8* %18, null
  br label %20

; <label>:20:                                     ; preds = %16, %11
  %21 = phi i1 [ true, %11 ], [ %19, %16 ]
  %22 = icmp ne %struct.halide_device_interface_t* %2, null
  %23 = xor i1 %21, true
  %24 = xor i1 %22, true
  %25 = or i1 %24, %23
  br i1 %25, label %37, label %26

; <label>:26:                                     ; preds = %20
  %27 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %28 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %27, align 8, !tbaa !85
  %29 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %28, i64 0, i32 14
  %30 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %29, align 8, !tbaa !170
  %31 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %30, i64 0, i32 10
  %32 = load i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)** %31, align 8, !tbaa !184
  %33 = tail call i32 %32(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* null, %struct.halide_buffer_t* %3) #13
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %35, label %58

; <label>:35:                                     ; preds = %26
  %36 = tail call i32 @copy_to_device_already_locked(i8* %0, %struct.halide_buffer_t* %3, %struct.halide_device_interface_t* nonnull %2) #15
  br label %58

; <label>:37:                                     ; preds = %20
  %38 = or i1 %22, %23
  br i1 %38, label %44, label %39

; <label>:39:                                     ; preds = %37
  %40 = tail call i32 @_ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t(i8* %0, %struct.halide_buffer_t* nonnull %1) #15
  %41 = icmp eq i32 %40, 0
  br i1 %41, label %42, label %58

; <label>:42:                                     ; preds = %39
  %43 = tail call i32 @halide_default_buffer_copy(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* null, %struct.halide_buffer_t* %3) #15
  br label %58

; <label>:44:                                     ; preds = %37, %9
  %45 = phi i1 [ false, %9 ], [ %21, %37 ]
  %46 = phi i1 [ %10, %9 ], [ %24, %37 ]
  %47 = or i1 %45, %46
  br i1 %47, label %53, label %48

; <label>:48:                                     ; preds = %44
  %49 = tail call i32 @halide_default_buffer_copy(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* null, %struct.halide_buffer_t* %3) #15
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %58

; <label>:51:                                     ; preds = %48
  %52 = tail call i32 @copy_to_device_already_locked(i8* %0, %struct.halide_buffer_t* %3, %struct.halide_device_interface_t* nonnull %2) #15
  br label %58

; <label>:53:                                     ; preds = %44
  %54 = bitcast %"struct.Halide::Runtime::Internal::device_copy"* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 416, i8* nonnull %54) #14
  call void @_ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b(%"struct.Halide::Runtime::Internal::device_copy"* nonnull sret %5, %struct.halide_buffer_t* nonnull %1, i1 zeroext true, %struct.halide_buffer_t* %3, i1 zeroext true) #15
  call void @_ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv(%"struct.Halide::Runtime::Internal::device_copy"* nonnull dereferenceable(416) %5, i8* %0) #15
  %55 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 3
  %56 = load i64, i64* %55, align 8, !tbaa !91
  %57 = or i64 %56, 1
  store i64 %57, i64* %55, align 8, !tbaa !91
  call void @llvm.lifetime.end.p0i8(i64 416, i8* nonnull %54) #14
  br label %58

; <label>:58:                                     ; preds = %53, %51, %48, %42, %39, %35, %26
  %59 = phi i32 [ %33, %26 ], [ %36, %35 ], [ %40, %39 ], [ %43, %42 ], [ %49, %48 ], [ %52, %51 ], [ 0, %53 ]
  ret i32 %59
}

; Function Attrs: nounwind
define weak i32 @halide_buffer_copy(i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  %5 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %6 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %5, align 8, !tbaa !85
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = icmp eq %struct.halide_device_interface_t* %8, null
  %10 = icmp eq %struct.halide_device_interface_t* %8, %2
  %11 = or i1 %9, %10
  br i1 %11, label %13, label %12

; <label>:12:                                     ; preds = %4
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.48, i64 0, i64 0)) #13
  br label %80

; <label>:13:                                     ; preds = %4
  %14 = icmp ne %struct.halide_device_interface_t* %2, null
  br i1 %14, label %15, label %27

; <label>:15:                                     ; preds = %13
  %16 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 0
  %17 = load i64, i64* %16, align 8, !tbaa !84
  %18 = icmp eq i64 %17, 0
  br i1 %18, label %19, label %22

; <label>:19:                                     ; preds = %15
  %20 = tail call i32 @halide_device_malloc(i8* %0, %struct.halide_buffer_t* nonnull %3, %struct.halide_device_interface_t* nonnull %2) #15
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %80

; <label>:22:                                     ; preds = %19, %15
  %23 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %2, i64 0, i32 14
  %24 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %23, align 8, !tbaa !170
  %25 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %24, i64 0, i32 0
  %26 = load void ()*, void ()** %25, align 8, !tbaa !175
  tail call void %26() #13
  br label %27

; <label>:27:                                     ; preds = %22, %13
  %28 = icmp ne %struct.halide_device_interface_t* %6, null
  br i1 %28, label %29, label %34

; <label>:29:                                     ; preds = %27
  %30 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %6, i64 0, i32 14
  %31 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %30, align 8, !tbaa !170
  %32 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %31, i64 0, i32 0
  %33 = load void ()*, void ()** %32, align 8, !tbaa !175
  tail call void %33() #13
  br label %34

; <label>:34:                                     ; preds = %29, %27
  br i1 %14, label %35, label %41

; <label>:35:                                     ; preds = %34
  %36 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %2, i64 0, i32 14
  %37 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %36, align 8, !tbaa !170
  %38 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %37, i64 0, i32 10
  %39 = load i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)** %38, align 8, !tbaa !184
  %40 = tail call i32 %39(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* nonnull %2, %struct.halide_buffer_t* nonnull %3) #13
  br label %50

; <label>:41:                                     ; preds = %34
  br i1 %28, label %42, label %48

; <label>:42:                                     ; preds = %41
  %43 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %6, i64 0, i32 14
  %44 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %43, align 8, !tbaa !170
  %45 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %44, i64 0, i32 10
  %46 = load i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_device_interface_t*, %struct.halide_buffer_t*)** %45, align 8, !tbaa !184
  %47 = tail call i32 %46(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* null, %struct.halide_buffer_t* nonnull %3) #13
  br label %50

; <label>:48:                                     ; preds = %41
  %49 = tail call i32 @halide_default_buffer_copy(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_device_interface_t* null, %struct.halide_buffer_t* nonnull %3) #15
  br label %50

; <label>:50:                                     ; preds = %48, %42, %35
  %51 = phi i32 [ %40, %35 ], [ %47, %42 ], [ %49, %48 ]
  %52 = icmp eq %struct.halide_buffer_t* %3, %1
  br i1 %52, label %64, label %53

; <label>:53:                                     ; preds = %50
  %54 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 3
  %55 = load i64, i64* %54, align 8, !tbaa !91
  br i1 %14, label %56, label %60

; <label>:56:                                     ; preds = %53
  %57 = or i64 %55, 2
  store i64 %57, i64* %54, align 8, !tbaa !91
  %58 = icmp eq i32 %51, 0
  %59 = select i1 %58, i32 0, i32 -39
  br label %67

; <label>:60:                                     ; preds = %53
  %61 = or i64 %55, 1
  store i64 %61, i64* %54, align 8, !tbaa !91
  %62 = icmp eq i32 %51, 0
  %63 = select i1 %62, i32 0, i32 -39
  br label %73

; <label>:64:                                     ; preds = %50
  %65 = icmp eq i32 %51, 0
  %66 = select i1 %65, i32 0, i32 -39
  br i1 %14, label %67, label %73

; <label>:67:                                     ; preds = %64, %56
  %68 = phi i32 [ %59, %56 ], [ %66, %64 ]
  %69 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %2, i64 0, i32 14
  %70 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %69, align 8, !tbaa !170
  %71 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %70, i64 0, i32 1
  %72 = load void ()*, void ()** %71, align 8, !tbaa !177
  tail call void %72() #13
  br label %73

; <label>:73:                                     ; preds = %67, %64, %60
  %74 = phi i32 [ %68, %67 ], [ %66, %64 ], [ %63, %60 ]
  br i1 %28, label %75, label %80

; <label>:75:                                     ; preds = %73
  %76 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %6, i64 0, i32 14
  %77 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %76, align 8, !tbaa !170
  %78 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %77, i64 0, i32 1
  %79 = load void ()*, void ()** %78, align 8, !tbaa !177
  tail call void %79() #13
  br label %80

; <label>:80:                                     ; preds = %75, %73, %19, %12
  %81 = phi i32 [ -42, %12 ], [ %20, %19 ], [ %74, %75 ], [ %74, %73 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  ret i32 %81
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_crop(i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.49, i64 0, i64 0)) #13
  ret i32 -40
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_slice(i8*, %struct.halide_buffer_t*, i32, i32, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.50, i64 0, i64 0)) #13
  ret i32 -40
}

; Function Attrs: nounwind
define weak i32 @halide_device_crop(i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  %4 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %5 = load i64, i64* %4, align 8, !tbaa !84
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %32, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !84
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %12, label %11

; <label>:11:                                     ; preds = %7
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.51, i64 0, i64 0)) #13
  br label %32

; <label>:12:                                     ; preds = %7
  %13 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 5
  %14 = load i32, i32* %13, align 4, !tbaa !79
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 5
  %16 = load i32, i32* %15, align 4, !tbaa !79
  %17 = icmp eq i32 %14, %16
  br i1 %17, label %19, label %18

; <label>:18:                                     ; preds = %12
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.52, i64 0, i64 0)) #13
  br label %32

; <label>:19:                                     ; preds = %12
  %20 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %21 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %20, align 8, !tbaa !85
  %22 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %21, i64 0, i32 14
  %23 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %22, align 8, !tbaa !170
  %24 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %23, i64 0, i32 0
  %25 = load void ()*, void ()** %24, align 8, !tbaa !175
  tail call void %25() #13
  %26 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %20, align 8, !tbaa !85
  %27 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %26, i64 0, i32 14
  %28 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %27, align 8, !tbaa !170
  %29 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %28, i64 0, i32 11
  %30 = load i32 (i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, %struct.halide_buffer_t*)** %29, align 8, !tbaa !185
  %31 = tail call i32 %30(i8* %0, %struct.halide_buffer_t* nonnull %1, %struct.halide_buffer_t* nonnull %2) #13
  br label %32

; <label>:32:                                     ; preds = %19, %18, %11, %3
  %33 = phi i32 [ -41, %11 ], [ -41, %18 ], [ %31, %19 ], [ 0, %3 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  ret i32 %33
}

; Function Attrs: nounwind
define weak i32 @halide_device_slice(i8*, %struct.halide_buffer_t*, i32, i32, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  %6 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !84
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %35, label %9

; <label>:9:                                      ; preds = %5
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !84
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %14, label %13

; <label>:13:                                     ; preds = %9
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.51, i64 0, i64 0)) #13
  br label %35

; <label>:14:                                     ; preds = %9
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 5
  %16 = load i32, i32* %15, align 4, !tbaa !79
  %17 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 5
  %18 = load i32, i32* %17, align 4, !tbaa !79
  %19 = add nsw i32 %18, 1
  %20 = icmp eq i32 %16, %19
  br i1 %20, label %22, label %21

; <label>:21:                                     ; preds = %14
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.55, i64 0, i64 0)) #13
  br label %35

; <label>:22:                                     ; preds = %14
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %24 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %23, align 8, !tbaa !85
  %25 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %24, i64 0, i32 14
  %26 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %25, align 8, !tbaa !170
  %27 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %26, i64 0, i32 0
  %28 = load void ()*, void ()** %27, align 8, !tbaa !175
  tail call void %28() #13
  %29 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %23, align 8, !tbaa !85
  %30 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %29, i64 0, i32 14
  %31 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %30, align 8, !tbaa !170
  %32 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %31, i64 0, i32 12
  %33 = load i32 (i8*, %struct.halide_buffer_t*, i32, i32, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*, i32, i32, %struct.halide_buffer_t*)** %32, align 8, !tbaa !186
  %34 = tail call i32 %33(i8* %0, %struct.halide_buffer_t* nonnull %1, i32 %2, i32 %3, %struct.halide_buffer_t* nonnull %4) #13
  br label %35

; <label>:35:                                     ; preds = %22, %21, %13, %5
  %36 = phi i32 [ -41, %13 ], [ -41, %21 ], [ %34, %22 ], [ 0, %5 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  ret i32 %36
}

; Function Attrs: nounwind
define weak i32 @halide_default_device_release_crop(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %4 = load i64, i64* %3, align 8, !tbaa !84
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %7, label %6

; <label>:6:                                      ; preds = %2
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.49, i64 0, i64 0)) #13
  br label %7

; <label>:7:                                      ; preds = %6, %2
  %8 = phi i32 [ -40, %6 ], [ 0, %2 ]
  ret i32 %8
}

; Function Attrs: nounwind
define weak i32 @halide_device_release_crop(i8*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 0
  %4 = load i64, i64* %3, align 8, !tbaa !84
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %17, label %6

; <label>:6:                                      ; preds = %2
  tail call void @halide_mutex_lock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %1, i64 0, i32 1
  %8 = load %struct.halide_device_interface_t*, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  %9 = getelementptr inbounds %struct.halide_device_interface_t, %struct.halide_device_interface_t* %8, i64 0, i32 14
  %10 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %9, align 8, !tbaa !170
  %11 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %10, i64 0, i32 13
  %12 = load i32 (i8*, %struct.halide_buffer_t*)*, i32 (i8*, %struct.halide_buffer_t*)** %11, align 8, !tbaa !187
  %13 = tail call i32 %12(i8* %0, %struct.halide_buffer_t* nonnull %1) #13
  store i64 0, i64* %3, align 8, !tbaa !84
  %14 = load %struct.halide_device_interface_impl_t*, %struct.halide_device_interface_impl_t** %9, align 8, !tbaa !170
  %15 = getelementptr inbounds %struct.halide_device_interface_impl_t, %struct.halide_device_interface_impl_t* %14, i64 0, i32 1
  %16 = load void ()*, void ()** %15, align 8, !tbaa !177
  tail call void %16() #13
  store %struct.halide_device_interface_t* null, %struct.halide_device_interface_t** %7, align 8, !tbaa !85
  tail call void @halide_mutex_unlock(%struct.halide_mutex* nonnull @_ZN6Halide7Runtime8Internal17device_copy_mutexE) #13
  br label %17

; <label>:17:                                     ; preds = %6, %2
  %18 = phi i32 [ %13, %6 ], [ 0, %2 ]
  ret i32 %18
}

; Function Attrs: norecurse nounwind
define linkonce %struct.halide_filter_metadata_t* @_ZN6Halide7Runtime8Internal56unused_function_to_get_halide_filter_metadata_t_declaredEv() local_unnamed_addr #2 {
  ret %struct.halide_filter_metadata_t* null
}

; Function Attrs: nounwind
define weak float @halide_float16_bits_to_float(i16 zeroext) local_unnamed_addr #0 {
  %2 = zext i16 %0 to i32
  %3 = shl nuw i32 %2, 16
  %4 = and i32 %3, -2147483648
  %5 = and i32 %2, 1023
  %6 = lshr i32 %2, 10
  %7 = and i32 %6, 31
  %8 = icmp eq i32 %7, 0
  %9 = icmp ne i32 %5, 0
  %10 = and i1 %9, %8
  br i1 %10, label %11, label %21

; <label>:11:                                     ; preds = %1
  %12 = tail call i32 @llvm.ctlz.i32(i32 %5, i1 true), !range !188
  %13 = xor i32 %12, 31
  %14 = shl i32 1, %13
  %15 = xor i32 %14, -1
  %16 = and i32 %5, %15
  %17 = sub nsw i32 23, %13
  %18 = shl i32 %16, %17
  %19 = shl nuw nsw i32 %13, 23
  %20 = add nuw nsw i32 %19, 864026624
  br label %28

; <label>:21:                                     ; preds = %1
  %22 = shl nuw nsw i32 %5, 13
  br i1 %8, label %28, label %23

; <label>:23:                                     ; preds = %21
  %24 = icmp eq i32 %7, 31
  br i1 %24, label %28, label %25

; <label>:25:                                     ; preds = %23
  %26 = shl nuw nsw i32 %7, 23
  %27 = add nuw nsw i32 %26, 939524096
  br label %28

; <label>:28:                                     ; preds = %25, %23, %21, %11
  %29 = phi i32 [ %20, %11 ], [ %22, %23 ], [ %22, %21 ], [ %22, %25 ]
  %30 = phi i32 [ %18, %11 ], [ 2139095040, %23 ], [ 0, %21 ], [ %27, %25 ]
  %31 = or i32 %29, %4
  %32 = or i32 %31, %30
  %33 = bitcast i32 %32 to float
  ret float %33
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.ctlz.i32(i32, i1) #7

; Function Attrs: nounwind
define weak double @halide_float16_bits_to_double(i16 zeroext) local_unnamed_addr #0 {
  %2 = tail call float @halide_float16_bits_to_float(i16 zeroext %0) #15
  %3 = fpext float %2 to double
  ret double %3
}

; Function Attrs: nounwind
define weak i32 @halide_error_bounds_inference_call_failed(i8*, i8*, i32) local_unnamed_addr #0 {
  %4 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %5 = ptrtoint i8* %4 to i64
  %6 = icmp eq i8* %4, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %4, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %9

; <label>:9:                                      ; preds = %7, %3
  %10 = phi i8* [ %8, %7 ], [ null, %3 ]
  %11 = tail call i8* @halide_string_to_string(i8* %4, i8* %10, i8* nonnull getelementptr inbounds ([41 x i8], [41 x i8]* @.str.112, i64 0, i64 0)) #13
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  %14 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %9
  %16 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %10, i8* nonnull getelementptr inbounds ([27 x i8], [27 x i8]* @.str.1.113, i64 0, i64 0)) #13
  %20 = sext i32 %2 to i64
  %21 = tail call i8* @halide_int64_to_string(i8* %19, i8* %10, i64 %20, i32 1) #13
  br i1 %6, label %22, label %23

; <label>:22:                                     ; preds = %17
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %27

; <label>:23:                                     ; preds = %17
  %24 = ptrtoint i8* %21 to i64
  %25 = sub i64 1, %5
  %26 = add i64 %25, %24
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %26) #13
  tail call void @halide_error(i8* %0, i8* nonnull %4) #13
  br label %27

; <label>:27:                                     ; preds = %23, %22
  tail call void @halide_free(i8* %0, i8* %4) #13
  ret i32 %2
}

; Function Attrs: nounwind
define weak i32 @halide_error_extern_stage_failed(i8*, i8*, i32) local_unnamed_addr #0 {
  %4 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %5 = ptrtoint i8* %4 to i64
  %6 = icmp eq i8* %4, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %4, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %9

; <label>:9:                                      ; preds = %7, %3
  %10 = phi i8* [ %8, %7 ], [ null, %3 ]
  %11 = tail call i8* @halide_string_to_string(i8* %4, i8* %10, i8* nonnull getelementptr inbounds ([24 x i8], [24 x i8]* @.str.2.114, i64 0, i64 0)) #13
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  %14 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %9
  %16 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %10, i8* nonnull getelementptr inbounds ([27 x i8], [27 x i8]* @.str.1.113, i64 0, i64 0)) #13
  %20 = sext i32 %2 to i64
  %21 = tail call i8* @halide_int64_to_string(i8* %19, i8* %10, i64 %20, i32 1) #13
  br i1 %6, label %22, label %23

; <label>:22:                                     ; preds = %17
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %27

; <label>:23:                                     ; preds = %17
  %24 = ptrtoint i8* %21 to i64
  %25 = sub i64 1, %5
  %26 = add i64 %25, %24
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %26) #13
  tail call void @halide_error(i8* %0, i8* nonnull %4) #13
  br label %27

; <label>:27:                                     ; preds = %23, %22
  tail call void @halide_free(i8* %0, i8* %4) #13
  ret i32 %2
}

; Function Attrs: nounwind
define weak i32 @halide_error_explicit_bounds_too_small(i8*, i8*, i8*, i32, i32, i32, i32) local_unnamed_addr #0 {
  %8 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %9 = ptrtoint i8* %8 to i64
  %10 = icmp eq i8* %8, null
  br i1 %10, label %13, label %11

; <label>:11:                                     ; preds = %7
  %12 = getelementptr inbounds i8, i8* %8, i64 1023
  store i8 0, i8* %12, align 1, !tbaa !7
  br label %13

; <label>:13:                                     ; preds = %11, %7
  %14 = phi i8* [ %12, %11 ], [ null, %7 ]
  %15 = tail call i8* @halide_string_to_string(i8* %8, i8* %14, i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @.str.3.115, i64 0, i64 0)) #13
  %16 = icmp eq i8* %2, null
  br i1 %16, label %17, label %19

; <label>:17:                                     ; preds = %13
  %18 = tail call i8* @halide_string_to_string(i8* %15, i8* %14, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %21

; <label>:19:                                     ; preds = %13
  %20 = tail call i8* @halide_string_to_string(i8* %15, i8* %14, i8* nonnull %2) #13
  br label %21

; <label>:21:                                     ; preds = %19, %17
  %22 = phi i8* [ %20, %19 ], [ %18, %17 ]
  %23 = tail call i8* @halide_string_to_string(i8* %22, i8* %14, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4.116, i64 0, i64 0)) #13
  %24 = icmp eq i8* %1, null
  br i1 %24, label %25, label %27

; <label>:25:                                     ; preds = %21
  %26 = tail call i8* @halide_string_to_string(i8* %23, i8* %14, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %29

; <label>:27:                                     ; preds = %21
  %28 = tail call i8* @halide_string_to_string(i8* %23, i8* %14, i8* nonnull %1) #13
  br label %29

; <label>:29:                                     ; preds = %27, %25
  %30 = phi i8* [ %28, %27 ], [ %26, %25 ]
  %31 = tail call i8* @halide_string_to_string(i8* %30, i8* %14, i8* nonnull getelementptr inbounds ([8 x i8], [8 x i8]* @.str.5.117, i64 0, i64 0)) #13
  %32 = sext i32 %3 to i64
  %33 = tail call i8* @halide_int64_to_string(i8* %31, i8* %14, i64 %32, i32 1) #13
  %34 = tail call i8* @halide_string_to_string(i8* %33, i8* %14, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6.118, i64 0, i64 0)) #13
  %35 = sext i32 %4 to i64
  %36 = tail call i8* @halide_int64_to_string(i8* %34, i8* %14, i64 %35, i32 1) #13
  %37 = tail call i8* @halide_string_to_string(i8* %36, i8* %14, i8* nonnull getelementptr inbounds ([38 x i8], [38 x i8]* @.str.7.119, i64 0, i64 0)) #13
  %38 = sext i32 %5 to i64
  %39 = tail call i8* @halide_int64_to_string(i8* %37, i8* %14, i64 %38, i32 1) #13
  %40 = tail call i8* @halide_string_to_string(i8* %39, i8* %14, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6.118, i64 0, i64 0)) #13
  %41 = sext i32 %6 to i64
  %42 = tail call i8* @halide_int64_to_string(i8* %40, i8* %14, i64 %41, i32 1) #13
  %43 = tail call i8* @halide_string_to_string(i8* %42, i8* %14, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8.120, i64 0, i64 0)) #13
  br i1 %10, label %44, label %45

; <label>:44:                                     ; preds = %29
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %49

; <label>:45:                                     ; preds = %29
  %46 = ptrtoint i8* %43 to i64
  %47 = sub i64 1, %9
  %48 = add i64 %47, %46
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %8, i64 %48) #13
  tail call void @halide_error(i8* %0, i8* nonnull %8) #13
  br label %49

; <label>:49:                                     ; preds = %45, %44
  tail call void @halide_free(i8* %0, i8* %8) #13
  ret i32 -2
}

; Function Attrs: nounwind
define weak i32 @halide_error_bad_type(i8*, i8*, i8 zeroext, i8 zeroext, i8 zeroext, i8 zeroext, i16 zeroext, i16 zeroext) local_unnamed_addr #0 {
  %9 = alloca %struct.halide_type_t, align 2
  %10 = alloca %struct.halide_type_t, align 2
  %11 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %9, i64 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %11) #14
  store i8 %3, i8* %11, align 2, !tbaa !168
  %12 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %9, i64 0, i32 1
  store i8 %5, i8* %12, align 1, !tbaa !99
  %13 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %9, i64 0, i32 2
  store i16 %7, i16* %13, align 2, !tbaa !169
  %14 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %10, i64 0, i32 0
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %14) #14
  store i8 %2, i8* %14, align 2, !tbaa !168
  %15 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %10, i64 0, i32 1
  store i8 %4, i8* %15, align 1, !tbaa !99
  %16 = getelementptr inbounds %struct.halide_type_t, %struct.halide_type_t* %10, i64 0, i32 2
  store i16 %6, i16* %16, align 2, !tbaa !169
  %17 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %18 = ptrtoint i8* %17 to i64
  %19 = icmp eq i8* %17, null
  br i1 %19, label %22, label %20

; <label>:20:                                     ; preds = %8
  %21 = getelementptr inbounds i8, i8* %17, i64 1023
  store i8 0, i8* %21, align 1, !tbaa !7
  br label %22

; <label>:22:                                     ; preds = %20, %8
  %23 = phi i8* [ %21, %20 ], [ null, %8 ]
  %24 = icmp eq i8* %1, null
  br i1 %24, label %25, label %27

; <label>:25:                                     ; preds = %22
  %26 = tail call i8* @halide_string_to_string(i8* %17, i8* %23, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %29

; <label>:27:                                     ; preds = %22
  %28 = tail call i8* @halide_string_to_string(i8* %17, i8* %23, i8* nonnull %1) #13
  br label %29

; <label>:29:                                     ; preds = %27, %25
  %30 = phi i8* [ %28, %27 ], [ %26, %25 ]
  %31 = tail call i8* @halide_string_to_string(i8* %30, i8* %23, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.9.121, i64 0, i64 0)) #13
  %32 = call i8* @halide_type_to_string(i8* %31, i8* %23, %struct.halide_type_t* nonnull %9) #13
  %33 = call i8* @halide_string_to_string(i8* %32, i8* %23, i8* nonnull getelementptr inbounds ([38 x i8], [38 x i8]* @.str.10.122, i64 0, i64 0)) #13
  %34 = call i8* @halide_type_to_string(i8* %33, i8* %23, %struct.halide_type_t* nonnull %10) #13
  br i1 %19, label %35, label %36

; <label>:35:                                     ; preds = %29
  call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %40

; <label>:36:                                     ; preds = %29
  %37 = ptrtoint i8* %34 to i64
  %38 = sub i64 1, %18
  %39 = add i64 %38, %37
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %17, i64 %39) #13
  call void @halide_error(i8* %0, i8* nonnull %17) #13
  br label %40

; <label>:40:                                     ; preds = %36, %35
  call void @halide_free(i8* %0, i8* %17) #13
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %14) #14
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %11) #14
  ret i32 -3
}

; Function Attrs: nounwind
define weak i32 @halide_error_bad_dimensions(i8*, i8*, i32, i32) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %10
  %14 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %10
  %16 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %11, i8* nonnull getelementptr inbounds ([31 x i8], [31 x i8]* @.str.11.123, i64 0, i64 0)) #13
  %20 = sext i32 %3 to i64
  %21 = tail call i8* @halide_int64_to_string(i8* %19, i8* %11, i64 %20, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([43 x i8], [43 x i8]* @.str.12.124, i64 0, i64 0)) #13
  %23 = sext i32 %2 to i64
  %24 = tail call i8* @halide_int64_to_string(i8* %22, i8* %11, i64 %23, i32 1) #13
  %25 = tail call i8* @halide_string_to_string(i8* %24, i8* %11, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.13.125, i64 0, i64 0)) #13
  br i1 %7, label %26, label %27

; <label>:26:                                     ; preds = %17
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %31

; <label>:27:                                     ; preds = %17
  %28 = ptrtoint i8* %25 to i64
  %29 = sub i64 1, %6
  %30 = add i64 %29, %28
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %30) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %31

; <label>:31:                                     ; preds = %27, %26
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -43
}

; Function Attrs: nounwind
define weak i32 @halide_error_access_out_of_bounds(i8*, i8*, i32, i32, i32, i32, i32) local_unnamed_addr #0 {
  %8 = icmp slt i32 %3, %5
  br i1 %8, label %9, label %39

; <label>:9:                                      ; preds = %7
  %10 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %11 = ptrtoint i8* %10 to i64
  %12 = icmp eq i8* %10, null
  br i1 %12, label %15, label %13

; <label>:13:                                     ; preds = %9
  %14 = getelementptr inbounds i8, i8* %10, i64 1023
  store i8 0, i8* %14, align 1, !tbaa !7
  br label %15

; <label>:15:                                     ; preds = %13, %9
  %16 = phi i8* [ %14, %13 ], [ null, %9 ]
  %17 = icmp eq i8* %1, null
  br i1 %17, label %18, label %20

; <label>:18:                                     ; preds = %15
  %19 = tail call i8* @halide_string_to_string(i8* %10, i8* %16, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %22

; <label>:20:                                     ; preds = %15
  %21 = tail call i8* @halide_string_to_string(i8* %10, i8* %16, i8* nonnull %1) #13
  br label %22

; <label>:22:                                     ; preds = %20, %18
  %23 = phi i8* [ %21, %20 ], [ %19, %18 ]
  %24 = tail call i8* @halide_string_to_string(i8* %23, i8* %16, i8* nonnull getelementptr inbounds ([17 x i8], [17 x i8]* @.str.14.126, i64 0, i64 0)) #13
  %25 = sext i32 %3 to i64
  %26 = tail call i8* @halide_int64_to_string(i8* %24, i8* %16, i64 %25, i32 1) #13
  %27 = tail call i8* @halide_string_to_string(i8* %26, i8* %16, i8* nonnull getelementptr inbounds ([28 x i8], [28 x i8]* @.str.15.127, i64 0, i64 0)) #13
  %28 = sext i32 %5 to i64
  %29 = tail call i8* @halide_int64_to_string(i8* %27, i8* %16, i64 %28, i32 1) #13
  %30 = tail call i8* @halide_string_to_string(i8* %29, i8* %16, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16.128, i64 0, i64 0)) #13
  %31 = sext i32 %2 to i64
  %32 = tail call i8* @halide_int64_to_string(i8* %30, i8* %16, i64 %31, i32 1) #13
  br i1 %12, label %33, label %34

; <label>:33:                                     ; preds = %22
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %38

; <label>:34:                                     ; preds = %22
  %35 = ptrtoint i8* %32 to i64
  %36 = sub i64 1, %11
  %37 = add i64 %36, %35
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %10, i64 %37) #13
  tail call void @halide_error(i8* %0, i8* nonnull %10) #13
  br label %38

; <label>:38:                                     ; preds = %34, %33
  tail call void @halide_free(i8* %0, i8* %10) #13
  br label %71

; <label>:39:                                     ; preds = %7
  %40 = icmp sgt i32 %4, %6
  br i1 %40, label %41, label %71

; <label>:41:                                     ; preds = %39
  %42 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %43 = ptrtoint i8* %42 to i64
  %44 = icmp eq i8* %42, null
  br i1 %44, label %47, label %45

; <label>:45:                                     ; preds = %41
  %46 = getelementptr inbounds i8, i8* %42, i64 1023
  store i8 0, i8* %46, align 1, !tbaa !7
  br label %47

; <label>:47:                                     ; preds = %45, %41
  %48 = phi i8* [ %46, %45 ], [ null, %41 ]
  %49 = icmp eq i8* %1, null
  br i1 %49, label %50, label %52

; <label>:50:                                     ; preds = %47
  %51 = tail call i8* @halide_string_to_string(i8* %42, i8* %48, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %54

; <label>:52:                                     ; preds = %47
  %53 = tail call i8* @halide_string_to_string(i8* %42, i8* %48, i8* nonnull %1) #13
  br label %54

; <label>:54:                                     ; preds = %52, %50
  %55 = phi i8* [ %53, %52 ], [ %51, %50 ]
  %56 = tail call i8* @halide_string_to_string(i8* %55, i8* %48, i8* nonnull getelementptr inbounds ([17 x i8], [17 x i8]* @.str.14.126, i64 0, i64 0)) #13
  %57 = sext i32 %4 to i64
  %58 = tail call i8* @halide_int64_to_string(i8* %56, i8* %48, i64 %57, i32 1) #13
  %59 = tail call i8* @halide_string_to_string(i8* %58, i8* %48, i8* nonnull getelementptr inbounds ([28 x i8], [28 x i8]* @.str.17.129, i64 0, i64 0)) #13
  %60 = sext i32 %6 to i64
  %61 = tail call i8* @halide_int64_to_string(i8* %59, i8* %48, i64 %60, i32 1) #13
  %62 = tail call i8* @halide_string_to_string(i8* %61, i8* %48, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.16.128, i64 0, i64 0)) #13
  %63 = sext i32 %2 to i64
  %64 = tail call i8* @halide_int64_to_string(i8* %62, i8* %48, i64 %63, i32 1) #13
  br i1 %44, label %65, label %66

; <label>:65:                                     ; preds = %54
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %70

; <label>:66:                                     ; preds = %54
  %67 = ptrtoint i8* %64 to i64
  %68 = sub i64 1, %43
  %69 = add i64 %68, %67
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %42, i64 %69) #13
  tail call void @halide_error(i8* %0, i8* nonnull %42) #13
  br label %70

; <label>:70:                                     ; preds = %66, %65
  tail call void @halide_free(i8* %0, i8* %42) #13
  br label %71

; <label>:71:                                     ; preds = %70, %39, %38
  ret i32 -4
}

; Function Attrs: nounwind
define weak i32 @halide_error_buffer_allocation_too_large(i8*, i8*, i64, i64) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([29 x i8], [29 x i8]* @.str.18.130, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_uint64_to_string(i8* %20, i8* %11, i64 %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([37 x i8], [37 x i8]* @.str.20.132, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_uint64_to_string(i8* %22, i8* %11, i64 %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -5
}

; Function Attrs: nounwind
define weak i32 @halide_error_buffer_extents_negative(i8*, i8*, i32, i32) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([24 x i8], [24 x i8]* @.str.21.133, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.22.134, i64 0, i64 0)) #13
  %21 = sext i32 %2 to i64
  %22 = tail call i8* @halide_int64_to_string(i8* %20, i8* %11, i64 %21, i32 1) #13
  %23 = tail call i8* @halide_string_to_string(i8* %22, i8* %11, i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @.str.23.135, i64 0, i64 0)) #13
  %24 = sext i32 %3 to i64
  %25 = tail call i8* @halide_int64_to_string(i8* %23, i8* %11, i64 %24, i32 1) #13
  %26 = tail call i8* @halide_string_to_string(i8* %25, i8* %11, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8.120, i64 0, i64 0)) #13
  br i1 %7, label %27, label %28

; <label>:27:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %32

; <label>:28:                                     ; preds = %18
  %29 = ptrtoint i8* %26 to i64
  %30 = sub i64 1, %6
  %31 = add i64 %30, %29
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %31) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %32

; <label>:32:                                     ; preds = %28, %27
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -28
}

; Function Attrs: nounwind
define weak i32 @halide_error_buffer_extents_too_large(i8*, i8*, i64, i64) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([31 x i8], [31 x i8]* @.str.24.136, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_int64_to_string(i8* %20, i8* %11, i64 %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([37 x i8], [37 x i8]* @.str.20.132, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_int64_to_string(i8* %22, i8* %11, i64 %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -6
}

; Function Attrs: nounwind
define weak i32 @halide_error_constraints_make_required_region_smaller(i8*, i8*, i32, i32, i32, i32, i32) local_unnamed_addr #0 {
  %8 = add i32 %6, -1
  %9 = add i32 %8, %5
  %10 = add i32 %8, %3
  %11 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %12 = ptrtoint i8* %11 to i64
  %13 = icmp eq i8* %11, null
  br i1 %13, label %16, label %14

; <label>:14:                                     ; preds = %7
  %15 = getelementptr inbounds i8, i8* %11, i64 1023
  store i8 0, i8* %15, align 1, !tbaa !7
  br label %16

; <label>:16:                                     ; preds = %14, %7
  %17 = phi i8* [ %15, %14 ], [ null, %7 ]
  %18 = tail call i8* @halide_string_to_string(i8* %11, i8* %17, i8* nonnull getelementptr inbounds ([29 x i8], [29 x i8]* @.str.25.137, i64 0, i64 0)) #13
  %19 = icmp eq i8* %1, null
  br i1 %19, label %20, label %22

; <label>:20:                                     ; preds = %16
  %21 = tail call i8* @halide_string_to_string(i8* %18, i8* %17, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %24

; <label>:22:                                     ; preds = %16
  %23 = tail call i8* @halide_string_to_string(i8* %18, i8* %17, i8* nonnull %1) #13
  br label %24

; <label>:24:                                     ; preds = %22, %20
  %25 = phi i8* [ %23, %22 ], [ %21, %20 ]
  %26 = tail call i8* @halide_string_to_string(i8* %25, i8* %17, i8* nonnull getelementptr inbounds ([42 x i8], [42 x i8]* @.str.26.138, i64 0, i64 0)) #13
  %27 = tail call i8* @halide_string_to_string(i8* %26, i8* %17, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.27.139, i64 0, i64 0)) #13
  %28 = sext i32 %5 to i64
  %29 = tail call i8* @halide_int64_to_string(i8* %27, i8* %17, i64 %28, i32 1) #13
  %30 = tail call i8* @halide_string_to_string(i8* %29, i8* %17, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6.118, i64 0, i64 0)) #13
  %31 = sext i32 %9 to i64
  %32 = tail call i8* @halide_int64_to_string(i8* %30, i8* %17, i64 %31, i32 1) #13
  %33 = tail call i8* @halide_string_to_string(i8* %32, i8* %17, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.28.140, i64 0, i64 0)) #13
  %34 = tail call i8* @halide_string_to_string(i8* %33, i8* %17, i8* nonnull getelementptr inbounds ([19 x i8], [19 x i8]* @.str.29.141, i64 0, i64 0)) #13
  %35 = sext i32 %3 to i64
  %36 = tail call i8* @halide_int64_to_string(i8* %34, i8* %17, i64 %35, i32 1) #13
  %37 = tail call i8* @halide_string_to_string(i8* %36, i8* %17, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6.118, i64 0, i64 0)) #13
  %38 = sext i32 %10 to i64
  %39 = tail call i8* @halide_int64_to_string(i8* %37, i8* %17, i64 %38, i32 1) #13
  %40 = tail call i8* @halide_string_to_string(i8* %39, i8* %17, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30.142, i64 0, i64 0)) #13
  br i1 %13, label %41, label %42

; <label>:41:                                     ; preds = %24
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %46

; <label>:42:                                     ; preds = %24
  %43 = ptrtoint i8* %40 to i64
  %44 = sub i64 1, %12
  %45 = add i64 %44, %43
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %11, i64 %45) #13
  tail call void @halide_error(i8* %0, i8* nonnull %11) #13
  br label %46

; <label>:46:                                     ; preds = %42, %41
  tail call void @halide_free(i8* %0, i8* %11) #13
  ret i32 -7
}

; Function Attrs: nounwind
define weak i32 @halide_error_constraint_violated(i8*, i8*, i32, i8*, i32) local_unnamed_addr #0 {
  %6 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %7 = ptrtoint i8* %6 to i64
  %8 = icmp eq i8* %6, null
  br i1 %8, label %11, label %9

; <label>:9:                                      ; preds = %5
  %10 = getelementptr inbounds i8, i8* %6, i64 1023
  store i8 0, i8* %10, align 1, !tbaa !7
  br label %11

; <label>:11:                                     ; preds = %9, %5
  %12 = phi i8* [ %10, %9 ], [ null, %5 ]
  %13 = tail call i8* @halide_string_to_string(i8* %6, i8* %12, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.31.143, i64 0, i64 0)) #13
  %14 = icmp eq i8* %1, null
  br i1 %14, label %15, label %17

; <label>:15:                                     ; preds = %11
  %16 = tail call i8* @halide_string_to_string(i8* %13, i8* %12, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %19

; <label>:17:                                     ; preds = %11
  %18 = tail call i8* @halide_string_to_string(i8* %13, i8* %12, i8* nonnull %1) #13
  br label %19

; <label>:19:                                     ; preds = %17, %15
  %20 = phi i8* [ %18, %17 ], [ %16, %15 ]
  %21 = tail call i8* @halide_string_to_string(i8* %20, i8* %12, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.32.144, i64 0, i64 0)) #13
  %22 = sext i32 %2 to i64
  %23 = tail call i8* @halide_int64_to_string(i8* %21, i8* %12, i64 %22, i32 1) #13
  %24 = tail call i8* @halide_string_to_string(i8* %23, i8* %12, i8* nonnull getelementptr inbounds ([6 x i8], [6 x i8]* @.str.33.145, i64 0, i64 0)) #13
  %25 = icmp eq i8* %3, null
  br i1 %25, label %26, label %28

; <label>:26:                                     ; preds = %19
  %27 = tail call i8* @halide_string_to_string(i8* %24, i8* %12, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %30

; <label>:28:                                     ; preds = %19
  %29 = tail call i8* @halide_string_to_string(i8* %24, i8* %12, i8* nonnull %3) #13
  br label %30

; <label>:30:                                     ; preds = %28, %26
  %31 = phi i8* [ %29, %28 ], [ %27, %26 ]
  %32 = tail call i8* @halide_string_to_string(i8* %31, i8* %12, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.32.144, i64 0, i64 0)) #13
  %33 = sext i32 %4 to i64
  %34 = tail call i8* @halide_int64_to_string(i8* %32, i8* %12, i64 %33, i32 1) #13
  %35 = tail call i8* @halide_string_to_string(i8* %34, i8* %12, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8.120, i64 0, i64 0)) #13
  br i1 %8, label %36, label %37

; <label>:36:                                     ; preds = %30
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %41

; <label>:37:                                     ; preds = %30
  %38 = ptrtoint i8* %35 to i64
  %39 = sub i64 1, %7
  %40 = add i64 %39, %38
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %6, i64 %40) #13
  tail call void @halide_error(i8* %0, i8* nonnull %6) #13
  br label %41

; <label>:41:                                     ; preds = %37, %36
  tail call void @halide_free(i8* %0, i8* %6) #13
  ret i32 -8
}

; Function Attrs: nounwind
define weak i32 @halide_error_param_too_small_i64(i8*, i8*, i64, i64) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.34.146, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_int64_to_string(i8* %20, i8* %11, i64 %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str.35.147, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_int64_to_string(i8* %22, i8* %11, i64 %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -9
}

; Function Attrs: nounwind
define weak i32 @halide_error_param_too_small_u64(i8*, i8*, i64, i64) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.34.146, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_uint64_to_string(i8* %20, i8* %11, i64 %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str.35.147, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_uint64_to_string(i8* %22, i8* %11, i64 %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -9
}

; Function Attrs: nounwind
define weak i32 @halide_error_param_too_small_f64(i8*, i8*, double, double) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.34.146, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_double_to_string(i8* %20, i8* %11, double %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str.35.147, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_double_to_string(i8* %22, i8* %11, double %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -9
}

; Function Attrs: nounwind
define weak i32 @halide_error_param_too_large_i64(i8*, i8*, i64, i64) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.34.146, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_int64_to_string(i8* %20, i8* %11, i64 %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.36.148, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_int64_to_string(i8* %22, i8* %11, i64 %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -10
}

; Function Attrs: nounwind
define weak i32 @halide_error_param_too_large_u64(i8*, i8*, i64, i64) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.34.146, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_uint64_to_string(i8* %20, i8* %11, i64 %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.36.148, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_uint64_to_string(i8* %22, i8* %11, i64 %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -10
}

; Function Attrs: nounwind
define weak i32 @halide_error_param_too_large_f64(i8*, i8*, double, double) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.34.146, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.19.131, i64 0, i64 0)) #13
  %21 = tail call i8* @halide_double_to_string(i8* %20, i8* %11, double %2, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %11, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.36.148, i64 0, i64 0)) #13
  %23 = tail call i8* @halide_double_to_string(i8* %22, i8* %11, double %3, i32 1) #13
  br i1 %7, label %24, label %25

; <label>:24:                                     ; preds = %18
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %29

; <label>:25:                                     ; preds = %18
  %26 = ptrtoint i8* %23 to i64
  %27 = sub i64 1, %6
  %28 = add i64 %27, %26
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %28) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %29

; <label>:29:                                     ; preds = %25, %24
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -10
}

; Function Attrs: nounwind
define weak i32 @halide_error_out_of_memory(i8*) local_unnamed_addr #0 {
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.37, i64 0, i64 0)) #13
  ret i32 -11
}

; Function Attrs: nounwind
define weak i32 @halide_error_buffer_argument_is_null(i8*, i8*) local_unnamed_addr #0 {
  %3 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %4 = ptrtoint i8* %3 to i64
  %5 = icmp eq i8* %3, null
  br i1 %5, label %8, label %6

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds i8, i8* %3, i64 1023
  store i8 0, i8* %7, align 1, !tbaa !7
  br label %8

; <label>:8:                                      ; preds = %6, %2
  %9 = phi i8* [ %7, %6 ], [ null, %2 ]
  %10 = tail call i8* @halide_string_to_string(i8* %3, i8* %9, i8* nonnull getelementptr inbounds ([17 x i8], [17 x i8]* @.str.38, i64 0, i64 0)) #13
  %11 = icmp eq i8* %1, null
  br i1 %11, label %12, label %14

; <label>:12:                                     ; preds = %8
  %13 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %16

; <label>:14:                                     ; preds = %8
  %15 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* nonnull %1) #13
  br label %16

; <label>:16:                                     ; preds = %14, %12
  %17 = phi i8* [ %15, %14 ], [ %13, %12 ]
  %18 = tail call i8* @halide_string_to_string(i8* %17, i8* %9, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @.str.39, i64 0, i64 0)) #13
  br i1 %5, label %19, label %20

; <label>:19:                                     ; preds = %16
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %24

; <label>:20:                                     ; preds = %16
  %21 = ptrtoint i8* %18 to i64
  %22 = sub i64 1, %4
  %23 = add i64 %22, %21
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %3, i64 %23) #13
  tail call void @halide_error(i8* %0, i8* nonnull %3) #13
  br label %24

; <label>:24:                                     ; preds = %20, %19
  tail call void @halide_free(i8* %0, i8* %3) #13
  ret i32 -12
}

; Function Attrs: nounwind
define weak i32 @halide_error_debug_to_file_failed(i8*, i8*, i8*, i32) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([25 x i8], [25 x i8]* @.str.40, i64 0, i64 0)) #13
  %13 = icmp eq i8* %1, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %1) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([10 x i8], [10 x i8]* @.str.41, i64 0, i64 0)) #13
  %21 = icmp eq i8* %2, null
  br i1 %21, label %22, label %24

; <label>:22:                                     ; preds = %18
  %23 = tail call i8* @halide_string_to_string(i8* %20, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %26

; <label>:24:                                     ; preds = %18
  %25 = tail call i8* @halide_string_to_string(i8* %20, i8* %11, i8* nonnull %2) #13
  br label %26

; <label>:26:                                     ; preds = %24, %22
  %27 = phi i8* [ %25, %24 ], [ %23, %22 ]
  %28 = tail call i8* @halide_string_to_string(i8* %27, i8* %11, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.42, i64 0, i64 0)) #13
  %29 = sext i32 %3 to i64
  %30 = tail call i8* @halide_int64_to_string(i8* %28, i8* %11, i64 %29, i32 1) #13
  br i1 %7, label %31, label %32

; <label>:31:                                     ; preds = %26
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %36

; <label>:32:                                     ; preds = %26
  %33 = ptrtoint i8* %30 to i64
  %34 = sub i64 1, %6
  %35 = add i64 %34, %33
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %35) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %36

; <label>:36:                                     ; preds = %32, %31
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -13
}

; Function Attrs: nounwind
define weak i32 @halide_error_failed_to_upgrade_buffer_t(i8*, i8*, i8*) local_unnamed_addr #0 {
  %4 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %5 = ptrtoint i8* %4 to i64
  %6 = icmp eq i8* %4, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %4, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %9

; <label>:9:                                      ; preds = %7, %3
  %10 = phi i8* [ %8, %7 ], [ null, %3 ]
  %11 = tail call i8* @halide_string_to_string(i8* %4, i8* %10, i8* nonnull getelementptr inbounds ([51 x i8], [51 x i8]* @.str.43, i64 0, i64 0)) #13
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  %14 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %9
  %16 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %10, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.44, i64 0, i64 0)) #13
  %20 = icmp eq i8* %2, null
  br i1 %20, label %21, label %23

; <label>:21:                                     ; preds = %17
  %22 = tail call i8* @halide_string_to_string(i8* %19, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %25

; <label>:23:                                     ; preds = %17
  %24 = tail call i8* @halide_string_to_string(i8* %19, i8* %10, i8* nonnull %2) #13
  br label %25

; <label>:25:                                     ; preds = %23, %21
  %26 = phi i8* [ %24, %23 ], [ %22, %21 ]
  br i1 %6, label %27, label %28

; <label>:27:                                     ; preds = %25
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %32

; <label>:28:                                     ; preds = %25
  %29 = ptrtoint i8* %26 to i64
  %30 = sub i64 1, %5
  %31 = add i64 %30, %29
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %31) #13
  tail call void @halide_error(i8* %0, i8* nonnull %4) #13
  br label %32

; <label>:32:                                     ; preds = %28, %27
  tail call void @halide_free(i8* %0, i8* %4) #13
  ret i32 -29
}

; Function Attrs: nounwind
define weak i32 @halide_error_failed_to_downgrade_buffer_t(i8*, i8*, i8*) local_unnamed_addr #0 {
  %4 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %5 = ptrtoint i8* %4 to i64
  %6 = icmp eq i8* %4, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %4, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %9

; <label>:9:                                      ; preds = %7, %3
  %10 = phi i8* [ %8, %7 ], [ null, %3 ]
  %11 = tail call i8* @halide_string_to_string(i8* %4, i8* %10, i8* nonnull getelementptr inbounds ([53 x i8], [53 x i8]* @.str.45, i64 0, i64 0)) #13
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  %14 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %9
  %16 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %10, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.44, i64 0, i64 0)) #13
  %20 = icmp eq i8* %2, null
  br i1 %20, label %21, label %23

; <label>:21:                                     ; preds = %17
  %22 = tail call i8* @halide_string_to_string(i8* %19, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %25

; <label>:23:                                     ; preds = %17
  %24 = tail call i8* @halide_string_to_string(i8* %19, i8* %10, i8* nonnull %2) #13
  br label %25

; <label>:25:                                     ; preds = %23, %21
  %26 = phi i8* [ %24, %23 ], [ %22, %21 ]
  br i1 %6, label %27, label %28

; <label>:27:                                     ; preds = %25
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %32

; <label>:28:                                     ; preds = %25
  %29 = ptrtoint i8* %26 to i64
  %30 = sub i64 1, %5
  %31 = add i64 %30, %29
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %31) #13
  tail call void @halide_error(i8* %0, i8* nonnull %4) #13
  br label %32

; <label>:32:                                     ; preds = %28, %27
  tail call void @halide_free(i8* %0, i8* %4) #13
  ret i32 -30
}

; Function Attrs: nounwind
define weak i32 @halide_error_unaligned_host_ptr(i8*, i8*, i32) local_unnamed_addr #0 {
  %4 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %5 = ptrtoint i8* %4 to i64
  %6 = icmp eq i8* %4, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %4, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %9

; <label>:9:                                      ; preds = %7, %3
  %10 = phi i8* [ %8, %7 ], [ null, %3 ]
  %11 = tail call i8* @halide_string_to_string(i8* %4, i8* %10, i8* nonnull getelementptr inbounds ([21 x i8], [21 x i8]* @.str.46, i64 0, i64 0)) #13
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  %14 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %9
  %16 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %10, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.47, i64 0, i64 0)) #13
  %20 = sext i32 %2 to i64
  %21 = tail call i8* @halide_int64_to_string(i8* %19, i8* %10, i64 %20, i32 1) #13
  %22 = tail call i8* @halide_string_to_string(i8* %21, i8* %10, i8* nonnull getelementptr inbounds ([17 x i8], [17 x i8]* @.str.48.149, i64 0, i64 0)) #13
  br i1 %6, label %23, label %24

; <label>:23:                                     ; preds = %17
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %28

; <label>:24:                                     ; preds = %17
  %25 = ptrtoint i8* %22 to i64
  %26 = sub i64 1, %5
  %27 = add i64 %26, %25
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %27) #13
  tail call void @halide_error(i8* %0, i8* nonnull %4) #13
  br label %28

; <label>:28:                                     ; preds = %24, %23
  tail call void @halide_free(i8* %0, i8* %4) #13
  ret i32 -24
}

; Function Attrs: nounwind
define weak i32 @halide_error_host_is_null(i8*, i8*) local_unnamed_addr #0 {
  %3 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %4 = ptrtoint i8* %3 to i64
  %5 = icmp eq i8* %3, null
  br i1 %5, label %8, label %6

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds i8, i8* %3, i64 1023
  store i8 0, i8* %7, align 1, !tbaa !7
  br label %8

; <label>:8:                                      ; preds = %6, %2
  %9 = phi i8* [ %7, %6 ], [ null, %2 ]
  %10 = tail call i8* @halide_string_to_string(i8* %3, i8* %9, i8* nonnull getelementptr inbounds ([21 x i8], [21 x i8]* @.str.46, i64 0, i64 0)) #13
  %11 = icmp eq i8* %1, null
  br i1 %11, label %12, label %14

; <label>:12:                                     ; preds = %8
  %13 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %16

; <label>:14:                                     ; preds = %8
  %15 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* nonnull %1) #13
  br label %16

; <label>:16:                                     ; preds = %14, %12
  %17 = phi i8* [ %15, %14 ], [ %13, %12 ]
  %18 = tail call i8* @halide_string_to_string(i8* %17, i8* %9, i8* nonnull getelementptr inbounds ([55 x i8], [55 x i8]* @.str.49.150, i64 0, i64 0)) #13
  br i1 %5, label %19, label %20

; <label>:19:                                     ; preds = %16
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %24

; <label>:20:                                     ; preds = %16
  %21 = ptrtoint i8* %18 to i64
  %22 = sub i64 1, %4
  %23 = add i64 %22, %21
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %3, i64 %23) #13
  tail call void @halide_error(i8* %0, i8* nonnull %3) #13
  br label %24

; <label>:24:                                     ; preds = %20, %19
  tail call void @halide_free(i8* %0, i8* %3) #13
  ret i32 -34
}

; Function Attrs: nounwind
define weak i32 @halide_error_bad_fold(i8*, i8*, i8*, i8*) local_unnamed_addr #0 {
  %5 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %6 = ptrtoint i8* %5 to i64
  %7 = icmp eq i8* %5, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds i8, i8* %5, i64 1023
  store i8 0, i8* %9, align 1, !tbaa !7
  br label %10

; <label>:10:                                     ; preds = %8, %4
  %11 = phi i8* [ %9, %8 ], [ null, %4 ]
  %12 = tail call i8* @halide_string_to_string(i8* %5, i8* %11, i8* nonnull getelementptr inbounds ([30 x i8], [30 x i8]* @.str.50.151, i64 0, i64 0)) #13
  %13 = icmp eq i8* %2, null
  br i1 %13, label %14, label %16

; <label>:14:                                     ; preds = %10
  %15 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %18

; <label>:16:                                     ; preds = %10
  %17 = tail call i8* @halide_string_to_string(i8* %12, i8* %11, i8* nonnull %2) #13
  br label %18

; <label>:18:                                     ; preds = %16, %14
  %19 = phi i8* [ %17, %16 ], [ %15, %14 ]
  %20 = tail call i8* @halide_string_to_string(i8* %19, i8* %11, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.51.152, i64 0, i64 0)) #13
  %21 = icmp eq i8* %1, null
  br i1 %21, label %22, label %24

; <label>:22:                                     ; preds = %18
  %23 = tail call i8* @halide_string_to_string(i8* %20, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %26

; <label>:24:                                     ; preds = %18
  %25 = tail call i8* @halide_string_to_string(i8* %20, i8* %11, i8* nonnull %1) #13
  br label %26

; <label>:26:                                     ; preds = %24, %22
  %27 = phi i8* [ %25, %24 ], [ %23, %22 ]
  %28 = tail call i8* @halide_string_to_string(i8* %27, i8* %11, i8* nonnull getelementptr inbounds ([36 x i8], [36 x i8]* @.str.52.153, i64 0, i64 0)) #13
  %29 = icmp eq i8* %3, null
  br i1 %29, label %30, label %32

; <label>:30:                                     ; preds = %26
  %31 = tail call i8* @halide_string_to_string(i8* %28, i8* %11, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %34

; <label>:32:                                     ; preds = %26
  %33 = tail call i8* @halide_string_to_string(i8* %28, i8* %11, i8* nonnull %3) #13
  br label %34

; <label>:34:                                     ; preds = %32, %30
  %35 = phi i8* [ %33, %32 ], [ %31, %30 ]
  %36 = tail call i8* @halide_string_to_string(i8* %35, i8* %11, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30.142, i64 0, i64 0)) #13
  br i1 %7, label %37, label %38

; <label>:37:                                     ; preds = %34
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %42

; <label>:38:                                     ; preds = %34
  %39 = ptrtoint i8* %36 to i64
  %40 = sub i64 1, %6
  %41 = add i64 %40, %39
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %5, i64 %41) #13
  tail call void @halide_error(i8* %0, i8* nonnull %5) #13
  br label %42

; <label>:42:                                     ; preds = %38, %37
  tail call void @halide_free(i8* %0, i8* %5) #13
  ret i32 -25
}

; Function Attrs: nounwind
define weak i32 @halide_error_bad_extern_fold(i8*, i8*, i32, i32, i32, i32, i32) local_unnamed_addr #0 {
  %8 = icmp slt i32 %3, %5
  br i1 %8, label %13, label %9

; <label>:9:                                      ; preds = %7
  %10 = add nsw i32 %4, %3
  %11 = add nsw i32 %6, %5
  %12 = icmp sgt i32 %10, %11
  br i1 %12, label %13, label %56

; <label>:13:                                     ; preds = %9, %7
  %14 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %15 = ptrtoint i8* %14 to i64
  %16 = icmp eq i8* %14, null
  br i1 %16, label %19, label %17

; <label>:17:                                     ; preds = %13
  %18 = getelementptr inbounds i8, i8* %14, i64 1023
  store i8 0, i8* %18, align 1, !tbaa !7
  br label %19

; <label>:19:                                     ; preds = %17, %13
  %20 = phi i8* [ %18, %17 ], [ null, %13 ]
  %21 = tail call i8* @halide_string_to_string(i8* %14, i8* %20, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str.53, i64 0, i64 0)) #13
  %22 = sext i32 %2 to i64
  %23 = tail call i8* @halide_int64_to_string(i8* %21, i8* %20, i64 %22, i32 1) #13
  %24 = tail call i8* @halide_string_to_string(i8* %23, i8* %20, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.51.152, i64 0, i64 0)) #13
  %25 = icmp eq i8* %1, null
  br i1 %25, label %26, label %28

; <label>:26:                                     ; preds = %19
  %27 = tail call i8* @halide_string_to_string(i8* %24, i8* %20, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %30

; <label>:28:                                     ; preds = %19
  %29 = tail call i8* @halide_string_to_string(i8* %24, i8* %20, i8* nonnull %1) #13
  br label %30

; <label>:30:                                     ; preds = %28, %26
  %31 = phi i8* [ %29, %28 ], [ %27, %26 ]
  %32 = tail call i8* @halide_string_to_string(i8* %31, i8* %20, i8* nonnull getelementptr inbounds ([36 x i8], [36 x i8]* @.str.54, i64 0, i64 0)) #13
  %33 = sext i32 %3 to i64
  %34 = tail call i8* @halide_int64_to_string(i8* %32, i8* %20, i64 %33, i32 1) #13
  %35 = tail call i8* @halide_string_to_string(i8* %34, i8* %20, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.55.154, i64 0, i64 0)) #13
  %36 = add nsw i32 %4, %3
  %37 = add nsw i32 %36, -1
  %38 = sext i32 %37 to i64
  %39 = tail call i8* @halide_int64_to_string(i8* %35, i8* %20, i64 %38, i32 1) #13
  %40 = tail call i8* @halide_string_to_string(i8* %39, i8* %20, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.56, i64 0, i64 0)) #13
  %41 = tail call i8* @halide_string_to_string(i8* %40, i8* %20, i8* nonnull getelementptr inbounds ([47 x i8], [47 x i8]* @.str.57.155, i64 0, i64 0)) #13
  %42 = sext i32 %5 to i64
  %43 = tail call i8* @halide_int64_to_string(i8* %41, i8* %20, i64 %42, i32 1) #13
  %44 = tail call i8* @halide_string_to_string(i8* %43, i8* %20, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.55.154, i64 0, i64 0)) #13
  %45 = add nsw i32 %6, %5
  %46 = add nsw i32 %45, -1
  %47 = sext i32 %46 to i64
  %48 = tail call i8* @halide_int64_to_string(i8* %44, i8* %20, i64 %47, i32 1) #13
  %49 = tail call i8* @halide_string_to_string(i8* %48, i8* %20, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.58, i64 0, i64 0)) #13
  br i1 %16, label %50, label %51

; <label>:50:                                     ; preds = %30
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %55

; <label>:51:                                     ; preds = %30
  %52 = ptrtoint i8* %49 to i64
  %53 = sub i64 1, %15
  %54 = add i64 %53, %52
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %14, i64 %54) #13
  tail call void @halide_error(i8* %0, i8* nonnull %14) #13
  br label %55

; <label>:55:                                     ; preds = %51, %50
  tail call void @halide_free(i8* %0, i8* %14) #13
  br label %94

; <label>:56:                                     ; preds = %9
  %57 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %58 = ptrtoint i8* %57 to i64
  %59 = icmp eq i8* %57, null
  br i1 %59, label %62, label %60

; <label>:60:                                     ; preds = %56
  %61 = getelementptr inbounds i8, i8* %57, i64 1023
  store i8 0, i8* %61, align 1, !tbaa !7
  br label %62

; <label>:62:                                     ; preds = %60, %56
  %63 = phi i8* [ %61, %60 ], [ null, %56 ]
  %64 = tail call i8* @halide_string_to_string(i8* %57, i8* %63, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str.53, i64 0, i64 0)) #13
  %65 = sext i32 %2 to i64
  %66 = tail call i8* @halide_int64_to_string(i8* %64, i8* %63, i64 %65, i32 1) #13
  %67 = tail call i8* @halide_string_to_string(i8* %66, i8* %63, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.51.152, i64 0, i64 0)) #13
  %68 = icmp eq i8* %1, null
  br i1 %68, label %69, label %71

; <label>:69:                                     ; preds = %62
  %70 = tail call i8* @halide_string_to_string(i8* %67, i8* %63, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %73

; <label>:71:                                     ; preds = %62
  %72 = tail call i8* @halide_string_to_string(i8* %67, i8* %63, i8* nonnull %1) #13
  br label %73

; <label>:73:                                     ; preds = %71, %69
  %74 = phi i8* [ %72, %71 ], [ %70, %69 ]
  %75 = tail call i8* @halide_string_to_string(i8* %74, i8* %63, i8* nonnull getelementptr inbounds ([36 x i8], [36 x i8]* @.str.54, i64 0, i64 0)) #13
  %76 = sext i32 %3 to i64
  %77 = tail call i8* @halide_int64_to_string(i8* %75, i8* %63, i64 %76, i32 1) #13
  %78 = tail call i8* @halide_string_to_string(i8* %77, i8* %63, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.55.154, i64 0, i64 0)) #13
  %79 = add nsw i32 %10, -1
  %80 = sext i32 %79 to i64
  %81 = tail call i8* @halide_int64_to_string(i8* %78, i8* %63, i64 %80, i32 1) #13
  %82 = tail call i8* @halide_string_to_string(i8* %81, i8* %63, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.56, i64 0, i64 0)) #13
  %83 = tail call i8* @halide_string_to_string(i8* %82, i8* %63, i8* nonnull getelementptr inbounds ([47 x i8], [47 x i8]* @.str.59, i64 0, i64 0)) #13
  %84 = tail call i8* @halide_string_to_string(i8* %83, i8* %63, i8* nonnull getelementptr inbounds ([30 x i8], [30 x i8]* @.str.60, i64 0, i64 0)) #13
  %85 = sext i32 %6 to i64
  %86 = tail call i8* @halide_int64_to_string(i8* %84, i8* %63, i64 %85, i32 1) #13
  %87 = tail call i8* @halide_string_to_string(i8* %86, i8* %63, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30.142, i64 0, i64 0)) #13
  br i1 %59, label %88, label %89

; <label>:88:                                     ; preds = %73
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %93

; <label>:89:                                     ; preds = %73
  %90 = ptrtoint i8* %87 to i64
  %91 = sub i64 1, %58
  %92 = add i64 %91, %90
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %57, i64 %92) #13
  tail call void @halide_error(i8* %0, i8* nonnull %57) #13
  br label %93

; <label>:93:                                     ; preds = %89, %88
  tail call void @halide_free(i8* %0, i8* %57) #13
  br label %94

; <label>:94:                                     ; preds = %93, %55
  ret i32 -35
}

; Function Attrs: nounwind
define weak i32 @halide_error_fold_factor_too_small(i8*, i8*, i8*, i32, i8*, i32) local_unnamed_addr #0 {
  %7 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %8 = ptrtoint i8* %7 to i64
  %9 = icmp eq i8* %7, null
  br i1 %9, label %12, label %10

; <label>:10:                                     ; preds = %6
  %11 = getelementptr inbounds i8, i8* %7, i64 1023
  store i8 0, i8* %11, align 1, !tbaa !7
  br label %12

; <label>:12:                                     ; preds = %10, %6
  %13 = phi i8* [ %11, %10 ], [ null, %6 ]
  %14 = tail call i8* @halide_string_to_string(i8* %7, i8* %13, i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @.str.61, i64 0, i64 0)) #13
  %15 = sext i32 %3 to i64
  %16 = tail call i8* @halide_int64_to_string(i8* %14, i8* %13, i64 %15, i32 1) #13
  %17 = tail call i8* @halide_string_to_string(i8* %16, i8* %13, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.62, i64 0, i64 0)) #13
  %18 = icmp eq i8* %2, null
  br i1 %18, label %19, label %21

; <label>:19:                                     ; preds = %12
  %20 = tail call i8* @halide_string_to_string(i8* %17, i8* %13, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %23

; <label>:21:                                     ; preds = %12
  %22 = tail call i8* @halide_string_to_string(i8* %17, i8* %13, i8* nonnull %2) #13
  br label %23

; <label>:23:                                     ; preds = %21, %19
  %24 = phi i8* [ %22, %21 ], [ %20, %19 ]
  %25 = tail call i8* @halide_string_to_string(i8* %24, i8* %13, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.51.152, i64 0, i64 0)) #13
  %26 = icmp eq i8* %1, null
  br i1 %26, label %27, label %29

; <label>:27:                                     ; preds = %23
  %28 = tail call i8* @halide_string_to_string(i8* %25, i8* %13, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %31

; <label>:29:                                     ; preds = %23
  %30 = tail call i8* @halide_string_to_string(i8* %25, i8* %13, i8* nonnull %1) #13
  br label %31

; <label>:31:                                     ; preds = %29, %27
  %32 = phi i8* [ %30, %29 ], [ %28, %27 ]
  %33 = tail call i8* @halide_string_to_string(i8* %32, i8* %13, i8* nonnull getelementptr inbounds ([61 x i8], [61 x i8]* @.str.63, i64 0, i64 0)) #13
  %34 = icmp eq i8* %4, null
  br i1 %34, label %35, label %37

; <label>:35:                                     ; preds = %31
  %36 = tail call i8* @halide_string_to_string(i8* %33, i8* %13, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %39

; <label>:37:                                     ; preds = %31
  %38 = tail call i8* @halide_string_to_string(i8* %33, i8* %13, i8* nonnull %4) #13
  br label %39

; <label>:39:                                     ; preds = %37, %35
  %40 = phi i8* [ %38, %37 ], [ %36, %35 ]
  %41 = tail call i8* @halide_string_to_string(i8* %40, i8* %13, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.32.144, i64 0, i64 0)) #13
  %42 = sext i32 %5 to i64
  %43 = tail call i8* @halide_int64_to_string(i8* %41, i8* %13, i64 %42, i32 1) #13
  %44 = tail call i8* @halide_string_to_string(i8* %43, i8* %13, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.64, i64 0, i64 0)) #13
  br i1 %9, label %45, label %46

; <label>:45:                                     ; preds = %39
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %50

; <label>:46:                                     ; preds = %39
  %47 = ptrtoint i8* %44 to i64
  %48 = sub i64 1, %8
  %49 = add i64 %48, %47
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %7, i64 %49) #13
  tail call void @halide_error(i8* %0, i8* nonnull %7) #13
  br label %50

; <label>:50:                                     ; preds = %46, %45
  tail call void @halide_free(i8* %0, i8* %7) #13
  ret i32 -26
}

; Function Attrs: nounwind
define weak i32 @halide_error_requirement_failed(i8*, i8*, i8*) local_unnamed_addr #0 {
  %4 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %5 = ptrtoint i8* %4 to i64
  %6 = icmp eq i8* %4, null
  br i1 %6, label %9, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %4, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  br label %9

; <label>:9:                                      ; preds = %7, %3
  %10 = phi i8* [ %8, %7 ], [ null, %3 ]
  %11 = tail call i8* @halide_string_to_string(i8* %4, i8* %10, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.65, i64 0, i64 0)) #13
  %12 = icmp eq i8* %1, null
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %9
  %14 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %17

; <label>:15:                                     ; preds = %9
  %16 = tail call i8* @halide_string_to_string(i8* %11, i8* %10, i8* nonnull %1) #13
  br label %17

; <label>:17:                                     ; preds = %15, %13
  %18 = phi i8* [ %16, %15 ], [ %14, %13 ]
  %19 = tail call i8* @halide_string_to_string(i8* %18, i8* %10, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.66, i64 0, i64 0)) #13
  %20 = icmp eq i8* %2, null
  br i1 %20, label %21, label %23

; <label>:21:                                     ; preds = %17
  %22 = tail call i8* @halide_string_to_string(i8* %19, i8* %10, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %25

; <label>:23:                                     ; preds = %17
  %24 = tail call i8* @halide_string_to_string(i8* %19, i8* %10, i8* nonnull %2) #13
  br label %25

; <label>:25:                                     ; preds = %23, %21
  %26 = phi i8* [ %24, %23 ], [ %22, %21 ]
  br i1 %6, label %27, label %28

; <label>:27:                                     ; preds = %25
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %32

; <label>:28:                                     ; preds = %25
  %29 = ptrtoint i8* %26 to i64
  %30 = sub i64 1, %5
  %31 = add i64 %30, %29
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %31) #13
  tail call void @halide_error(i8* %0, i8* nonnull %4) #13
  br label %32

; <label>:32:                                     ; preds = %28, %27
  tail call void @halide_free(i8* %0, i8* %4) #13
  ret i32 -27
}

; Function Attrs: nounwind
define weak i32 @halide_error_specialize_fail(i8*, i8*) local_unnamed_addr #0 {
  %3 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %4 = ptrtoint i8* %3 to i64
  %5 = icmp eq i8* %3, null
  br i1 %5, label %8, label %6

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds i8, i8* %3, i64 1023
  store i8 0, i8* %7, align 1, !tbaa !7
  br label %8

; <label>:8:                                      ; preds = %6, %2
  %9 = phi i8* [ %7, %6 ], [ null, %2 ]
  %10 = tail call i8* @halide_string_to_string(i8* %3, i8* %9, i8* nonnull getelementptr inbounds ([59 x i8], [59 x i8]* @.str.67, i64 0, i64 0)) #13
  %11 = icmp eq i8* %1, null
  br i1 %11, label %12, label %14

; <label>:12:                                     ; preds = %8
  %13 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %16

; <label>:14:                                     ; preds = %8
  %15 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* nonnull %1) #13
  br label %16

; <label>:16:                                     ; preds = %14, %12
  %17 = phi i8* [ %15, %14 ], [ %13, %12 ]
  br i1 %5, label %18, label %19

; <label>:18:                                     ; preds = %16
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %23

; <label>:19:                                     ; preds = %16
  %20 = ptrtoint i8* %17 to i64
  %21 = sub i64 1, %4
  %22 = add i64 %21, %20
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %3, i64 %22) #13
  tail call void @halide_error(i8* %0, i8* nonnull %3) #13
  br label %23

; <label>:23:                                     ; preds = %19, %18
  tail call void @halide_free(i8* %0, i8* %3) #13
  ret i32 -31
}

; Function Attrs: nounwind
define weak i32 @halide_error_no_device_interface(i8*) local_unnamed_addr #0 {
  %2 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %3 = icmp eq i8* %2, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %1
  %5 = tail call i8* @halide_string_to_string(i8* null, i8* null, i8* nonnull getelementptr inbounds ([55 x i8], [55 x i8]* @.str.68, i64 0, i64 0)) #13
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %13

; <label>:6:                                      ; preds = %1
  %7 = ptrtoint i8* %2 to i64
  %8 = getelementptr inbounds i8, i8* %2, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  %9 = tail call i8* @halide_string_to_string(i8* nonnull %2, i8* nonnull %8, i8* nonnull getelementptr inbounds ([55 x i8], [55 x i8]* @.str.68, i64 0, i64 0)) #13
  %10 = ptrtoint i8* %9 to i64
  %11 = sub i64 1, %7
  %12 = add i64 %11, %10
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %2, i64 %12) #13
  tail call void @halide_error(i8* %0, i8* nonnull %2) #13
  br label %13

; <label>:13:                                     ; preds = %6, %4
  tail call void @halide_free(i8* %0, i8* %2) #13
  ret i32 -19
}

; Function Attrs: nounwind
define weak i32 @halide_error_device_interface_no_device(i8*) local_unnamed_addr #0 {
  %2 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %3 = icmp eq i8* %2, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %1
  %5 = tail call i8* @halide_string_to_string(i8* null, i8* null, i8* nonnull getelementptr inbounds ([56 x i8], [56 x i8]* @.str.69, i64 0, i64 0)) #13
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %13

; <label>:6:                                      ; preds = %1
  %7 = ptrtoint i8* %2 to i64
  %8 = getelementptr inbounds i8, i8* %2, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  %9 = tail call i8* @halide_string_to_string(i8* nonnull %2, i8* nonnull %8, i8* nonnull getelementptr inbounds ([56 x i8], [56 x i8]* @.str.69, i64 0, i64 0)) #13
  %10 = ptrtoint i8* %9 to i64
  %11 = sub i64 1, %7
  %12 = add i64 %11, %10
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %2, i64 %12) #13
  tail call void @halide_error(i8* %0, i8* nonnull %2) #13
  br label %13

; <label>:13:                                     ; preds = %6, %4
  tail call void @halide_free(i8* %0, i8* %2) #13
  ret i32 -36
}

; Function Attrs: nounwind
define weak i32 @halide_error_host_and_device_dirty(i8*) local_unnamed_addr #0 {
  %2 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %3 = icmp eq i8* %2, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %1
  %5 = tail call i8* @halide_string_to_string(i8* null, i8* null, i8* nonnull getelementptr inbounds ([49 x i8], [49 x i8]* @.str.70, i64 0, i64 0)) #13
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %13

; <label>:6:                                      ; preds = %1
  %7 = ptrtoint i8* %2 to i64
  %8 = getelementptr inbounds i8, i8* %2, i64 1023
  store i8 0, i8* %8, align 1, !tbaa !7
  %9 = tail call i8* @halide_string_to_string(i8* nonnull %2, i8* nonnull %8, i8* nonnull getelementptr inbounds ([49 x i8], [49 x i8]* @.str.70, i64 0, i64 0)) #13
  %10 = ptrtoint i8* %9 to i64
  %11 = sub i64 1, %7
  %12 = add i64 %11, %10
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %2, i64 %12) #13
  tail call void @halide_error(i8* %0, i8* nonnull %2) #13
  br label %13

; <label>:13:                                     ; preds = %6, %4
  tail call void @halide_free(i8* %0, i8* %2) #13
  ret i32 -37
}

; Function Attrs: nounwind
define weak i32 @halide_error_buffer_is_null(i8*, i8*) local_unnamed_addr #0 {
  %3 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %4 = ptrtoint i8* %3 to i64
  %5 = icmp eq i8* %3, null
  br i1 %5, label %8, label %6

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds i8, i8* %3, i64 1023
  store i8 0, i8* %7, align 1, !tbaa !7
  br label %8

; <label>:8:                                      ; preds = %6, %2
  %9 = phi i8* [ %7, %6 ], [ null, %2 ]
  %10 = tail call i8* @halide_string_to_string(i8* %3, i8* %9, i8* nonnull getelementptr inbounds ([26 x i8], [26 x i8]* @.str.71, i64 0, i64 0)) #13
  %11 = icmp eq i8* %1, null
  br i1 %11, label %12, label %14

; <label>:12:                                     ; preds = %8
  %13 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.74, i64 0, i64 0)) #13
  br label %16

; <label>:14:                                     ; preds = %8
  %15 = tail call i8* @halide_string_to_string(i8* %10, i8* %9, i8* nonnull %1) #13
  br label %16

; <label>:16:                                     ; preds = %14, %12
  %17 = phi i8* [ %15, %14 ], [ %13, %12 ]
  %18 = tail call i8* @halide_string_to_string(i8* %17, i8* %9, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.72, i64 0, i64 0)) #13
  br i1 %5, label %19, label %20

; <label>:19:                                     ; preds = %16
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.73, i64 0, i64 0)) #13
  br label %24

; <label>:20:                                     ; preds = %16
  %21 = ptrtoint i8* %18 to i64
  %22 = sub i64 1, %4
  %23 = add i64 %22, %21
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %3, i64 %23) #13
  tail call void @halide_error(i8* %0, i8* nonnull %3) #13
  br label %24

; <label>:24:                                     ; preds = %20, %19
  tail call void @halide_free(i8* %0, i8* %3) #13
  ret i32 -38
}

; Function Attrs: nounwind
define linkonce i32 @_ZN6Halide7Runtime8Internal29guess_type_and_dimensionalityEPvP8buffer_tP15halide_buffer_t(i8*, %struct.buffer_t*, %struct.halide_buffer_t*) local_unnamed_addr #0 {
  %4 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 5
  store i32 4, i32* %4, align 4, !tbaa !79
  %5 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %1, i64 0, i32 2, i64 0
  %6 = load i32, i32* %5, align 4, !tbaa !96
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %10

; <label>:8:                                      ; preds = %37, %33, %10, %3
  %9 = phi i32 [ 0, %3 ], [ 1, %10 ], [ 2, %33 ], [ 3, %37 ]
  store i32 %9, i32* %4, align 4, !tbaa !79
  br label %14

; <label>:10:                                     ; preds = %3
  %11 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %1, i64 0, i32 2, i64 1
  %12 = load i32, i32* %11, align 4, !tbaa !96
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %8, label %33

; <label>:14:                                     ; preds = %37, %8
  %15 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %1, i64 0, i32 5
  %16 = load i32, i32* %15, align 8, !tbaa !189
  switch i32 %16, label %29 [
    i32 1, label %17
    i32 2, label %20
    i32 4, label %23
    i32 8, label %26
  ]

; <label>:17:                                     ; preds = %14
  %18 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4, i32 0
  %19 = bitcast i8* %18 to i32*
  store i32 67585, i32* %19, align 8
  br label %31

; <label>:20:                                     ; preds = %14
  %21 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4, i32 0
  %22 = bitcast i8* %21 to i32*
  store i32 69633, i32* %22, align 8
  br label %31

; <label>:23:                                     ; preds = %14
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4, i32 0
  %25 = bitcast i8* %24 to i32*
  store i32 73729, i32* %25, align 8
  br label %31

; <label>:26:                                     ; preds = %14
  %27 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4, i32 0
  %28 = bitcast i8* %27 to i32*
  store i32 81921, i32* %28, align 8
  br label %31

; <label>:29:                                     ; preds = %14
  %30 = tail call i32 @halide_error_failed_to_upgrade_buffer_t(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.1.165, i64 0, i64 0)) #13
  br label %31

; <label>:31:                                     ; preds = %29, %26, %23, %20, %17
  %32 = phi i32 [ %30, %29 ], [ 0, %26 ], [ 0, %23 ], [ 0, %20 ], [ 0, %17 ]
  ret i32 %32

; <label>:33:                                     ; preds = %10
  %34 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %1, i64 0, i32 2, i64 2
  %35 = load i32, i32* %34, align 4, !tbaa !96
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %8, label %37

; <label>:37:                                     ; preds = %33
  %38 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %1, i64 0, i32 2, i64 3
  %39 = load i32, i32* %38, align 4, !tbaa !96
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %8, label %14
}

; Function Attrs: nounwind
define weak i32 @halide_upgrade_buffer_t(i8*, i8*, %struct.buffer_t*, %struct.halide_buffer_t*, i32) local_unnamed_addr #0 {
  %6 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 1
  %7 = load i8*, i8** %6, align 8, !tbaa !191
  %8 = icmp eq i8* %7, null
  %9 = ptrtoint i8* %7 to i64
  br i1 %8, label %10, label %17

; <label>:10:                                     ; preds = %5
  %11 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !192
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %17

; <label>:14:                                     ; preds = %10
  %15 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 2
  %16 = bitcast i8** %15 to i64*
  store i64 %9, i64* %16, align 8, !tbaa !83
  br label %75

; <label>:17:                                     ; preds = %10, %5
  %18 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 5
  %19 = load i32, i32* %18, align 8, !tbaa !189
  %20 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4
  %21 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  %22 = load i8, i8* %21, align 1, !tbaa !99
  %23 = zext i8 %22 to i32
  %24 = add nuw nsw i32 %23, 7
  %25 = lshr i32 %24, 3
  %26 = icmp eq i32 %19, %25
  br i1 %26, label %52, label %27

; <label>:27:                                     ; preds = %17
  %28 = tail call i8* @halide_malloc(i8* %0, i64 1024) #13
  %29 = ptrtoint i8* %28 to i64
  %30 = icmp eq i8* %28, null
  br i1 %30, label %33, label %31

; <label>:31:                                     ; preds = %27
  %32 = getelementptr inbounds i8, i8* %28, i64 1023
  store i8 0, i8* %32, align 1, !tbaa !7
  br label %33

; <label>:33:                                     ; preds = %31, %27
  %34 = phi i8* [ %32, %31 ], [ null, %27 ]
  %35 = tail call i8* @halide_string_to_string(i8* %28, i8* %34, i8* nonnull getelementptr inbounds ([33 x i8], [33 x i8]* @.str.2.166, i64 0, i64 0)) #13
  %36 = load i32, i32* %18, align 8, !tbaa !189
  %37 = sext i32 %36 to i64
  %38 = tail call i8* @halide_int64_to_string(i8* %35, i8* %34, i64 %37, i32 1) #13
  %39 = tail call i8* @halide_string_to_string(i8* %38, i8* %34, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3.167, i64 0, i64 0)) #13
  %40 = tail call i8* @halide_string_to_string(i8* %39, i8* %34, i8* nonnull getelementptr inbounds ([20 x i8], [20 x i8]* @.str.4.168, i64 0, i64 0)) #13
  %41 = tail call i8* @halide_type_to_string(i8* %40, i8* %34, %struct.halide_type_t* nonnull %20) #13
  %42 = tail call i8* @halide_string_to_string(i8* %41, i8* %34, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5.169, i64 0, i64 0)) #13
  br i1 %30, label %43, label %45

; <label>:43:                                     ; preds = %33
  %44 = tail call i32 @halide_error_failed_to_upgrade_buffer_t(i8* %0, i8* %1, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.8.170, i64 0, i64 0)) #13
  tail call void @halide_error(i8* %0, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.8.170, i64 0, i64 0)) #13
  br label %50

; <label>:45:                                     ; preds = %33
  %46 = ptrtoint i8* %42 to i64
  %47 = sub i64 1, %29
  %48 = add i64 %47, %46
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %28, i64 %48) #13
  %49 = tail call i32 @halide_error_failed_to_upgrade_buffer_t(i8* %0, i8* %1, i8* nonnull %28) #13
  tail call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %28, i64 %48) #13
  br label %50

; <label>:50:                                     ; preds = %45, %43
  %51 = phi i32 [ %49, %45 ], [ %44, %43 ]
  tail call void @halide_free(i8* %0, i8* %28) #13
  br label %110

; <label>:52:                                     ; preds = %17
  %53 = icmp eq i32 %4, 0
  br i1 %53, label %60, label %54

; <label>:54:                                     ; preds = %52
  %55 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 2
  %56 = load i8*, i8** %55, align 8, !tbaa !83
  %57 = icmp eq i8* %56, %7
  br i1 %57, label %110, label %58

; <label>:58:                                     ; preds = %54
  %59 = tail call i32 @halide_error_failed_to_upgrade_buffer_t(i8* %0, i8* %1, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.6.171, i64 0, i64 0)) #13
  br label %110

; <label>:60:                                     ; preds = %52
  %61 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 0
  %62 = load i64, i64* %61, align 8, !tbaa !192
  %63 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 2
  %64 = bitcast i8** %63 to i64*
  store i64 %9, i64* %64, align 8, !tbaa !83
  %65 = icmp eq i64 %62, 0
  br i1 %65, label %75, label %66

; <label>:66:                                     ; preds = %60
  %67 = inttoptr i64 %62 to %"struct.Halide::Runtime::Internal::old_dev_wrapper"*
  %68 = getelementptr inbounds %"struct.Halide::Runtime::Internal::old_dev_wrapper", %"struct.Halide::Runtime::Internal::old_dev_wrapper"* %67, i64 0, i32 0
  %69 = load i64, i64* %68, align 8, !tbaa !193
  %70 = getelementptr inbounds %"struct.Halide::Runtime::Internal::old_dev_wrapper", %"struct.Halide::Runtime::Internal::old_dev_wrapper"* %67, i64 0, i32 1
  %71 = bitcast %struct.halide_device_interface_t** %70 to i64*
  %72 = load i64, i64* %71, align 8, !tbaa !195
  %73 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  %74 = bitcast %struct.halide_device_interface_t** %73 to i64*
  store i64 %72, i64* %74, align 8, !tbaa !85
  br label %77

; <label>:75:                                     ; preds = %60, %14
  %76 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  store %struct.halide_device_interface_t* null, %struct.halide_device_interface_t** %76, align 8, !tbaa !85
  br label %77

; <label>:77:                                     ; preds = %75, %66
  %78 = phi i64 [ 0, %75 ], [ %69, %66 ]
  %79 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 0
  store i64 %78, i64* %79, align 8
  %80 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 5
  %81 = load i32, i32* %80, align 4, !tbaa !79
  %82 = icmp sgt i32 %81, 0
  br i1 %82, label %83, label %87

; <label>:83:                                     ; preds = %77
  %84 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  %85 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %84, align 8, !tbaa !86
  %86 = sext i32 %81 to i64
  br label %97

; <label>:87:                                     ; preds = %97, %77
  %88 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 3
  %89 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 6
  %90 = load i8, i8* %89, align 4, !tbaa !196, !range !10
  %91 = zext i8 %90 to i64
  %92 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 7
  %93 = load i8, i8* %92, align 1, !tbaa !197, !range !10
  %94 = icmp eq i8 %93, 0
  %95 = or i64 %91, 2
  %96 = select i1 %94, i64 %91, i64 %95
  store i64 %96, i64* %88, align 8, !tbaa !91
  br label %110

; <label>:97:                                     ; preds = %97, %83
  %98 = phi i64 [ 0, %83 ], [ %108, %97 ]
  %99 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 4, i64 %98
  %100 = load i32, i32* %99, align 4, !tbaa !96
  %101 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %85, i64 %98, i32 0
  store i32 %100, i32* %101, align 4, !tbaa !87
  %102 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 2, i64 %98
  %103 = load i32, i32* %102, align 4, !tbaa !96
  %104 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %85, i64 %98, i32 1
  store i32 %103, i32* %104, align 4, !tbaa !89
  %105 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %2, i64 0, i32 3, i64 %98
  %106 = load i32, i32* %105, align 4, !tbaa !96
  %107 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %85, i64 %98, i32 2
  store i32 %106, i32* %107, align 4, !tbaa !90
  %108 = add nuw nsw i64 %98, 1
  %109 = icmp slt i64 %108, %86
  br i1 %109, label %97, label %87

; <label>:110:                                    ; preds = %87, %58, %54, %50
  %111 = phi i32 [ %51, %50 ], [ %59, %58 ], [ 0, %87 ], [ 0, %54 ]
  ret i32 %111
}

; Function Attrs: nounwind
define weak i32 @halide_downgrade_buffer_t(i8*, i8*, %struct.halide_buffer_t*, %struct.buffer_t*) local_unnamed_addr #0 {
  %5 = bitcast %struct.buffer_t* %3 to i8*
  %6 = tail call i8* @memset(i8* %5, i32 0, i64 72) #13
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 5
  %8 = load i32, i32* %7, align 4, !tbaa !79
  %9 = icmp sgt i32 %8, 4
  br i1 %9, label %10, label %12

; <label>:10:                                     ; preds = %4
  %11 = tail call i32 @halide_error_failed_to_downgrade_buffer_t(i8* %0, i8* %1, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.7.172, i64 0, i64 0)) #13
  br label %45

; <label>:12:                                     ; preds = %4
  %13 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 2
  %14 = bitcast i8** %13 to i64*
  %15 = load i64, i64* %14, align 8, !tbaa !83
  %16 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 1
  %17 = bitcast i8** %16 to i64*
  store i64 %15, i64* %17, align 8, !tbaa !191
  %18 = icmp sgt i32 %8, 0
  br i1 %18, label %19, label %22

; <label>:19:                                     ; preds = %12
  %20 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 6
  %21 = load %struct.halide_dimension_t*, %struct.halide_dimension_t** %20, align 8, !tbaa !86
  br label %30

; <label>:22:                                     ; preds = %30, %12
  %23 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 4, i32 1
  %24 = load i8, i8* %23, align 1, !tbaa !99
  %25 = zext i8 %24 to i32
  %26 = add nuw nsw i32 %25, 7
  %27 = lshr i32 %26, 3
  %28 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 5
  store i32 %27, i32* %28, align 8, !tbaa !189
  %29 = tail call i32 @halide_downgrade_buffer_t_device_fields(i8* %0, i8* %1, %struct.halide_buffer_t* nonnull %2, %struct.buffer_t* nonnull %3) #15
  br label %45

; <label>:30:                                     ; preds = %30, %19
  %31 = phi i64 [ 0, %19 ], [ %41, %30 ]
  %32 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %21, i64 %31, i32 0
  %33 = load i32, i32* %32, align 4, !tbaa !87
  %34 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 4, i64 %31
  store i32 %33, i32* %34, align 4, !tbaa !96
  %35 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %21, i64 %31, i32 1
  %36 = load i32, i32* %35, align 4, !tbaa !89
  %37 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 2, i64 %31
  store i32 %36, i32* %37, align 4, !tbaa !96
  %38 = getelementptr inbounds %struct.halide_dimension_t, %struct.halide_dimension_t* %21, i64 %31, i32 2
  %39 = load i32, i32* %38, align 4, !tbaa !90
  %40 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 3, i64 %31
  store i32 %39, i32* %40, align 4, !tbaa !96
  %41 = add nuw nsw i64 %31, 1
  %42 = load i32, i32* %7, align 4, !tbaa !79
  %43 = sext i32 %42 to i64
  %44 = icmp slt i64 %41, %43
  br i1 %44, label %30, label %22

; <label>:45:                                     ; preds = %22, %10
  %46 = phi i32 [ %11, %10 ], [ %29, %22 ]
  ret i32 %46
}

; Function Attrs: nounwind
define weak i32 @halide_downgrade_buffer_t_device_fields(i8*, i8*, %struct.halide_buffer_t*, %struct.buffer_t*) local_unnamed_addr #0 {
  %5 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 3
  %6 = load i64, i64* %5, align 8, !tbaa !91
  %7 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 6
  %8 = trunc i64 %6 to i8
  %9 = and i8 %8, 1
  store i8 %9, i8* %7, align 4, !tbaa !196
  %10 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 7
  %11 = lshr i64 %6, 1
  %12 = trunc i64 %11 to i8
  %13 = and i8 %12, 1
  store i8 %13, i8* %10, align 1, !tbaa !197
  %14 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !84
  %16 = icmp eq i64 %15, 0
  %17 = getelementptr inbounds %struct.buffer_t, %struct.buffer_t* %3, i64 0, i32 0
  %18 = load i64, i64* %17, align 8, !tbaa !192
  %19 = icmp ne i64 %18, 0
  br i1 %16, label %39, label %20

; <label>:20:                                     ; preds = %4
  br i1 %19, label %21, label %29

; <label>:21:                                     ; preds = %20
  %22 = inttoptr i64 %18 to %"struct.Halide::Runtime::Internal::old_dev_wrapper"*
  %23 = getelementptr inbounds %"struct.Halide::Runtime::Internal::old_dev_wrapper", %"struct.Halide::Runtime::Internal::old_dev_wrapper"* %22, i64 0, i32 0
  store i64 %15, i64* %23, align 8, !tbaa !193
  %24 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 1
  %25 = bitcast %struct.halide_device_interface_t** %24 to i64*
  %26 = load i64, i64* %25, align 8, !tbaa !85
  %27 = getelementptr inbounds %"struct.Halide::Runtime::Internal::old_dev_wrapper", %"struct.Halide::Runtime::Internal::old_dev_wrapper"* %22, i64 0, i32 1
  %28 = bitcast %struct.halide_device_interface_t** %27 to i64*
  store i64 %26, i64* %28, align 8, !tbaa !195
  br label %42

; <label>:29:                                     ; preds = %20
  %30 = tail call i8* @malloc(i64 16) #13
  %31 = load i64, i64* %14, align 8, !tbaa !84
  %32 = bitcast i8* %30 to i64*
  store i64 %31, i64* %32, align 8, !tbaa !193
  %33 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %2, i64 0, i32 1
  %34 = bitcast %struct.halide_device_interface_t** %33 to i64*
  %35 = load i64, i64* %34, align 8, !tbaa !85
  %36 = getelementptr inbounds i8, i8* %30, i64 8
  %37 = bitcast i8* %36 to i64*
  store i64 %35, i64* %37, align 8, !tbaa !195
  %38 = ptrtoint i8* %30 to i64
  store i64 %38, i64* %17, align 8, !tbaa !192
  br label %42

; <label>:39:                                     ; preds = %4
  br i1 %19, label %40, label %42

; <label>:40:                                     ; preds = %39
  %41 = inttoptr i64 %18 to i8*
  tail call void @free(i8* %41) #13
  store i64 0, i64* %17, align 8, !tbaa !192
  br label %42

; <label>:42:                                     ; preds = %40, %39, %29, %21
  ret i32 0
}

; Function Attrs: nounwind
define weak i32 @halide_copy_to_host_legacy(i8*, %struct.buffer_t*) local_unnamed_addr #0 {
  %3 = alloca %struct.halide_buffer_t, align 8
  %4 = alloca [4 x %struct.halide_dimension_t], align 4
  %5 = bitcast %struct.halide_buffer_t* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %5) #14
  %6 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  %7 = bitcast %struct.halide_device_interface_t** %6 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %7, i8 0, i64 48, i1 false)
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 0
  store i64 0, i64* %8, align 8, !tbaa !84
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 0
  store i8 0, i8* %9, align 8, !tbaa !168
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  store i8 0, i8* %10, align 1, !tbaa !99
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 2
  store i16 0, i16* %11, align 2, !tbaa !169
  %12 = bitcast [4 x %struct.halide_dimension_t]* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %12) #14
  %13 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0
  %14 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 0
  store i32 0, i32* %14, align 4, !tbaa !87
  %15 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 1
  store i32 0, i32* %15, align 4, !tbaa !89
  %16 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 2
  store i32 0, i32* %16, align 4, !tbaa !90
  %17 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 3
  store i32 0, i32* %17, align 4, !tbaa !135
  %18 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 0
  store i32 0, i32* %18, align 4, !tbaa !87
  %19 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 1
  store i32 0, i32* %19, align 4, !tbaa !89
  %20 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 2
  store i32 0, i32* %20, align 4, !tbaa !90
  %21 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 3
  store i32 0, i32* %21, align 4, !tbaa !135
  %22 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 0
  store i32 0, i32* %22, align 4, !tbaa !87
  %23 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 1
  store i32 0, i32* %23, align 4, !tbaa !89
  %24 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 2
  store i32 0, i32* %24, align 4, !tbaa !90
  %25 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 3
  store i32 0, i32* %25, align 4, !tbaa !135
  %26 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 0
  store i32 0, i32* %26, align 4, !tbaa !87
  %27 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 1
  store i32 0, i32* %27, align 4, !tbaa !89
  %28 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 2
  store i32 0, i32* %28, align 4, !tbaa !90
  %29 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 3
  store i32 0, i32* %29, align 4, !tbaa !135
  %30 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  store %struct.halide_dimension_t* %13, %struct.halide_dimension_t** %30, align 8, !tbaa !86
  %31 = call i32 @_ZN6Halide7Runtime8Internal29guess_type_and_dimensionalityEPvP8buffer_tP15halide_buffer_t(i8* %0, %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %3) #15
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %43

; <label>:33:                                     ; preds = %2
  %34 = call i32 @halide_upgrade_buffer_t(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %3, i32 0) #15
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %43

; <label>:36:                                     ; preds = %33
  %37 = call i32 @halide_copy_to_host(i8* %0, %struct.halide_buffer_t* nonnull %3) #13
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %39, label %43

; <label>:39:                                     ; preds = %36
  %40 = call i32 @halide_downgrade_buffer_t_device_fields(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.halide_buffer_t* nonnull %3, %struct.buffer_t* %1) #15
  %41 = icmp ne i32 %40, 0
  %42 = zext i1 %41 to i32
  br label %43

; <label>:43:                                     ; preds = %39, %36, %33, %2
  %44 = phi i32 [ 1, %36 ], [ %42, %39 ], [ 1, %33 ], [ 1, %2 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %12) #14
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %5) #14
  ret i32 %44
}

; Function Attrs: nounwind
define weak i32 @halide_copy_to_device_legacy(i8*, %struct.buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = alloca %struct.halide_buffer_t, align 8
  %5 = alloca [4 x %struct.halide_dimension_t], align 4
  %6 = bitcast %struct.halide_buffer_t* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %6) #14
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 1
  %8 = bitcast %struct.halide_device_interface_t** %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %8, i8 0, i64 48, i1 false)
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 0
  store i64 0, i64* %9, align 8, !tbaa !84
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 4, i32 0
  store i8 0, i8* %10, align 8, !tbaa !168
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 4, i32 1
  store i8 0, i8* %11, align 1, !tbaa !99
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 4, i32 2
  store i16 0, i16* %12, align 2, !tbaa !169
  %13 = bitcast [4 x %struct.halide_dimension_t]* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %13) #14
  %14 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0
  %15 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 0
  store i32 0, i32* %15, align 4, !tbaa !87
  %16 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  store i32 0, i32* %16, align 4, !tbaa !89
  %17 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 2
  store i32 0, i32* %17, align 4, !tbaa !90
  %18 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 3
  store i32 0, i32* %18, align 4, !tbaa !135
  %19 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 0
  store i32 0, i32* %19, align 4, !tbaa !87
  %20 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  store i32 0, i32* %20, align 4, !tbaa !89
  %21 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 2
  store i32 0, i32* %21, align 4, !tbaa !90
  %22 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 3
  store i32 0, i32* %22, align 4, !tbaa !135
  %23 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 0
  store i32 0, i32* %23, align 4, !tbaa !87
  %24 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  store i32 0, i32* %24, align 4, !tbaa !89
  %25 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 2
  store i32 0, i32* %25, align 4, !tbaa !90
  %26 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 3
  store i32 0, i32* %26, align 4, !tbaa !135
  %27 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 0
  store i32 0, i32* %27, align 4, !tbaa !87
  %28 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  store i32 0, i32* %28, align 4, !tbaa !89
  %29 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 2
  store i32 0, i32* %29, align 4, !tbaa !90
  %30 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 3
  store i32 0, i32* %30, align 4, !tbaa !135
  %31 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 6
  store %struct.halide_dimension_t* %14, %struct.halide_dimension_t** %31, align 8, !tbaa !86
  %32 = call i32 @_ZN6Halide7Runtime8Internal29guess_type_and_dimensionalityEPvP8buffer_tP15halide_buffer_t(i8* %0, %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %4) #15
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %44

; <label>:34:                                     ; preds = %3
  %35 = call i32 @halide_upgrade_buffer_t(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %4, i32 0) #15
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %44

; <label>:37:                                     ; preds = %34
  %38 = call i32 @halide_copy_to_device(i8* %0, %struct.halide_buffer_t* nonnull %4, %struct.halide_device_interface_t* %2) #13
  %39 = icmp eq i32 %38, 0
  br i1 %39, label %40, label %44

; <label>:40:                                     ; preds = %37
  %41 = call i32 @halide_downgrade_buffer_t_device_fields(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.halide_buffer_t* nonnull %4, %struct.buffer_t* %1) #15
  %42 = icmp ne i32 %41, 0
  %43 = zext i1 %42 to i32
  br label %44

; <label>:44:                                     ; preds = %40, %37, %34, %3
  %45 = phi i32 [ 1, %37 ], [ %43, %40 ], [ 1, %34 ], [ 1, %3 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %13) #14
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %6) #14
  ret i32 %45
}

; Function Attrs: nounwind
define weak i32 @halide_device_sync_legacy(i8*, %struct.buffer_t*) local_unnamed_addr #0 {
  %3 = alloca %struct.halide_buffer_t, align 8
  %4 = alloca [4 x %struct.halide_dimension_t], align 4
  %5 = bitcast %struct.halide_buffer_t* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %5) #14
  %6 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  %7 = bitcast %struct.halide_device_interface_t** %6 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %7, i8 0, i64 48, i1 false)
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 0
  store i64 0, i64* %8, align 8, !tbaa !84
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 0
  store i8 0, i8* %9, align 8, !tbaa !168
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  store i8 0, i8* %10, align 1, !tbaa !99
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 2
  store i16 0, i16* %11, align 2, !tbaa !169
  %12 = bitcast [4 x %struct.halide_dimension_t]* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %12) #14
  %13 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0
  %14 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 0
  store i32 0, i32* %14, align 4, !tbaa !87
  %15 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 1
  store i32 0, i32* %15, align 4, !tbaa !89
  %16 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 2
  store i32 0, i32* %16, align 4, !tbaa !90
  %17 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 3
  store i32 0, i32* %17, align 4, !tbaa !135
  %18 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 0
  store i32 0, i32* %18, align 4, !tbaa !87
  %19 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 1
  store i32 0, i32* %19, align 4, !tbaa !89
  %20 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 2
  store i32 0, i32* %20, align 4, !tbaa !90
  %21 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 3
  store i32 0, i32* %21, align 4, !tbaa !135
  %22 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 0
  store i32 0, i32* %22, align 4, !tbaa !87
  %23 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 1
  store i32 0, i32* %23, align 4, !tbaa !89
  %24 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 2
  store i32 0, i32* %24, align 4, !tbaa !90
  %25 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 3
  store i32 0, i32* %25, align 4, !tbaa !135
  %26 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 0
  store i32 0, i32* %26, align 4, !tbaa !87
  %27 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 1
  store i32 0, i32* %27, align 4, !tbaa !89
  %28 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 2
  store i32 0, i32* %28, align 4, !tbaa !90
  %29 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 3
  store i32 0, i32* %29, align 4, !tbaa !135
  %30 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  store %struct.halide_dimension_t* %13, %struct.halide_dimension_t** %30, align 8, !tbaa !86
  %31 = call i32 @_ZN6Halide7Runtime8Internal29guess_type_and_dimensionalityEPvP8buffer_tP15halide_buffer_t(i8* %0, %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %3) #15
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %43

; <label>:33:                                     ; preds = %2
  %34 = call i32 @halide_upgrade_buffer_t(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %3, i32 0) #15
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %43

; <label>:36:                                     ; preds = %33
  %37 = call i32 @halide_device_sync(i8* %0, %struct.halide_buffer_t* nonnull %3) #13
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %39, label %43

; <label>:39:                                     ; preds = %36
  %40 = call i32 @halide_downgrade_buffer_t_device_fields(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.halide_buffer_t* nonnull %3, %struct.buffer_t* %1) #15
  %41 = icmp ne i32 %40, 0
  %42 = zext i1 %41 to i32
  br label %43

; <label>:43:                                     ; preds = %39, %36, %33, %2
  %44 = phi i32 [ 1, %36 ], [ %42, %39 ], [ 1, %33 ], [ 1, %2 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %12) #14
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %5) #14
  ret i32 %44
}

; Function Attrs: nounwind
define weak i32 @halide_device_malloc_legacy(i8*, %struct.buffer_t*, %struct.halide_device_interface_t*) local_unnamed_addr #0 {
  %4 = alloca %struct.halide_buffer_t, align 8
  %5 = alloca [4 x %struct.halide_dimension_t], align 4
  %6 = bitcast %struct.halide_buffer_t* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %6) #14
  %7 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 1
  %8 = bitcast %struct.halide_device_interface_t** %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %8, i8 0, i64 48, i1 false)
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 0
  store i64 0, i64* %9, align 8, !tbaa !84
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 4, i32 0
  store i8 0, i8* %10, align 8, !tbaa !168
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 4, i32 1
  store i8 0, i8* %11, align 1, !tbaa !99
  %12 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 4, i32 2
  store i16 0, i16* %12, align 2, !tbaa !169
  %13 = bitcast [4 x %struct.halide_dimension_t]* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %13) #14
  %14 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0
  %15 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 0
  store i32 0, i32* %15, align 4, !tbaa !87
  %16 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 1
  store i32 0, i32* %16, align 4, !tbaa !89
  %17 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 2
  store i32 0, i32* %17, align 4, !tbaa !90
  %18 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 0, i32 3
  store i32 0, i32* %18, align 4, !tbaa !135
  %19 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 0
  store i32 0, i32* %19, align 4, !tbaa !87
  %20 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 1
  store i32 0, i32* %20, align 4, !tbaa !89
  %21 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 2
  store i32 0, i32* %21, align 4, !tbaa !90
  %22 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 1, i32 3
  store i32 0, i32* %22, align 4, !tbaa !135
  %23 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 0
  store i32 0, i32* %23, align 4, !tbaa !87
  %24 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 1
  store i32 0, i32* %24, align 4, !tbaa !89
  %25 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 2
  store i32 0, i32* %25, align 4, !tbaa !90
  %26 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 2, i32 3
  store i32 0, i32* %26, align 4, !tbaa !135
  %27 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 0
  store i32 0, i32* %27, align 4, !tbaa !87
  %28 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 1
  store i32 0, i32* %28, align 4, !tbaa !89
  %29 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 2
  store i32 0, i32* %29, align 4, !tbaa !90
  %30 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %5, i64 0, i64 3, i32 3
  store i32 0, i32* %30, align 4, !tbaa !135
  %31 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %4, i64 0, i32 6
  store %struct.halide_dimension_t* %14, %struct.halide_dimension_t** %31, align 8, !tbaa !86
  %32 = call i32 @_ZN6Halide7Runtime8Internal29guess_type_and_dimensionalityEPvP8buffer_tP15halide_buffer_t(i8* %0, %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %4) #15
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %44

; <label>:34:                                     ; preds = %3
  %35 = call i32 @halide_upgrade_buffer_t(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %4, i32 0) #15
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %44

; <label>:37:                                     ; preds = %34
  %38 = call i32 @halide_device_malloc(i8* %0, %struct.halide_buffer_t* nonnull %4, %struct.halide_device_interface_t* %2) #13
  %39 = icmp eq i32 %38, 0
  br i1 %39, label %40, label %44

; <label>:40:                                     ; preds = %37
  %41 = call i32 @halide_downgrade_buffer_t_device_fields(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.halide_buffer_t* nonnull %4, %struct.buffer_t* %1) #15
  %42 = icmp ne i32 %41, 0
  %43 = zext i1 %42 to i32
  br label %44

; <label>:44:                                     ; preds = %40, %37, %34, %3
  %45 = phi i32 [ 1, %37 ], [ %43, %40 ], [ 1, %34 ], [ 1, %3 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %13) #14
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %6) #14
  ret i32 %45
}

; Function Attrs: nounwind
define weak i32 @halide_device_free_legacy(i8*, %struct.buffer_t*) local_unnamed_addr #0 {
  %3 = alloca %struct.halide_buffer_t, align 8
  %4 = alloca [4 x %struct.halide_dimension_t], align 4
  %5 = bitcast %struct.halide_buffer_t* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %5) #14
  %6 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 1
  %7 = bitcast %struct.halide_device_interface_t** %6 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %7, i8 0, i64 48, i1 false)
  %8 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 0
  store i64 0, i64* %8, align 8, !tbaa !84
  %9 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 0
  store i8 0, i8* %9, align 8, !tbaa !168
  %10 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 1
  store i8 0, i8* %10, align 1, !tbaa !99
  %11 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 4, i32 2
  store i16 0, i16* %11, align 2, !tbaa !169
  %12 = bitcast [4 x %struct.halide_dimension_t]* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %12) #14
  %13 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0
  %14 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 0
  store i32 0, i32* %14, align 4, !tbaa !87
  %15 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 1
  store i32 0, i32* %15, align 4, !tbaa !89
  %16 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 2
  store i32 0, i32* %16, align 4, !tbaa !90
  %17 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 0, i32 3
  store i32 0, i32* %17, align 4, !tbaa !135
  %18 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 0
  store i32 0, i32* %18, align 4, !tbaa !87
  %19 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 1
  store i32 0, i32* %19, align 4, !tbaa !89
  %20 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 2
  store i32 0, i32* %20, align 4, !tbaa !90
  %21 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 1, i32 3
  store i32 0, i32* %21, align 4, !tbaa !135
  %22 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 0
  store i32 0, i32* %22, align 4, !tbaa !87
  %23 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 1
  store i32 0, i32* %23, align 4, !tbaa !89
  %24 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 2
  store i32 0, i32* %24, align 4, !tbaa !90
  %25 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 2, i32 3
  store i32 0, i32* %25, align 4, !tbaa !135
  %26 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 0
  store i32 0, i32* %26, align 4, !tbaa !87
  %27 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 1
  store i32 0, i32* %27, align 4, !tbaa !89
  %28 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 2
  store i32 0, i32* %28, align 4, !tbaa !90
  %29 = getelementptr inbounds [4 x %struct.halide_dimension_t], [4 x %struct.halide_dimension_t]* %4, i64 0, i64 3, i32 3
  store i32 0, i32* %29, align 4, !tbaa !135
  %30 = getelementptr inbounds %struct.halide_buffer_t, %struct.halide_buffer_t* %3, i64 0, i32 6
  store %struct.halide_dimension_t* %13, %struct.halide_dimension_t** %30, align 8, !tbaa !86
  %31 = call i32 @_ZN6Halide7Runtime8Internal29guess_type_and_dimensionalityEPvP8buffer_tP15halide_buffer_t(i8* %0, %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %3) #15
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %43

; <label>:33:                                     ; preds = %2
  %34 = call i32 @halide_upgrade_buffer_t(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.buffer_t* %1, %struct.halide_buffer_t* nonnull %3, i32 0) #15
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %43

; <label>:36:                                     ; preds = %33
  %37 = call i32 @halide_device_free(i8* %0, %struct.halide_buffer_t* nonnull %3) #13
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %39, label %43

; <label>:39:                                     ; preds = %36
  %40 = call i32 @halide_downgrade_buffer_t_device_fields(i8* %0, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.164, i64 0, i64 0), %struct.halide_buffer_t* nonnull %3, %struct.buffer_t* %1) #15
  %41 = icmp ne i32 %40, 0
  %42 = zext i1 %41 to i32
  br label %43

; <label>:43:                                     ; preds = %39, %36, %33, %2
  %44 = phi i32 [ 1, %36 ], [ %42, %39 ], [ 1, %33 ], [ 1, %2 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %12) #14
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %5) #14
  ret i32 %44
}

; Function Attrs: nounwind
define weak void @halide_profiler_shutdown() #0 {
  %1 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %2 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %1, i64 0, i32 7
  %3 = load %struct.halide_thread*, %struct.halide_thread** %2, align 8, !tbaa !198
  %4 = icmp eq %struct.halide_thread* %3, null
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %0
  %6 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %1, i64 0, i32 3
  store i32 -2, i32* %6, align 8, !tbaa !200
  tail call void @halide_join_thread(%struct.halide_thread* nonnull %3) #13
  store %struct.halide_thread* null, %struct.halide_thread** %2, align 8, !tbaa !198
  store i32 -1, i32* %6, align 8, !tbaa !200
  tail call void @halide_profiler_report_unlocked(i8* null, %struct.halide_profiler_state* %1) #15
  tail call void @halide_profiler_reset_unlocked(%struct.halide_profiler_state* %1) #15
  br label %7

; <label>:7:                                      ; preds = %5, %0
  ret void
}

; Function Attrs: norecurse nounwind
define weak %struct.halide_profiler_state* @halide_profiler_get_state() local_unnamed_addr #2 {
  ret %struct.halide_profiler_state* @_ZZ25halide_profiler_get_stateE1s
}

; Function Attrs: nounwind
define weak void @halide_profiler_report_unlocked(i8*, %struct.halide_profiler_state*) local_unnamed_addr #0 {
  %3 = alloca [1024 x i8], align 1
  %4 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* nonnull %4) #14
  %5 = ptrtoint [1024 x i8]* %3 to i64
  %6 = getelementptr inbounds [1024 x i8], [1024 x i8]* %3, i64 0, i64 1023
  store i8 0, i8* %6, align 1, !tbaa !7
  %7 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %1, i64 0, i32 5
  %8 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %7, align 8, !tbaa !3
  %9 = icmp eq %struct.halide_profiler_pipeline_stats* %8, null
  %10 = sub i64 1, %5
  br i1 %9, label %11, label %14

; <label>:11:                                     ; preds = %308, %2
  %12 = phi i64 [ %5, %2 ], [ %309, %308 ]
  %13 = add i64 %10, %12
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %13) #13
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* nonnull %4) #14
  ret void

; <label>:14:                                     ; preds = %308, %2
  %15 = phi %struct.halide_profiler_pipeline_stats* [ %312, %308 ], [ %8, %2 ]
  %16 = phi i64 [ %309, %308 ], [ %5, %2 ]
  %17 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 0
  %18 = load i64, i64* %17, align 8, !tbaa !201
  %19 = uitofp i64 %18 to float
  %20 = fdiv float %19, 1.000000e+06
  %21 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 11
  %22 = load i32, i32* %21, align 8, !tbaa !203
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %308, label %24

; <label>:24:                                     ; preds = %14
  store i8 0, i8* %4, align 1, !tbaa !7
  %25 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 13
  %26 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 4
  %27 = load i64, i64* %26, align 8, !tbaa !204
  %28 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 5
  %29 = load i64, i64* %28, align 8, !tbaa !205
  %30 = icmp eq i64 %27, %29
  %31 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 6
  %32 = load i8*, i8** %31, align 8, !tbaa !206
  %33 = icmp eq i8* %32, null
  br i1 %33, label %34, label %36

; <label>:34:                                     ; preds = %24
  %35 = call i8* @halide_string_to_string(i8* nonnull %4, i8* nonnull %6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.30.174, i64 0, i64 0)) #13
  br label %38

; <label>:36:                                     ; preds = %24
  %37 = call i8* @halide_string_to_string(i8* nonnull %4, i8* nonnull %6, i8* nonnull %32) #13
  br label %38

; <label>:38:                                     ; preds = %36, %34
  %39 = phi i8* [ %37, %36 ], [ %35, %34 ]
  %40 = call i8* @halide_string_to_string(i8* %39, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7.175, i64 0, i64 0)) #13
  %41 = call i8* @halide_string_to_string(i8* %40, i8* nonnull %6, i8* nonnull getelementptr inbounds ([14 x i8], [14 x i8]* @.str.8.176, i64 0, i64 0)) #13
  %42 = fpext float %20 to double
  %43 = call i8* @halide_double_to_string(i8* %41, i8* nonnull %6, double %42, i32 0) #13
  %44 = call i8* @halide_string_to_string(i8* %43, i8* nonnull %6, i8* nonnull getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9.177, i64 0, i64 0)) #13
  %45 = call i8* @halide_string_to_string(i8* %44, i8* nonnull %6, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.10.178, i64 0, i64 0)) #13
  %46 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 12
  %47 = load i32, i32* %46, align 4, !tbaa !207
  %48 = sext i32 %47 to i64
  %49 = call i8* @halide_int64_to_string(i8* %45, i8* nonnull %6, i64 %48, i32 1) #13
  %50 = call i8* @halide_string_to_string(i8* %49, i8* nonnull %6, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @.str.11.179, i64 0, i64 0)) #13
  %51 = load i32, i32* %21, align 8, !tbaa !203
  %52 = sext i32 %51 to i64
  %53 = call i8* @halide_int64_to_string(i8* %50, i8* nonnull %6, i64 %52, i32 1) #13
  %54 = call i8* @halide_string_to_string(i8* %53, i8* nonnull %6, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.12.180, i64 0, i64 0)) #13
  %55 = load i32, i32* %21, align 8, !tbaa !203
  %56 = sitofp i32 %55 to float
  %57 = fdiv float %20, %56
  %58 = fpext float %57 to double
  %59 = call i8* @halide_double_to_string(i8* %54, i8* nonnull %6, double %58, i32 0) #13
  %60 = call i8* @halide_string_to_string(i8* %59, i8* nonnull %6, i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.13.181, i64 0, i64 0)) #13
  br i1 %30, label %71, label %61

; <label>:61:                                     ; preds = %38
  %62 = uitofp i64 %27 to double
  %63 = uitofp i64 %29 to double
  %64 = fadd double %63, 1.000000e-10
  %65 = fdiv double %62, %64
  %66 = fptrunc double %65 to float
  %67 = call i8* @halide_string_to_string(i8* %60, i8* nonnull %6, i8* nonnull getelementptr inbounds ([24 x i8], [24 x i8]* @.str.14.182, i64 0, i64 0)) #13
  %68 = fpext float %66 to double
  %69 = call i8* @halide_double_to_string(i8* %67, i8* nonnull %6, double %68, i32 0) #13
  %70 = call i8* @halide_string_to_string(i8* %69, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7.175, i64 0, i64 0)) #13
  br label %71

; <label>:71:                                     ; preds = %61, %38
  %72 = phi i8* [ %60, %38 ], [ %70, %61 ]
  %73 = call i8* @halide_string_to_string(i8* %72, i8* nonnull %6, i8* nonnull getelementptr inbounds ([20 x i8], [20 x i8]* @.str.15.183, i64 0, i64 0)) #13
  %74 = load i32, i32* %25, align 8, !tbaa !208
  %75 = sext i32 %74 to i64
  %76 = call i8* @halide_int64_to_string(i8* %73, i8* nonnull %6, i64 %75, i32 1) #13
  %77 = call i8* @halide_string_to_string(i8* %76, i8* nonnull %6, i8* nonnull getelementptr inbounds ([20 x i8], [20 x i8]* @.str.16.184, i64 0, i64 0)) #13
  %78 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 2
  %79 = load i64, i64* %78, align 8, !tbaa !209
  %80 = call i8* @halide_uint64_to_string(i8* %77, i8* nonnull %6, i64 %79, i32 1) #13
  %81 = call i8* @halide_string_to_string(i8* %80, i8* nonnull %6, i8* nonnull getelementptr inbounds ([8 x i8], [8 x i8]* @.str.17.185, i64 0, i64 0)) #13
  %82 = ptrtoint i8* %81 to i64
  %83 = add i64 %10, %82
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %83) #13
  call void @halide_print(i8* %0, i8* nonnull %4) #13
  %84 = load i64, i64* %17, align 8, !tbaa !201
  %85 = icmp eq i64 %84, 0
  br i1 %85, label %86, label %106

; <label>:86:                                     ; preds = %71
  %87 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 3
  %88 = load i64, i64* %87, align 8, !tbaa !210
  %89 = icmp eq i64 %88, 0
  br i1 %89, label %90, label %106

; <label>:90:                                     ; preds = %86
  %91 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 9
  %92 = load i32, i32* %91, align 8, !tbaa !211
  %93 = icmp sgt i32 %92, 0
  br i1 %93, label %94, label %308

; <label>:94:                                     ; preds = %90
  %95 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 7
  %96 = load %struct.halide_profiler_func_stats*, %struct.halide_profiler_func_stats** %95, align 8, !tbaa !212
  %97 = sext i32 %92 to i64
  br label %100

; <label>:98:                                     ; preds = %100
  %99 = icmp slt i64 %105, %97
  br i1 %99, label %100, label %308

; <label>:100:                                    ; preds = %98, %94
  %101 = phi i64 [ 0, %94 ], [ %105, %98 ]
  %102 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %96, i64 %101, i32 4
  %103 = load i64, i64* %102, align 8, !tbaa !213
  %104 = icmp eq i64 %103, 0
  %105 = add nuw nsw i64 %101, 1
  br i1 %104, label %98, label %106

; <label>:106:                                    ; preds = %100, %86, %71
  %107 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 9
  %108 = load i32, i32* %107, align 8, !tbaa !211
  %109 = icmp sgt i32 %108, 0
  br i1 %109, label %110, label %308

; <label>:110:                                    ; preds = %106
  %111 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 7
  br label %112

; <label>:112:                                    ; preds = %302, %110
  %113 = phi i32 [ %108, %110 ], [ %303, %302 ]
  %114 = phi i64 [ 0, %110 ], [ %305, %302 ]
  store i8 0, i8* %4, align 1, !tbaa !7
  %115 = load %struct.halide_profiler_func_stats*, %struct.halide_profiler_func_stats** %111, align 8, !tbaa !212
  %116 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114
  %117 = icmp eq i64 %114, 0
  br i1 %117, label %118, label %122

; <label>:118:                                    ; preds = %112
  %119 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %116, i64 0, i32 0
  %120 = load i64, i64* %119, align 8, !tbaa !215
  %121 = icmp eq i64 %120, 0
  br i1 %121, label %302, label %122

; <label>:122:                                    ; preds = %118, %112
  %123 = call i8* @halide_string_to_string(i8* nonnull %4, i8* nonnull %6, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.18.186, i64 0, i64 0)) #13
  %124 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 7
  %125 = load i8*, i8** %124, align 8, !tbaa !216
  %126 = icmp eq i8* %125, null
  br i1 %126, label %127, label %129

; <label>:127:                                    ; preds = %122
  %128 = call i8* @halide_string_to_string(i8* %123, i8* nonnull %6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.30.174, i64 0, i64 0)) #13
  br label %131

; <label>:129:                                    ; preds = %122
  %130 = call i8* @halide_string_to_string(i8* %123, i8* nonnull %6, i8* nonnull %125) #13
  br label %131

; <label>:131:                                    ; preds = %129, %127
  %132 = phi i8* [ %130, %129 ], [ %128, %127 ]
  %133 = call i8* @halide_string_to_string(i8* %132, i8* nonnull %6, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.19.187, i64 0, i64 0)) #13
  %134 = ptrtoint i8* %133 to i64
  %135 = sub i64 %134, %5
  %136 = icmp ult i64 %135, 25
  br i1 %136, label %137, label %143

; <label>:137:                                    ; preds = %137, %131
  %138 = phi i8* [ %139, %137 ], [ %133, %131 ]
  %139 = call i8* @halide_string_to_string(i8* %138, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20.188, i64 0, i64 0)) #13
  %140 = ptrtoint i8* %139 to i64
  %141 = sub i64 %140, %5
  %142 = icmp ult i64 %141, 25
  br i1 %142, label %137, label %143

; <label>:143:                                    ; preds = %137, %131
  %144 = phi i8* [ %133, %131 ], [ %139, %137 ]
  %145 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %116, i64 0, i32 0
  %146 = load i64, i64* %145, align 8, !tbaa !215
  %147 = uitofp i64 %146 to float
  %148 = load i32, i32* %21, align 8, !tbaa !203
  %149 = sitofp i32 %148 to float
  %150 = fmul float %149, 1.000000e+06
  %151 = fdiv float %147, %150
  %152 = fpext float %151 to double
  %153 = call i8* @halide_double_to_string(i8* %144, i8* nonnull %6, double %152, i32 0) #13
  %154 = icmp eq i8* %153, null
  br i1 %154, label %159, label %155

; <label>:155:                                    ; preds = %143
  %156 = getelementptr inbounds i8, i8* %153, i64 -3
  %157 = icmp ult i8* %156, %4
  %158 = select i1 %157, i8* %4, i8* %156
  store i8 0, i8* %158, align 1, !tbaa !7
  br label %159

; <label>:159:                                    ; preds = %155, %143
  %160 = phi i8* [ null, %143 ], [ %158, %155 ]
  %161 = call i8* @halide_string_to_string(i8* %160, i8* nonnull %6, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.21.189, i64 0, i64 0)) #13
  %162 = ptrtoint i8* %161 to i64
  %163 = sub i64 %162, %5
  %164 = icmp ult i64 %163, 35
  br i1 %164, label %165, label %171

; <label>:165:                                    ; preds = %165, %159
  %166 = phi i8* [ %167, %165 ], [ %161, %159 ]
  %167 = call i8* @halide_string_to_string(i8* %166, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20.188, i64 0, i64 0)) #13
  %168 = ptrtoint i8* %167 to i64
  %169 = sub i64 %168, %5
  %170 = icmp ult i64 %169, 35
  br i1 %170, label %165, label %171

; <label>:171:                                    ; preds = %165, %159
  %172 = phi i8* [ %161, %159 ], [ %167, %165 ]
  %173 = load i64, i64* %17, align 8, !tbaa !201
  %174 = icmp eq i64 %173, 0
  br i1 %174, label %179, label %175

; <label>:175:                                    ; preds = %171
  %176 = load i64, i64* %145, align 8, !tbaa !215
  %177 = mul i64 %176, 100
  %178 = udiv i64 %177, %173
  br label %179

; <label>:179:                                    ; preds = %175, %171
  %180 = phi i64 [ %178, %175 ], [ 0, %171 ]
  %181 = call i8* @halide_string_to_string(i8* %172, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.22.190, i64 0, i64 0)) #13
  %182 = shl i64 %180, 32
  %183 = ashr exact i64 %182, 32
  %184 = call i8* @halide_int64_to_string(i8* %181, i8* nonnull %6, i64 %183, i32 1) #13
  %185 = call i8* @halide_string_to_string(i8* %184, i8* nonnull %6, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23.191, i64 0, i64 0)) #13
  %186 = ptrtoint i8* %185 to i64
  %187 = sub i64 %186, %5
  %188 = icmp ult i64 %187, 43
  br i1 %188, label %189, label %197

; <label>:189:                                    ; preds = %189, %179
  %190 = phi i8* [ %191, %189 ], [ %185, %179 ]
  %191 = call i8* @halide_string_to_string(i8* %190, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20.188, i64 0, i64 0)) #13
  %192 = ptrtoint i8* %191 to i64
  %193 = sub i64 %192, %5
  %194 = icmp ult i64 %193, 43
  br i1 %194, label %189, label %195

; <label>:195:                                    ; preds = %189
  %196 = ptrtoint i8* %191 to i64
  br label %197

; <label>:197:                                    ; preds = %195, %179
  %198 = phi i8* [ %185, %179 ], [ %191, %195 ]
  %199 = phi i64 [ %186, %179 ], [ %196, %195 ]
  br i1 %30, label %231, label %200

; <label>:200:                                    ; preds = %197
  %201 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 5
  %202 = load i64, i64* %201, align 8, !tbaa !217
  %203 = uitofp i64 %202 to double
  %204 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 6
  %205 = load i64, i64* %204, align 8, !tbaa !218
  %206 = uitofp i64 %205 to double
  %207 = fadd double %206, 1.000000e-10
  %208 = fdiv double %203, %207
  %209 = fptrunc double %208 to float
  %210 = call i8* @halide_string_to_string(i8* %198, i8* nonnull %6, i8* nonnull getelementptr inbounds ([10 x i8], [10 x i8]* @.str.24.192, i64 0, i64 0)) #13
  %211 = fpext float %209 to double
  %212 = call i8* @halide_double_to_string(i8* %210, i8* nonnull %6, double %211, i32 0) #13
  %213 = icmp eq i8* %212, null
  br i1 %213, label %218, label %214

; <label>:214:                                    ; preds = %200
  %215 = getelementptr inbounds i8, i8* %212, i64 -3
  %216 = icmp ult i8* %215, %4
  %217 = select i1 %216, i8* %4, i8* %215
  store i8 0, i8* %217, align 1, !tbaa !7
  br label %218

; <label>:218:                                    ; preds = %214, %200
  %219 = phi i8* [ null, %200 ], [ %217, %214 ]
  %220 = ptrtoint i8* %219 to i64
  %221 = sub i64 %220, %5
  %222 = icmp ult i64 %221, 58
  br i1 %222, label %223, label %231

; <label>:223:                                    ; preds = %223, %218
  %224 = phi i8* [ %225, %223 ], [ %219, %218 ]
  %225 = call i8* @halide_string_to_string(i8* %224, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20.188, i64 0, i64 0)) #13
  %226 = ptrtoint i8* %225 to i64
  %227 = sub i64 %226, %5
  %228 = icmp ult i64 %227, 58
  br i1 %228, label %223, label %229

; <label>:229:                                    ; preds = %223
  %230 = ptrtoint i8* %225 to i64
  br label %231

; <label>:231:                                    ; preds = %229, %218, %197
  %232 = phi i64 [ %199, %197 ], [ %220, %218 ], [ %230, %229 ]
  %233 = phi i64 [ 58, %197 ], [ 73, %218 ], [ 73, %229 ]
  %234 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 8
  %235 = load i32, i32* %234, align 8, !tbaa !219
  %236 = icmp eq i32 %235, 0
  br i1 %236, label %242, label %237

; <label>:237:                                    ; preds = %231
  %238 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 3
  %239 = load i64, i64* %238, align 8, !tbaa !220
  %240 = sext i32 %235 to i64
  %241 = udiv i64 %239, %240
  br label %242

; <label>:242:                                    ; preds = %237, %231
  %243 = phi i64 [ %241, %237 ], [ 0, %231 ]
  %244 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 2
  %245 = load i64, i64* %244, align 8, !tbaa !221
  %246 = icmp eq i64 %245, 0
  br i1 %246, label %284, label %247

; <label>:247:                                    ; preds = %242
  %248 = inttoptr i64 %232 to i8*
  %249 = call i8* @halide_string_to_string(i8* %248, i8* nonnull %6, i8* nonnull getelementptr inbounds ([8 x i8], [8 x i8]* @.str.25.193, i64 0, i64 0)) #13
  %250 = load i64, i64* %244, align 8, !tbaa !221
  %251 = call i8* @halide_uint64_to_string(i8* %249, i8* nonnull %6, i64 %250, i32 1) #13
  %252 = ptrtoint i8* %251 to i64
  %253 = sub i64 %252, %5
  %254 = icmp ult i64 %253, %233
  br i1 %254, label %255, label %261

; <label>:255:                                    ; preds = %255, %247
  %256 = phi i8* [ %257, %255 ], [ %251, %247 ]
  %257 = call i8* @halide_string_to_string(i8* %256, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20.188, i64 0, i64 0)) #13
  %258 = ptrtoint i8* %257 to i64
  %259 = sub i64 %258, %5
  %260 = icmp ult i64 %259, %233
  br i1 %260, label %255, label %261

; <label>:261:                                    ; preds = %255, %247
  %262 = phi i8* [ %251, %247 ], [ %257, %255 ]
  %263 = call i8* @halide_string_to_string(i8* %262, i8* nonnull %6, i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.26.194, i64 0, i64 0)) #13
  %264 = load i32, i32* %234, align 8, !tbaa !219
  %265 = sext i32 %264 to i64
  %266 = call i8* @halide_int64_to_string(i8* %263, i8* nonnull %6, i64 %265, i32 1) #13
  %267 = add nuw nsw i64 %233, 15
  %268 = ptrtoint i8* %266 to i64
  %269 = sub i64 %268, %5
  %270 = icmp ult i64 %269, %267
  br i1 %270, label %271, label %277

; <label>:271:                                    ; preds = %271, %261
  %272 = phi i8* [ %273, %271 ], [ %266, %261 ]
  %273 = call i8* @halide_string_to_string(i8* %272, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20.188, i64 0, i64 0)) #13
  %274 = ptrtoint i8* %273 to i64
  %275 = sub i64 %274, %5
  %276 = icmp ult i64 %275, %267
  br i1 %276, label %271, label %277

; <label>:277:                                    ; preds = %271, %261
  %278 = phi i8* [ %266, %261 ], [ %273, %271 ]
  %279 = call i8* @halide_string_to_string(i8* %278, i8* nonnull %6, i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.27.195, i64 0, i64 0)) #13
  %280 = shl i64 %243, 32
  %281 = ashr exact i64 %280, 32
  %282 = call i8* @halide_int64_to_string(i8* %279, i8* nonnull %6, i64 %281, i32 1) #13
  %283 = ptrtoint i8* %282 to i64
  br label %284

; <label>:284:                                    ; preds = %277, %242
  %285 = phi i64 [ %232, %242 ], [ %283, %277 ]
  %286 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %115, i64 %114, i32 4
  %287 = load i64, i64* %286, align 8, !tbaa !213
  %288 = icmp eq i64 %287, 0
  br i1 %288, label %295, label %289

; <label>:289:                                    ; preds = %284
  %290 = inttoptr i64 %285 to i8*
  %291 = call i8* @halide_string_to_string(i8* %290, i8* nonnull %6, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @.str.28.196, i64 0, i64 0)) #13
  %292 = load i64, i64* %286, align 8, !tbaa !213
  %293 = call i8* @halide_uint64_to_string(i8* %291, i8* nonnull %6, i64 %292, i32 1) #13
  %294 = ptrtoint i8* %293 to i64
  br label %295

; <label>:295:                                    ; preds = %289, %284
  %296 = phi i64 [ %285, %284 ], [ %294, %289 ]
  %297 = inttoptr i64 %296 to i8*
  %298 = call i8* @halide_string_to_string(i8* %297, i8* nonnull %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7.175, i64 0, i64 0)) #13
  %299 = ptrtoint i8* %298 to i64
  %300 = add i64 %10, %299
  call void @halide_msan_annotate_memory_is_initialized(i8* %0, i8* nonnull %4, i64 %300) #13
  call void @halide_print(i8* %0, i8* nonnull %4) #13
  %301 = load i32, i32* %107, align 8, !tbaa !211
  br label %302

; <label>:302:                                    ; preds = %295, %118
  %303 = phi i32 [ %113, %118 ], [ %301, %295 ]
  %304 = phi i64 [ %5, %118 ], [ %299, %295 ]
  %305 = add nuw nsw i64 %114, 1
  %306 = sext i32 %303 to i64
  %307 = icmp slt i64 %305, %306
  br i1 %307, label %112, label %308

; <label>:308:                                    ; preds = %302, %106, %98, %90, %14
  %309 = phi i64 [ %16, %14 ], [ %82, %106 ], [ %82, %90 ], [ %304, %302 ], [ %82, %98 ]
  %310 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %15, i64 0, i32 8
  %311 = bitcast i8** %310 to %struct.halide_profiler_pipeline_stats**
  %312 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %311, align 8, !tbaa !3
  %313 = icmp eq %struct.halide_profiler_pipeline_stats* %312, null
  br i1 %313, label %11, label %14
}

; Function Attrs: nounwind
define weak void @halide_profiler_reset_unlocked(%struct.halide_profiler_state*) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %0, i64 0, i32 5
  %3 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %2, align 8, !tbaa !222
  %4 = icmp eq %struct.halide_profiler_pipeline_stats* %3, null
  br i1 %4, label %18, label %5

; <label>:5:                                      ; preds = %1
  %6 = bitcast %struct.halide_profiler_pipeline_stats** %2 to i64*
  br label %7

; <label>:7:                                      ; preds = %7, %5
  %8 = phi %struct.halide_profiler_pipeline_stats* [ %3, %5 ], [ %16, %7 ]
  %9 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %8, i64 0, i32 8
  %10 = bitcast i8** %9 to i64*
  %11 = load i64, i64* %10, align 8, !tbaa !223
  store i64 %11, i64* %6, align 8, !tbaa !222
  %12 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %8, i64 0, i32 7
  %13 = bitcast %struct.halide_profiler_func_stats** %12 to i8**
  %14 = load i8*, i8** %13, align 8, !tbaa !212
  tail call void @free(i8* %14) #13
  %15 = bitcast %struct.halide_profiler_pipeline_stats* %8 to i8*
  tail call void @free(i8* %15) #13
  %16 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %2, align 8, !tbaa !222
  %17 = icmp eq %struct.halide_profiler_pipeline_stats* %16, null
  br i1 %17, label %18, label %7

; <label>:18:                                     ; preds = %7, %1
  %19 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %0, i64 0, i32 2
  store i32 0, i32* %19, align 4, !tbaa !224
  ret void
}

; Function Attrs: nounwind
define linkonce %struct.halide_profiler_pipeline_stats* @_ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy(i8*, i32, i64*) local_unnamed_addr #0 {
  %4 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %5 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 5
  %6 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %5, align 8, !tbaa !3
  %7 = icmp eq %struct.halide_profiler_pipeline_stats* %6, null
  br i1 %7, label %22, label %8

; <label>:8:                                      ; preds = %17, %3
  %9 = phi %struct.halide_profiler_pipeline_stats* [ %20, %17 ], [ %6, %3 ]
  %10 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %9, i64 0, i32 6
  %11 = load i8*, i8** %10, align 8, !tbaa !206
  %12 = icmp eq i8* %11, %0
  br i1 %12, label %13, label %17

; <label>:13:                                     ; preds = %8
  %14 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %9, i64 0, i32 9
  %15 = load i32, i32* %14, align 8, !tbaa !211
  %16 = icmp eq i32 %15, %1
  br i1 %16, label %88, label %17

; <label>:17:                                     ; preds = %13, %8
  %18 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %9, i64 0, i32 8
  %19 = bitcast i8** %18 to %struct.halide_profiler_pipeline_stats**
  %20 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %19, align 8, !tbaa !3
  %21 = icmp eq %struct.halide_profiler_pipeline_stats* %20, null
  br i1 %21, label %22, label %8

; <label>:22:                                     ; preds = %17, %3
  %23 = tail call i8* @malloc(i64 96) #13
  %24 = bitcast i8* %23 to %struct.halide_profiler_pipeline_stats*
  %25 = icmp eq i8* %23, null
  br i1 %25, label %88, label %26

; <label>:26:                                     ; preds = %22
  %27 = bitcast %struct.halide_profiler_pipeline_stats** %5 to i64*
  %28 = load i64, i64* %27, align 8, !tbaa !222
  %29 = getelementptr inbounds i8, i8* %23, i64 64
  %30 = bitcast i8* %29 to i64*
  store i64 %28, i64* %30, align 8, !tbaa !223
  %31 = getelementptr inbounds i8, i8* %23, i64 48
  %32 = bitcast i8* %31 to i8**
  store i8* %0, i8** %32, align 8, !tbaa !206
  %33 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 2
  %34 = load i32, i32* %33, align 4, !tbaa !224
  %35 = getelementptr inbounds i8, i8* %23, i64 76
  %36 = bitcast i8* %35 to i32*
  store i32 %34, i32* %36, align 4, !tbaa !225
  %37 = getelementptr inbounds i8, i8* %23, i64 72
  %38 = bitcast i8* %37 to i32*
  store i32 %1, i32* %38, align 8, !tbaa !211
  %39 = getelementptr inbounds i8, i8* %23, i64 80
  %40 = bitcast i8* %39 to i32*
  store i32 0, i32* %40, align 8, !tbaa !203
  %41 = bitcast i8* %23 to i64*
  store i64 0, i64* %41, align 8, !tbaa !201
  %42 = getelementptr inbounds i8, i8* %23, i64 84
  %43 = bitcast i8* %42 to i32*
  store i32 0, i32* %43, align 4, !tbaa !207
  %44 = getelementptr inbounds i8, i8* %23, i64 8
  %45 = bitcast i8* %44 to i64*
  store i64 0, i64* %45, align 8, !tbaa !226
  %46 = getelementptr inbounds i8, i8* %23, i64 16
  %47 = bitcast i8* %46 to i64*
  store i64 0, i64* %47, align 8, !tbaa !209
  %48 = getelementptr inbounds i8, i8* %23, i64 24
  %49 = bitcast i8* %48 to i64*
  store i64 0, i64* %49, align 8, !tbaa !210
  %50 = getelementptr inbounds i8, i8* %23, i64 88
  %51 = bitcast i8* %50 to i32*
  store i32 0, i32* %51, align 8, !tbaa !208
  %52 = getelementptr inbounds i8, i8* %23, i64 32
  %53 = bitcast i8* %52 to i64*
  store i64 0, i64* %53, align 8, !tbaa !204
  %54 = getelementptr inbounds i8, i8* %23, i64 40
  %55 = bitcast i8* %54 to i64*
  store i64 0, i64* %55, align 8, !tbaa !205
  %56 = sext i32 %1 to i64
  %57 = mul nsw i64 %56, 72
  %58 = tail call i8* @malloc(i64 %57) #13
  %59 = getelementptr inbounds i8, i8* %23, i64 56
  %60 = bitcast i8* %59 to i8**
  store i8* %58, i8** %60, align 8, !tbaa !212
  %61 = icmp eq i8* %58, null
  %62 = bitcast i8* %58 to %struct.halide_profiler_func_stats*
  br i1 %61, label %67, label %63

; <label>:63:                                     ; preds = %26
  %64 = icmp sgt i32 %1, 0
  br i1 %64, label %65, label %68

; <label>:65:                                     ; preds = %63
  %66 = zext i32 %1 to i64
  br label %72

; <label>:67:                                     ; preds = %26
  tail call void @free(i8* nonnull %23) #13
  br label %88

; <label>:68:                                     ; preds = %72, %63
  %69 = load i32, i32* %33, align 4, !tbaa !224
  %70 = add nsw i32 %69, %1
  store i32 %70, i32* %33, align 4, !tbaa !224
  %71 = bitcast %struct.halide_profiler_pipeline_stats** %5 to i8**
  store i8* %23, i8** %71, align 8, !tbaa !222
  br label %88

; <label>:72:                                     ; preds = %72, %65
  %73 = phi i64 [ 0, %65 ], [ %86, %72 ]
  %74 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 0
  store i64 0, i64* %74, align 8, !tbaa !215
  %75 = getelementptr inbounds i64, i64* %2, i64 %73
  %76 = load i64, i64* %75, align 8, !tbaa !11
  %77 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 7
  %78 = bitcast i8** %77 to i64*
  store i64 %76, i64* %78, align 8, !tbaa !216
  %79 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 1
  store i64 0, i64* %79, align 8, !tbaa !227
  %80 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 2
  store i64 0, i64* %80, align 8, !tbaa !221
  %81 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 3
  store i64 0, i64* %81, align 8, !tbaa !220
  %82 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 8
  store i32 0, i32* %82, align 8, !tbaa !219
  %83 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 4
  store i64 0, i64* %83, align 8, !tbaa !213
  %84 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 5
  store i64 0, i64* %84, align 8, !tbaa !217
  %85 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %62, i64 %73, i32 6
  store i64 0, i64* %85, align 8, !tbaa !218
  %86 = add nuw nsw i64 %73, 1
  %87 = icmp eq i64 %86, %66
  br i1 %87, label %68, label %72

; <label>:88:                                     ; preds = %68, %67, %22, %13
  %89 = phi %struct.halide_profiler_pipeline_stats* [ %24, %68 ], [ null, %67 ], [ null, %22 ], [ %9, %13 ]
  ret %struct.halide_profiler_pipeline_stats* %89
}

; Function Attrs: norecurse nounwind
define linkonce void @_ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi(%struct.halide_profiler_state*, i32, i64, i32) local_unnamed_addr #2 {
  %5 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %0, i64 0, i32 5
  %6 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %5, align 8, !tbaa !3
  %7 = icmp eq %struct.halide_profiler_pipeline_stats* %6, null
  %8 = ptrtoint %struct.halide_profiler_pipeline_stats* %6 to i64
  br i1 %7, label %63, label %9

; <label>:9:                                      ; preds = %58, %4
  %10 = phi %struct.halide_profiler_pipeline_stats* [ %61, %58 ], [ %6, %4 ]
  %11 = phi %struct.halide_profiler_pipeline_stats* [ %10, %58 ], [ null, %4 ]
  %12 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 10
  %13 = load i32, i32* %12, align 4, !tbaa !225
  %14 = icmp sgt i32 %13, %1
  br i1 %14, label %58, label %15

; <label>:15:                                     ; preds = %9
  %16 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 9
  %17 = load i32, i32* %16, align 8, !tbaa !211
  %18 = add nsw i32 %17, %13
  %19 = icmp sgt i32 %18, %1
  br i1 %19, label %20, label %58

; <label>:20:                                     ; preds = %15
  %21 = icmp eq %struct.halide_profiler_pipeline_stats* %11, null
  br i1 %21, label %28, label %22

; <label>:22:                                     ; preds = %20
  %23 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 8
  %24 = bitcast i8** %23 to i64*
  %25 = load i64, i64* %24, align 8, !tbaa !223
  %26 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %11, i64 0, i32 8
  %27 = bitcast i8** %26 to i64*
  store i64 %25, i64* %27, align 8, !tbaa !223
  store i64 %8, i64* %24, align 8, !tbaa !223
  store %struct.halide_profiler_pipeline_stats* %10, %struct.halide_profiler_pipeline_stats** %5, align 8, !tbaa !222
  br label %28

; <label>:28:                                     ; preds = %22, %20
  %29 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 7
  %30 = load %struct.halide_profiler_func_stats*, %struct.halide_profiler_func_stats** %29, align 8, !tbaa !212
  %31 = sext i32 %1 to i64
  %32 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %30, i64 %31
  %33 = sext i32 %13 to i64
  %34 = sub nsw i64 0, %33
  %35 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %32, i64 %34
  %36 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %35, i64 0, i32 0
  %37 = load i64, i64* %36, align 8, !tbaa !215
  %38 = add i64 %37, %2
  store i64 %38, i64* %36, align 8, !tbaa !215
  %39 = sext i32 %3 to i64
  %40 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %35, i64 0, i32 5
  %41 = load i64, i64* %40, align 8, !tbaa !217
  %42 = add i64 %41, %39
  store i64 %42, i64* %40, align 8, !tbaa !217
  %43 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %35, i64 0, i32 6
  %44 = load i64, i64* %43, align 8, !tbaa !218
  %45 = add i64 %44, 1
  store i64 %45, i64* %43, align 8, !tbaa !218
  %46 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 0
  %47 = load i64, i64* %46, align 8, !tbaa !201
  %48 = add i64 %47, %2
  store i64 %48, i64* %46, align 8, !tbaa !201
  %49 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 12
  %50 = load i32, i32* %49, align 4, !tbaa !207
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %49, align 4, !tbaa !207
  %52 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 4
  %53 = load i64, i64* %52, align 8, !tbaa !204
  %54 = add i64 %53, %39
  store i64 %54, i64* %52, align 8, !tbaa !204
  %55 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 5
  %56 = load i64, i64* %55, align 8, !tbaa !205
  %57 = add i64 %56, 1
  store i64 %57, i64* %55, align 8, !tbaa !205
  br label %63

; <label>:58:                                     ; preds = %15, %9
  %59 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %10, i64 0, i32 8
  %60 = bitcast i8** %59 to %struct.halide_profiler_pipeline_stats**
  %61 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %60, align 8, !tbaa !3
  %62 = icmp eq %struct.halide_profiler_pipeline_stats* %61, null
  br i1 %62, label %63, label %9

; <label>:63:                                     ; preds = %58, %28, %4
  ret void
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv(i8*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %5 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 0
  tail call void @halide_mutex_lock(%struct.halide_mutex* %5) #13
  %6 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 3
  %7 = load i32, i32* %6, align 8, !tbaa !200
  %8 = icmp eq i32 %7, -2
  br i1 %8, label %39, label %9

; <label>:9:                                      ; preds = %1
  %10 = bitcast i32* %2 to i8*
  %11 = bitcast i32* %3 to i8*
  %12 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 6
  %13 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 4
  %14 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %4, i64 0, i32 1
  br label %15

; <label>:15:                                     ; preds = %36, %9
  %16 = call i64 @halide_current_time_ns(i8* null) #13
  br label %17

; <label>:17:                                     ; preds = %34, %15
  %18 = phi i64 [ %16, %15 ], [ %26, %34 ]
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %10) #14
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %11) #14
  %19 = load void (i32*, i32*)*, void (i32*, i32*)** %12, align 8, !tbaa !228
  %20 = icmp eq void (i32*, i32*)* %19, null
  br i1 %20, label %22, label %21

; <label>:21:                                     ; preds = %17
  call void %19(i32* nonnull %2, i32* nonnull %3) #13
  br label %25

; <label>:22:                                     ; preds = %17
  %23 = load i32, i32* %6, align 8, !tbaa !200
  store i32 %23, i32* %2, align 4, !tbaa !96
  %24 = load i32, i32* %13, align 4, !tbaa !229
  store i32 %24, i32* %3, align 4, !tbaa !96
  br label %25

; <label>:25:                                     ; preds = %22, %21
  %26 = call i64 @halide_current_time_ns(i8* null) #13
  %27 = load i32, i32* %2, align 4, !tbaa !96
  %28 = icmp eq i32 %27, -2
  br i1 %28, label %36, label %29

; <label>:29:                                     ; preds = %25
  %30 = icmp sgt i32 %27, -1
  br i1 %30, label %31, label %34

; <label>:31:                                     ; preds = %29
  %32 = sub i64 %26, %18
  %33 = load i32, i32* %3, align 4, !tbaa !96
  call void @_ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi(%struct.halide_profiler_state* nonnull %4, i32 %27, i64 %32, i32 %33) #15
  br label %34

; <label>:34:                                     ; preds = %31, %29
  %35 = load i32, i32* %14, align 8, !tbaa !230
  call void @halide_mutex_unlock(%struct.halide_mutex* nonnull %5) #13
  call void @halide_sleep_ms(i8* null, i32 %35) #13
  call void @halide_mutex_lock(%struct.halide_mutex* nonnull %5) #13
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %11) #14
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %10) #14
  br label %17

; <label>:36:                                     ; preds = %25
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %11) #14
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %10) #14
  %37 = load i32, i32* %6, align 8, !tbaa !200
  %38 = icmp eq i32 %37, -2
  br i1 %38, label %39, label %15

; <label>:39:                                     ; preds = %36, %1
  call void @halide_mutex_unlock(%struct.halide_mutex* nonnull %5) #13
  ret void
}

; Function Attrs: nounwind
define weak %struct.halide_profiler_pipeline_stats* @halide_profiler_get_pipeline_state(i8*) local_unnamed_addr #0 {
  %2 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %3 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %2, i64 0, i32 0
  tail call void @halide_mutex_lock(%struct.halide_mutex* %3) #13
  %4 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %2, i64 0, i32 5
  %5 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %4, align 8, !tbaa !3
  %6 = icmp eq %struct.halide_profiler_pipeline_stats* %5, null
  br i1 %6, label %17, label %7

; <label>:7:                                      ; preds = %12, %1
  %8 = phi %struct.halide_profiler_pipeline_stats* [ %15, %12 ], [ %5, %1 ]
  %9 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %8, i64 0, i32 6
  %10 = load i8*, i8** %9, align 8, !tbaa !206
  %11 = icmp eq i8* %10, %0
  br i1 %11, label %17, label %12

; <label>:12:                                     ; preds = %7
  %13 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %8, i64 0, i32 8
  %14 = bitcast i8** %13 to %struct.halide_profiler_pipeline_stats**
  %15 = load %struct.halide_profiler_pipeline_stats*, %struct.halide_profiler_pipeline_stats** %14, align 8, !tbaa !3
  %16 = icmp eq %struct.halide_profiler_pipeline_stats* %15, null
  br i1 %16, label %17, label %7

; <label>:17:                                     ; preds = %12, %7, %1
  %18 = phi %struct.halide_profiler_pipeline_stats* [ null, %1 ], [ null, %12 ], [ %8, %7 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* %3) #13
  ret %struct.halide_profiler_pipeline_stats* %18
}

; Function Attrs: nounwind
define weak i32 @halide_profiler_pipeline_start(i8*, i8*, i32, i64*) local_unnamed_addr #0 {
  %5 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %6 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %5, i64 0, i32 0
  tail call void @halide_mutex_lock(%struct.halide_mutex* %6) #13
  %7 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %5, i64 0, i32 7
  %8 = load %struct.halide_thread*, %struct.halide_thread** %7, align 8, !tbaa !198
  %9 = icmp eq %struct.halide_thread* %8, null
  br i1 %9, label %10, label %13

; <label>:10:                                     ; preds = %4
  %11 = tail call i32 @halide_start_clock(i8* %0) #13
  %12 = tail call %struct.halide_thread* @halide_spawn_thread(void (i8*)* nonnull @_ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv, i8* null) #13
  store %struct.halide_thread* %12, %struct.halide_thread** %7, align 8, !tbaa !198
  br label %13

; <label>:13:                                     ; preds = %10, %4
  %14 = tail call %struct.halide_profiler_pipeline_stats* @_ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy(i8* %1, i32 %2, i64* %3) #15
  %15 = icmp eq %struct.halide_profiler_pipeline_stats* %14, null
  br i1 %15, label %16, label %18

; <label>:16:                                     ; preds = %13
  %17 = tail call i32 @halide_error_out_of_memory(i8* %0) #13
  br label %24

; <label>:18:                                     ; preds = %13
  %19 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %14, i64 0, i32 11
  %20 = load i32, i32* %19, align 8, !tbaa !203
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %19, align 8, !tbaa !203
  %22 = getelementptr inbounds %struct.halide_profiler_pipeline_stats, %struct.halide_profiler_pipeline_stats* %14, i64 0, i32 10
  %23 = load i32, i32* %22, align 4, !tbaa !225
  br label %24

; <label>:24:                                     ; preds = %18, %16
  %25 = phi i32 [ %23, %18 ], [ %17, %16 ]
  tail call void @halide_mutex_unlock(%struct.halide_mutex* %6) #13
  ret i32 %25
}

; Function Attrs: nounwind
define weak void @halide_profiler_stack_peak_update(i8*, i8*, i64*) local_unnamed_addr #0 {
  %4 = icmp eq i8* %1, null
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %3
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([95 x i8], [95 x i8]* @.str.197, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %6

; <label>:6:                                      ; preds = %5, %3
  %7 = getelementptr inbounds i8, i8* %1, i64 72
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32* %8, align 8, !tbaa !211
  %10 = icmp sgt i32 %9, 0
  br i1 %10, label %11, label %14

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds i8, i8* %1, i64 56
  %13 = bitcast i8* %12 to %struct.halide_profiler_func_stats**
  br label %15

; <label>:14:                                     ; preds = %34, %6
  ret void

; <label>:15:                                     ; preds = %34, %11
  %16 = phi i32 [ %9, %11 ], [ %35, %34 ]
  %17 = phi i64 [ 0, %11 ], [ %36, %34 ]
  %18 = getelementptr inbounds i64, i64* %2, i64 %17
  %19 = load i64, i64* %18, align 8, !tbaa !11
  %20 = icmp eq i64 %19, 0
  br i1 %20, label %34, label %21

; <label>:21:                                     ; preds = %15
  %22 = load %struct.halide_profiler_func_stats*, %struct.halide_profiler_func_stats** %13, align 8, !tbaa !212
  %23 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %22, i64 %17, i32 4
  %24 = load i64, i64* %23, align 8, !tbaa !11
  br label %25

; <label>:25:                                     ; preds = %28, %21
  %26 = phi i64 [ %24, %21 ], [ %30, %28 ]
  %27 = icmp ult i64 %26, %19
  br i1 %27, label %28, label %32

; <label>:28:                                     ; preds = %25
  %29 = cmpxchg i64* %23, i64 %26, i64 %19 seq_cst seq_cst
  %30 = extractvalue { i64, i1 } %29, 0
  %31 = icmp eq i64 %26, %30
  br i1 %31, label %32, label %25

; <label>:32:                                     ; preds = %28, %25
  %33 = load i32, i32* %8, align 8, !tbaa !211
  br label %34

; <label>:34:                                     ; preds = %32, %15
  %35 = phi i32 [ %33, %32 ], [ %16, %15 ]
  %36 = add nuw nsw i64 %17, 1
  %37 = sext i32 %35 to i64
  %38 = icmp slt i64 %36, %37
  br i1 %38, label %15, label %14
}

; Function Attrs: nounwind
define weak void @halide_profiler_memory_allocate(i8*, i8*, i32, i64) local_unnamed_addr #0 {
  %5 = icmp eq i64 %3, 0
  br i1 %5, label %60, label %6

; <label>:6:                                      ; preds = %4
  %7 = icmp eq i8* %1, null
  br i1 %7, label %8, label %9

; <label>:8:                                      ; preds = %6
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([95 x i8], [95 x i8]* @.str.1.198, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %9

; <label>:9:                                      ; preds = %8, %6
  %10 = icmp sgt i32 %2, -1
  br i1 %10, label %12, label %11

; <label>:11:                                     ; preds = %9
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([92 x i8], [92 x i8]* @.str.2.199, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %12

; <label>:12:                                     ; preds = %11, %9
  %13 = getelementptr inbounds i8, i8* %1, i64 72
  %14 = bitcast i8* %13 to i32*
  %15 = load i32, i32* %14, align 8, !tbaa !211
  %16 = icmp sgt i32 %15, %2
  br i1 %16, label %18, label %17

; <label>:17:                                     ; preds = %12
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([108 x i8], [108 x i8]* @.str.3.200, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %18

; <label>:18:                                     ; preds = %17, %12
  %19 = getelementptr inbounds i8, i8* %1, i64 56
  %20 = bitcast i8* %19 to %struct.halide_profiler_func_stats**
  %21 = load %struct.halide_profiler_func_stats*, %struct.halide_profiler_func_stats** %20, align 8, !tbaa !212
  %22 = sext i32 %2 to i64
  %23 = getelementptr inbounds i8, i8* %1, i64 88
  %24 = bitcast i8* %23 to i32*
  %25 = atomicrmw add i32* %24, i32 1 seq_cst
  %26 = getelementptr inbounds i8, i8* %1, i64 24
  %27 = bitcast i8* %26 to i64*
  %28 = atomicrmw add i64* %27, i64 %3 seq_cst
  %29 = getelementptr inbounds i8, i8* %1, i64 8
  %30 = bitcast i8* %29 to i64*
  %31 = atomicrmw add i64* %30, i64 %3 seq_cst
  %32 = add i64 %31, %3
  %33 = getelementptr inbounds i8, i8* %1, i64 16
  %34 = bitcast i8* %33 to i64*
  %35 = load i64, i64* %34, align 8, !tbaa !11
  br label %36

; <label>:36:                                     ; preds = %39, %18
  %37 = phi i64 [ %35, %18 ], [ %41, %39 ]
  %38 = icmp ult i64 %37, %32
  br i1 %38, label %39, label %43

; <label>:39:                                     ; preds = %36
  %40 = cmpxchg i64* %34, i64 %37, i64 %32 seq_cst seq_cst
  %41 = extractvalue { i64, i1 } %40, 0
  %42 = icmp eq i64 %37, %41
  br i1 %42, label %43, label %36

; <label>:43:                                     ; preds = %39, %36
  %44 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %21, i64 %22, i32 8
  %45 = atomicrmw add i32* %44, i32 1 seq_cst
  %46 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %21, i64 %22, i32 3
  %47 = atomicrmw add i64* %46, i64 %3 seq_cst
  %48 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %21, i64 %22, i32 1
  %49 = atomicrmw add i64* %48, i64 %3 seq_cst
  %50 = add i64 %49, %3
  %51 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %21, i64 %22, i32 2
  %52 = load i64, i64* %51, align 8, !tbaa !11
  br label %53

; <label>:53:                                     ; preds = %56, %43
  %54 = phi i64 [ %52, %43 ], [ %58, %56 ]
  %55 = icmp ult i64 %54, %50
  br i1 %55, label %56, label %60

; <label>:56:                                     ; preds = %53
  %57 = cmpxchg i64* %51, i64 %54, i64 %50 seq_cst seq_cst
  %58 = extractvalue { i64, i1 } %57, 0
  %59 = icmp eq i64 %54, %58
  br i1 %59, label %60, label %53

; <label>:60:                                     ; preds = %56, %53, %4
  ret void
}

; Function Attrs: nounwind
define weak void @halide_profiler_memory_free(i8*, i8*, i32, i64) local_unnamed_addr #0 {
  %5 = icmp eq i64 %3, 0
  br i1 %5, label %28, label %6

; <label>:6:                                      ; preds = %4
  %7 = icmp eq i8* %1, null
  br i1 %7, label %8, label %9

; <label>:8:                                      ; preds = %6
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([95 x i8], [95 x i8]* @.str.4.201, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %9

; <label>:9:                                      ; preds = %8, %6
  %10 = icmp sgt i32 %2, -1
  br i1 %10, label %12, label %11

; <label>:11:                                     ; preds = %9
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([92 x i8], [92 x i8]* @.str.5.202, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %12

; <label>:12:                                     ; preds = %11, %9
  %13 = getelementptr inbounds i8, i8* %1, i64 72
  %14 = bitcast i8* %13 to i32*
  %15 = load i32, i32* %14, align 8, !tbaa !211
  %16 = icmp sgt i32 %15, %2
  br i1 %16, label %18, label %17

; <label>:17:                                     ; preds = %12
  tail call void @halide_print(i8* %0, i8* getelementptr inbounds ([108 x i8], [108 x i8]* @.str.6.203, i64 0, i64 0)) #13
  tail call void @abort() #13
  br label %18

; <label>:18:                                     ; preds = %17, %12
  %19 = getelementptr inbounds i8, i8* %1, i64 56
  %20 = bitcast i8* %19 to %struct.halide_profiler_func_stats**
  %21 = load %struct.halide_profiler_func_stats*, %struct.halide_profiler_func_stats** %20, align 8, !tbaa !212
  %22 = sext i32 %2 to i64
  %23 = getelementptr inbounds i8, i8* %1, i64 8
  %24 = bitcast i8* %23 to i64*
  %25 = atomicrmw sub i64* %24, i64 %3 seq_cst
  %26 = getelementptr inbounds %struct.halide_profiler_func_stats, %struct.halide_profiler_func_stats* %21, i64 %22, i32 1
  %27 = atomicrmw sub i64* %26, i64 %3 seq_cst
  br label %28

; <label>:28:                                     ; preds = %18, %4
  ret void
}

; Function Attrs: nounwind
define weak void @halide_profiler_report(i8*) local_unnamed_addr #0 {
  %2 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %3 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %2, i64 0, i32 0
  tail call void @halide_mutex_lock(%struct.halide_mutex* %3) #13
  tail call void @halide_profiler_report_unlocked(i8* %0, %struct.halide_profiler_state* %2) #15
  tail call void @halide_mutex_unlock(%struct.halide_mutex* %3) #13
  ret void
}

; Function Attrs: nounwind
define weak void @halide_profiler_reset() local_unnamed_addr #0 {
  %1 = tail call %struct.halide_profiler_state* @halide_profiler_get_state() #15
  %2 = getelementptr inbounds %struct.halide_profiler_state, %struct.halide_profiler_state* %1, i64 0, i32 0
  tail call void @halide_mutex_lock(%struct.halide_mutex* %2) #13
  tail call void @halide_profiler_reset_unlocked(%struct.halide_profiler_state* %1) #15
  tail call void @halide_mutex_unlock(%struct.halide_mutex* %2) #13
  ret void
}

; Function Attrs: norecurse nounwind
define weak void @halide_profiler_pipeline_end(i8*, i8*) local_unnamed_addr #2 {
  %3 = getelementptr inbounds i8, i8* %1, i64 16
  %4 = bitcast i8* %3 to i32*
  store i32 -1, i32* %4, align 8, !tbaa !200
  ret void
}

; Function Attrs: norecurse nounwind
define weak void @halide_msan_annotate_memory_is_initialized(i8*, i8*, i64) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: norecurse nounwind
define weak void @halide_msan_annotate_buffer_is_initialized(i8*, %struct.halide_buffer_t*) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: norecurse nounwind
define weak void @halide_msan_annotate_buffer_is_initialized_as_destructor(i8*, i8*) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <16 x i8> @pavgbx16(<16 x i8> %a, <16 x i8> %b) #9 {
  %1 = zext <16 x i8> %a to <16 x i32>
  %2 = zext <16 x i8> %b to <16 x i32>
  %3 = add nuw nsw <16 x i32> %1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %4 = add nuw nsw <16 x i32> %3, %2
  %5 = lshr <16 x i32> %4, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %6 = trunc <16 x i32> %5 to <16 x i8>
  ret <16 x i8> %6
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x i16> @pavgwx8(<8 x i16> %a, <8 x i16> %b) #9 {
  %1 = zext <8 x i16> %a to <8 x i32>
  %2 = zext <8 x i16> %b to <8 x i32>
  %3 = add nuw nsw <8 x i32> %1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %4 = add nuw nsw <8 x i32> %3, %2
  %5 = lshr <8 x i32> %4, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %6 = trunc <8 x i32> %5 to <8 x i16>
  ret <8 x i16> %6
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <16 x i8> @packsswbx16(<16 x i16> %arg) #9 {
  %1 = shufflevector <16 x i16> %arg, <16 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <16 x i16> %arg, <16 x i16> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = tail call <16 x i8> @llvm.x86.sse2.packsswb.128(<8 x i16> %1, <8 x i16> %2)
  ret <16 x i8> %3
}

; Function Attrs: nounwind readnone
declare <16 x i8> @llvm.x86.sse2.packsswb.128(<8 x i16>, <8 x i16>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <16 x i8> @packuswbx16(<16 x i16> %arg) #9 {
  %1 = shufflevector <16 x i16> %arg, <16 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <16 x i16> %arg, <16 x i16> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = tail call <16 x i8> @llvm.x86.sse2.packuswb.128(<8 x i16> %1, <8 x i16> %2)
  ret <16 x i8> %3
}

; Function Attrs: nounwind readnone
declare <16 x i8> @llvm.x86.sse2.packuswb.128(<8 x i16>, <8 x i16>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x i16> @packssdwx8(<8 x i32> %arg) #9 {
  %1 = shufflevector <8 x i32> %arg, <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <8 x i32> %arg, <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %3 = tail call <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32> %1, <4 x i32> %2)
  ret <8 x i16> %3
}

; Function Attrs: nounwind readnone
declare <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32>, <4 x i32>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <4 x i32> @pmaddwdx4(<4 x i16> %a, <4 x i16> %b, <4 x i16> %c, <4 x i16> %d) #9 {
  %1 = shufflevector <4 x i16> %a, <4 x i16> %c, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %2 = shufflevector <4 x i16> %b, <4 x i16> %d, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %3 = tail call <4 x i32> @llvm.x86.sse2.pmadd.wd(<8 x i16> %1, <8 x i16> %2)
  ret <4 x i32> %3
}

; Function Attrs: nounwind readnone
declare <4 x i32> @llvm.x86.sse2.pmadd.wd(<8 x i16>, <8 x i16>) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x float> @sqrt_f32x4(<4 x float> %x) #6 {
  %1 = call <4 x float> @llvm.sqrt.v4f32(<4 x float> %x)
  ret <4 x float> %1
}

; Function Attrs: nounwind readnone speculatable
declare <4 x float> @llvm.sqrt.v4f32(<4 x float>) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <2 x double> @sqrt_f64x2(<2 x double> %x) #6 {
  %1 = call <2 x double> @llvm.sqrt.v2f64(<2 x double> %x)
  ret <2 x double> %1
}

; Function Attrs: nounwind readnone speculatable
declare <2 x double> @llvm.sqrt.v2f64(<2 x double>) #7

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x float> @abs_f32x4(<4 x float> %x) #6 {
  %arg = bitcast <4 x float> %x to <4 x i32>
  %mask = lshr <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>, <i32 1, i32 1, i32 1, i32 1>
  %masked = and <4 x i32> %arg, %mask
  %result = bitcast <4 x i32> %masked to <4 x float>
  ret <4 x float> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <2 x double> @abs_f64x2(<2 x double> %x) #6 {
  %arg = bitcast <2 x double> %x to <2 x i64>
  %mask = lshr <2 x i64> <i64 -1, i64 -1>, <i64 1, i64 1>
  %masked = and <2 x i64> %arg, %mask
  %result = bitcast <2 x i64> %masked to <2 x double>
  ret <2 x double> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @fast_inverse_f32(float %x) #6 {
  %vec = insertelement <4 x float> undef, float %x, i32 0
  %approx = tail call <4 x float> @llvm.x86.sse.rcp.ss(<4 x float> %vec)
  %result = extractelement <4 x float> %approx, i32 0
  ret float %result
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.rcp.ss(<4 x float>) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x float> @fast_inverse_f32x4(<4 x float> %x) #6 {
  %approx = tail call <4 x float> @llvm.x86.sse.rcp.ps(<4 x float> %x)
  ret <4 x float> %approx
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.rcp.ps(<4 x float>) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr float @fast_inverse_sqrt_f32(float %x) #6 {
  %vec = insertelement <4 x float> undef, float %x, i32 0
  %approx = tail call <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float> %vec)
  %result = extractelement <4 x float> %approx, i32 0
  ret float %result
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float>) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x float> @fast_inverse_sqrt_f32x4(<4 x float> %x) #6 {
  %approx = tail call <4 x float> @llvm.x86.sse.rsqrt.ps(<4 x float> %x)
  ret <4 x float> %approx
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.rsqrt.ps(<4 x float>) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x float> @min_f32x4(<4 x float> %a, <4 x float> %b) #6 {
  %c = fcmp olt <4 x float> %a, %b
  %result = select <4 x i1> %c, <4 x float> %a, <4 x float> %b
  ret <4 x float> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x float> @max_f32x4(<4 x float> %a, <4 x float> %b) #6 {
  %c = fcmp olt <4 x float> %a, %b
  %result = select <4 x i1> %c, <4 x float> %b, <4 x float> %a
  ret <4 x float> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <2 x double> @min_f64x2(<2 x double> %a, <2 x double> %b) #6 {
  %c = fcmp olt <2 x double> %a, %b
  %result = select <2 x i1> %c, <2 x double> %a, <2 x double> %b
  ret <2 x double> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <2 x double> @max_f64x2(<2 x double> %a, <2 x double> %b) #6 {
  %c = fcmp olt <2 x double> %a, %b
  %result = select <2 x i1> %c, <2 x double> %b, <2 x double> %a
  ret <2 x double> %result
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @x86_cpuid_halide(i32* %info) #10 {
  call void asm sideeffect inteldialect "xchg ebx, esi\0A\09mov eax, dword ptr $$0 $0\0A\09mov ecx, 0\0A\09cpuid\0A\09mov dword ptr $$0 $0, eax\0A\09mov dword ptr $$4 $0, ebx\0A\09mov dword ptr $$8 $0, ecx\0A\09mov dword ptr $$12 $0, edx\0A\09xchg ebx, esi", "=*m,~{eax},~{ebx},~{ecx},~{edx},~{esi},~{dirflag},~{fpsr},~{flags}"(i32* %info)
  ret void
}

; Function Attrs: alwaysinline nounwind
define linkonce i32 @_halide_prefetch(i8*) local_unnamed_addr #5 {
  tail call void @llvm.prefetch(i8* %0, i32 1, i32 3, i32 1)
  ret i32 0
}

; Function Attrs: inaccessiblemem_or_argmemonly nounwind
declare void @llvm.prefetch(i8* nocapture readonly, i32, i32, i32) #11

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x i16> @packusdwx8(<8 x i32> %arg) #9 {
  %1 = shufflevector <8 x i32> %arg, <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <8 x i32> %arg, <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %3 = tail call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> %1, <4 x i32> %2)
  ret <8 x i16> %3
}

; Function Attrs: nounwind readnone
declare <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32>, <4 x i32>) #8

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <4 x float> @floor_f32x4(<4 x float> %x) #12 {
  %1 = tail call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %x, i32 1)
  ret <4 x float> %1
}

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse41.round.ps(<4 x float>, i32) #8

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <2 x double> @floor_f64x2(<2 x double> %x) #12 {
  %1 = tail call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %x, i32 1)
  ret <2 x double> %1
}

; Function Attrs: nounwind readnone
declare <2 x double> @llvm.x86.sse41.round.pd(<2 x double>, i32) #8

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <4 x float> @ceil_f32x4(<4 x float> %x) #12 {
  %1 = tail call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %x, i32 2)
  ret <4 x float> %1
}

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <2 x double> @ceil_f64x2(<2 x double> %x) #12 {
  %1 = tail call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %x, i32 2)
  ret <2 x double> %1
}

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <4 x float> @round_f32x4(<4 x float> %x) #12 {
  %1 = tail call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %x, i32 0)
  ret <4 x float> %1
}

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <2 x double> @round_f64x2(<2 x double> %x) #12 {
  %1 = tail call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %x, i32 0)
  ret <2 x double> %1
}

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <4 x float> @trunc_f32x4(<4 x float> %x) #12 {
  %1 = tail call <4 x float> @llvm.x86.sse41.round.ps(<4 x float> %x, i32 3)
  ret <4 x float> %1
}

; Function Attrs: alwaysinline inlinehint nounwind optsize readnone uwtable
define linkonce_odr <2 x double> @trunc_f64x2(<2 x double> %x) #12 {
  %1 = tail call <2 x double> @llvm.x86.sse41.round.pd(<2 x double> %x, i32 3)
  ret <2 x double> %1
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <16 x i8> @abs_i8x16(<16 x i8> %x) #6 {
  %1 = sub <16 x i8> zeroinitializer, %x
  %2 = icmp sgt <16 x i8> %x, zeroinitializer
  %3 = select <16 x i1> %2, <16 x i8> %x, <16 x i8> %1
  ret <16 x i8> %3
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <8 x i16> @abs_i16x8(<8 x i16> %x) #6 {
  %1 = sub <8 x i16> zeroinitializer, %x
  %2 = icmp sgt <8 x i16> %x, zeroinitializer
  %3 = select <8 x i1> %2, <8 x i16> %x, <8 x i16> %1
  ret <8 x i16> %3
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x i32> @abs_i32x4(<4 x i32> %x) #6 {
  %1 = sub <4 x i32> zeroinitializer, %x
  %2 = icmp sgt <4 x i32> %x, zeroinitializer
  %3 = select <4 x i1> %2, <4 x i32> %x, <4 x i32> %1
  ret <4 x i32> %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x float> @sqrt_f32x8(<8 x float> %arg) #9 {
  %1 = call <8 x float> @llvm.sqrt.v8f32(<8 x float> %arg)
  ret <8 x float> %1
}

; Function Attrs: nounwind readnone speculatable
declare <8 x float> @llvm.sqrt.v8f32(<8 x float>) #7

; Function Attrs: alwaysinline nounwind
define linkonce_odr <4 x double> @sqrt_f64x4(<4 x double> %arg) #9 {
  %1 = call <4 x double> @llvm.sqrt.v4f64(<4 x double> %arg)
  ret <4 x double> %1
}

; Function Attrs: nounwind readnone speculatable
declare <4 x double> @llvm.sqrt.v4f64(<4 x double>) #7

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x float> @round_f32x8(<8 x float> %arg) #9 {
  %1 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %arg, i32 0) #14
  ret <8 x float> %1
}

; Function Attrs: nounwind readnone
declare <8 x float> @llvm.x86.avx.round.ps.256(<8 x float>, i32) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <4 x double> @round_f64x4(<4 x double> %arg) #9 {
  %1 = tail call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %arg, i32 0) #14
  ret <4 x double> %1
}

; Function Attrs: nounwind readnone
declare <4 x double> @llvm.x86.avx.round.pd.256(<4 x double>, i32) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x float> @ceil_f32x8(<8 x float> %arg) #9 {
  %1 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %arg, i32 2) #14
  ret <8 x float> %1
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <4 x double> @ceil_f64x4(<4 x double> %arg) #9 {
  %1 = tail call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %arg, i32 2) #14
  ret <4 x double> %1
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x float> @floor_f32x8(<8 x float> %arg) #9 {
  %1 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %arg, i32 1) #14
  ret <8 x float> %1
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <4 x double> @floor_f64x4(<4 x double> %arg) #9 {
  %1 = tail call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %arg, i32 1) #14
  ret <4 x double> %1
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x float> @trunc_f32x8(<8 x float> %arg) #9 {
  %1 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %arg, i32 3) #14
  ret <8 x float> %1
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <4 x double> @trunc_f64x4(<4 x double> %arg) #9 {
  %1 = tail call <4 x double> @llvm.x86.avx.round.pd.256(<4 x double> %arg, i32 3) #14
  ret <4 x double> %1
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <8 x float> @abs_f32x8(<8 x float> %x) #6 {
  %arg = bitcast <8 x float> %x to <8 x i32>
  %mask = lshr <8 x i32> <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %masked = and <8 x i32> %arg, %mask
  %result = bitcast <8 x i32> %masked to <8 x float>
  ret <8 x float> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <4 x double> @abs_f64x4(<4 x double> %x) #6 {
  %arg = bitcast <4 x double> %x to <4 x i64>
  %mask = lshr <4 x i64> <i64 -1, i64 -1, i64 -1, i64 -1>, <i64 1, i64 1, i64 1, i64 1>
  %masked = and <4 x i64> %arg, %mask
  %result = bitcast <4 x i64> %masked to <4 x double>
  ret <4 x double> %result
}

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <8 x float> @fast_inverse_f32x8(<8 x float> %x) #6 {
  %approx = tail call <8 x float> @llvm.x86.avx.rcp.ps.256(<8 x float> %x)
  ret <8 x float> %approx
}

; Function Attrs: nounwind readnone
declare <8 x float> @llvm.x86.avx.rcp.ps.256(<8 x float>) #8

; Function Attrs: alwaysinline nounwind readnone uwtable
define linkonce_odr <8 x float> @fast_inverse_sqrt_f32x8(<8 x float> %x) #6 {
  %approx = tail call <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float> %x)
  ret <8 x float> %approx
}

; Function Attrs: nounwind readnone
declare <8 x float> @llvm.x86.avx.rsqrt.ps.256(<8 x float>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <32 x i8> @pavgbx32(<32 x i8> %a, <32 x i8> %b) #9 {
  %1 = zext <32 x i8> %a to <32 x i32>
  %2 = zext <32 x i8> %b to <32 x i32>
  %3 = add nuw nsw <32 x i32> %1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %4 = add nuw nsw <32 x i32> %3, %2
  %5 = lshr <32 x i32> %4, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %6 = trunc <32 x i32> %5 to <32 x i8>
  ret <32 x i8> %6
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <16 x i16> @pavgwx16(<16 x i16> %a, <16 x i16> %b) #9 {
  %1 = zext <16 x i16> %a to <16 x i32>
  %2 = zext <16 x i16> %b to <16 x i32>
  %3 = add nuw nsw <16 x i32> %1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %4 = add nuw nsw <16 x i32> %3, %2
  %5 = lshr <16 x i32> %4, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %6 = trunc <16 x i32> %5 to <16 x i16>
  ret <16 x i16> %6
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <16 x i16> @packssdwx16(<16 x i32> %arg) #9 {
  %1 = shufflevector <16 x i32> %arg, <16 x i32> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  %2 = shufflevector <16 x i32> %arg, <16 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 12, i32 13, i32 14, i32 15>
  %3 = tail call <16 x i16> @llvm.x86.avx2.packssdw(<8 x i32> %1, <8 x i32> %2)
  ret <16 x i16> %3
}

; Function Attrs: nounwind readnone
declare <16 x i16> @llvm.x86.avx2.packssdw(<8 x i32>, <8 x i32>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <32 x i8> @packuswbx32(<32 x i16> %arg) #9 {
  %1 = shufflevector <32 x i16> %arg, <32 x i16> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %2 = shufflevector <32 x i16> %arg, <32 x i16> undef, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %3 = call <32 x i8> @llvm.x86.avx2.packuswb(<16 x i16> %1, <16 x i16> %2)
  ret <32 x i8> %3
}

; Function Attrs: nounwind readnone
declare <32 x i8> @llvm.x86.avx2.packuswb(<16 x i16>, <16 x i16>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <32 x i8> @packsswbx32(<32 x i16> %arg) #9 {
  %1 = shufflevector <32 x i16> %arg, <32 x i16> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  %2 = shufflevector <32 x i16> %arg, <32 x i16> undef, <16 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %3 = call <32 x i8> @llvm.x86.avx2.packsswb(<16 x i16> %1, <16 x i16> %2)
  ret <32 x i8> %3
}

; Function Attrs: nounwind readnone
declare <32 x i8> @llvm.x86.avx2.packsswb(<16 x i16>, <16 x i16>) #8

; Function Attrs: alwaysinline nounwind
define linkonce_odr <16 x i16> @packusdwx16(<16 x i32> %arg) #9 {
  %1 = shufflevector <16 x i32> %arg, <16 x i32> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  %2 = shufflevector <16 x i32> %arg, <16 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 12, i32 13, i32 14, i32 15>
  %3 = tail call <16 x i16> @llvm.x86.avx2.packusdw(<8 x i32> %1, <8 x i32> %2)
  ret <16 x i16> %3
}

; Function Attrs: nounwind readnone
declare <16 x i16> @llvm.x86.avx2.packusdw(<8 x i32>, <8 x i32>) #8

define linkonce_odr <32 x i8> @abs_i8x32(<32 x i8> %arg) {
  %1 = sub <32 x i8> zeroinitializer, %arg
  %2 = icmp sgt <32 x i8> %arg, zeroinitializer
  %3 = select <32 x i1> %2, <32 x i8> %arg, <32 x i8> %1
  ret <32 x i8> %3
}

define linkonce_odr <16 x i16> @abs_i16x16(<16 x i16> %arg) {
  %1 = sub <16 x i16> zeroinitializer, %arg
  %2 = icmp sgt <16 x i16> %arg, zeroinitializer
  %3 = select <16 x i1> %2, <16 x i16> %arg, <16 x i16> %1
  ret <16 x i16> %3
}

define linkonce_odr <8 x i32> @abs_i32x8(<8 x i32> %arg) {
  %1 = sub <8 x i32> zeroinitializer, %arg
  %2 = icmp sgt <8 x i32> %arg, zeroinitializer
  %3 = select <8 x i1> %2, <8 x i32> %arg, <8 x i32> %1
  ret <8 x i32> %3
}

; Function Attrs: alwaysinline nounwind
define linkonce_odr <8 x i32> @pmaddwdx8(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c, <8 x i16> %d) #9 {
  %1 = shufflevector <8 x i16> %a, <8 x i16> %c, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %2 = shufflevector <8 x i16> %b, <8 x i16> %d, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %3 = tail call <8 x i32> @llvm.x86.avx2.pmadd.wd(<16 x i16> %1, <16 x i16> %2)
  ret <8 x i32> %3
}

; Function Attrs: nounwind readnone
declare <8 x i32> @llvm.x86.avx2.pmadd.wd(<16 x i16>, <16 x i16>) #8

; Function Attrs: nounwind
define weak i32 @halide_default_can_use_target_features(i32, i64*) #0 {
  %3 = alloca %"struct.Halide::Runtime::Internal::CpuFeatures", align 8
  %4 = load i1, i1* @_ZZ38halide_default_can_use_target_featuresE11initialized, align 1
  br i1 %4, label %8, label %5

; <label>:5:                                      ; preds = %2
  %6 = bitcast %"struct.Halide::Runtime::Internal::CpuFeatures"* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %6) #14
  call void @_ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv(%"struct.Halide::Runtime::Internal::CpuFeatures"* nonnull sret %3) #13
  %7 = call i8* @memcpy(i8* bitcast ([2 x i64]* @_ZZ38halide_default_can_use_target_featuresE20cpu_features_storage to i8*), i8* nonnull %6, i64 16) #13
  store i1 true, i1* @_ZZ38halide_default_can_use_target_featuresE11initialized, align 1
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %6) #14
  br label %8

; <label>:8:                                      ; preds = %5, %2
  %9 = icmp eq i32 %0, 1
  br i1 %9, label %11, label %10

; <label>:10:                                     ; preds = %8
  call void @halide_error(i8* null, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @.str.208, i64 0, i64 0)) #13
  br label %11

; <label>:11:                                     ; preds = %10, %8
  %12 = load i64, i64* %1, align 8, !tbaa !11
  %13 = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @_ZZ38halide_default_can_use_target_featuresE20cpu_features_storage, i64 0, i64 0), align 8, !tbaa !11
  %14 = and i64 %13, %12
  %15 = icmp eq i64 %14, 0
  br i1 %15, label %20, label %16

; <label>:16:                                     ; preds = %11
  %17 = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @_ZZ38halide_default_can_use_target_featuresE20cpu_features_storage, i64 0, i64 1), align 8, !tbaa !11
  %18 = and i64 %17, %14
  %19 = icmp eq i64 %18, %14
  br i1 %19, label %20, label %21

; <label>:20:                                     ; preds = %16, %11
  br label %21

; <label>:21:                                     ; preds = %20, %16
  %22 = phi i32 [ 0, %16 ], [ 1, %20 ]
  ret i32 %22
}

; Function Attrs: norecurse nounwind
define weak i32 (i32, i64*)* @halide_set_custom_can_use_target_features(i32 (i32, i64*)*) local_unnamed_addr #2 {
  %2 = load i32 (i32, i64*)*, i32 (i32, i64*)** @_ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE, align 8, !tbaa !3
  store i32 (i32, i64*)* %0, i32 (i32, i64*)** @_ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE, align 8, !tbaa !3
  ret i32 (i32, i64*)* %2
}

; Function Attrs: nounwind
define weak i32 @halide_can_use_target_features(i32, i64*) local_unnamed_addr #0 {
  %3 = load i32 (i32, i64*)*, i32 (i32, i64*)** @_ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE, align 8, !tbaa !3
  %4 = tail call i32 %3(i32 %0, i64* %1) #13
  ret i32 %4
}

; Function Attrs: nounwind
define linkonce void @_ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv(%"struct.Halide::Runtime::Internal::CpuFeatures"* noalias sret) local_unnamed_addr #0 {
  %2 = alloca [4 x i32], align 4
  %3 = alloca [4 x i32], align 4
  %4 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CpuFeatures", %"struct.Halide::Runtime::Internal::CpuFeatures"* %0, i64 0, i32 0, i64 0
  %5 = getelementptr inbounds %"struct.Halide::Runtime::Internal::CpuFeatures", %"struct.Halide::Runtime::Internal::CpuFeatures"* %0, i64 0, i32 1, i64 0
  store i64 0, i64* %5, align 8, !tbaa !11
  store i64 4123168604912, i64* %4, align 8, !tbaa !11
  %6 = bitcast [4 x i32]* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %6) #14
  %7 = getelementptr inbounds [4 x i32], [4 x i32]* %2, i64 0, i64 0
  store i32 1, i32* %7, align 4, !tbaa !96
  call void @x86_cpuid_halide(i32* nonnull %7) #13
  %8 = getelementptr inbounds [4 x i32], [4 x i32]* %2, i64 0, i64 2
  %9 = load i32, i32* %8, align 4, !tbaa !96
  %10 = and i32 %9, 4096
  %11 = icmp eq i32 %10, 0
  %12 = lshr i32 %9, 15
  %13 = and i32 %12, 16
  %14 = lshr i32 %9, 23
  %15 = and i32 %14, 32
  %16 = or i32 %15, %13
  %17 = lshr i32 %9, 20
  %18 = and i32 %17, 512
  %19 = or i32 %18, %16
  %20 = zext i32 %19 to i64
  %21 = or i64 %20, 128
  %22 = select i1 %11, i64 %20, i64 %21
  %23 = and i32 %9, 805830656
  %24 = icmp ne i32 %23, 0
  %25 = xor i1 %11, true
  %26 = or i1 %24, %25
  br i1 %26, label %27, label %28

; <label>:27:                                     ; preds = %1
  store i64 %22, i64* %5, align 8, !tbaa !11
  br label %28

; <label>:28:                                     ; preds = %27, %1
  %29 = and i32 %9, 1879048192
  %30 = icmp eq i32 %29, 1879048192
  br i1 %30, label %31, label %59

; <label>:31:                                     ; preds = %28
  %32 = bitcast [4 x i32]* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %32) #14
  %33 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 0
  store i32 7, i32* %33, align 4, !tbaa !96
  call void @x86_cpuid_halide(i32* nonnull %33) #13
  %34 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 1
  %35 = load i32, i32* %34, align 4, !tbaa !96
  %36 = and i32 %35, 32
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %40, label %38

; <label>:38:                                     ; preds = %31
  %39 = or i64 %22, 64
  store i64 %39, i64* %5, align 8, !tbaa !11
  br label %40

; <label>:40:                                     ; preds = %38, %31
  %41 = phi i64 [ %22, %31 ], [ %39, %38 ]
  %42 = and i32 %35, 268500992
  %43 = icmp eq i32 %42, 268500992
  br i1 %43, label %44, label %58

; <label>:44:                                     ; preds = %40
  %45 = and i32 %35, 469827584
  %46 = icmp eq i32 %45, 469827584
  %47 = select i1 %46, i64 824633720832, i64 274877906944
  %48 = or i64 %41, %47
  %49 = and i32 %35, -805109760
  %50 = icmp eq i32 %49, -805109760
  %51 = or i64 %48, 1099511627776
  %52 = select i1 %50, i64 %51, i64 %48
  store i64 %52, i64* %5, align 8, !tbaa !11
  %53 = and i32 %35, -803012608
  %54 = icmp eq i32 %53, -803012608
  br i1 %54, label %55, label %58

; <label>:55:                                     ; preds = %44
  %56 = select i1 %50, i64 %51, i64 %48
  %57 = or i64 %56, 2199023255552
  store i64 %57, i64* %5, align 8, !tbaa !11
  br label %58

; <label>:58:                                     ; preds = %55, %44, %40
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %32) #14
  br label %59

; <label>:59:                                     ; preds = %58, %28
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %6) #14
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce void @_ZN6Halide7Runtime8Internal21halide_use_jit_moduleEv() local_unnamed_addr #2 {
  ret void
}

; Function Attrs: norecurse nounwind
define linkonce void @_ZN6Halide7Runtime8Internal25halide_release_jit_moduleEv() local_unnamed_addr #2 {
  ret void
}

define i32 @brighter(i8* noalias %input, i8* noalias %input1, i8* noalias %brighter) {
entry:
  br i1 false, label %true_bb, label %false_bb

true_bb:                                          ; preds = %entry
  br label %after_bb

false_bb:                                         ; preds = %entry
  br label %after_bb

after_bb:                                         ; preds = %false_bb, %true_bb
  br i1 false, label %true_bb1, label %false_bb2

true_bb1:                                         ; preds = %after_bb
  br label %after_bb3

false_bb2:                                        ; preds = %after_bb
  br label %after_bb3

after_bb3:                                        ; preds = %false_bb2, %true_bb1
  br i1 false, label %true_bb4, label %false_bb5

true_bb4:                                         ; preds = %after_bb3
  br label %after_bb6

false_bb5:                                        ; preds = %after_bb3
  br label %after_bb6

after_bb6:                                        ; preds = %false_bb5, %true_bb4
  br i1 true, label %true_bb7, label %false_bb8

true_bb7:                                         ; preds = %after_bb6
  br label %"produce brighter"

false_bb8:                                        ; preds = %after_bb6
  br label %after_bb9

after_bb9:                                        ; preds = %false_bb8, %"end for brighter.s0.x"
  br label %destructor_block

"produce brighter":                               ; preds = %true_bb7
  br i1 true, label %"for brighter.s0.x", label %"end for brighter.s0.x", !prof !231

"for brighter.s0.x":                              ; preds = %"for brighter.s0.x", %"produce brighter"
  %brighter.s0.x = phi i32 [ 0, %"produce brighter" ], [ %10, %"for brighter.s0.x" ]
  %0 = sext i32 %brighter.s0.x to i64
  %1 = getelementptr inbounds i8, i8* %input, i64 %0
  %2 = load i8, i8* %1, align 1, !tbaa !232
  %3 = sext i32 %brighter.s0.x to i64
  %4 = getelementptr inbounds i8, i8* %input1, i64 %3
  %5 = load i8, i8* %4, align 1, !tbaa !235
  %6 = add i8 %2, %5
  %7 = sext i32 %brighter.s0.x to i64
  %8 = sub nsw i64 %7, 0
  %9 = getelementptr inbounds i8, i8* %brighter, i64 %8
  store i8 %6, i8* %9, align 1, !tbaa !237
  %10 = add nsw i32 %brighter.s0.x, 1
  %11 = icmp ne i32 %10, 10
  br i1 %11, label %"for brighter.s0.x", label %"end for brighter.s0.x"

"end for brighter.s0.x":                          ; preds = %"for brighter.s0.x", %"produce brighter"
  br label %after_bb9

destructor_block:                                 ; preds = %after_bb9
  ret i32 0
}

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { alwaysinline norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { alwaysinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { alwaysinline nounwind readnone uwtable }
attributes #7 = { nounwind readnone speculatable }
attributes #8 = { nounwind readnone }
attributes #9 = { alwaysinline nounwind }
attributes #10 = { nounwind uwtable }
attributes #11 = { inaccessiblemem_or_argmemonly nounwind }
attributes #12 = { alwaysinline inlinehint nounwind optsize readnone uwtable }
attributes #13 = { nobuiltin nounwind }
attributes #14 = { nounwind }
attributes #15 = { nobuiltin }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 1}
!2 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!5, !5, i64 0}
!8 = !{!9, !9, i64 0}
!9 = !{!"bool", !5, i64 0}
!10 = !{i8 0, i8 2}
!11 = !{!12, !12, i64 0}
!12 = !{!"long long", !5, i64 0}
!13 = !{!14, !15, i64 0}
!14 = !{!"_ZTS18mach_timebase_info", !15, i64 0, !15, i64 4}
!15 = !{!"int", !5, i64 0}
!16 = !{!14, !15, i64 4}
!17 = !{!18, !9, i64 2109}
!18 = !{!"_ZTSN6Halide7Runtime8Internal12work_queue_tE", !19, i64 0, !15, i64 8, !15, i64 12, !4, i64 16, !15, i64 24, !15, i64 28, !20, i64 32, !20, i64 40, !20, i64 48, !5, i64 56, !15, i64 2104, !9, i64 2108, !9, i64 2109}
!19 = !{!"_ZTS12halide_mutex", !5, i64 0}
!20 = !{!"_ZTS11halide_cond", !5, i64 0}
!21 = !{!18, !15, i64 2104}
!22 = !{!18, !15, i64 8}
!23 = !{!18, !15, i64 24}
!24 = !{!25, !4, i64 8}
!25 = !{!"_ZTSN6Halide7Runtime8Internal4workE", !4, i64 0, !4, i64 8, !4, i64 16, !15, i64 24, !15, i64 28, !4, i64 32, !15, i64 40, !15, i64 44}
!26 = !{!25, !4, i64 16}
!27 = !{!25, !15, i64 24}
!28 = !{!25, !15, i64 28}
!29 = !{!25, !4, i64 32}
!30 = !{!25, !15, i64 44}
!31 = !{!25, !15, i64 40}
!32 = !{!18, !4, i64 16}
!33 = !{!18, !15, i64 28}
!34 = !{!25, !4, i64 0}
!35 = !{!36, !4, i64 8}
!36 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization15parking_controlE", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24}
!37 = !{!36, !4, i64 24}
!38 = !{!39, !4, i64 32}
!39 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE", !4, i64 32}
!40 = !{!36, !4, i64 0}
!41 = !{!36, !4, i64 16}
!42 = !{!43, !4, i64 0}
!43 = !{!"_ZTSN6Halide7Runtime8Internal14spawned_threadE", !4, i64 0, !4, i64 8, !44, i64 16}
!44 = !{!"long", !5, i64 0}
!45 = !{!43, !4, i64 8}
!46 = !{!43, !44, i64 16}
!47 = !{!48, !4, i64 32}
!48 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE", !4, i64 32, !4, i64 40}
!49 = !{!48, !4, i64 40}
!50 = !{!18, !9, i64 2108}
!51 = !{!52, !4, i64 144}
!52 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization10queue_dataE", !53, i64 0, !12, i64 136, !4, i64 144, !12, i64 152}
!53 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization13thread_parkerE", !54, i64 0, !55, i64 64, !9, i64 128}
!54 = !{!"_ZTS15pthread_mutex_t", !5, i64 0}
!55 = !{!"_ZTS14pthread_cond_t", !5, i64 0}
!56 = !{!57, !4, i64 16}
!57 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization11hash_bucketE", !58, i64 0, !4, i64 8, !4, i64 16}
!58 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization9word_lockE", !12, i64 0}
!59 = !{!52, !12, i64 152}
!60 = !{!53, !9, i64 128}
!61 = !{!62, !4, i64 152}
!62 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization20word_lock_queue_dataE", !53, i64 0, !4, i64 136, !4, i64 144, !4, i64 152}
!63 = !{!62, !4, i64 136}
!64 = !{!62, !4, i64 144}
!65 = !{!66, !4, i64 32}
!66 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE", !4, i64 32, !4, i64 40}
!67 = !{!66, !4, i64 40}
!68 = !{!69, !12, i64 8}
!69 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization15validate_actionE", !9, i64 0, !12, i64 8}
!70 = !{!52, !12, i64 136}
!71 = !{!69, !9, i64 0}
!72 = !{!57, !4, i64 8}
!73 = !{!74, !4, i64 0}
!74 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization11bucket_pairE", !4, i64 0, !4, i64 8}
!75 = !{!74, !4, i64 8}
!76 = !{!77, !4, i64 32}
!77 = !{!"_ZTSN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE", !4, i64 32, !4, i64 40}
!78 = !{!77, !4, i64 40}
!79 = !{!80, !15, i64 36}
!80 = !{!"_ZTS15halide_buffer_t", !12, i64 0, !4, i64 8, !4, i64 16, !12, i64 24, !81, i64 32, !15, i64 36, !4, i64 40, !4, i64 48}
!81 = !{!"_ZTS13halide_type_t", !5, i64 0, !5, i64 1, !82, i64 2}
!82 = !{!"short", !5, i64 0}
!83 = !{!80, !4, i64 16}
!84 = !{!80, !12, i64 0}
!85 = !{!80, !4, i64 8}
!86 = !{!80, !4, i64 40}
!87 = !{!88, !15, i64 0}
!88 = !{!"_ZTS18halide_dimension_t", !15, i64 0, !15, i64 4, !15, i64 8, !15, i64 12}
!89 = !{!88, !15, i64 4}
!90 = !{!88, !15, i64 8}
!91 = !{!80, !12, i64 24}
!92 = !{!80, !5, i64 32}
!93 = !{!80, !5, i64 33}
!94 = !{!80, !82, i64 34}
!95 = !{i64 0, i64 4, !96, i64 4, i64 4, !96, i64 8, i64 4, !96, i64 12, i64 4, !96}
!96 = !{!15, !15, i64 0}
!97 = !{i64 0, i64 8, !11, i64 8, i64 8, !3, i64 16, i64 8, !3, i64 24, i64 8, !11, i64 32, i64 1, !7, i64 33, i64 1, !7, i64 34, i64 2, !98, i64 36, i64 4, !96, i64 40, i64 8, !3, i64 48, i64 8, !3}
!98 = !{!82, !82, i64 0}
!99 = !{!81, !5, i64 1}
!100 = !{!101, !4, i64 72}
!101 = !{!"_ZTS25halide_device_interface_t", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !4, i64 32, !4, i64 40, !4, i64 48, !4, i64 56, !4, i64 64, !4, i64 72, !4, i64 80, !4, i64 88, !4, i64 96, !4, i64 104, !4, i64 112}
!102 = !{!101, !4, i64 32}
!103 = !{!101, !4, i64 8}
!104 = !{!101, !4, i64 88}
!105 = !{!106, !82, i64 34}
!106 = !{!"_ZTS20halide_trace_event_t", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !81, i64 32, !107, i64 36, !15, i64 40, !15, i64 44, !15, i64 48}
!107 = !{!"_ZTS25halide_trace_event_code_t", !5, i64 0}
!108 = !{!106, !15, i64 48}
!109 = !{!106, !4, i64 0}
!110 = !{!106, !4, i64 24}
!111 = !{!112, !15, i64 0}
!112 = !{!"_ZTSN6Halide7Runtime8Internal23SharedExclusiveSpinLockE", !15, i64 0}
!113 = !{!114, !15, i64 4}
!114 = !{!"_ZTSN6Halide7Runtime8Internal11TraceBufferE", !112, i64 0, !15, i64 4, !15, i64 8, !5, i64 12}
!115 = !{!114, !15, i64 8}
!116 = !{!117, !15, i64 0}
!117 = !{!"_ZTS21halide_trace_packet_t", !15, i64 0, !15, i64 4, !81, i64 8, !107, i64 12, !15, i64 16, !15, i64 20, !15, i64 24}
!118 = !{!117, !15, i64 4}
!119 = !{!106, !107, i64 36}
!120 = !{!117, !107, i64 12}
!121 = !{!106, !15, i64 40}
!122 = !{!117, !15, i64 16}
!123 = !{!106, !15, i64 44}
!124 = !{!117, !15, i64 20}
!125 = !{!117, !15, i64 24}
!126 = !{!106, !4, i64 16}
!127 = !{!106, !4, i64 8}
!128 = !{!117, !82, i64 10}
!129 = !{!106, !5, i64 33}
!130 = !{!106, !5, i64 32}
!131 = !{!132, !132, i64 0}
!132 = !{!"float", !5, i64 0}
!133 = !{!134, !134, i64 0}
!134 = !{!"double", !5, i64 0}
!135 = !{!88, !15, i64 12}
!136 = !{!137, !82, i64 0}
!137 = !{!"_ZTSN6Halide7Runtime8Internal18halide_tiff_headerE", !82, i64 0, !82, i64 2, !15, i64 4, !82, i64 8, !5, i64 10, !15, i64 190, !5, i64 194, !5, i64 202}
!138 = !{!137, !82, i64 2}
!139 = !{!137, !15, i64 4}
!140 = !{!137, !82, i64 8}
!141 = !{!142, !82, i64 0}
!142 = !{!"_ZTSN6Halide7Runtime8Internal8tiff_tagE", !82, i64 0, !82, i64 2, !15, i64 4, !5, i64 8}
!143 = !{!142, !82, i64 2}
!144 = !{!142, !15, i64 4}
!145 = !{!137, !15, i64 190}
!146 = !{!147, !4, i64 0}
!147 = !{!"_ZTSN6Halide7Runtime8Internal10CacheEntryE", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !44, i64 32, !4, i64 40, !15, i64 48, !15, i64 52, !15, i64 56, !15, i64 60, !4, i64 64, !4, i64 72}
!148 = !{!147, !15, i64 56}
!149 = !{!147, !4, i64 24}
!150 = !{!147, !4, i64 72}
!151 = !{!152, !12, i64 0}
!152 = !{!"_ZTSN6Halide7Runtime8Internal11device_copyE", !12, i64 0, !12, i64 8, !12, i64 16, !5, i64 24, !5, i64 152, !5, i64 280, !12, i64 408}
!153 = !{!152, !12, i64 8}
!154 = !{!152, !12, i64 408}
!155 = !{!152, !12, i64 16}
!156 = !{i64 0, i64 8, !11, i64 8, i64 8, !11, i64 16, i64 8, !11, i64 24, i64 128, !7, i64 152, i64 128, !7, i64 280, i64 128, !7, i64 408, i64 8, !11}
!157 = !{!147, !4, i64 8}
!158 = !{!147, !4, i64 16}
!159 = !{!147, !44, i64 32}
!160 = !{!147, !15, i64 48}
!161 = !{!147, !15, i64 52}
!162 = !{!147, !15, i64 60}
!163 = !{!147, !4, i64 64}
!164 = !{!147, !4, i64 40}
!165 = !{!166, !15, i64 8}
!166 = !{!"_ZTSN6Halide7Runtime8Internal16CacheBlockHeaderE", !4, i64 0, !15, i64 8}
!167 = !{!166, !4, i64 0}
!168 = !{!81, !5, i64 0}
!169 = !{!81, !82, i64 2}
!170 = !{!101, !4, i64 112}
!171 = !{!172, !4, i64 48}
!172 = !{!"_ZTS30halide_device_interface_impl_t", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !4, i64 32, !4, i64 40, !4, i64 48, !4, i64 56, !4, i64 64, !4, i64 72, !4, i64 80, !4, i64 88, !4, i64 96, !4, i64 104, !4, i64 112, !4, i64 120}
!173 = !{!172, !4, i64 40}
!174 = !{!172, !4, i64 56}
!175 = !{!172, !4, i64 0}
!176 = !{!172, !4, i64 16}
!177 = !{!172, !4, i64 8}
!178 = !{!172, !4, i64 32}
!179 = !{!172, !4, i64 24}
!180 = !{!172, !4, i64 64}
!181 = !{!172, !4, i64 72}
!182 = !{!172, !4, i64 112}
!183 = !{!172, !4, i64 120}
!184 = !{!172, !4, i64 80}
!185 = !{!172, !4, i64 88}
!186 = !{!172, !4, i64 96}
!187 = !{!172, !4, i64 104}
!188 = !{i32 22, i32 33}
!189 = !{!190, !15, i64 64}
!190 = !{!"_ZTS8buffer_t", !12, i64 0, !4, i64 8, !5, i64 16, !5, i64 32, !5, i64 48, !15, i64 64, !9, i64 68, !9, i64 69, !5, i64 70}
!191 = !{!190, !4, i64 8}
!192 = !{!190, !12, i64 0}
!193 = !{!194, !12, i64 0}
!194 = !{!"_ZTSN6Halide7Runtime8Internal15old_dev_wrapperE", !12, i64 0, !4, i64 8}
!195 = !{!194, !4, i64 8}
!196 = !{!190, !9, i64 68}
!197 = !{!190, !9, i64 69}
!198 = !{!199, !4, i64 40}
!199 = !{!"_ZTS21halide_profiler_state", !19, i64 0, !15, i64 8, !15, i64 12, !15, i64 16, !15, i64 20, !4, i64 24, !4, i64 32, !4, i64 40}
!200 = !{!199, !15, i64 16}
!201 = !{!202, !12, i64 0}
!202 = !{!"_ZTS30halide_profiler_pipeline_stats", !12, i64 0, !12, i64 8, !12, i64 16, !12, i64 24, !12, i64 32, !12, i64 40, !4, i64 48, !4, i64 56, !4, i64 64, !15, i64 72, !15, i64 76, !15, i64 80, !15, i64 84, !15, i64 88}
!203 = !{!202, !15, i64 80}
!204 = !{!202, !12, i64 32}
!205 = !{!202, !12, i64 40}
!206 = !{!202, !4, i64 48}
!207 = !{!202, !15, i64 84}
!208 = !{!202, !15, i64 88}
!209 = !{!202, !12, i64 16}
!210 = !{!202, !12, i64 24}
!211 = !{!202, !15, i64 72}
!212 = !{!202, !4, i64 56}
!213 = !{!214, !12, i64 32}
!214 = !{!"_ZTS26halide_profiler_func_stats", !12, i64 0, !12, i64 8, !12, i64 16, !12, i64 24, !12, i64 32, !12, i64 40, !12, i64 48, !4, i64 56, !15, i64 64}
!215 = !{!214, !12, i64 0}
!216 = !{!214, !4, i64 56}
!217 = !{!214, !12, i64 40}
!218 = !{!214, !12, i64 48}
!219 = !{!214, !15, i64 64}
!220 = !{!214, !12, i64 24}
!221 = !{!214, !12, i64 16}
!222 = !{!199, !4, i64 24}
!223 = !{!202, !4, i64 64}
!224 = !{!199, !15, i64 12}
!225 = !{!202, !15, i64 76}
!226 = !{!202, !12, i64 8}
!227 = !{!214, !12, i64 8}
!228 = !{!199, !4, i64 32}
!229 = !{!199, !15, i64 20}
!230 = !{!199, !15, i64 8}
!231 = !{!"branch_weights", i32 1073741824, i32 0}
!232 = !{!233, !233, i64 0}
!233 = !{!"input", !234, i64 0}
!234 = !{!"Halide buffer"}
!235 = !{!236, !236, i64 0}
!236 = !{!"input1", !234, i64 0}
!237 = !{!238, !238, i64 0}
!238 = !{!"brighter", !234, i64 0}
