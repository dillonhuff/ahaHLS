; ModuleID = './apps/hardware_benchmarks/apps/cascade/bin/vhls_target.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

%class.hls_stream_AxiPackedStencil_uint16_t_1_1__ = type { i32, [1000 x %class.AxiPackedStencil_uint16_t_1_1_] }
%class.AxiPackedStencil_uint16_t_1_1_ = type { [21 x i16], [1 x i16] }
%class.ram_int32_t_9 = type { i8 }
%class.hls_stream_PackedStencil_uint16_t_3_3__ = type { i32, [1000 x %class.AxiPackedStencil_uint16_t_3_3_] }
%class.AxiPackedStencil_uint16_t_3_3_ = type { [29 x i16], [9 x i16] }
%class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16 = type { i8 }
%class.hls_stream_PackedStencil_int32_t_1_1__ = type { i32, [1000 x %class.AxiPackedStencil_int32_t_1_1_] }
%class.AxiPackedStencil_int32_t_1_1_ = type { [21 x i32], [1 x i32] }
%class.hls_stream_PackedStencil_int32_t_3_3__ = type { i32, [1000 x %class.AxiPackedStencil_int32_t_3_3_] }
%class.AxiPackedStencil_int32_t_3_3_ = type { [29 x i32], [9 x i32] }
%class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14 = type { i8 }

; Function Attrs: ssp uwtable
define void @_Z11vhls_targetR42hls_stream_AxiPackedStencil_uint16_t_1_1__S0_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(44004) %arg_0, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(44004) %arg_1) #0 {
  %_kernela0 = alloca %class.ram_int32_t_9, align 1
  %_hw_input_stencil_stream = alloca %class.hls_stream_PackedStencil_uint16_t_3_3__, align 4
  %_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream = alloca %class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16, align 1
  %1 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %2 = alloca %class.AxiPackedStencil_uint16_t_3_3_, align 2
  %3 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %_hw_input_stencil_stream_to_conv1 = alloca %class.hls_stream_PackedStencil_uint16_t_3_3__, align 4
  %_tmp_stencil = alloca %class.AxiPackedStencil_uint16_t_3_3_, align 2
  %4 = alloca %class.AxiPackedStencil_uint16_t_3_3_, align 2
  %_conv1_stencil_update_stream = alloca %class.hls_stream_PackedStencil_int32_t_1_1__, align 4
  %_hw_input_stencil = alloca %class.AxiPackedStencil_uint16_t_3_3_, align 2
  %5 = alloca %class.AxiPackedStencil_uint16_t_3_3_, align 2
  %_conv1_stencil = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %6 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %_conv1_stencil_stream = alloca %class.hls_stream_PackedStencil_int32_t_3_3__, align 4
  %_lb__conv1_stencil_update_stream_to__conv1_stencil_stream = alloca %class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14, align 1
  %7 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %8 = alloca %class.AxiPackedStencil_int32_t_3_3_, align 4
  %9 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %_conv1_stencil_stream_to_conv2 = alloca %class.hls_stream_PackedStencil_int32_t_3_3__, align 4
  %_tmp_stencil6 = alloca %class.AxiPackedStencil_int32_t_3_3_, align 4
  %10 = alloca %class.AxiPackedStencil_int32_t_3_3_, align 4
  %_conv2_stencil_stream = alloca %class.hls_stream_PackedStencil_int32_t_1_1__, align 4
  %_conv1_stencil7 = alloca %class.AxiPackedStencil_int32_t_3_3_, align 4
  %11 = alloca %class.AxiPackedStencil_int32_t_3_3_, align 4
  %_conv2_stencil = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %12 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %_conv2_stencil_stream_to_hw_output = alloca %class.hls_stream_PackedStencil_int32_t_1_1__, align 4
  %_tmp_stencil10 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %13 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %_conv2_stencil11 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %14 = alloca %class.AxiPackedStencil_int32_t_1_1_, align 4
  %_hw_output_stencil = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %_hw_output_stencil_packed = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %15 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %16 = getelementptr inbounds %class.ram_int32_t_9, %class.ram_int32_t_9* %_kernela0, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %16) #3
  br label %20

; <label>:17                                      ; preds = %22
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 0, i32 1)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 3, i32 2)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 6, i32 1)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 1, i32 2)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 4, i32 4)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 7, i32 2)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 2, i32 1)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 5, i32 2)
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 8, i32 1)
  %18 = bitcast %class.hls_stream_PackedStencil_uint16_t_3_3__* %_hw_input_stencil_stream to i8*
  call void @llvm.lifetime.start(i64 76004, i8* %18) #3
  call void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__C1Ev(%class.hls_stream_PackedStencil_uint16_t_3_3__* nonnull %_hw_input_stencil_stream)
  %19 = getelementptr inbounds %class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16, %class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16* %_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %19) #3
  br label %27

