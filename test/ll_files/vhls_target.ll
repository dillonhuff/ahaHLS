; ModuleID = './apps/hardware_benchmarks/apps/pointwise/bin/vhls_target.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

%class.hls_stream_AxiPackedStencil_uint16_t_1_1__ = type { i8 }
%class.PackedStencil_uint16_t_1_1_ = type { i8 }
%class.Stencil_uint16_t_1_1_ = type { i8 }
%class.AxiPackedStencil_uint16_t_1_1_ = type { i8 }

; Function Attrs: ssp uwtable
define void @_Z11vhls_targetR42hls_stream_AxiPackedStencil_uint16_t_1_1__S0_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(1) %arg_0, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(1) %arg_1) #0 {
  %_hw_input_stencil_stream_to_mult = alloca %class.hls_stream_AxiPackedStencil_uint16_t_1_1__, align 1
  %_tmp_stencil = alloca %class.PackedStencil_uint16_t_1_1_, align 1
  %_hw_input_stencil = alloca %class.Stencil_uint16_t_1_1_, align 1
  %_mult_stencil = alloca %class.Stencil_uint16_t_1_1_, align 1
  %_mult_stencil_packed = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 1
  %1 = getelementptr inbounds %class.hls_stream_AxiPackedStencil_uint16_t_1_1__, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* %_hw_input_stencil_stream_to_mult, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1) #3
  %2 = getelementptr inbounds %class.PackedStencil_uint16_t_1_1_, %class.PackedStencil_uint16_t_1_1_* %_tmp_stencil, i64 0, i32 0
  br label %.preheader9

.preheader9:                                      ; preds = %6, %0
  %_dim_1.013 = phi i32 [ 0, %0 ], [ %7, %6 ]
  br label %8

.preheader8:                                      ; preds = %6
  %3 = getelementptr inbounds %class.Stencil_uint16_t_1_1_, %class.Stencil_uint16_t_1_1_* %_hw_input_stencil, i64 0, i32 0
  %4 = getelementptr inbounds %class.Stencil_uint16_t_1_1_, %class.Stencil_uint16_t_1_1_* %_mult_stencil, i64 0, i32 0
  %5 = getelementptr inbounds %class.AxiPackedStencil_uint16_t_1_1_, %class.AxiPackedStencil_uint16_t_1_1_* %_mult_stencil_packed, i64 0, i32 0
  br label %.preheader

; <label>:6                                       ; preds = %13
  %7 = add nuw nsw i32 %_dim_1.013, 1
  %exitcond16 = icmp eq i32 %7, 2
  br i1 %exitcond16, label %.preheader8, label %.preheader9

; <label>:8                                       ; preds = %13, %.preheader9
  %_dim_0.012 = phi i32 [ 0, %.preheader9 ], [ %14, %13 ]
  call void @llvm.lifetime.start(i64 1, i8* %2) #3
  %9 = call dereferenceable(1) %class.AxiPackedStencil_uint16_t_1_1_* @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_0)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_cv27PackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %9)
  %10 = or i32 %_dim_0.012, %_dim_1.013
  %11 = icmp sgt i32 %10, -1
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %8
  call void @_ZN27PackedStencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.PackedStencil_uint16_t_1_1_* nonnull %_tmp_stencil)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  br label %13

; <label>:13                                      ; preds = %12, %8
  call void @llvm.lifetime.end(i64 1, i8* %2) #3
  %14 = add nuw nsw i32 %_dim_0.012, 1
  %exitcond15 = icmp eq i32 %14, 2
  br i1 %exitcond15, label %6, label %8

.preheader:                                       ; preds = %17, %.preheader8
  %_mult_y___scan_dim_1.011 = phi i32 [ 0, %.preheader8 ], [ %18, %17 ]
  %15 = icmp eq i32 %_mult_y___scan_dim_1.011, 1
  br label %19

; <label>:16                                      ; preds = %17
  call void @llvm.lifetime.end(i64 1, i8* %1) #3
  ret void

; <label>:17                                      ; preds = %30
  %18 = add nuw nsw i32 %_mult_y___scan_dim_1.011, 1
  %exitcond14 = icmp eq i32 %18, 2
  br i1 %exitcond14, label %16, label %.preheader

; <label>:19                                      ; preds = %30, %.preheader
  %_mult_x___scan_dim_0.010 = phi i32 [ 0, %.preheader ], [ %31, %30 ]
  call void @llvm.lifetime.start(i64 1, i8* %3) #3
  %20 = call dereferenceable(2) i16* @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i64 0, i64 0, i64 0)
  store i16 0, i16* %20, align 2, !tbaa !2
  %21 = call dereferenceable(1) %class.AxiPackedStencil_uint16_t_1_1_* @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_cv21Stencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %21)
  call void @llvm.lifetime.start(i64 1, i8* %4) #3
  %22 = call dereferenceable(2) i16* @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil, i64 0, i64 0, i64 0)
  store i16 0, i16* %22, align 2, !tbaa !2
  %23 = call dereferenceable(2) i16* @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i64 0, i64 0, i64 0)
  %24 = load i16, i16* %23, align 2, !tbaa !2
  %25 = shl i16 %24, 1
  %26 = call dereferenceable(2) i16* @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil, i64 0, i64 0, i64 0)
  store i16 %25, i16* %26, align 2, !tbaa !2
  call void @llvm.lifetime.start(i64 1, i8* %5) #3
  call void @_ZN21Stencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil)
  %27 = icmp eq i32 %_mult_x___scan_dim_0.010, 1
  %or.cond7 = and i1 %15, %27
  br i1 %or.cond7, label %28, label %29

; <label>:28                                      ; preds = %19
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 1)
  br label %30

; <label>:29                                      ; preds = %19
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 0)
  br label %30

; <label>:30                                      ; preds = %29, %28
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_1)
  call void @llvm.lifetime.end(i64 1, i8* %5) #3
  call void @llvm.lifetime.end(i64 1, i8* %4) #3
  call void @llvm.lifetime.end(i64 1, i8* %3) #3
  %31 = add nuw nsw i32 %_mult_x___scan_dim_0.010, 1
  %exitcond = icmp eq i32 %31, 2
  br i1 %exitcond, label %17, label %19
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare dereferenceable(1) %class.AxiPackedStencil_uint16_t_1_1_* @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_cv27PackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN27PackedStencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.PackedStencil_uint16_t_1_1_*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare dereferenceable(2) i16* @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_*, i64, i64, i64) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_cv21Stencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN21Stencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.Stencil_uint16_t_1_1_*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_*, i32) #2

attributes #0 = { ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"short", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
