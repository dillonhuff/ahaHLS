; ModuleID = 'tiny_test.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

; Function Attrs: nounwind ssp uwtable
define void @foo(i32* %b) #0 {
  %1 = alloca i32*, align 8
  store i32* %b, i32** %1, align 8
  %2 = load i32*, i32** %1, align 8
  store i32 0, i32* %2, align 4
  br label %3

; <label>:3                                       ; preds = %7, %0
  %4 = load i32*, i32** %1, align 8
  %5 = load i32, i32* %4, align 4
  %6 = icmp slt i32 %5, 10
  br i1 %6, label %7, label %11

; <label>:7                                       ; preds = %3
  %8 = load i32*, i32** %1, align 8
  %9 = load i32, i32* %8, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, i32* %8, align 4
  br label %3

; <label>:11                                      ; preds = %3
  %12 = load i32*, i32** %1, align 8
  %13 = load i32, i32* %12, align 4
  %14 = sub nsw i32 %13, 3
  %15 = load i32*, i32** %1, align 8
  store i32 %14, i32* %15, align 4
  ret void
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
