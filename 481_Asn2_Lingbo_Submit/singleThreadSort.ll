; ModuleID = 'singleThreadSort.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.timeval = type { i64, i32 }

@.str = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@__stderrp = external global %struct.__sFILE*, align 8
@.str.3 = private unnamed_addr constant [25 x i8] c"error: Not enough info!\0A\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"a+\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%d, %f\0A\00", align 1
@str = private unnamed_addr constant [2 x i8] c"]\00"

; Function Attrs: nounwind readonly ssp uwtable
define i32 @cmpfunc(i8* nocapture readonly %a, i8* nocapture readonly %b) #0 {
  %1 = bitcast i8* %a to i64*
  %2 = load i64, i64* %1, align 8, !tbaa !2
  %3 = bitcast i8* %b to i64*
  %4 = load i64, i64* %3, align 8, !tbaa !2
  %5 = sub nsw i64 %2, %4
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: nounwind ssp uwtable
define void @printArr(i64* nocapture readonly %arr, i32 %size) #1 {
  %1 = icmp sgt i32 %size, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %2 = add nsw i32 %size, -1
  %3 = zext i32 %2 to i64
  br label %4

._crit_edge.loopexit:                             ; preds = %14
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  ret void

; <label>:4                                       ; preds = %14, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %14 ]
  %5 = icmp eq i64 %indvars.iv, 0
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %4
  %7 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0)) #7
  br label %8

; <label>:8                                       ; preds = %6, %4
  %9 = getelementptr inbounds i64, i64* %arr, i64 %indvars.iv
  %10 = load i64, i64* %9, align 8, !tbaa !2
  %11 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i64 %10) #7
  %12 = icmp eq i64 %indvars.iv, %3
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %8
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @str, i64 0, i64 0))
  br label %14

; <label>:14                                      ; preds = %8, %13
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %size
  br i1 %exitcond, label %._crit_edge.loopexit, label %4
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #1 {
  %start = alloca %struct.timeval, align 8
  %end = alloca %struct.timeval, align 8
  %1 = bitcast %struct.timeval* %start to i8*
  call void @llvm.lifetime.start(i64 16, i8* %1) #7
  %2 = bitcast %struct.timeval* %end to i8*
  call void @llvm.lifetime.start(i64 16, i8* %2) #7
  %3 = icmp eq i32 %argc, 3
  br i1 %3, label %7, label %4

; <label>:4                                       ; preds = %0
  %5 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !6
  %6 = tail call i64 @fwrite(i8* nonnull getelementptr inbounds ([25 x i8], [25 x i8]* @.str.3, i64 0, i64 0), i64 24, i64 1, %struct.__sFILE* %5)
  tail call void @exit(i32 1) #8
  unreachable

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds i8*, i8** %argv, i64 1
  %9 = load i8*, i8** %8, align 8, !tbaa !6
  %10 = tail call i32 @atoi(i8* %9) #7
  %11 = getelementptr inbounds i8*, i8** %argv, i64 2
  %12 = load i8*, i8** %11, align 8, !tbaa !6
  %13 = tail call %struct.__sFILE* @"\01_fopen"(i8* %12, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0)) #7
  %14 = sext i32 %10 to i64
  %15 = shl nsw i64 %14, 3
  %16 = tail call i8* @malloc(i64 %15) #7
  %17 = bitcast i8* %16 to i64*
  %18 = tail call i64 @time(i64* null) #7
  %19 = trunc i64 %18 to i32
  tail call void @srandom(i32 %19) #7
  %20 = icmp sgt i32 %10, 0
  br i1 %20, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %7
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %21 = tail call i64 @random() #7
  %22 = getelementptr inbounds i64, i64* %17, i64 %indvars.iv
  store i64 %21, i64* %22, align 8, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %10
  br i1 %exitcond, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %7
  %23 = call i32 @gettimeofday(%struct.timeval* nonnull %start, i8* null) #7
  tail call void @qsort(i8* %16, i64 %14, i64 8, i32 (i8*, i8*)* nonnull @cmpfunc) #7
  %24 = call i32 @gettimeofday(%struct.timeval* nonnull %end, i8* null) #7
  %25 = getelementptr inbounds %struct.timeval, %struct.timeval* %end, i64 0, i32 0
  %26 = load i64, i64* %25, align 8, !tbaa !8
  %27 = getelementptr inbounds %struct.timeval, %struct.timeval* %start, i64 0, i32 0
  %28 = load i64, i64* %27, align 8, !tbaa !8
  %29 = sub nsw i64 %26, %28
  %30 = sitofp i64 %29 to double
  %31 = fmul double %30, 1.000000e+06
  %32 = getelementptr inbounds %struct.timeval, %struct.timeval* %end, i64 0, i32 1
  %33 = load i32, i32* %32, align 8, !tbaa !11
  %34 = getelementptr inbounds %struct.timeval, %struct.timeval* %start, i64 0, i32 1
  %35 = load i32, i32* %34, align 8, !tbaa !11
  %36 = sub nsw i32 %33, %35
  %37 = sitofp i32 %36 to double
  %38 = fadd double %31, %37
  %39 = fdiv double %38, 1.000000e+06
  %40 = tail call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %13, i8* nonnull getelementptr inbounds ([8 x i8], [8 x i8]* @.str.5, i64 0, i64 0), i32 %10, double %39) #7
  tail call void @free(i8* %16)
  %41 = tail call i32 @fclose(%struct.__sFILE* %13) #7
  call void @llvm.lifetime.end(i64 16, i8* %2) #7
  call void @llvm.lifetime.end(i64 16, i8* %1) #7
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @fprintf(%struct.__sFILE* nocapture, i8* nocapture readonly, ...) #3

; Function Attrs: noreturn
declare void @exit(i32) #4

; Function Attrs: nounwind readonly
declare i32 @atoi(i8* nocapture) #5

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) #6

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare void @srandom(i32) #6

declare i64 @time(i64*) #6

declare i64 @random() #6

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval* nocapture, i8* nocapture) #3

declare void @qsort(i8*, i64, i64, i32 (i8*, i8*)* nocapture) #6

; Function Attrs: nounwind
declare void @free(i8* nocapture) #3

; Function Attrs: nounwind
declare i32 @fclose(%struct.__sFILE* nocapture) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #7

; Function Attrs: nounwind
declare i64 @fwrite(i8* nocapture, i64, i64, %struct.__sFILE* nocapture) #7

attributes #0 = { nounwind readonly ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"long", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"any pointer", !4, i64 0}
!8 = !{!9, !3, i64 0}
!9 = !{!"timeval", !3, i64 0, !10, i64 8}
!10 = !{!"int", !4, i64 0}
!11 = !{!9, !10, i64 8}