; <label>:20                                      ; preds = %22, %0
  %_kernel_s0_y.056 = phi i32 [ 0, %0 ], [ %23, %22 ]
  %21 = mul nuw nsw i32 %_kernel_s0_y.056, 3
  br label %24

; <label>:22                                      ; preds = %24
  %23 = add nuw nsw i32 %_kernel_s0_y.056, 1
  %exitcond73 = icmp eq i32 %23, 3
  br i1 %exitcond73, label %17, label %20

; <label>:24                                      ; preds = %24, %20
  %_kernel_s0_x.055 = phi i32 [ 0, %20 ], [ %26, %24 ]
  %25 = add nuw nsw i32 %_kernel_s0_x.055, %21
  call void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9* nonnull %_kernela0, i32 %25, i32 0)
  %26 = add nuw nsw i32 %_kernel_s0_x.055, 1
  %exitcond72 = icmp eq i32 %26, 3
  br i1 %exitcond72, label %22, label %24

; <label>:27                                      ; preds = %27, %17
  %i.054 = phi i32 [ 0, %17 ], [ %28, %27 ]
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %1, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_0)
  call void @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_168lb_writeERK30AxiPackedStencil_uint16_t_1_1_(%class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16* nonnull %_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %1)
  %28 = add nuw nsw i32 %i.054, 1
  %exitcond71 = icmp eq i32 %28, 35
  br i1 %exitcond71, label %.preheader38, label %27

; <label>:29                                      ; preds = %34
  %30 = bitcast %class.hls_stream_PackedStencil_uint16_t_3_3__* %_hw_input_stencil_stream_to_conv1 to i8*
  call void @llvm.lifetime.start(i64 76004, i8* %30) #3
  call void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__C1Ev(%class.hls_stream_PackedStencil_uint16_t_3_3__* nonnull %_hw_input_stencil_stream_to_conv1)
  %31 = bitcast %class.AxiPackedStencil_uint16_t_3_3_* %_tmp_stencil to i8*
  br label %.preheader37

.preheader38:                                     ; preds = %27, %34
  %i1.053 = phi i32 [ %35, %34 ], [ 0, %27 ]
  %32 = call zeroext i1 @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_1614has_valid_dataEv(%class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16* nonnull %_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream)
  br i1 %32, label %33, label %34

; <label>:33                                      ; preds = %.preheader38
  call void @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_167lb_readEv(%class.AxiPackedStencil_uint16_t_3_3_* nonnull sret %2, %class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16* nonnull %_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream)
  call void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__5writeE30AxiPackedStencil_uint16_t_3_3_(%class.hls_stream_PackedStencil_uint16_t_3_3__* nonnull %_hw_input_stencil_stream, %class.AxiPackedStencil_uint16_t_3_3_* nonnull %2)
  br label %34

; <label>:34                                      ; preds = %.preheader38, %33
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %3, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_0)
  call void @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_168lb_writeERK30AxiPackedStencil_uint16_t_1_1_(%class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16* nonnull %_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %3)
  %35 = add nuw nsw i32 %i1.053, 1
  %exitcond70 = icmp eq i32 %35, 221
  br i1 %exitcond70, label %29, label %.preheader38

.preheader37:                                     ; preds = %40, %29
  %_dim_1.052 = phi i32 [ 0, %29 ], [ %41, %40 ]
  br label %42

; <label>:36                                      ; preds = %40
  %37 = bitcast %class.hls_stream_PackedStencil_int32_t_1_1__* %_conv1_stencil_update_stream to i8*
  call void @llvm.lifetime.start(i64 88004, i8* %37) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__C1Ev(%class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv1_stencil_update_stream)
  %38 = bitcast %class.AxiPackedStencil_uint16_t_3_3_* %_hw_input_stencil to i8*
  %39 = bitcast %class.AxiPackedStencil_int32_t_1_1_* %_conv1_stencil to i8*
  br label %.preheader36

; <label>:40                                      ; preds = %46
  %41 = add nuw nsw i32 %_dim_1.052, 1
  %exitcond69 = icmp eq i32 %41, 14
  br i1 %exitcond69, label %36, label %.preheader37

; <label>:42                                      ; preds = %46, %.preheader37
  %_dim_0.051 = phi i32 [ 0, %.preheader37 ], [ %47, %46 ]
  call void @llvm.lifetime.start(i64 76, i8* %31) #3
  call void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__4readEv(%class.AxiPackedStencil_uint16_t_3_3_* nonnull sret %_tmp_stencil, %class.hls_stream_PackedStencil_uint16_t_3_3__* nonnull %_hw_input_stencil_stream)
  %43 = or i32 %_dim_0.051, %_dim_1.052
  %44 = icmp sgt i32 %43, -1
  br i1 %44, label %45, label %46

