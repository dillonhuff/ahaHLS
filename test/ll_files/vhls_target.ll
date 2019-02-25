; ModuleID = './apps/hardware_benchmarks/apps/pointwise/bin/vhls_target.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

%class.hls_stream_AxiPackedStencil_uint16_t_1_1__ = type { i32, [1000 x %class.AxiPackedStencil_uint16_t_1_1_] }
%class.AxiPackedStencil_uint16_t_1_1_ = type { [21 x i16], [1 x i16] }
%class.PackedStencil_uint16_t_1_1_ = type { [21 x i16], [1 x i16] }
%class.Stencil_uint16_t_1_1_ = type { [21 x i16], [1 x i16] }

; Function Attrs: ssp uwtable
define void @_Z11vhls_targetR42hls_stream_AxiPackedStencil_uint16_t_1_1__S0_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(44004) %arg_0, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(44004) %arg_1) #0 {
  %_hw_input_stencil_stream_to_mult = alloca %class.hls_stream_AxiPackedStencil_uint16_t_1_1__, align 4
  %_tmp_stencil = alloca %class.PackedStencil_uint16_t_1_1_, align 2
  %1 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %2 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 8
  %_hw_input_stencil = alloca %class.Stencil_uint16_t_1_1_, align 2
  %3 = alloca %class.Stencil_uint16_t_1_1_, align 2
  %4 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 2
  %_mult_stencil = alloca %class.Stencil_uint16_t_1_1_, align 2
  %_mult_stencil_packed = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 8
  %5 = bitcast %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* %_hw_input_stencil_stream_to_mult to i8*
  call void @llvm.lifetime.start(i64 44004, i8* %5) #3
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__C1Ev(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  %6 = bitcast %class.PackedStencil_uint16_t_1_1_* %_tmp_stencil to i8*
  br label %.preheader9

.preheader9:                                      ; preds = %10, %0
  %_dim_1.013 = phi i32 [ 0, %0 ], [ %11, %10 ]
  br label %12

.preheader8:                                      ; preds = %10
  %7 = bitcast %class.Stencil_uint16_t_1_1_* %_hw_input_stencil to i8*
  %8 = bitcast %class.Stencil_uint16_t_1_1_* %_mult_stencil to i8*
  %9 = bitcast %class.AxiPackedStencil_uint16_t_1_1_* %_mult_stencil_packed to i8*
  br label %.preheader

; <label>:10                                      ; preds = %16
  %11 = add nuw nsw i32 %_dim_1.013, 1
  %exitcond16 = icmp eq i32 %11, 2
  br i1 %exitcond16, label %.preheader8, label %.preheader9

; <label>:12                                      ; preds = %16, %.preheader9
  %_dim_0.012 = phi i32 [ 0, %.preheader9 ], [ %17, %16 ]
  call void @llvm.lifetime.start(i64 44, i8* %6) #3
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %1, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_0)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_cv27PackedStencil_uint16_t_1_1_Ev(%class.PackedStencil_uint16_t_1_1_* nonnull sret %_tmp_stencil, %class.AxiPackedStencil_uint16_t_1_1_* nonnull %1)
  %13 = or i32 %_dim_0.012, %_dim_1.013
  %14 = icmp sgt i32 %13, -1
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %12
  call void @_ZN27PackedStencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %2, %class.PackedStencil_uint16_t_1_1_* nonnull %_tmp_stencil)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult, %class.AxiPackedStencil_uint16_t_1_1_* byval nonnull align 8 %2)
  br label %16

; <label>:16                                      ; preds = %15, %12
  call void @llvm.lifetime.end(i64 44, i8* %6) #3
  %17 = add nuw nsw i32 %_dim_0.012, 1
  %exitcond15 = icmp eq i32 %17, 2
  br i1 %exitcond15, label %10, label %12

.preheader:                                       ; preds = %20, %.preheader8
  %_mult_y___scan_dim_1.011 = phi i32 [ 0, %.preheader8 ], [ %21, %20 ]
  %18 = icmp eq i32 %_mult_y___scan_dim_1.011, 1
  br label %22

