; ModuleID = './apps/hardware_benchmarks/apps/pointwise/bin/vhls_target.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

%class.hls_stream_AxiPackedStencil_uint16_t_1_1__ = type { i8 }
%class.PackedStencil_uint16_t_1_1_ = type { i8 }
%class.AxiPackedStencil_uint16_t_1_1_ = type { i8 }
%class.Stencil_uint16_t_1_1_ = type { i8 }

; Function Attrs: ssp uwtable
define void @_Z11vhls_targetR42hls_stream_AxiPackedStencil_uint16_t_1_1__S0_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(1) %arg_0, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* dereferenceable(1) %arg_1) #0 {
  %_hw_input_stencil_stream_to_mult = alloca %class.hls_stream_AxiPackedStencil_uint16_t_1_1__, align 1
  %_tmp_stencil = alloca %class.PackedStencil_uint16_t_1_1_, align 1
  %1 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 1
  %_hw_input_stencil = alloca %class.Stencil_uint16_t_1_1_, align 1
  %2 = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 1
  %_mult_stencil = alloca %class.Stencil_uint16_t_1_1_, align 1
  %_mult_stencil_packed = alloca %class.AxiPackedStencil_uint16_t_1_1_, align 1
  %3 = getelementptr inbounds %class.hls_stream_AxiPackedStencil_uint16_t_1_1__, %class.hls_stream_AxiPackedStencil_uint16_t_1_1__* %_hw_input_stencil_stream_to_mult, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3) #3
  %4 = getelementptr inbounds %class.PackedStencil_uint16_t_1_1_, %class.PackedStencil_uint16_t_1_1_* %_tmp_stencil, i64 0, i32 0
  br label %.preheader9

.preheader9:                                      ; preds = %8, %0
  %_dim_1.013 = phi i32 [ 0, %0 ], [ %9, %8 ]
  br label %10

.preheader8:                                      ; preds = %8
  %5 = getelementptr inbounds %class.Stencil_uint16_t_1_1_, %class.Stencil_uint16_t_1_1_* %_hw_input_stencil, i64 0, i32 0
  %6 = getelementptr inbounds %class.Stencil_uint16_t_1_1_, %class.Stencil_uint16_t_1_1_* %_mult_stencil, i64 0, i32 0
  %7 = getelementptr inbounds %class.AxiPackedStencil_uint16_t_1_1_, %class.AxiPackedStencil_uint16_t_1_1_* %_mult_stencil_packed, i64 0, i32 0
  br label %.preheader

; <label>:8                                       ; preds = %14
  %9 = add nuw nsw i32 %_dim_1.013, 1
  %exitcond16 = icmp eq i32 %9, 2
  br i1 %exitcond16, label %.preheader8, label %.preheader9

; <label>:10                                      ; preds = %14, %.preheader9
  %_dim_0.012 = phi i32 [ 0, %.preheader9 ], [ %15, %14 ]
  call void @llvm.lifetime.start(i64 1, i8* %4) #3
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_0)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_cv27PackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %1)
  %11 = or i32 %_dim_0.012, %_dim_1.013
  %12 = icmp sgt i32 %11, -1
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %10
  call void @_ZN27PackedStencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.PackedStencil_uint16_t_1_1_* nonnull %_tmp_stencil)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  br label %14

; <label>:14                                      ; preds = %13, %10
  call void @llvm.lifetime.end(i64 1, i8* %4) #3
  %15 = add nuw nsw i32 %_dim_0.012, 1
  %exitcond15 = icmp eq i32 %15, 2
  br i1 %exitcond15, label %8, label %10

.preheader:                                       ; preds = %18, %.preheader8
  %_mult_y___scan_dim_1.011 = phi i32 [ 0, %.preheader8 ], [ %19, %18 ]
  %16 = icmp eq i32 %_mult_y___scan_dim_1.011, 1
  br label %20

; <label>:17                                      ; preds = %18
  call void @llvm.lifetime.end(i64 1, i8* %3) #3
  ret void

; <label>:18                                      ; preds = %26
  %19 = add nuw nsw i32 %_mult_y___scan_dim_1.011, 1
  %exitcond14 = icmp eq i32 %19, 2
  br i1 %exitcond14, label %17, label %.preheader

; <label>:20                                      ; preds = %26, %.preheader
  %_mult_x___scan_dim_0.010 = phi i32 [ 0, %.preheader ], [ %27, %26 ]
  call void @llvm.lifetime.start(i64 1, i8* %5) #3
  call void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %_hw_input_stencil_stream_to_mult)
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_cv21Stencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %2)
  call void @llvm.lifetime.start(i64 1, i8* %6) #3
  call void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil, i16 zeroext 0, i64 0, i64 0, i64 0)
  %21 = call zeroext i16 @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_* nonnull %_hw_input_stencil, i64 0, i64 0, i64 0)
  %22 = shl i16 %21, 1
  call void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil, i16 zeroext %22, i64 0, i64 0, i64 0)
  call void @llvm.lifetime.start(i64 1, i8* %7) #3
  call void @_ZN21Stencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.Stencil_uint16_t_1_1_* nonnull %_mult_stencil)
  %23 = icmp eq i32 %_mult_x___scan_dim_0.010, 1
  %or.cond7 = and i1 %16, %23
  br i1 %or.cond7, label %24, label %25

; <label>:24                                      ; preds = %20
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 1)
  br label %26

; <label>:25                                      ; preds = %20
  call void @_ZN30AxiPackedStencil_uint16_t_1_1_8set_lastEi(%class.AxiPackedStencil_uint16_t_1_1_* nonnull %_mult_stencil_packed, i32 0)
  br label %26

; <label>:26                                      ; preds = %25, %24
  call void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__* nonnull %arg_1)
  call void @llvm.lifetime.end(i64 1, i8* %7) #3
  call void @llvm.lifetime.end(i64 1, i8* %6) #3
  call void @llvm.lifetime.end(i64 1, i8* %5) #3
  %27 = add nuw nsw i32 %_mult_x___scan_dim_0.010, 1
  %exitcond = icmp eq i32 %27, 2
  br i1 %exitcond, label %18, label %20
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__4readEv(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_cv27PackedStencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_*) #2

declare void @_ZN42hls_stream_AxiPackedStencil_uint16_t_1_1__5writeE30AxiPackedStencil_uint16_t_1_1_(%class.hls_stream_AxiPackedStencil_uint16_t_1_1__*) #2

declare void @_ZN27PackedStencil_uint16_t_1_1_cv30AxiPackedStencil_uint16_t_1_1_Ev(%class.PackedStencil_uint16_t_1_1_*) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare void @_ZN21Stencil_uint16_t_1_1_5writeEtmmm(%class.Stencil_uint16_t_1_1_*, i16 zeroext, i64, i64, i64) #2

declare void @_ZN30AxiPackedStencil_uint16_t_1_1_cv21Stencil_uint16_t_1_1_Ev(%class.AxiPackedStencil_uint16_t_1_1_*) #2

declare zeroext i16 @_ZN21Stencil_uint16_t_1_1_clEmmm(%class.Stencil_uint16_t_1_1_*, i64, i64, i64) #2

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