; <label>:45                                      ; preds = %42
  call void @_ZN30AxiPackedStencil_uint16_t_3_3_C1ERKS_(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %4, %class.AxiPackedStencil_uint16_t_3_3_* nonnull dereferenceable(76) %_tmp_stencil)
  call void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__5writeE30AxiPackedStencil_uint16_t_3_3_(%class.hls_stream_PackedStencil_uint16_t_3_3__* nonnull %_hw_input_stencil_stream_to_conv1, %class.AxiPackedStencil_uint16_t_3_3_* nonnull %4)
  br label %46

; <label>:46                                      ; preds = %45, %42
  call void @llvm.lifetime.end(i64 76, i8* %31) #3
  %47 = add nuw nsw i32 %_dim_0.051, 1
  %exitcond68 = icmp eq i32 %47, 14
  br i1 %exitcond68, label %40, label %42

.preheader36:                                     ; preds = %51, %36
  %_conv1_y___scan_dim_1.050 = phi i32 [ 0, %36 ], [ %52, %51 ]
  br label %53

; <label>:48                                      ; preds = %51
  %49 = bitcast %class.hls_stream_PackedStencil_int32_t_3_3__* %_conv1_stencil_stream to i8*
  call void @llvm.lifetime.start(i64 152004, i8* %49) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_3_3__C1Ev(%class.hls_stream_PackedStencil_int32_t_3_3__* nonnull %_conv1_stencil_stream)
  %50 = getelementptr inbounds %class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14, %class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14* %_lb__conv1_stencil_update_stream_to__conv1_stencil_stream, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %50) #3
  br label %109

; <label>:51                                      ; preds = %53
  %52 = add nuw nsw i32 %_conv1_y___scan_dim_1.050, 1
  %exitcond67 = icmp eq i32 %52, 14
  br i1 %exitcond67, label %48, label %.preheader36

; <label>:53                                      ; preds = %53, %.preheader36
  %_conv1_x___scan_dim_0.049 = phi i32 [ 0, %.preheader36 ], [ %108, %53 ]
  call void @llvm.lifetime.start(i64 76, i8* %38) #3
  call void @_ZN30AxiPackedStencil_uint16_t_3_3_C1Ev(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil)
  call void @_ZN30AxiPackedStencil_uint16_t_3_3_3setEtmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  call void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__4readEv(%class.AxiPackedStencil_uint16_t_3_3_* nonnull sret %5, %class.hls_stream_PackedStencil_uint16_t_3_3__* nonnull %_hw_input_stencil_stream_to_conv1)
  call void @_ZN30AxiPackedStencil_uint16_t_3_3_4copyERKS_(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, %class.AxiPackedStencil_uint16_t_3_3_* nonnull dereferenceable(76) %5)
  call void @llvm.lifetime.start(i64 88, i8* %39) #3
  call void @_ZN29AxiPackedStencil_int32_t_1_1_C1Ev(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 0, i64 0, i64 0, i64 0)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 0, i64 0, i64 0, i64 0)
  %54 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %55 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 0)
  %56 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 0, i64 0, i64 0)
  %57 = zext i16 %56 to i32
  %58 = mul nsw i32 %57, %55
  %59 = add nsw i32 %58, %54
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %59, i64 0, i64 0, i64 0)
  %60 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %61 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 1)
  %62 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 1, i64 0, i64 0)
  %63 = zext i16 %62 to i32
  %64 = mul nsw i32 %63, %61
  %65 = add nsw i32 %64, %60
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %65, i64 0, i64 0, i64 0)
  %66 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %67 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 2)
  %68 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 2, i64 0, i64 0)
  %69 = zext i16 %68 to i32
  %70 = mul nsw i32 %69, %67
  %71 = add nsw i32 %70, %66
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %71, i64 0, i64 0, i64 0)
  %72 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %73 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 3)
  %74 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 0, i64 1, i64 0)
  %75 = zext i16 %74 to i32
  %76 = mul nsw i32 %75, %73
  %77 = add nsw i32 %76, %72
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %77, i64 0, i64 0, i64 0)
  %78 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %79 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 4)
  %80 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 1, i64 1, i64 0)
  %81 = zext i16 %80 to i32
  %82 = mul nsw i32 %81, %79
  %83 = add nsw i32 %82, %78
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %83, i64 0, i64 0, i64 0)
  %84 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %85 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 5)
  %86 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 2, i64 1, i64 0)
  %87 = zext i16 %86 to i32
  %88 = mul nsw i32 %87, %85
  %89 = add nsw i32 %88, %84
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %89, i64 0, i64 0, i64 0)
  %90 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %91 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 6)
  %92 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 0, i64 2, i64 0)
  %93 = zext i16 %92 to i32
  %94 = mul nsw i32 %93, %91
  %95 = add nsw i32 %94, %90
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %95, i64 0, i64 0, i64 0)
  %96 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %97 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 7)
  %98 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 1, i64 2, i64 0)
  %99 = zext i16 %98 to i32
  %100 = mul nsw i32 %99, %97
  %101 = add nsw i32 %100, %96
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %101, i64 0, i64 0, i64 0)
  %102 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i64 0, i64 0, i64 0)
  %103 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 8)
  %104 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_* nonnull %_hw_input_stencil, i64 2, i64 2, i64 0)
  %105 = zext i16 %104 to i32
  %106 = mul nsw i32 %105, %103
  %107 = add nsw i32 %106, %102
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv1_stencil, i32 %107, i64 0, i64 0, i64 0)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_C1ERKS_(%class.AxiPackedStencil_int32_t_1_1_* nonnull %6, %class.AxiPackedStencil_int32_t_1_1_* nonnull dereferenceable(88) %_conv1_stencil)
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__5writeE29AxiPackedStencil_int32_t_1_1_(%class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv1_stencil_update_stream, %class.AxiPackedStencil_int32_t_1_1_* nonnull %6)
  call void @llvm.lifetime.end(i64 88, i8* %39) #3
  call void @llvm.lifetime.end(i64 76, i8* %38) #3
  %108 = add nuw nsw i32 %_conv1_x___scan_dim_0.049, 1
  %exitcond66 = icmp eq i32 %108, 14
  br i1 %exitcond66, label %51, label %53

