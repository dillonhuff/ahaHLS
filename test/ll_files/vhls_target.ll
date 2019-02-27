; ModuleID = './apps/hardware_benchmarks/apps/pointwise/bin/vhls_target.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

%class.hls_stream_AxiPackedStencil_uint16_t_1_1__ = type { i32, [1000 x %class.AxiPackedStencil_uint16_t_1_1_] }
%class.AxiPackedStencil_uint16_t_1_1_ = type { [21 x i16], [1 x i16] }

; Function Attrs: ssp uwtable
define void @_Z11vhls_targetR42hls_stream_AxiPackedStencil_uint16_t_1_1__S0_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(44004) %arg_0, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(44004) %arg_1) #0 {
  %_hw_input_stencil_stream_to_mult = alloca %class.hls_stream_AxiPackedStencil_uint16_t_1_1__, align 4
  %_tmp_stencil = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %1 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %_hw_input_stencil = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %2 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %_mult_stencil = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %_mult_stencil_packed = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %3 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %4 = bitcast %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* %_hw_input_stencil_stream_to_mult to i8*
  call void @llvm.lifetime.start(i64 44004, i8* %4) #3
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__C1Ev(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  %5 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_tmp_stencil to i8*
  br label %.preheader9

.preheader9:                                      ; preds = %9, %0
  %_dim_1.013 = phi i32 [ 0, %0 ], [ %10, %9 ]
  br label %11

.preheader8:                                      ; preds = %9
  %6 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_hw_input_stencil to i8*
  %7 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_mult_stencil to i8*
  %8 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_mult_stencil_packed to i8*
  br label %.preheader

; <label>:9                                       ; preds = %15
  %10 = add nuw nsw i32 %_dim_1.013, 1
  %exitcond16 = icmp eq i32 %10, 2
  br i1 %exitcond16, label %.preheader8, label %.preheader9

; <label>:11                                      ; preds = %15, %.preheader9
  %_dim_0.012 = phi i32 [ 0, %.preheader9 ], [ %16, %15 ]
  call void @llvm.lifetime.start(i64 44, i8* %5) #3
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %_tmp_stencil, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_0)
  %12 = or i32 %_dim_0.012, %_dim_1.013
  %13 = icmp sgt i32 %12, -1
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %11
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %1, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %_tmp_stencil)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult, %class.AxiPackedStencil_uint16_t_1_1_* nonnull %1)
  br label %15

; <label>:15                                      ; preds = %14, %11
  call void @llvm.lifetime.end(i64 44, i8* %5) #3
  %16 = add nuw nsw i32 %_dim_0.012, 1
  %exitcond15 = icmp eq i32 %16, 2
  br i1 %exitcond15, label %9, label %11

.preheader:                                       ; preds = %19, %.preheader8
  %_mult_y___scan_dim_1.011 = phi i32 [ 0, %.preheader8 ], [ %20, %19 ]
  %17 = icmp eq i32 %_mult_y___scan_dim_1.011, 1
  br label %21

; <label>:18                                      ; preds = %19
  call void @llvm.lifetime.end(i64 44004, i8* %4) #3
  ret void

; <label>:19                                      ; preds = %27
  %20 = add nuw nsw i32 %_mult_y___scan_dim_1.011, 1
  %exitcond14 = icmp eq i32 %20, 2
  br i1 %exitcond14, label %18, label %.preheader

; <label>:21                                      ; preds = %27, %.preheader
  %_mult_x___scan_dim_0.010 = phi i32 [ 0, %.preheader ], [ %28, %27 ]
  call void @llvm.lifetime.start(i64 44, i8* %6) #3
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_input_stencil)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %2, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_4copyERKS_(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_input_stencil, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %2)
  call void @llvm.lifetime.start(i64 44, i8* %7) #3
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  %22 = call zeroext i16 @_ZN30AxiPackedStencil_uint16_t_1_1_3getEmmm(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i64 0, i64 0, i64 0)
  %23 = shl i16 %22, 1
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil, i16 zeroext %23, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.start(i64 44, i8* %8) #3
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %_mult_stencil)
  %24 = icmp eq i32 %_mult_x___scan_dim_0.010, 1
  %or.cond7 = and i1 %17, %24
  br i1 %or.cond7, label %25, label %26

; <label>:25                                      ; preds = %21
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 1)
  br label %27

; <label>:26                                      ; preds = %21
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 0)
  br label %27

; <label>:27                                      ; preds = %26, %25
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %3, %class.AxiPackedStencil_uint16_t_1_1_* nonnull dereferenceable(44) %_mult_stencil_packed)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_1, %class.AxiPackedStencil_uint16_t_1_1_* nonnull %3)
  call void @llvm.lifetime.end(i64 44, i8* %8) #3
  call void @llvm.lifetime.end(i64 44, i8* %7) #3
  call void @llvm.lifetime.end(i64 44, i8* %6) #3
  %28 = add nuw nsw i32 %_mult_x___scan_dim_0.010, 1
  %exitcond = icmp eq i32 %28, 2
  br i1 %exitcond, label %19, label %21
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__C1Ev(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* sret, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*, %class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_C1ERKS_(%class.AxiPackedStencil_uint16_t_1_1_*, %class.AxiPackedStencil_uint16_t_1_1_* dereferenceable(44)) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_C1Ev(%class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_3setEtmmm(%class.AxiPackedStencil_uint16_t_1_1_*, i16 zeroext, i64, i64, i64) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_4copyERKS_(%class.AxiPackedStencil_uint16_t_1_1_*, %class.AxiPackedStencil_uint16_t_1_1_* dereferenceable(44)) #2

declare zeroext i16 @_ZN30AxiPackedStencil_uint16_t_1_1_3getEmmm(%class.AxiPackedStencil_uint16_t_1_1_*, i64, i64, i64) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_*, i32) #2

attributes #0 = { ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