; <label>:19                                      ; preds = %20
  call void @llvm.lifetime.end(i64 44004, i8* %5) #3
  ret void

; <label>:20                                      ; preds = %29
  %21 = add nuw nsw i32 %_mult_y___scan_dim_1.011, 1
  %exitcond14 = icmp eq i32 %21, 2
  br i1 %exitcond14, label %19, label %.preheader

; <label>:22                                      ; preds = %29, %.preheader
  %_mult_x___scan_dim_0.010 = phi i32 [ 0, %.preheader ], [ %30, %29 ]
  call void @llvm.lifetime.start(i64 44, i8* %7) #3
  call void @_ZN21Stencil_uint16_t_1_1_C1Ev(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil)
  call void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %4, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_cv21Stencil_uint16_t_1_1_Ev(%class.Stencil_uint16_t_1_1_* nonnull sret %3, %class.AxiPackedStencil_uint16_t_1_1_* nonnull %4)
  %23 = call dereferenceable(44) %class.Stencil_uint16_t_1_1_* @_ZN21Stencil_uint16_t_1_1_aSERKS_(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, %class.Stencil_uint16_t_1_1_* nonnull dereferenceable(44) %3)
  call void @llvm.lifetime.start(i64 44, i8* %8) #3
  call void @_ZN21Stencil_uint16_t_1_1_C1Ev(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil)
  call void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  %24 = call zeroext i16 @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i64 0, i64 0, i64 0)
  %25 = shl i16 %24, 1
  call void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil, i16 zeroext %25, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.start(i64 44, i8* %9) #3
  call void @_ZN21Stencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull sret %_mult_stencil_packed, %class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil)
  %26 = icmp eq i32 %_mult_x___scan_dim_0.010, 1
  %or.cond7 = and i1 %18, %26
  br i1 %or.cond7, label %27, label %28

; <label>:27                                      ; preds = %22
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 1)
  br label %29

; <label>:28                                      ; preds = %22
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 0)
  br label %29

; <label>:29                                      ; preds = %28, %27
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_1, %class.AxiPackedStencil_uint16_t_1_1_* byval nonnull align 8 %_mult_stencil_packed)
  call void @llvm.lifetime.end(i64 44, i8* %9) #3
  call void @llvm.lifetime.end(i64 44, i8* %8) #3
  call void @llvm.lifetime.end(i64 44, i8* %7) #3
  %30 = add nuw nsw i32 %_mult_x___scan_dim_0.010, 1
  %exitcond = icmp eq i32 %30, 2
  br i1 %exitcond, label %20, label %22
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__C1Ev(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.AxiPackedStencil_uint16_t_1_1_* sret, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_cv27PackedStencil_uint16_t_1_1_Ev(%class.PackedStencil_uint16_t_1_1_* sret, %class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*, %class.AxiPackedStencil_uint16_t_1_1_* byval align 8) #2

declare void @_ZN27PackedStencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* sret, %class.PackedStencil_uint16_t_1_1_*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare void @_ZN21Stencil_uint16_t_1_1_C1Ev(%class.Stencil_uint16_t_1_1_*) #2

declare void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_*, i16 zeroext, i64, i64, i64) #2

declare dereferenceable(44) %class.Stencil_uint16_t_1_1_* @_ZN21Stencil_uint16_t_1_1_aSERKS_(%class.Stencil_uint16_t_1_1_*, %class.Stencil_uint16_t_1_1_* dereferenceable(44)) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_cv21Stencil_uint16_t_1_1_Ev(%class.Stencil_uint16_t_1_1_* sret, %class.AxiPackedStencil_uint16_t_1_1_*) #2

declare zeroext i16 @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_*, i64, i64, i64) #2

declare void @_ZN21Stencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* sret, %class.Stencil_uint16_t_1_1_*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_*, i32) #2

attributes #0 = { ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