; <label>:109                                     ; preds = %109, %48
  %i2.048 = phi i32 [ 0, %48 ], [ %110, %109 ]
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__4readEv(%class.AxiPackedStencil_int32_t_1_1_* nonnull sret %7, %class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv1_stencil_update_stream)
  call void @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_148lb_writeERK29AxiPackedStencil_int32_t_1_1_(%class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14* nonnull %_lb__conv1_stencil_update_stream_to__conv1_stencil_stream, %class.AxiPackedStencil_int32_t_1_1_* nonnull dereferenceable(88) %7)
  %110 = add nuw nsw i32 %i2.048, 1
  %exitcond65 = icmp eq i32 %110, 31
  br i1 %exitcond65, label %.preheader35, label %109

; <label>:111                                     ; preds = %116
  %112 = bitcast %class.hls_stream_PackedStencil_int32_t_3_3__* %_conv1_stencil_stream_to_conv2 to i8*
  call void @llvm.lifetime.start(i64 152004, i8* %112) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_3_3__C1Ev(%class.hls_stream_PackedStencil_int32_t_3_3__* nonnull %_conv1_stencil_stream_to_conv2)
  %113 = bitcast %class.AxiPackedStencil_int32_t_3_3_* %_tmp_stencil6 to i8*
  br label %.preheader34

.preheader35:                                     ; preds = %109, %116
  %i3.047 = phi i32 [ %117, %116 ], [ 0, %109 ]
  %114 = call zeroext i1 @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_1414has_valid_dataEv(%class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14* nonnull %_lb__conv1_stencil_update_stream_to__conv1_stencil_stream)
  br i1 %114, label %115, label %116

; <label>:115                                     ; preds = %.preheader35
  call void @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_147lb_readEv(%class.AxiPackedStencil_int32_t_3_3_* nonnull sret %8, %class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14* nonnull %_lb__conv1_stencil_update_stream_to__conv1_stencil_stream)
  call void @_ZN38hls_stream_PackedStencil_int32_t_3_3__5writeE29AxiPackedStencil_int32_t_3_3_(%class.hls_stream_PackedStencil_int32_t_3_3__* nonnull %_conv1_stencil_stream, %class.AxiPackedStencil_int32_t_3_3_* nonnull %8)
  br label %116

; <label>:116                                     ; preds = %.preheader35, %115
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__4readEv(%class.AxiPackedStencil_int32_t_1_1_* nonnull sret %9, %class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv1_stencil_update_stream)
  call void @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_148lb_writeERK29AxiPackedStencil_int32_t_1_1_(%class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14* nonnull %_lb__conv1_stencil_update_stream_to__conv1_stencil_stream, %class.AxiPackedStencil_int32_t_1_1_* nonnull dereferenceable(88) %9)
  %117 = add nuw nsw i32 %i3.047, 1
  %exitcond64 = icmp eq i32 %117, 165
  br i1 %exitcond64, label %111, label %.preheader35

.preheader34:                                     ; preds = %122, %111
  %_dim_14.046 = phi i32 [ 0, %111 ], [ %123, %122 ]
  br label %124

