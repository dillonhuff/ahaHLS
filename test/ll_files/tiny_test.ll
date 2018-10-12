; ModuleID = './test/ll_files/tiny_test.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

; Function Attrs: nounwind ssp uwtable
define void @foo(i32* noalias nocapture readonly %a, i32* noalias nocapture readonly %b, i32* noalias nocapture %c) #0 {
  br label %2

; <label>:1                                       ; preds = %2
  ret void

; <label>:2                                       ; preds = %2, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %2 ]
  %3 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %4 = load i32, i32* %3, align 4, !tbaa !2
  %5 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %6 = load i32, i32* %5, align 4, !tbaa !2
  %7 = add nsw i32 %6, %4
  %8 = getelementptr inbounds i32, i32* %c, i64 %indvars.iv
  store i32 %7, i32* %8, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 100
  br i1 %exitcond, label %1, label %2
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