; <label>:118                                     ; preds = %122
  %119 = bitcast %class.hls_stream_PackedStencil_int32_t_1_1__* %_conv2_stencil_stream to i8*
  call void @llvm.lifetime.start(i64 88004, i8* %119) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__C1Ev(%class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv2_stencil_stream)
  %120 = bitcast %class.AxiPackedStencil_int32_t_3_3_* %_conv1_stencil7 to i8*
  %121 = bitcast %class.AxiPackedStencil_int32_t_1_1_* %_conv2_stencil to i8*
  br label %.preheader33

; <label>:122                                     ; preds = %128
  %123 = add nuw nsw i32 %_dim_14.046, 1
  %exitcond63 = icmp eq i32 %123, 12
  br i1 %exitcond63, label %118, label %.preheader34

; <label>:124                                     ; preds = %128, %.preheader34
  %_dim_05.045 = phi i32 [ 0, %.preheader34 ], [ %129, %128 ]
  call void @llvm.lifetime.start(i64 152, i8* %113) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_3_3__4readEv(%class.AxiPackedStencil_int32_t_3_3_* nonnull sret %_tmp_stencil6, %class.hls_stream_PackedStencil_int32_t_3_3__* nonnull %_conv1_stencil_stream)
  %125 = or i32 %_dim_05.045, %_dim_14.046
  %126 = icmp sgt i32 %125, -1
  br i1 %126, label %127, label %128

; <label>:127                                     ; preds = %124
  call void @_ZN29AxiPackedStencil_int32_t_3_3_C1ERKS_(%class.AxiPackedStencil_int32_t_3_3_* nonnull %10, %class.AxiPackedStencil_int32_t_3_3_* nonnull dereferenceable(152) %_tmp_stencil6)
  call void @_ZN38hls_stream_PackedStencil_int32_t_3_3__5writeE29AxiPackedStencil_int32_t_3_3_(%class.hls_stream_PackedStencil_int32_t_3_3__* nonnull %_conv1_stencil_stream_to_conv2, %class.AxiPackedStencil_int32_t_3_3_* nonnull %10)
  br label %128

; <label>:128                                     ; preds = %127, %124
  call void @llvm.lifetime.end(i64 152, i8* %113) #3
  %129 = add nuw nsw i32 %_dim_05.045, 1
  %exitcond62 = icmp eq i32 %129, 12
  br i1 %exitcond62, label %122, label %124

.preheader33:                                     ; preds = %133, %118
  %_conv2_y___scan_dim_1.044 = phi i32 [ 0, %118 ], [ %134, %133 ]
  br label %135

; <label>:130                                     ; preds = %133
  %131 = bitcast %class.hls_stream_PackedStencil_int32_t_1_1__* %_conv2_stencil_stream_to_hw_output to i8*
  call void @llvm.lifetime.start(i64 88004, i8* %131) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__C1Ev(%class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv2_stencil_stream_to_hw_output)
  %132 = bitcast %class.AxiPackedStencil_int32_t_1_1_* %_tmp_stencil10 to i8*
  br label %.preheader32

; <label>:133                                     ; preds = %135
  %134 = add nuw nsw i32 %_conv2_y___scan_dim_1.044, 1
  %exitcond61 = icmp eq i32 %134, 12
  br i1 %exitcond61, label %130, label %.preheader33

; <label>:135                                     ; preds = %135, %.preheader33
  %_conv2_x___scan_dim_0.043 = phi i32 [ 0, %.preheader33 ], [ %181, %135 ]
  call void @llvm.lifetime.start(i64 152, i8* %120) #3
  call void @_ZN29AxiPackedStencil_int32_t_3_3_C1Ev(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7)
  call void @_ZN29AxiPackedStencil_int32_t_3_3_3setEimmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i32 0, i64 0, i64 0, i64 0)
  call void @_ZN38hls_stream_PackedStencil_int32_t_3_3__4readEv(%class.AxiPackedStencil_int32_t_3_3_* nonnull sret %11, %class.hls_stream_PackedStencil_int32_t_3_3__* nonnull %_conv1_stencil_stream_to_conv2)
  call void @_ZN29AxiPackedStencil_int32_t_3_3_4copyERKS_(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, %class.AxiPackedStencil_int32_t_3_3_* nonnull dereferenceable(152) %11)
  call void @llvm.lifetime.start(i64 88, i8* %121) #3
  call void @_ZN29AxiPackedStencil_int32_t_1_1_C1Ev(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 0, i64 0, i64 0, i64 0)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 0, i64 0, i64 0, i64 0)
  %136 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %137 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 0, i64 0, i64 0)
  %138 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 0)
  %139 = mul nsw i32 %138, %137
  %140 = add nsw i32 %139, %136
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %140, i64 0, i64 0, i64 0)
  %141 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %142 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 1, i64 0, i64 0)
  %143 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 1)
  %144 = mul nsw i32 %143, %142
  %145 = add nsw i32 %144, %141
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %145, i64 0, i64 0, i64 0)
  %146 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %147 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 2, i64 0, i64 0)
  %148 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 2)
  %149 = mul nsw i32 %148, %147
  %150 = add nsw i32 %149, %146
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %150, i64 0, i64 0, i64 0)
  %151 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %152 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 0, i64 1, i64 0)
  %153 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 3)
  %154 = mul nsw i32 %153, %152
  %155 = add nsw i32 %154, %151
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %155, i64 0, i64 0, i64 0)
  %156 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %157 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 1, i64 1, i64 0)
  %158 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 4)
  %159 = mul nsw i32 %158, %157
  %160 = add nsw i32 %159, %156
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %160, i64 0, i64 0, i64 0)
  %161 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %162 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 2, i64 1, i64 0)
  %163 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 5)
  %164 = mul nsw i32 %163, %162
  %165 = add nsw i32 %164, %161
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %165, i64 0, i64 0, i64 0)
  %166 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %167 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 0, i64 2, i64 0)
  %168 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 6)
  %169 = mul nsw i32 %168, %167
  %170 = add nsw i32 %169, %166
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %170, i64 0, i64 0, i64 0)
  %171 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %172 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 1, i64 2, i64 0)
  %173 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 7)
  %174 = mul nsw i32 %173, %172
  %175 = add nsw i32 %174, %171
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %175, i64 0, i64 0, i64 0)
  %176 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i64 0, i64 0, i64 0)
  %177 = call i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_* nonnull %_conv1_stencil7, i64 2, i64 2, i64 0)
  %178 = call i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9* nonnull %_kernela0, i32 8)
  %179 = mul nsw i32 %178, %177
  %180 = add nsw i32 %179, %176
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil, i32 %180, i64 0, i64 0, i64 0)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_C1ERKS_(%class.AxiPackedStencil_int32_t_1_1_* nonnull %12, %class.AxiPackedStencil_int32_t_1_1_* nonnull dereferenceable(88) %_conv2_stencil)
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__5writeE29AxiPackedStencil_int32_t_1_1_(%class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv2_stencil_stream, %class.AxiPackedStencil_int32_t_1_1_* nonnull %12)
  call void @llvm.lifetime.end(i64 88, i8* %121) #3
  call void @llvm.lifetime.end(i64 152, i8* %120) #3
  %181 = add nuw nsw i32 %_conv2_x___scan_dim_0.043, 1
  %exitcond60 = icmp eq i32 %181, 12
  br i1 %exitcond60, label %133, label %135

.preheader32:                                     ; preds = %185, %130
  %_dim_18.042 = phi i32 [ 0, %130 ], [ %186, %185 ]
  br label %187

.preheader31:                                     ; preds = %185
  %182 = bitcast %class.AxiPackedStencil_int32_t_1_1_* %_conv2_stencil11 to i8*
  %183 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_hw_output_stencil to i8*
  %184 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_hw_output_stencil_packed to i8*
  br label %.preheader

; <label>:185                                     ; preds = %191
  %186 = add nuw nsw i32 %_dim_18.042, 1
  %exitcond59 = icmp eq i32 %186, 12
  br i1 %exitcond59, label %.preheader31, label %.preheader32

; <label>:187                                     ; preds = %191, %.preheader32
  %_dim_09.041 = phi i32 [ 0, %.preheader32 ], [ %192, %191 ]
  call void @llvm.lifetime.start(i64 88, i8* %132) #3
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__4readEv(%class.AxiPackedStencil_int32_t_1_1_* nonnull sret %_tmp_stencil10, %class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv2_stencil_stream)
  %188 = or i32 %_dim_09.041, %_dim_18.042
  %189 = icmp sgt i32 %188, -1
  br i1 %189, label %190, label %191

; <label>:190                                     ; preds = %187
  call void @_ZN29AxiPackedStencil_int32_t_1_1_C1ERKS_(%class.AxiPackedStencil_int32_t_1_1_* nonnull %13, %class.AxiPackedStencil_int32_t_1_1_* nonnull dereferenceable(88) %_tmp_stencil10)
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__5writeE29AxiPackedStencil_int32_t_1_1_(%class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv2_stencil_stream_to_hw_output, %class.AxiPackedStencil_int32_t_1_1_* nonnull %13)
  br label %191

; <label>:191                                     ; preds = %190, %187
  call void @llvm.lifetime.end(i64 88, i8* %132) #3
  %192 = add nuw nsw i32 %_dim_09.041, 1
  %exitcond58 = icmp eq i32 %192, 12
  br i1 %exitcond58, label %185, label %187

.preheader:                                       ; preds = %195, %.preheader31
  %_hw_output_y___scan_dim_1.040 = phi i32 [ 0, %.preheader31 ], [ %196, %195 ]
  %193 = icmp eq i32 %_hw_output_y___scan_dim_1.040, 11
  br label %197

; <label>:194                                     ; preds = %195
  call void @llvm.lifetime.end(i64 88004, i8* %131) #3
  call void @llvm.lifetime.end(i64 88004, i8* %119) #3
  call void @llvm.lifetime.end(i64 152004, i8* %112) #3
  call void @llvm.lifetime.end(i64 1, i8* %50) #3
  call void @llvm.lifetime.end(i64 152004, i8* %49) #3
  call void @llvm.lifetime.end(i64 88004, i8* %37) #3
  call void @llvm.lifetime.end(i64 76004, i8* %30) #3
  call void @llvm.lifetime.end(i64 1, i8* %19) #3
  call void @llvm.lifetime.end(i64 76004, i8* %18) #3
  call void @llvm.lifetime.end(i64 1, i8* %16) #3
  ret void

; <label>:195                                     ; preds = %203
  %196 = add nuw nsw i32 %_hw_output_y___scan_dim_1.040, 1
  %exitcond57 = icmp eq i32 %196, 12
  br i1 %exitcond57, label %194, label %.preheader

; <label>:197                                     ; preds = %203, %.preheader
  %_hw_output_x___scan_dim_0.039 = phi i32 [ 0, %.preheader ], [ %204, %203 ]
  call void @llvm.lifetime.start(i64 88, i8* %182) #3
  call void @_ZN29AxiPackedStencil_int32_t_1_1_C1Ev(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil11)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil11, i32 0, i64 0, i64 0, i64 0)
  call void @_ZN38hls_stream_PackedStencil_int32_t_1_1__4readEv(%class.AxiPackedStencil_int32_t_1_1_* nonnull sret %14, %class.hls_stream_PackedStencil_int32_t_1_1__* nonnull %_conv2_stencil_stream_to_hw_output)
  call void @_ZN29AxiPackedStencil_int32_t_1_1_4copyERKS_(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil11, %class.AxiPackedStencil_int32_t_1_1_* nonnull dereferenceable(88) %14)
  call void @llvm.lifetime.start(i64 44, i8* %183) #3
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_output_stencil)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_output_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  %198 = call i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_* nonnull %_conv2_stencil11, i64 0, i64 0, i64 0)
  %199 = trunc i32 %198 to i16
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_output_stencil, i16 zeroext %199, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.start(i64 44, i8* %184) #3
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_output_stencil_packed, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %_hw_output_stencil)
  %200 = icmp eq i32 %_hw_output_x___scan_dim_0.039, 11
  %or.cond30 = and i1 %193, %200
  br i1 %or.cond30, label %201, label %202

; <label>:201                                     ; preds = %197
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_output_stencil_packed, i32 1)
  br label %203

; <label>:202                                     ; preds = %197
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_output_stencil_packed, i32 0)
  br label %203

; <label>:203                                     ; preds = %202, %201
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %15, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %_hw_output_stencil_packed)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_1, %class.AxiPackedStencil_uint16_t_1_1_* nonnull %15)
  call void @llvm.lifetime.end(i64 44, i8* %184) #3
  call void @llvm.lifetime.end(i64 44, i8* %183) #3
  call void @llvm.lifetime.end(i64 88, i8* %182) #3
  %204 = add nuw nsw i32 %_hw_output_x___scan_dim_0.039, 1
  %exitcond = icmp eq i32 %204, 12
  br i1 %exitcond, label %195, label %197
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare void @_ZN13ram_int32_t_99ram_writeEii(%class.ram_int32_t_9*, i32, i32) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__C1Ev(%class.hls_stream_PackedStencil_uint16_t_3_3__*) #2

declare void @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_168lb_writeERK30AxiPackedStencil_uint16_t_1_1_(%class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16*, %class.AxiPackedStencil_uint16_t_1_1_* dereferenceable(44)) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* sret, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare zeroext i1 @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_1614has_valid_dataEv(%class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16*) #2

declare void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__5writeE30AxiPackedStencil_uint16_t_3_3_(%class.hls_stream_PackedStencil_uint16_t_3_3__*, %class.AxiPackedStencil_uint16_t_3_3_*) #2

declare void @_ZN107linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_167lb_readEv(%class.AxiPackedStencil_uint16_t_3_3_* sret, %class.linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16*) #2

declare void @_ZN39hls_stream_PackedStencil_uint16_t_3_3__4readEv(%class.AxiPackedStencil_uint16_t_3_3_* sret, %class.hls_stream_PackedStencil_uint16_t_3_3__*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_3_3_C1ERKS_(%class.AxiPackedStencil_uint16_t_3_3_*, %class.AxiPackedStencil_uint16_t_3_3_* dereferenceable(76)) #2

declare void @_ZN38hls_stream_PackedStencil_int32_t_1_1__C1Ev(%class.hls_stream_PackedStencil_int32_t_1_1__*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_3_3_C1Ev(%class.AxiPackedStencil_uint16_t_3_3_*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_3_3_3setEtmmm(%class.AxiPackedStencil_uint16_t_3_3_*, i16 zeroext, i64, i64, i64) #2

declare void @_ZN30AxiPackedStencil_uint16_t_3_3_4copyERKS_(%class.AxiPackedStencil_uint16_t_3_3_*, %class.AxiPackedStencil_uint16_t_3_3_* dereferenceable(76)) #2

declare void @_ZN29AxiPackedStencil_int32_t_1_1_C1Ev(%class.AxiPackedStencil_int32_t_1_1_*) #2

declare void @_ZN29AxiPackedStencil_int32_t_1_1_3setEimmm(%class.AxiPackedStencil_int32_t_1_1_*, i32, i64, i64, i64) #2

declare i32 @_ZN29AxiPackedStencil_int32_t_1_1_3getEmmm(%class.AxiPackedStencil_int32_t_1_1_*, i64, i64, i64) #2

declare i32 @_ZN13ram_int32_t_98ram_readEi(%class.ram_int32_t_9*, i32) #2

declare zeroext i16 @_ZN30AxiPackedStencil_uint16_t_3_3_3getEmmm(%class.AxiPackedStencil_uint16_t_3_3_*, i64, i64, i64) #2

declare void @_ZN38hls_stream_PackedStencil_int32_t_1_1__5writeE29AxiPackedStencil_int32_t_1_1_(%class.hls_stream_PackedStencil_int32_t_1_1__*, %class.AxiPackedStencil_int32_t_1_1_*) #2

declare void @_ZN29AxiPackedStencil_int32_t_1_1_C1ERKS_(%class.AxiPackedStencil_int32_t_1_1_*, %class.AxiPackedStencil_int32_t_1_1_* dereferenceable(88)) #2

declare void @_ZN38hls_stream_PackedStencil_int32_t_3_3__C1Ev(%class.hls_stream_PackedStencil_int32_t_3_3__*) #2

declare void @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_148lb_writeERK29AxiPackedStencil_int32_t_1_1_(%class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14*, %class.AxiPackedStencil_int32_t_1_1_* dereferenceable(88)) #2

declare void @_ZN38hls_stream_PackedStencil_int32_t_1_1__4readEv(%class.AxiPackedStencil_int32_t_1_1_* sret, %class.hls_stream_PackedStencil_int32_t_1_1__*) #2

declare zeroext i1 @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_1414has_valid_dataEv(%class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14*) #2

declare void @_ZN38hls_stream_PackedStencil_int32_t_3_3__5writeE29AxiPackedStencil_int32_t_3_3_(%class.hls_stream_PackedStencil_int32_t_3_3__*, %class.AxiPackedStencil_int32_t_3_3_*) #2

declare void @_ZN102linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_147lb_readEv(%class.AxiPackedStencil_int32_t_3_3_* sret, %class.linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14*) #2

declare void @_ZN38hls_stream_PackedStencil_int32_t_3_3__4readEv(%class.AxiPackedStencil_int32_t_3_3_* sret, %class.hls_stream_PackedStencil_int32_t_3_3__*) #2

declare void @_ZN29AxiPackedStencil_int32_t_3_3_C1ERKS_(%class.AxiPackedStencil_int32_t_3_3_*, %class.AxiPackedStencil_int32_t_3_3_* dereferenceable(152)) #2

declare void @_ZN29AxiPackedStencil_int32_t_3_3_C1Ev(%class.AxiPackedStencil_int32_t_3_3_*) #2

declare void @_ZN29AxiPackedStencil_int32_t_3_3_3setEimmm(%class.AxiPackedStencil_int32_t_3_3_*, i32, i64, i64, i64) #2

declare void @_ZN29AxiPackedStencil_int32_t_3_3_4copyERKS_(%class.AxiPackedStencil_int32_t_3_3_*, %class.AxiPackedStencil_int32_t_3_3_* dereferenceable(152)) #2

declare i32 @_ZN29AxiPackedStencil_int32_t_3_3_3getEmmm(%class.AxiPackedStencil_int32_t_3_3_*, i64, i64, i64) #2

declare void @_ZN29AxiPackedStencil_int32_t_1_1_4copyERKS_(%class.AxiPackedStencil_int32_t_1_1_*, %class.AxiPackedStencil_int32_t_1_1_* dereferenceable(88)) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_C1Ev(%class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_*, i16 zeroext, i64, i64, i64) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_*, %class.AxiPackedStencil_uint16_t_1_1_* dereferenceable(44)) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_*, i32) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*, %class.AxiPackedStencil_uint16_t_1_1_*) #2

attributes #0 = { ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
