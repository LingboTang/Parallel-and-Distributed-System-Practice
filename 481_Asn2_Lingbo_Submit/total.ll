; ModuleID = 'total.c'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

%struct.ompi_predefined_communicator_t = type opaque
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.ompi_predefined_datatype_t = type opaque
%struct.ompi_communicator_t = type opaque
%struct.ompi_datatype_t = type opaque

@.str = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@ompi_mpi_comm_world = external global %struct.ompi_predefined_communicator_t, align 1
@__stderrp = external global %struct.__sFILE*, align 8
@.str.4 = private unnamed_addr constant [34 x i8] c"Usage: ./mypsrs <N> <outputfile>\0A\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"a+\00", align 1
@.str.6 = private unnamed_addr constant [51 x i8] c"Total must be divided evenly for analysis purpose\0A\00", align 1
@ompi_mpi_long = external global %struct.ompi_predefined_datatype_t, align 1
@ompi_mpi_int = external global %struct.ompi_predefined_datatype_t, align 1
@.str.7 = private unnamed_addr constant [12 x i8] c"%d, %d, %f\0A\00", align 1
@str.8 = private unnamed_addr constant [2 x i8] c"]\00"

; Function Attrs: nounwind ssp uwtable
define void @multimerge(i64** nocapture readonly %arrays, i32* nocapture readonly %arraysizes, i32 %number_of_arrays, i64* nocapture %output) #0 {
  %1 = sext i32 %number_of_arrays to i64
  %2 = tail call i8* @calloc(i64 %1, i64 8) #7
  %3 = bitcast i8* %2 to i64*
  %4 = icmp eq i8* %2, null
  br i1 %4, label %48, label %.preheader

.preheader:                                       ; preds = %0
  %5 = icmp sgt i32 %number_of_arrays, 0
  br i1 %5, label %.lr.ph.preheader.preheader, label %._crit_edge.thread

.lr.ph.preheader.preheader:                       ; preds = %.preheader
  %xtraiter = and i32 %number_of_arrays, 1
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  %6 = icmp eq i32 %number_of_arrays, 1
  br label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %.lr.ph.preheader.preheader, %41
  %indvars.iv57 = phi i64 [ %indvars.iv.next6, %41 ], [ 0, %.lr.ph.preheader.preheader ]
  br i1 %lcmp.mod, label %.lr.ph.preheader.split, label %.lr.ph.prol

.lr.ph.prol:                                      ; preds = %.lr.ph.preheader
  %7 = load i64, i64* %3, align 8, !tbaa !2
  %8 = load i32, i32* %arraysizes, align 4, !tbaa !6
  %9 = sext i32 %8 to i64
  %10 = icmp slt i64 %7, %9
  br i1 %10, label %11, label %18

; <label>:11                                      ; preds = %.lr.ph.prol
  %12 = load i64*, i64** %arrays, align 8, !tbaa !8
  %13 = getelementptr inbounds i64, i64* %12, i64 %7
  %14 = load i64, i64* %13, align 8, !tbaa !2
  %15 = icmp slt i64 %14, 2147483647
  %16 = select i1 %15, i64 %14, i64 2147483647
  %17 = trunc i64 %16 to i32
  %not. = icmp sgt i64 %14, 2147483646
  %j.0.minposition.0.prol = sext i1 %not. to i32
  br label %18

; <label>:18                                      ; preds = %11, %.lr.ph.prol
  %min.1.prol = phi i32 [ 2147483647, %.lr.ph.prol ], [ %17, %11 ]
  %minposition.1.prol = phi i32 [ -1, %.lr.ph.prol ], [ %j.0.minposition.0.prol, %11 ]
  br label %.lr.ph.preheader.split

.lr.ph.preheader.split:                           ; preds = %.lr.ph.preheader, %18
  %minposition.1.lcssa.unr = phi i32 [ undef, %.lr.ph.preheader ], [ %minposition.1.prol, %18 ]
  %min.1.lcssa.unr = phi i32 [ undef, %.lr.ph.preheader ], [ %min.1.prol, %18 ]
  %indvars.iv.unr = phi i64 [ 0, %.lr.ph.preheader ], [ 1, %18 ]
  %minposition.03.unr = phi i32 [ -1, %.lr.ph.preheader ], [ %minposition.1.prol, %18 ]
  %min.02.unr = phi i32 [ 2147483647, %.lr.ph.preheader ], [ %min.1.prol, %18 ]
  br i1 %6, label %._crit_edge, label %.lr.ph.preheader.split.split

.lr.ph.preheader.split.split:                     ; preds = %.lr.ph.preheader.split
  br label %.lr.ph

.lr.ph:                                           ; preds = %58, %.lr.ph.preheader.split.split
  %indvars.iv = phi i64 [ %indvars.iv.unr, %.lr.ph.preheader.split.split ], [ %indvars.iv.next.1, %58 ]
  %minposition.03 = phi i32 [ %minposition.03.unr, %.lr.ph.preheader.split.split ], [ %minposition.1.1, %58 ]
  %min.02 = phi i32 [ %min.02.unr, %.lr.ph.preheader.split.split ], [ %min.1.1, %58 ]
  %19 = getelementptr inbounds i64, i64* %3, i64 %indvars.iv
  %20 = load i64, i64* %19, align 8, !tbaa !2
  %21 = getelementptr inbounds i32, i32* %arraysizes, i64 %indvars.iv
  %22 = load i32, i32* %21, align 4, !tbaa !6
  %23 = sext i32 %22 to i64
  %24 = icmp slt i64 %20, %23
  br i1 %24, label %25, label %.lr.ph.18

; <label>:25                                      ; preds = %.lr.ph
  %26 = getelementptr inbounds i64*, i64** %arrays, i64 %indvars.iv
  %27 = load i64*, i64** %26, align 8, !tbaa !8
  %28 = getelementptr inbounds i64, i64* %27, i64 %20
  %29 = load i64, i64* %28, align 8, !tbaa !2
  %30 = sext i32 %min.02 to i64
  %31 = icmp slt i64 %29, %30
  %32 = trunc i64 %29 to i32
  %.min.0 = select i1 %31, i32 %32, i32 %min.02
  %33 = trunc i64 %indvars.iv to i32
  %j.0.minposition.0 = select i1 %31, i32 %33, i32 %minposition.03
  br label %.lr.ph.18

.lr.ph.18:                                        ; preds = %25, %.lr.ph
  %min.1 = phi i32 [ %min.02, %.lr.ph ], [ %.min.0, %25 ]
  %minposition.1 = phi i32 [ %minposition.03, %.lr.ph ], [ %j.0.minposition.0, %25 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %34 = getelementptr inbounds i64, i64* %3, i64 %indvars.iv.next
  %35 = load i64, i64* %34, align 8, !tbaa !2
  %36 = getelementptr inbounds i32, i32* %arraysizes, i64 %indvars.iv.next
  %37 = load i32, i32* %36, align 4, !tbaa !6
  %38 = sext i32 %37 to i64
  %39 = icmp slt i64 %35, %38
  br i1 %39, label %49, label %58

._crit_edge.unr-lcssa:                            ; preds = %58
  %minposition.1.1.lcssa = phi i32 [ %minposition.1.1, %58 ]
  %min.1.1.lcssa = phi i32 [ %min.1.1, %58 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph.preheader.split, %._crit_edge.unr-lcssa
  %minposition.1.lcssa = phi i32 [ %minposition.1.lcssa.unr, %.lr.ph.preheader.split ], [ %minposition.1.1.lcssa, %._crit_edge.unr-lcssa ]
  %min.1.lcssa = phi i32 [ %min.1.lcssa.unr, %.lr.ph.preheader.split ], [ %min.1.1.lcssa, %._crit_edge.unr-lcssa ]
  %40 = icmp eq i32 %minposition.1.lcssa, -1
  br i1 %40, label %._crit_edge.thread.loopexit, label %41

; <label>:41                                      ; preds = %._crit_edge
  %42 = sext i32 %min.1.lcssa to i64
  %indvars.iv.next6 = add nuw nsw i64 %indvars.iv57, 1
  %43 = getelementptr inbounds i64, i64* %output, i64 %indvars.iv57
  store i64 %42, i64* %43, align 8, !tbaa !2
  %44 = sext i32 %minposition.1.lcssa to i64
  %45 = getelementptr inbounds i64, i64* %3, i64 %44
  %46 = load i64, i64* %45, align 8, !tbaa !2
  %47 = add nsw i64 %46, 1
  store i64 %47, i64* %45, align 8, !tbaa !2
  br i1 %5, label %.lr.ph.preheader, label %._crit_edge.thread.loopexit

._crit_edge.thread.loopexit:                      ; preds = %41, %._crit_edge
  br label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %._crit_edge.thread.loopexit, %.preheader
  tail call void @free(i8* nonnull %2)
  br label %48

; <label>:48                                      ; preds = %0, %._crit_edge.thread
  ret void

; <label>:49                                      ; preds = %.lr.ph.18
  %50 = getelementptr inbounds i64*, i64** %arrays, i64 %indvars.iv.next
  %51 = load i64*, i64** %50, align 8, !tbaa !8
  %52 = getelementptr inbounds i64, i64* %51, i64 %35
  %53 = load i64, i64* %52, align 8, !tbaa !2
  %54 = sext i32 %min.1 to i64
  %55 = icmp slt i64 %53, %54
  %56 = trunc i64 %53 to i32
  %.min.0.1 = select i1 %55, i32 %56, i32 %min.1
  %57 = trunc i64 %indvars.iv.next to i32
  %j.0.minposition.0.1 = select i1 %55, i32 %57, i32 %minposition.1
  br label %58

; <label>:58                                      ; preds = %49, %.lr.ph.18
  %min.1.1 = phi i32 [ %min.1, %.lr.ph.18 ], [ %.min.0.1, %49 ]
  %minposition.1.1 = phi i32 [ %minposition.1, %.lr.ph.18 ], [ %j.0.minposition.0.1, %49 ]
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %number_of_arrays
  br i1 %exitcond.1, label %._crit_edge.unr-lcssa, label %.lr.ph
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare noalias i8* @calloc(i64, i64) #2

; Function Attrs: nounwind
declare void @free(i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable
define void @printArr(i64* nocapture readonly %arr, i32 %size) #0 {
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
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @str.8, i64 0, i64 0))
  br label %14

; <label>:14                                      ; preds = %8, %13
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %size
  br i1 %exitcond, label %._crit_edge.loopexit, label %4
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind ssp uwtable
define void @printArrInt(i32* nocapture readonly %arr, i32 %size) #0 {
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
  %9 = getelementptr inbounds i32, i32* %arr, i64 %indvars.iv
  %10 = load i32, i32* %9, align 4, !tbaa !6
  %11 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 %10) #7
  %12 = icmp eq i64 %indvars.iv, %3
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %8
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @str.8, i64 0, i64 0))
  br label %14

; <label>:14                                      ; preds = %8, %13
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %size
  br i1 %exitcond, label %._crit_edge.loopexit, label %4
}

; Function Attrs: nounwind readonly ssp uwtable
define i32 @isSorted(i64* nocapture readonly %arr, i32 %size) #3 {
  %1 = add nsw i32 %size, -1
  %2 = sext i32 %1 to i64
  br label %3

; <label>:3                                       ; preds = %5, %0
  %indvars.iv = phi i64 [ %indvars.iv.next, %5 ], [ 0, %0 ]
  %4 = icmp slt i64 %indvars.iv, %2
  br i1 %4, label %5, label %11

; <label>:5                                       ; preds = %3
  %6 = getelementptr inbounds i64, i64* %arr, i64 %indvars.iv
  %7 = load i64, i64* %6, align 8, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %8 = getelementptr inbounds i64, i64* %arr, i64 %indvars.iv.next
  %9 = load i64, i64* %8, align 8, !tbaa !2
  %10 = icmp sgt i64 %7, %9
  br i1 %10, label %11, label %3

; <label>:11                                      ; preds = %5, %3
  %.0 = phi i32 [ 1, %3 ], [ 0, %5 ]
  ret i32 %.0
}

; Function Attrs: nounwind readonly ssp uwtable
define i32 @binarySearch(i64* readonly %arr, i32 %l, i32 %r, i64 %x) #3 {
  %1 = icmp slt i32 %r, %l
  br i1 %1, label %.loopexit, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %tailrecurse.outer
  %r.tr.ph8 = phi i32 [ %r.tr5.lcssa42, %tailrecurse.outer ], [ %r, %.lr.ph.preheader ]
  %l.tr.ph7 = phi i32 [ %16, %tailrecurse.outer ], [ %l, %.lr.ph.preheader ]
  br label %2

; <label>:2                                       ; preds = %.lr.ph, %tailrecurse
  %r.tr5 = phi i32 [ %r.tr.ph8, %.lr.ph ], [ %14, %tailrecurse ]
  %3 = sub nsw i32 %r.tr5, %l.tr.ph7
  %4 = sdiv i32 %3, 2
  %5 = add nsw i32 %4, %l.tr.ph7
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds i64, i64* %arr, i64 %6
  %8 = load i64, i64* %7, align 8, !tbaa !2
  %9 = icmp eq i64 %8, %x
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %2
  %.lcssa = phi i32 [ %5, %2 ]
  %11 = add nsw i32 %.lcssa, 1
  br label %.loopexit

; <label>:12                                      ; preds = %2
  %13 = icmp sgt i64 %8, %x
  br i1 %13, label %tailrecurse, label %tailrecurse.outer

tailrecurse:                                      ; preds = %12
  %14 = add nsw i32 %5, -1
  %15 = icmp slt i32 %3, 2
  br i1 %15, label %.loopexit.loopexit, label %2

tailrecurse.outer:                                ; preds = %12
  %.lcssa44 = phi i32 [ %5, %12 ]
  %r.tr5.lcssa42 = phi i32 [ %r.tr5, %12 ]
  %16 = add nsw i32 %.lcssa44, 1
  %17 = icmp sgt i32 %r.tr5.lcssa42, %.lcssa44
  br i1 %17, label %.lr.ph, label %.loopexit.loopexit34

.loopexit.loopexit:                               ; preds = %tailrecurse
  %l.tr.ph7.lcssa47 = phi i32 [ %l.tr.ph7, %tailrecurse ]
  br label %.loopexit

.loopexit.loopexit34:                             ; preds = %tailrecurse.outer
  %.lcssa48 = phi i32 [ %16, %tailrecurse.outer ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit34, %.loopexit.loopexit, %0, %10
  %.1 = phi i32 [ %11, %10 ], [ %l, %0 ], [ %l.tr.ph7.lcssa47, %.loopexit.loopexit ], [ %.lcssa48, %.loopexit.loopexit34 ]
  ret i32 %.1
}

; Function Attrs: nounwind readonly ssp uwtable
define i32 @cmpfunc(i8* nocapture readonly %a, i8* nocapture readonly %b) #3 {
  %1 = bitcast i8* %a to i64*
  %2 = load i64, i64* %1, align 8, !tbaa !2
  %3 = bitcast i8* %b to i64*
  %4 = load i64, i64* %3, align 8, !tbaa !2
  %5 = sub nsw i64 %2, %4
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %taskid = alloca i32, align 4
  %Nthr = alloca i32, align 4
  %mysendLength = alloca i32, align 4
  %1 = tail call i32 @MPI_Init(i32* null, i8*** null) #7
  %2 = bitcast i32* %taskid to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2) #7
  %3 = bitcast i32* %Nthr to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3) #7
  %4 = call i32 @MPI_Comm_size(%struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), i32* nonnull %Nthr) #7
  %5 = call i32 @MPI_Comm_rank(%struct.ompi_communicator_t* bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*), i32* nonnull %taskid) #7
  %6 = icmp eq i32 %argc, 3
  br i1 %6, label %17, label %7

; <label>:7                                       ; preds = %0
  %8 = load i32, i32* %taskid, align 4, !tbaa !6
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %15

; <label>:10                                      ; preds = %7
  %11 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !8
  %12 = call i64 @fwrite(i8* nonnull getelementptr inbounds ([34 x i8], [34 x i8]* @.str.4, i64 0, i64 0), i64 33, i64 1, %struct.__sFILE* %11)
  %13 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !8
  %14 = call i32 @fflush(%struct.__sFILE* %13) #7
  br label %15

; <label>:15                                      ; preds = %10, %7
  %16 = call i32 @MPI_Finalize() #7
  call void @exit(i32 0) #8
  unreachable

; <label>:17                                      ; preds = %0
  %18 = getelementptr inbounds i8*, i8** %argv, i64 1
  %19 = load i8*, i8** %18, align 8, !tbaa !8
  %20 = call i32 @atoi(i8* %19) #7
  %21 = getelementptr inbounds i8*, i8** %argv, i64 2
  %22 = load i8*, i8** %21, align 8, !tbaa !8
  %23 = call %struct.__sFILE* @"\01_fopen"(i8* %22, i8* nonnull getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i64 0, i64 0)) #7
  %24 = load i32, i32* %Nthr, align 4, !tbaa !6
  %25 = srem i32 %20, %24
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %37, label %27

; <label>:27                                      ; preds = %17
  %28 = load i32, i32* %taskid, align 4, !tbaa !6
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %35

; <label>:30                                      ; preds = %27
  %31 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !8
  %32 = call i64 @fwrite(i8* nonnull getelementptr inbounds ([51 x i8], [51 x i8]* @.str.6, i64 0, i64 0), i64 50, i64 1, %struct.__sFILE* %31)
  %33 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !8
  %34 = call i32 @fflush(%struct.__sFILE* %33) #7
  br label %35

; <label>:35                                      ; preds = %30, %27
  %36 = call i32 @MPI_Finalize() #7
  call void @exit(i32 1) #8
  unreachable

; <label>:37                                      ; preds = %17
  %38 = mul nsw i32 %24, %24
  %39 = srem i32 %20, %38
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %51, label %41

; <label>:41                                      ; preds = %37
  %42 = load i32, i32* %taskid, align 4, !tbaa !6
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %49

; <label>:44                                      ; preds = %41
  %45 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !8
  %46 = call i64 @fwrite(i8* nonnull getelementptr inbounds ([51 x i8], [51 x i8]* @.str.6, i64 0, i64 0), i64 50, i64 1, %struct.__sFILE* %45)
  %47 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8, !tbaa !8
  %48 = call i32 @fflush(%struct.__sFILE* %47) #7
  br label %49

; <label>:49                                      ; preds = %44, %41
  %50 = call i32 @MPI_Finalize() #7
  call void @exit(i32 2) #8
  unreachable

; <label>:51                                      ; preds = %37
  %52 = sext i32 %20 to i64
  %53 = call i8* @calloc(i64 %52, i64 8) #7
  %54 = bitcast i8* %53 to i64*
  %55 = sdiv i32 %20, %24
  %56 = sdiv i32 %20, %38
  %57 = zext i32 %38 to i64
  %58 = call i8* @calloc(i64 %57, i64 8) #7
  %59 = bitcast i8* %58 to i64*
  %60 = sext i32 %24 to i64
  %61 = call i8* @calloc(i64 %60, i64 4) #7
  %62 = bitcast i8* %61 to i32*
  %63 = call i8* @calloc(i64 %60, i64 4) #7
  %64 = bitcast i8* %63 to i32*
  %65 = load i32, i32* %taskid, align 4, !tbaa !6
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %79, label %.preheader14

.preheader14.loopexit:                            ; preds = %.lr.ph70
  br label %.preheader14

.preheader14:                                     ; preds = %.preheader14.loopexit, %79, %51
  %67 = load i32, i32* %Nthr, align 4, !tbaa !6
  %68 = icmp sgt i32 %67, 0
  br i1 %68, label %.lr.ph65, label %._crit_edge.66

.lr.ph65:                                         ; preds = %.preheader14
  %69 = sext i32 %55 to i64
  %70 = sext i32 %67 to i64
  %71 = sext i32 %67 to i64
  %72 = add nsw i64 %71, -1
  %xtraiter203 = and i64 %71, 3
  %lcmp.mod204 = icmp eq i64 %xtraiter203, 0
  br i1 %lcmp.mod204, label %.lr.ph65.split, label %.preheader208

.preheader208:                                    ; preds = %.lr.ph65
  br label %73

; <label>:73                                      ; preds = %.preheader208, %73
  %indvars.iv99.prol = phi i64 [ %indvars.iv.next100.prol, %73 ], [ 0, %.preheader208 ]
  %prol.iter205 = phi i64 [ %prol.iter205.sub, %73 ], [ %xtraiter203, %.preheader208 ]
  %74 = mul nsw i64 %indvars.iv99.prol, %69
  %75 = getelementptr inbounds i32, i32* %62, i64 %indvars.iv99.prol
  %76 = trunc i64 %74 to i32
  store i32 %76, i32* %75, align 4, !tbaa !6
  %77 = getelementptr inbounds i32, i32* %64, i64 %indvars.iv99.prol
  store i32 %55, i32* %77, align 4, !tbaa !6
  %indvars.iv.next100.prol = add nuw nsw i64 %indvars.iv99.prol, 1
  %prol.iter205.sub = add i64 %prol.iter205, -1
  %prol.iter205.cmp = icmp eq i64 %prol.iter205.sub, 0
  br i1 %prol.iter205.cmp, label %.lr.ph65.split.loopexit, label %73, !llvm.loop !10

.lr.ph65.split.loopexit:                          ; preds = %73
  %indvars.iv.next100.prol.lcssa = phi i64 [ %indvars.iv.next100.prol, %73 ]
  br label %.lr.ph65.split

.lr.ph65.split:                                   ; preds = %.lr.ph65.split.loopexit, %.lr.ph65
  %indvars.iv99.unr = phi i64 [ 0, %.lr.ph65 ], [ %indvars.iv.next100.prol.lcssa, %.lr.ph65.split.loopexit ]
  %78 = icmp ult i64 %72, 3
  br i1 %78, label %._crit_edge.66.loopexit, label %.lr.ph65.split.split

.lr.ph65.split.split:                             ; preds = %.lr.ph65.split
  br label %87

; <label>:79                                      ; preds = %51
  call void @srandom(i32 23478237) #7
  %80 = icmp sgt i32 %20, 0
  br i1 %80, label %.lr.ph70.preheader, label %.preheader14

.lr.ph70.preheader:                               ; preds = %79
  br label %.lr.ph70

.lr.ph70:                                         ; preds = %.lr.ph70.preheader, %.lr.ph70
  %indvars.iv101 = phi i64 [ %indvars.iv.next102, %.lr.ph70 ], [ 0, %.lr.ph70.preheader ]
  %81 = call i64 @random() #7
  %82 = srem i64 %81, 100
  %83 = getelementptr inbounds i64, i64* %54, i64 %indvars.iv101
  store i64 %82, i64* %83, align 8, !tbaa !2
  %indvars.iv.next102 = add nuw nsw i64 %indvars.iv101, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next102 to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %20
  br i1 %exitcond, label %.preheader14.loopexit, label %.lr.ph70

._crit_edge.66.loopexit.unr-lcssa:                ; preds = %87
  br label %._crit_edge.66.loopexit

._crit_edge.66.loopexit:                          ; preds = %.lr.ph65.split, %._crit_edge.66.loopexit.unr-lcssa
  br label %._crit_edge.66

._crit_edge.66:                                   ; preds = %._crit_edge.66.loopexit, %.preheader14
  %84 = load i32, i32* %taskid, align 4, !tbaa !6
  %85 = icmp eq i32 %84, 0
  %86 = sdiv i32 %20, %67
  br i1 %85, label %105, label %107

; <label>:87                                      ; preds = %87, %.lr.ph65.split.split
  %indvars.iv99 = phi i64 [ %indvars.iv99.unr, %.lr.ph65.split.split ], [ %indvars.iv.next100.3, %87 ]
  %88 = mul nsw i64 %indvars.iv99, %69
  %89 = getelementptr inbounds i32, i32* %62, i64 %indvars.iv99
  %90 = trunc i64 %88 to i32
  store i32 %90, i32* %89, align 4, !tbaa !6
  %91 = getelementptr inbounds i32, i32* %64, i64 %indvars.iv99
  store i32 %55, i32* %91, align 4, !tbaa !6
  %indvars.iv.next100 = add nuw nsw i64 %indvars.iv99, 1
  %92 = mul nsw i64 %indvars.iv.next100, %69
  %93 = getelementptr inbounds i32, i32* %62, i64 %indvars.iv.next100
  %94 = trunc i64 %92 to i32
  store i32 %94, i32* %93, align 4, !tbaa !6
  %95 = getelementptr inbounds i32, i32* %64, i64 %indvars.iv.next100
  store i32 %55, i32* %95, align 4, !tbaa !6
  %indvars.iv.next100.1 = add nsw i64 %indvars.iv99, 2
  %96 = mul nsw i64 %indvars.iv.next100.1, %69
  %97 = getelementptr inbounds i32, i32* %62, i64 %indvars.iv.next100.1
  %98 = trunc i64 %96 to i32
  store i32 %98, i32* %97, align 4, !tbaa !6
  %99 = getelementptr inbounds i32, i32* %64, i64 %indvars.iv.next100.1
  store i32 %55, i32* %99, align 4, !tbaa !6
  %indvars.iv.next100.2 = add nsw i64 %indvars.iv99, 3
  %100 = mul nsw i64 %indvars.iv.next100.2, %69
  %101 = getelementptr inbounds i32, i32* %62, i64 %indvars.iv.next100.2
  %102 = trunc i64 %100 to i32
  store i32 %102, i32* %101, align 4, !tbaa !6
  %103 = getelementptr inbounds i32, i32* %64, i64 %indvars.iv.next100.2
  store i32 %55, i32* %103, align 4, !tbaa !6
  %indvars.iv.next100.3 = add nsw i64 %indvars.iv99, 4
  %104 = icmp slt i64 %indvars.iv.next100.3, %70
  br i1 %104, label %87, label %._crit_edge.66.loopexit.unr-lcssa

; <label>:105                                     ; preds = %._crit_edge.66
  %106 = call i32 @MPI_Scatterv(i8* %53, i32* %64, i32* %62, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* nonnull inttoptr (i64 1 to i8*), i32 %86, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %109

; <label>:107                                     ; preds = %._crit_edge.66
  %108 = call i32 @MPI_Scatterv(i8* %53, i32* %64, i32* %62, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %53, i32 %86, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %109

; <label>:109                                     ; preds = %107, %105
  %110 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %111 = load i32, i32* %taskid, align 4, !tbaa !6
  %112 = icmp eq i32 %111, 0
  br i1 %112, label %113, label %115

; <label>:113                                     ; preds = %109
  %114 = call double @MPI_Wtime() #7
  br label %115

; <label>:115                                     ; preds = %113, %109
  %t_start.0 = phi double [ %114, %113 ], [ undef, %109 ]
  %116 = sext i32 %55 to i64
  call void @qsort(i8* %53, i64 %116, i64 8, i32 (i8*, i8*)* nonnull @cmpfunc) #7
  %117 = load i32, i32* %Nthr, align 4, !tbaa !6
  %118 = icmp sgt i32 %117, 0
  br i1 %118, label %.lr.ph61, label %._crit_edge.62

.lr.ph61:                                         ; preds = %115
  %119 = sext i32 %56 to i64
  %120 = sext i32 %117 to i64
  %121 = sext i32 %117 to i64
  %min.iters.check = icmp ult i32 %117, 4
  br i1 %min.iters.check, label %scalar.ph.preheader, label %min.iters.checked

scalar.ph.preheader:                              ; preds = %min.iters.checked, %middle.block, %.lr.ph61
  %indvars.iv97.ph = phi i64 [ 0, %min.iters.checked ], [ 0, %.lr.ph61 ], [ %n.vec, %middle.block ]
  br label %scalar.ph

min.iters.checked:                                ; preds = %.lr.ph61
  %n.vec = and i64 %121, -4
  %cmp.zero = icmp ne i64 %n.vec, 0
  %ident.check = icmp eq i32 %56, 1
  %or.cond = and i1 %cmp.zero, %ident.check
  br i1 %or.cond, label %vector.body.preheader, label %scalar.ph.preheader

vector.body.preheader:                            ; preds = %min.iters.checked
  %122 = sext i32 %117 to i64
  %123 = add nsw i64 %122, -4
  %124 = lshr i64 %123, 2
  %125 = add nuw nsw i64 %124, 1
  %xtraiter200 = and i64 %125, 3
  %lcmp.mod201 = icmp eq i64 %xtraiter200, 0
  br i1 %lcmp.mod201, label %vector.body.preheader.split, label %vector.body.prol.preheader

vector.body.prol.preheader:                       ; preds = %vector.body.preheader
  br label %vector.body.prol

vector.body.prol:                                 ; preds = %vector.body.prol.preheader, %vector.body.prol
  %index.prol = phi i64 [ %index.next.prol, %vector.body.prol ], [ 0, %vector.body.prol.preheader ]
  %prol.iter202 = phi i64 [ %prol.iter202.sub, %vector.body.prol ], [ %xtraiter200, %vector.body.prol.preheader ]
  %126 = getelementptr inbounds i64, i64* %54, i64 %index.prol
  %127 = bitcast i64* %126 to <2 x i64>*
  %wide.load.prol = load <2 x i64>, <2 x i64>* %127, align 8, !tbaa !2
  %128 = getelementptr i64, i64* %126, i64 2
  %129 = bitcast i64* %128 to <2 x i64>*
  %wide.load125.prol = load <2 x i64>, <2 x i64>* %129, align 8, !tbaa !2
  %130 = getelementptr inbounds i64, i64* %59, i64 %index.prol
  %131 = bitcast i64* %130 to <2 x i64>*
  store <2 x i64> %wide.load.prol, <2 x i64>* %131, align 8, !tbaa !2
  %132 = getelementptr i64, i64* %130, i64 2
  %133 = bitcast i64* %132 to <2 x i64>*
  store <2 x i64> %wide.load125.prol, <2 x i64>* %133, align 8, !tbaa !2
  %index.next.prol = add i64 %index.prol, 4
  %prol.iter202.sub = add i64 %prol.iter202, -1
  %prol.iter202.cmp = icmp eq i64 %prol.iter202.sub, 0
  br i1 %prol.iter202.cmp, label %vector.body.preheader.split.loopexit, label %vector.body.prol, !llvm.loop !12

vector.body.preheader.split.loopexit:             ; preds = %vector.body.prol
  %index.next.prol.lcssa = phi i64 [ %index.next.prol, %vector.body.prol ]
  br label %vector.body.preheader.split

vector.body.preheader.split:                      ; preds = %vector.body.preheader.split.loopexit, %vector.body.preheader
  %index.unr = phi i64 [ 0, %vector.body.preheader ], [ %index.next.prol.lcssa, %vector.body.preheader.split.loopexit ]
  %134 = icmp ult i64 %123, 12
  br i1 %134, label %middle.block, label %vector.body.preheader.split.split

vector.body.preheader.split.split:                ; preds = %vector.body.preheader.split
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.body.preheader.split.split
  %index = phi i64 [ %index.unr, %vector.body.preheader.split.split ], [ %index.next.3, %vector.body ]
  %135 = getelementptr inbounds i64, i64* %54, i64 %index
  %136 = bitcast i64* %135 to <2 x i64>*
  %wide.load = load <2 x i64>, <2 x i64>* %136, align 8, !tbaa !2
  %137 = getelementptr i64, i64* %135, i64 2
  %138 = bitcast i64* %137 to <2 x i64>*
  %wide.load125 = load <2 x i64>, <2 x i64>* %138, align 8, !tbaa !2
  %139 = getelementptr inbounds i64, i64* %59, i64 %index
  %140 = bitcast i64* %139 to <2 x i64>*
  store <2 x i64> %wide.load, <2 x i64>* %140, align 8, !tbaa !2
  %141 = getelementptr i64, i64* %139, i64 2
  %142 = bitcast i64* %141 to <2 x i64>*
  store <2 x i64> %wide.load125, <2 x i64>* %142, align 8, !tbaa !2
  %index.next = add i64 %index, 4
  %143 = getelementptr inbounds i64, i64* %54, i64 %index.next
  %144 = bitcast i64* %143 to <2 x i64>*
  %wide.load.1 = load <2 x i64>, <2 x i64>* %144, align 8, !tbaa !2
  %145 = getelementptr i64, i64* %143, i64 2
  %146 = bitcast i64* %145 to <2 x i64>*
  %wide.load125.1 = load <2 x i64>, <2 x i64>* %146, align 8, !tbaa !2
  %147 = getelementptr inbounds i64, i64* %59, i64 %index.next
  %148 = bitcast i64* %147 to <2 x i64>*
  store <2 x i64> %wide.load.1, <2 x i64>* %148, align 8, !tbaa !2
  %149 = getelementptr i64, i64* %147, i64 2
  %150 = bitcast i64* %149 to <2 x i64>*
  store <2 x i64> %wide.load125.1, <2 x i64>* %150, align 8, !tbaa !2
  %index.next.1 = add i64 %index, 8
  %151 = getelementptr inbounds i64, i64* %54, i64 %index.next.1
  %152 = bitcast i64* %151 to <2 x i64>*
  %wide.load.2 = load <2 x i64>, <2 x i64>* %152, align 8, !tbaa !2
  %153 = getelementptr i64, i64* %151, i64 2
  %154 = bitcast i64* %153 to <2 x i64>*
  %wide.load125.2 = load <2 x i64>, <2 x i64>* %154, align 8, !tbaa !2
  %155 = getelementptr inbounds i64, i64* %59, i64 %index.next.1
  %156 = bitcast i64* %155 to <2 x i64>*
  store <2 x i64> %wide.load.2, <2 x i64>* %156, align 8, !tbaa !2
  %157 = getelementptr i64, i64* %155, i64 2
  %158 = bitcast i64* %157 to <2 x i64>*
  store <2 x i64> %wide.load125.2, <2 x i64>* %158, align 8, !tbaa !2
  %index.next.2 = add i64 %index, 12
  %159 = getelementptr inbounds i64, i64* %54, i64 %index.next.2
  %160 = bitcast i64* %159 to <2 x i64>*
  %wide.load.3 = load <2 x i64>, <2 x i64>* %160, align 8, !tbaa !2
  %161 = getelementptr i64, i64* %159, i64 2
  %162 = bitcast i64* %161 to <2 x i64>*
  %wide.load125.3 = load <2 x i64>, <2 x i64>* %162, align 8, !tbaa !2
  %163 = getelementptr inbounds i64, i64* %59, i64 %index.next.2
  %164 = bitcast i64* %163 to <2 x i64>*
  store <2 x i64> %wide.load.3, <2 x i64>* %164, align 8, !tbaa !2
  %165 = getelementptr i64, i64* %163, i64 2
  %166 = bitcast i64* %165 to <2 x i64>*
  store <2 x i64> %wide.load125.3, <2 x i64>* %166, align 8, !tbaa !2
  %index.next.3 = add i64 %index, 16
  %167 = icmp eq i64 %index.next.3, %n.vec
  br i1 %167, label %middle.block.unr-lcssa, label %vector.body, !llvm.loop !13

middle.block.unr-lcssa:                           ; preds = %vector.body
  br label %middle.block

middle.block:                                     ; preds = %vector.body.preheader.split, %middle.block.unr-lcssa
  %cmp.n = icmp eq i64 %121, %n.vec
  br i1 %cmp.n, label %._crit_edge.62, label %scalar.ph.preheader

._crit_edge.62.loopexit:                          ; preds = %scalar.ph
  br label %._crit_edge.62

._crit_edge.62:                                   ; preds = %._crit_edge.62.loopexit, %middle.block, %115
  %168 = load i32, i32* %taskid, align 4, !tbaa !6
  %169 = icmp eq i32 %168, 0
  br i1 %169, label %175, label %177

scalar.ph:                                        ; preds = %scalar.ph.preheader, %scalar.ph
  %indvars.iv97 = phi i64 [ %indvars.iv.next98, %scalar.ph ], [ %indvars.iv97.ph, %scalar.ph.preheader ]
  %170 = mul nsw i64 %indvars.iv97, %119
  %171 = getelementptr inbounds i64, i64* %54, i64 %170
  %172 = load i64, i64* %171, align 8, !tbaa !2
  %173 = getelementptr inbounds i64, i64* %59, i64 %indvars.iv97
  store i64 %172, i64* %173, align 8, !tbaa !2
  %indvars.iv.next98 = add nuw nsw i64 %indvars.iv97, 1
  %174 = icmp slt i64 %indvars.iv.next98, %120
  br i1 %174, label %scalar.ph, label %._crit_edge.62.loopexit, !llvm.loop !16

; <label>:175                                     ; preds = %._crit_edge.62
  %176 = call i32 @MPI_Gather(i8* nonnull inttoptr (i64 1 to i8*), i32 %117, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %58, i32 %117, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %179

; <label>:177                                     ; preds = %._crit_edge.62
  %178 = call i32 @MPI_Gather(i8* %58, i32 %117, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %58, i32 %117, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %179

; <label>:179                                     ; preds = %177, %175
  %180 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %181 = load i32, i32* %taskid, align 4, !tbaa !6
  %182 = icmp eq i32 %181, 0
  br i1 %182, label %183, label %278

; <label>:183                                     ; preds = %179
  %184 = load i32, i32* %Nthr, align 4, !tbaa !6
  %185 = zext i32 %184 to i64
  %186 = call i8* @llvm.stacksave()
  %187 = alloca i64*, i64 %185, align 16
  %188 = load i32, i32* %Nthr, align 4, !tbaa !6
  %189 = zext i32 %188 to i64
  %190 = alloca i32, i64 %189, align 16
  %191 = icmp sgt i32 %188, 0
  br i1 %191, label %.lr.ph56, label %._crit_edge.57

.lr.ph56:                                         ; preds = %183
  %192 = sext i32 %188 to i64
  %193 = sext i32 %188 to i64
  %194 = add nsw i64 %193, -1
  %xtraiter197 = and i64 %193, 3
  %lcmp.mod198 = icmp eq i64 %xtraiter197, 0
  br i1 %lcmp.mod198, label %.lr.ph56.split, label %.preheader207

.preheader207:                                    ; preds = %.lr.ph56
  br label %195

; <label>:195                                     ; preds = %.preheader207, %195
  %indvars.iv95.prol = phi i64 [ %indvars.iv.next96.prol, %195 ], [ 0, %.preheader207 ]
  %prol.iter199 = phi i64 [ %prol.iter199.sub, %195 ], [ %xtraiter197, %.preheader207 ]
  %196 = trunc i64 %indvars.iv95.prol to i32
  %197 = mul nsw i32 %188, %196
  %198 = sext i32 %197 to i64
  %199 = getelementptr inbounds i64, i64* %59, i64 %198
  %200 = getelementptr inbounds i64*, i64** %187, i64 %indvars.iv95.prol
  store i64* %199, i64** %200, align 8, !tbaa !8
  %201 = getelementptr inbounds i32, i32* %190, i64 %indvars.iv95.prol
  store i32 %188, i32* %201, align 4, !tbaa !6
  %indvars.iv.next96.prol = add nuw nsw i64 %indvars.iv95.prol, 1
  %prol.iter199.sub = add i64 %prol.iter199, -1
  %prol.iter199.cmp = icmp eq i64 %prol.iter199.sub, 0
  br i1 %prol.iter199.cmp, label %.lr.ph56.split.loopexit, label %195, !llvm.loop !17

.lr.ph56.split.loopexit:                          ; preds = %195
  %indvars.iv.next96.prol.lcssa = phi i64 [ %indvars.iv.next96.prol, %195 ]
  br label %.lr.ph56.split

.lr.ph56.split:                                   ; preds = %.lr.ph56.split.loopexit, %.lr.ph56
  %indvars.iv95.unr = phi i64 [ 0, %.lr.ph56 ], [ %indvars.iv.next96.prol.lcssa, %.lr.ph56.split.loopexit ]
  %202 = icmp ult i64 %194, 3
  br i1 %202, label %._crit_edge.57.loopexit, label %.lr.ph56.split.split

.lr.ph56.split.split:                             ; preds = %.lr.ph56.split
  br label %245

._crit_edge.57.loopexit.unr-lcssa:                ; preds = %245
  br label %._crit_edge.57.loopexit

._crit_edge.57.loopexit:                          ; preds = %.lr.ph56.split, %._crit_edge.57.loopexit.unr-lcssa
  br label %._crit_edge.57

._crit_edge.57:                                   ; preds = %._crit_edge.57.loopexit, %183
  %203 = mul nsw i32 %188, %188
  %204 = zext i32 %203 to i64
  %205 = alloca i64, i64 %204, align 16
  call void @multimerge(i64** nonnull %187, i32* nonnull %190, i32 %188, i64* nonnull %205)
  %206 = load i32, i32* %Nthr, align 4, !tbaa !6
  %207 = icmp sgt i32 %206, 1
  br i1 %207, label %.lr.ph52, label %._crit_edge.53

.lr.ph52:                                         ; preds = %._crit_edge.57
  %208 = add nsw i32 %206, -1
  %209 = sext i32 %208 to i64
  %210 = sext i32 %208 to i64
  %211 = icmp sgt i64 %210, 1
  %smax = select i1 %211, i64 %210, i64 1
  %min.iters.check131 = icmp ult i64 %smax, 4
  br i1 %min.iters.check131, label %scalar.ph130.preheader, label %min.iters.checked132

scalar.ph130.preheader:                           ; preds = %min.iters.checked132, %middle.block129, %.lr.ph52
  %indvars.iv93.ph = phi i64 [ 0, %min.iters.checked132 ], [ 0, %.lr.ph52 ], [ %n.vec134, %middle.block129 ]
  br label %scalar.ph130

min.iters.checked132:                             ; preds = %.lr.ph52
  %n.vec134 = and i64 %smax, -4
  %cmp.zero135 = icmp ne i64 %n.vec134, 0
  %ident.check137 = icmp eq i32 %206, 1
  %or.cond174 = and i1 %cmp.zero135, %ident.check137
  br i1 %or.cond174, label %vector.body128.preheader, label %scalar.ph130.preheader

vector.body128.preheader:                         ; preds = %min.iters.checked132
  %212 = add i32 %206, -1
  %213 = sext i32 %212 to i64
  %214 = icmp sgt i64 %213, 1
  %smax194 = select i1 %214, i64 %213, i64 1
  %215 = add nsw i64 %smax194, -4
  %216 = lshr i64 %215, 2
  %217 = and i64 %216, 1
  %lcmp.mod196 = icmp eq i64 %217, 0
  br i1 %lcmp.mod196, label %vector.body128.prol, label %vector.body128.preheader.split

vector.body128.prol:                              ; preds = %vector.body128.preheader
  %218 = getelementptr inbounds i64, i64* %205, i64 1
  %219 = bitcast i64* %218 to <2 x i64>*
  %wide.load148.prol = load <2 x i64>, <2 x i64>* %219, align 8, !tbaa !2
  %220 = getelementptr i64, i64* %205, i64 3
  %221 = bitcast i64* %220 to <2 x i64>*
  %wide.load149.prol = load <2 x i64>, <2 x i64>* %221, align 8, !tbaa !2
  %222 = bitcast i8* %58 to <2 x i64>*
  store <2 x i64> %wide.load148.prol, <2 x i64>* %222, align 8, !tbaa !2
  %223 = getelementptr i8, i8* %58, i64 16
  %224 = bitcast i8* %223 to <2 x i64>*
  store <2 x i64> %wide.load149.prol, <2 x i64>* %224, align 8, !tbaa !2
  br label %vector.body128.preheader.split

vector.body128.preheader.split:                   ; preds = %vector.body128.prol, %vector.body128.preheader
  %index140.unr = phi i64 [ 0, %vector.body128.preheader ], [ 4, %vector.body128.prol ]
  %225 = icmp eq i64 %216, 0
  br i1 %225, label %middle.block129, label %vector.body128.preheader.split.split

vector.body128.preheader.split.split:             ; preds = %vector.body128.preheader.split
  br label %vector.body128

vector.body128:                                   ; preds = %vector.body128, %vector.body128.preheader.split.split
  %index140 = phi i64 [ %index140.unr, %vector.body128.preheader.split.split ], [ %index.next141.1, %vector.body128 ]
  %.lhs.lhs = shl i64 %index140, 32
  %.lhs = ashr exact i64 %.lhs.lhs, 32
  %226 = or i64 %.lhs, 1
  %227 = getelementptr inbounds i64, i64* %205, i64 %226
  %228 = bitcast i64* %227 to <2 x i64>*
  %wide.load148 = load <2 x i64>, <2 x i64>* %228, align 8, !tbaa !2
  %229 = getelementptr i64, i64* %227, i64 2
  %230 = bitcast i64* %229 to <2 x i64>*
  %wide.load149 = load <2 x i64>, <2 x i64>* %230, align 8, !tbaa !2
  %231 = getelementptr inbounds i64, i64* %59, i64 %index140
  %232 = bitcast i64* %231 to <2 x i64>*
  store <2 x i64> %wide.load148, <2 x i64>* %232, align 8, !tbaa !2
  %233 = getelementptr i64, i64* %231, i64 2
  %234 = bitcast i64* %233 to <2 x i64>*
  store <2 x i64> %wide.load149, <2 x i64>* %234, align 8, !tbaa !2
  %index.next141 = add i64 %index140, 4
  %.lhs.lhs.1 = shl i64 %index.next141, 32
  %.lhs.1 = ashr exact i64 %.lhs.lhs.1, 32
  %235 = or i64 %.lhs.1, 1
  %236 = getelementptr inbounds i64, i64* %205, i64 %235
  %237 = bitcast i64* %236 to <2 x i64>*
  %wide.load148.1 = load <2 x i64>, <2 x i64>* %237, align 8, !tbaa !2
  %238 = getelementptr i64, i64* %236, i64 2
  %239 = bitcast i64* %238 to <2 x i64>*
  %wide.load149.1 = load <2 x i64>, <2 x i64>* %239, align 8, !tbaa !2
  %240 = getelementptr inbounds i64, i64* %59, i64 %index.next141
  %241 = bitcast i64* %240 to <2 x i64>*
  store <2 x i64> %wide.load148.1, <2 x i64>* %241, align 8, !tbaa !2
  %242 = getelementptr i64, i64* %240, i64 2
  %243 = bitcast i64* %242 to <2 x i64>*
  store <2 x i64> %wide.load149.1, <2 x i64>* %243, align 8, !tbaa !2
  %index.next141.1 = add i64 %index140, 8
  %244 = icmp eq i64 %index.next141.1, %n.vec134
  br i1 %244, label %middle.block129.unr-lcssa, label %vector.body128, !llvm.loop !18

middle.block129.unr-lcssa:                        ; preds = %vector.body128
  br label %middle.block129

middle.block129:                                  ; preds = %vector.body128.preheader.split, %middle.block129.unr-lcssa
  %cmp.n143 = icmp eq i64 %smax, %n.vec134
  br i1 %cmp.n143, label %._crit_edge.53, label %scalar.ph130.preheader

; <label>:245                                     ; preds = %245, %.lr.ph56.split.split
  %indvars.iv95 = phi i64 [ %indvars.iv95.unr, %.lr.ph56.split.split ], [ %indvars.iv.next96.3, %245 ]
  %246 = trunc i64 %indvars.iv95 to i32
  %247 = mul nsw i32 %188, %246
  %248 = sext i32 %247 to i64
  %249 = getelementptr inbounds i64, i64* %59, i64 %248
  %250 = getelementptr inbounds i64*, i64** %187, i64 %indvars.iv95
  store i64* %249, i64** %250, align 8, !tbaa !8
  %251 = getelementptr inbounds i32, i32* %190, i64 %indvars.iv95
  store i32 %188, i32* %251, align 4, !tbaa !6
  %indvars.iv.next96 = add nuw nsw i64 %indvars.iv95, 1
  %252 = trunc i64 %indvars.iv.next96 to i32
  %253 = mul nsw i32 %188, %252
  %254 = sext i32 %253 to i64
  %255 = getelementptr inbounds i64, i64* %59, i64 %254
  %256 = getelementptr inbounds i64*, i64** %187, i64 %indvars.iv.next96
  store i64* %255, i64** %256, align 8, !tbaa !8
  %257 = getelementptr inbounds i32, i32* %190, i64 %indvars.iv.next96
  store i32 %188, i32* %257, align 4, !tbaa !6
  %indvars.iv.next96.1 = add nsw i64 %indvars.iv95, 2
  %258 = trunc i64 %indvars.iv.next96.1 to i32
  %259 = mul nsw i32 %188, %258
  %260 = sext i32 %259 to i64
  %261 = getelementptr inbounds i64, i64* %59, i64 %260
  %262 = getelementptr inbounds i64*, i64** %187, i64 %indvars.iv.next96.1
  store i64* %261, i64** %262, align 8, !tbaa !8
  %263 = getelementptr inbounds i32, i32* %190, i64 %indvars.iv.next96.1
  store i32 %188, i32* %263, align 4, !tbaa !6
  %indvars.iv.next96.2 = add nsw i64 %indvars.iv95, 3
  %264 = trunc i64 %indvars.iv.next96.2 to i32
  %265 = mul nsw i32 %188, %264
  %266 = sext i32 %265 to i64
  %267 = getelementptr inbounds i64, i64* %59, i64 %266
  %268 = getelementptr inbounds i64*, i64** %187, i64 %indvars.iv.next96.2
  store i64* %267, i64** %268, align 8, !tbaa !8
  %269 = getelementptr inbounds i32, i32* %190, i64 %indvars.iv.next96.2
  store i32 %188, i32* %269, align 4, !tbaa !6
  %indvars.iv.next96.3 = add nsw i64 %indvars.iv95, 4
  %270 = icmp slt i64 %indvars.iv.next96.3, %192
  br i1 %270, label %245, label %._crit_edge.57.loopexit.unr-lcssa

._crit_edge.53.loopexit:                          ; preds = %scalar.ph130
  br label %._crit_edge.53

._crit_edge.53:                                   ; preds = %._crit_edge.53.loopexit, %middle.block129, %._crit_edge.57
  call void @llvm.stackrestore(i8* %186)
  br label %278

scalar.ph130:                                     ; preds = %scalar.ph130.preheader, %scalar.ph130
  %indvars.iv93 = phi i64 [ %indvars.iv.next94, %scalar.ph130 ], [ %indvars.iv93.ph, %scalar.ph130.preheader ]
  %indvars.iv.next94 = add nuw nsw i64 %indvars.iv93, 1
  %271 = trunc i64 %indvars.iv.next94 to i32
  %272 = mul nsw i32 %271, %206
  %273 = sext i32 %272 to i64
  %274 = getelementptr inbounds i64, i64* %205, i64 %273
  %275 = load i64, i64* %274, align 8, !tbaa !2
  %276 = getelementptr inbounds i64, i64* %59, i64 %indvars.iv93
  store i64 %275, i64* %276, align 8, !tbaa !2
  %277 = icmp slt i64 %indvars.iv.next94, %209
  br i1 %277, label %scalar.ph130, label %._crit_edge.53.loopexit, !llvm.loop !19

; <label>:278                                     ; preds = %._crit_edge.53, %179
  %279 = load i32, i32* %Nthr, align 4, !tbaa !6
  %280 = add nsw i32 %279, -1
  %281 = call i32 @MPI_Bcast(i8* %58, i32 %280, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %282 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %283 = load i32, i32* %Nthr, align 4, !tbaa !6
  %284 = add nsw i32 %283, -1
  %285 = zext i32 %284 to i64
  %286 = alloca i32, i64 %285, align 16
  %287 = zext i32 %283 to i64
  %288 = alloca i32, i64 %287, align 16
  %289 = icmp sgt i32 %283, 1
  br i1 %289, label %.lr.ph47, label %._crit_edge.48

.lr.ph47:                                         ; preds = %278
  %290 = add nsw i32 %55, -1
  %291 = icmp slt i32 %55, 1
  %292 = sext i32 %284 to i64
  br label %300

._crit_edge.48.loopexit:                          ; preds = %binarySearch.exit
  br label %._crit_edge.48

._crit_edge.48:                                   ; preds = %._crit_edge.48.loopexit, %278
  %293 = alloca i32, i64 %287, align 16
  %294 = icmp sgt i32 %283, 0
  br i1 %294, label %.lr.ph44, label %._crit_edge.41.thread

.lr.ph44:                                         ; preds = %._crit_edge.48
  %295 = sext i32 %283 to i64
  %xtraiter192 = and i32 %283, 1
  %lcmp.mod193 = icmp eq i32 %xtraiter192, 0
  br i1 %lcmp.mod193, label %.lr.ph44.split, label %296

; <label>:296                                     ; preds = %.lr.ph44
  br i1 true, label %298, label %297

; <label>:297                                     ; preds = %296
  br label %298

; <label>:298                                     ; preds = %297, %296
  store i32 0, i32* %293, align 16
  br label %.lr.ph44.split

.lr.ph44.split:                                   ; preds = %.lr.ph44, %298
  %indvars.iv89.unr = phi i64 [ 0, %.lr.ph44 ], [ 1, %298 ]
  %299 = icmp eq i32 %283, 1
  br i1 %299, label %.preheader, label %.lr.ph44.split.split

.lr.ph44.split.split:                             ; preds = %.lr.ph44.split
  br label %335

; <label>:300                                     ; preds = %.lr.ph47, %binarySearch.exit
  %indvars.iv91 = phi i64 [ 0, %.lr.ph47 ], [ %indvars.iv.next92, %binarySearch.exit ]
  %301 = getelementptr inbounds i64, i64* %59, i64 %indvars.iv91
  %302 = load i64, i64* %301, align 8, !tbaa !2
  br i1 %291, label %binarySearch.exit, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %300
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i.preheader, %tailrecurse.outer.i
  %r.tr.ph8.i = phi i32 [ %r.tr5.i.lcssa210, %tailrecurse.outer.i ], [ %290, %.lr.ph.i.preheader ]
  %l.tr.ph7.i = phi i32 [ %317, %tailrecurse.outer.i ], [ 0, %.lr.ph.i.preheader ]
  br label %303

; <label>:303                                     ; preds = %tailrecurse.i, %.lr.ph.i
  %r.tr5.i = phi i32 [ %r.tr.ph8.i, %.lr.ph.i ], [ %315, %tailrecurse.i ]
  %304 = sub nsw i32 %r.tr5.i, %l.tr.ph7.i
  %305 = sdiv i32 %304, 2
  %306 = add nsw i32 %305, %l.tr.ph7.i
  %307 = sext i32 %306 to i64
  %308 = getelementptr inbounds i64, i64* %54, i64 %307
  %309 = load i64, i64* %308, align 8, !tbaa !2
  %310 = icmp eq i64 %309, %302
  br i1 %310, label %311, label %313

; <label>:311                                     ; preds = %303
  %.lcssa212 = phi i32 [ %306, %303 ]
  %312 = add nsw i32 %.lcssa212, 1
  br label %binarySearch.exit

; <label>:313                                     ; preds = %303
  %314 = icmp sgt i64 %309, %302
  br i1 %314, label %tailrecurse.i, label %tailrecurse.outer.i

tailrecurse.i:                                    ; preds = %313
  %315 = add nsw i32 %306, -1
  %316 = icmp slt i32 %304, 2
  br i1 %316, label %binarySearch.exit.loopexit, label %303

tailrecurse.outer.i:                              ; preds = %313
  %.lcssa213 = phi i32 [ %306, %313 ]
  %r.tr5.i.lcssa210 = phi i32 [ %r.tr5.i, %313 ]
  %317 = add nsw i32 %.lcssa213, 1
  %318 = icmp sgt i32 %r.tr5.i.lcssa210, %.lcssa213
  br i1 %318, label %.lr.ph.i, label %binarySearch.exit.loopexit175

binarySearch.exit.loopexit:                       ; preds = %tailrecurse.i
  %l.tr.ph7.i.lcssa216 = phi i32 [ %l.tr.ph7.i, %tailrecurse.i ]
  br label %binarySearch.exit

binarySearch.exit.loopexit175:                    ; preds = %tailrecurse.outer.i
  %.lcssa217 = phi i32 [ %317, %tailrecurse.outer.i ]
  br label %binarySearch.exit

binarySearch.exit:                                ; preds = %binarySearch.exit.loopexit175, %binarySearch.exit.loopexit, %300, %311
  %.1.i = phi i32 [ %312, %311 ], [ 0, %300 ], [ %l.tr.ph7.i.lcssa216, %binarySearch.exit.loopexit ], [ %.lcssa217, %binarySearch.exit.loopexit175 ]
  %319 = getelementptr inbounds i32, i32* %286, i64 %indvars.iv91
  store i32 %.1.i, i32* %319, align 4, !tbaa !6
  %indvars.iv.next92 = add nuw nsw i64 %indvars.iv91, 1
  %320 = icmp slt i64 %indvars.iv.next92, %292
  br i1 %320, label %300, label %._crit_edge.48.loopexit

.preheader.unr-lcssa:                             ; preds = %539
  br label %.preheader

.preheader:                                       ; preds = %.lr.ph44.split, %.preheader.unr-lcssa
  br i1 %294, label %.lr.ph40, label %._crit_edge.41.thread

.lr.ph40:                                         ; preds = %.preheader
  %321 = load i32, i32* %taskid, align 4, !tbaa !6
  %322 = sext i32 %321 to i64
  %323 = getelementptr inbounds i32, i32* %64, i64 %322
  %324 = sext i32 %283 to i64
  %.pre = load i32, i32* %293, align 16, !tbaa !6
  %xtraiter189 = and i32 %283, 1
  %lcmp.mod190 = icmp eq i32 %xtraiter189, 0
  br i1 %lcmp.mod190, label %.lr.ph40.split, label %325

; <label>:325                                     ; preds = %.lr.ph40
  %326 = getelementptr inbounds i32, i32* %293, i64 1
  %327 = load i32, i32* %326, align 4, !tbaa !6
  %328 = sub nsw i32 %327, %.pre
  store i32 %328, i32* %288, align 16, !tbaa !6
  %329 = icmp eq i32 %284, 0
  br i1 %329, label %330, label %.backedge.prol

; <label>:330                                     ; preds = %325
  %331 = load i32, i32* %323, align 4, !tbaa !6
  %332 = load i32, i32* %293, align 16, !tbaa !6
  %333 = sub nsw i32 %331, %332
  store i32 %333, i32* %288, align 16, !tbaa !6
  br label %.backedge.prol

.backedge.prol:                                   ; preds = %330, %325
  br label %.lr.ph40.split

.lr.ph40.split:                                   ; preds = %.lr.ph40, %.backedge.prol
  %.unr191 = phi i32 [ %.pre, %.lr.ph40 ], [ %327, %.backedge.prol ]
  %indvars.iv87.unr = phi i64 [ 0, %.lr.ph40 ], [ 1, %.backedge.prol ]
  %334 = icmp eq i32 %283, 1
  br i1 %334, label %._crit_edge.41, label %.lr.ph40.split.split

.lr.ph40.split.split:                             ; preds = %.lr.ph40.split
  br label %351

; <label>:335                                     ; preds = %539, %.lr.ph44.split.split
  %indvars.iv89 = phi i64 [ %indvars.iv89.unr, %.lr.ph44.split.split ], [ %indvars.iv.next90.1, %539 ]
  %336 = icmp eq i64 %indvars.iv89, 0
  br i1 %336, label %341, label %337

; <label>:337                                     ; preds = %335
  %338 = add nsw i64 %indvars.iv89, -1
  %339 = getelementptr inbounds i32, i32* %286, i64 %338
  %340 = load i32, i32* %339, align 4, !tbaa !6
  br label %341

; <label>:341                                     ; preds = %335, %337
  %.sink = phi i32 [ %340, %337 ], [ 0, %335 ]
  %342 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv89
  store i32 %.sink, i32* %342, align 4
  %indvars.iv.next90 = add nuw nsw i64 %indvars.iv89, 1
  br i1 false, label %539, label %536

._crit_edge.41.thread:                            ; preds = %.preheader, %._crit_edge.48
  %343 = call i8* @calloc(i64 %52, i64 8) #7
  %344 = alloca i32, i64 %287, align 16
  %345 = alloca i32, i64 %287, align 16
  br label %._crit_edge.37.thread

._crit_edge.41.unr-lcssa:                         ; preds = %.backedge.1
  br label %._crit_edge.41

._crit_edge.41:                                   ; preds = %.lr.ph40.split, %._crit_edge.41.unr-lcssa
  %346 = call i8* @calloc(i64 %52, i64 8) #7
  %347 = bitcast i8* %346 to i64*
  %348 = alloca i32, i64 %287, align 16
  %349 = alloca i32, i64 %287, align 16
  br i1 %294, label %.lr.ph36, label %._crit_edge.37.thread

.lr.ph36:                                         ; preds = %._crit_edge.41
  %350 = bitcast i32* %348 to i8*
  br label %398

; <label>:351                                     ; preds = %.backedge.1, %.lr.ph40.split.split
  %352 = phi i32 [ %.unr191, %.lr.ph40.split.split ], [ %359, %.backedge.1 ]
  %indvars.iv87 = phi i64 [ %indvars.iv87.unr, %.lr.ph40.split.split ], [ %indvars.iv.next88.1, %.backedge.1 ]
  %indvars.iv.next88 = add nuw nsw i64 %indvars.iv87, 1
  %353 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv.next88
  %354 = load i32, i32* %353, align 4, !tbaa !6
  %355 = sub nsw i32 %354, %352
  %356 = getelementptr inbounds i32, i32* %288, i64 %indvars.iv87
  store i32 %355, i32* %356, align 4, !tbaa !6
  %357 = icmp eq i64 %indvars.iv87, %285
  br i1 %357, label %363, label %.backedge

.backedge:                                        ; preds = %351, %363
  %indvars.iv.next88.1 = add nsw i64 %indvars.iv87, 2
  %358 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv.next88.1
  %359 = load i32, i32* %358, align 4, !tbaa !6
  %360 = sub nsw i32 %359, %354
  %361 = getelementptr inbounds i32, i32* %288, i64 %indvars.iv.next88
  store i32 %360, i32* %361, align 4, !tbaa !6
  %362 = icmp eq i64 %indvars.iv.next88, %285
  br i1 %362, label %530, label %.backedge.1

; <label>:363                                     ; preds = %351
  %364 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv87
  %365 = load i32, i32* %323, align 4, !tbaa !6
  %366 = load i32, i32* %364, align 4, !tbaa !6
  %367 = sub nsw i32 %365, %366
  store i32 %367, i32* %356, align 4, !tbaa !6
  br label %.backedge

._crit_edge.37.thread:                            ; preds = %._crit_edge.41, %._crit_edge.41.thread
  %.ph = phi i32* [ %345, %._crit_edge.41.thread ], [ %349, %._crit_edge.41 ]
  %.ph103 = phi i32* [ %344, %._crit_edge.41.thread ], [ %348, %._crit_edge.41 ]
  %.ph105 = phi i8* [ %343, %._crit_edge.41.thread ], [ %346, %._crit_edge.41 ]
  %368 = zext i32 %283 to i64
  %369 = alloca i64*, i64 %368, align 16
  br label %._crit_edge

._crit_edge.37:                                   ; preds = %.loopexit12
  %.lcssa209 = phi i32 [ %450, %.loopexit12 ]
  %370 = zext i32 %.lcssa209 to i64
  %371 = alloca i64*, i64 %370, align 16
  %372 = icmp sgt i32 %.lcssa209, 0
  br i1 %372, label %.lr.ph30, label %._crit_edge

.lr.ph30:                                         ; preds = %._crit_edge.37
  %373 = sext i32 %.lcssa209 to i64
  %374 = sext i32 %.lcssa209 to i64
  %min.iters.check155 = icmp ult i32 %.lcssa209, 4
  br i1 %min.iters.check155, label %scalar.ph154.preheader, label %min.iters.checked156

scalar.ph154.preheader:                           ; preds = %middle.block153, %min.iters.checked156, %.lr.ph30
  %indvars.iv81.ph = phi i64 [ 0, %min.iters.checked156 ], [ 0, %.lr.ph30 ], [ %n.vec158, %middle.block153 ]
  br label %scalar.ph154

min.iters.checked156:                             ; preds = %.lr.ph30
  %n.vec158 = and i64 %374, -4
  %cmp.zero159 = icmp eq i64 %n.vec158, 0
  br i1 %cmp.zero159, label %scalar.ph154.preheader, label %vector.body152.preheader

vector.body152.preheader:                         ; preds = %min.iters.checked156
  br label %vector.body152

vector.body152:                                   ; preds = %vector.body152.preheader, %vector.body152
  %index161 = phi i64 [ %index.next162, %vector.body152 ], [ 0, %vector.body152.preheader ]
  %375 = getelementptr inbounds i32, i32* %349, i64 %index161
  %376 = bitcast i32* %375 to <2 x i32>*
  %wide.load169 = load <2 x i32>, <2 x i32>* %376, align 16, !tbaa !6
  %377 = getelementptr i32, i32* %375, i64 2
  %378 = bitcast i32* %377 to <2 x i32>*
  %wide.load170 = load <2 x i32>, <2 x i32>* %378, align 8, !tbaa !6
  %379 = sext <2 x i32> %wide.load169 to <2 x i64>
  %380 = sext <2 x i32> %wide.load170 to <2 x i64>
  %381 = extractelement <2 x i64> %379, i32 0
  %382 = getelementptr inbounds i64, i64* %347, i64 %381
  %383 = insertelement <2 x i64*> undef, i64* %382, i32 0
  %384 = extractelement <2 x i64> %379, i32 1
  %385 = getelementptr inbounds i64, i64* %347, i64 %384
  %386 = insertelement <2 x i64*> %383, i64* %385, i32 1
  %387 = extractelement <2 x i64> %380, i32 0
  %388 = getelementptr inbounds i64, i64* %347, i64 %387
  %389 = insertelement <2 x i64*> undef, i64* %388, i32 0
  %390 = extractelement <2 x i64> %380, i32 1
  %391 = getelementptr inbounds i64, i64* %347, i64 %390
  %392 = insertelement <2 x i64*> %389, i64* %391, i32 1
  %393 = getelementptr inbounds i64*, i64** %371, i64 %index161
  %394 = bitcast i64** %393 to <2 x i64*>*
  store <2 x i64*> %386, <2 x i64*>* %394, align 16, !tbaa !8
  %395 = getelementptr i64*, i64** %393, i64 2
  %396 = bitcast i64** %395 to <2 x i64*>*
  store <2 x i64*> %392, <2 x i64*>* %396, align 16, !tbaa !8
  %index.next162 = add i64 %index161, 4
  %397 = icmp eq i64 %index.next162, %n.vec158
  br i1 %397, label %middle.block153, label %vector.body152, !llvm.loop !20

middle.block153:                                  ; preds = %vector.body152
  %cmp.n164 = icmp eq i64 %374, %n.vec158
  br i1 %cmp.n164, label %._crit_edge, label %scalar.ph154.preheader

; <label>:398                                     ; preds = %.lr.ph36, %.loopexit12
  %indvars.iv85 = phi i64 [ 0, %.lr.ph36 ], [ %indvars.iv.next86, %.loopexit12 ]
  %399 = getelementptr inbounds i32, i32* %288, i64 %indvars.iv85
  %400 = bitcast i32* %399 to i8*
  %401 = trunc i64 %indvars.iv85 to i32
  %402 = call i32 @MPI_Gather(i8* %400, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i8* %350, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 %401, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %403 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %404 = load i32, i32* %taskid, align 4, !tbaa !6
  %405 = zext i32 %404 to i64
  %406 = icmp eq i64 %405, %indvars.iv85
  br i1 %406, label %407, label %.loopexit12

; <label>:407                                     ; preds = %398
  store i32 0, i32* %349, align 16, !tbaa !6
  %408 = load i32, i32* %Nthr, align 4, !tbaa !6
  %409 = icmp sgt i32 %408, 1
  br i1 %409, label %.lr.ph33, label %.loopexit12

.lr.ph33:                                         ; preds = %407
  %410 = sext i32 %408 to i64
  %411 = sext i32 %408 to i64
  %412 = add nsw i64 %411, 3
  %413 = add nsw i64 %411, -2
  %xtraiter184 = and i64 %412, 3
  %lcmp.mod185 = icmp eq i64 %xtraiter184, 0
  br i1 %lcmp.mod185, label %.lr.ph33.split, label %.preheader188

.preheader188:                                    ; preds = %.lr.ph33
  br label %414

; <label>:414                                     ; preds = %414, %.preheader188
  %415 = phi i32 [ %419, %414 ], [ 0, %.preheader188 ]
  %indvars.iv83.prol = phi i64 [ %indvars.iv.next84.prol, %414 ], [ 1, %.preheader188 ]
  %prol.iter186 = phi i64 [ %prol.iter186.sub, %414 ], [ %xtraiter184, %.preheader188 ]
  %416 = add nsw i64 %indvars.iv83.prol, -1
  %417 = getelementptr inbounds i32, i32* %348, i64 %416
  %418 = load i32, i32* %417, align 4, !tbaa !6
  %419 = add nsw i32 %418, %415
  %420 = getelementptr inbounds i32, i32* %349, i64 %indvars.iv83.prol
  store i32 %419, i32* %420, align 4, !tbaa !6
  %indvars.iv.next84.prol = add nuw nsw i64 %indvars.iv83.prol, 1
  %prol.iter186.sub = add i64 %prol.iter186, -1
  %prol.iter186.cmp = icmp eq i64 %prol.iter186.sub, 0
  br i1 %prol.iter186.cmp, label %.lr.ph33.split.loopexit, label %414, !llvm.loop !21

.lr.ph33.split.loopexit:                          ; preds = %414
  %indvars.iv.next84.prol.lcssa = phi i64 [ %indvars.iv.next84.prol, %414 ]
  %.lcssa = phi i32 [ %419, %414 ]
  br label %.lr.ph33.split

.lr.ph33.split:                                   ; preds = %.lr.ph33, %.lr.ph33.split.loopexit
  %.unr187 = phi i32 [ 0, %.lr.ph33 ], [ %.lcssa, %.lr.ph33.split.loopexit ]
  %indvars.iv83.unr = phi i64 [ 1, %.lr.ph33 ], [ %indvars.iv.next84.prol.lcssa, %.lr.ph33.split.loopexit ]
  %421 = icmp ult i64 %413, 3
  br i1 %421, label %.loopexit12.loopexit, label %.lr.ph33.split.split

.lr.ph33.split.split:                             ; preds = %.lr.ph33.split
  br label %422

; <label>:422                                     ; preds = %422, %.lr.ph33.split.split
  %423 = phi i32 [ %.unr187, %.lr.ph33.split.split ], [ %439, %422 ]
  %indvars.iv83 = phi i64 [ %indvars.iv83.unr, %.lr.ph33.split.split ], [ %indvars.iv.next84.3, %422 ]
  %424 = add nsw i64 %indvars.iv83, -1
  %425 = getelementptr inbounds i32, i32* %348, i64 %424
  %426 = load i32, i32* %425, align 4, !tbaa !6
  %427 = add nsw i32 %426, %423
  %428 = getelementptr inbounds i32, i32* %349, i64 %indvars.iv83
  store i32 %427, i32* %428, align 4, !tbaa !6
  %indvars.iv.next84 = add nuw nsw i64 %indvars.iv83, 1
  %429 = getelementptr inbounds i32, i32* %348, i64 %indvars.iv83
  %430 = load i32, i32* %429, align 4, !tbaa !6
  %431 = add nsw i32 %430, %427
  %432 = getelementptr inbounds i32, i32* %349, i64 %indvars.iv.next84
  store i32 %431, i32* %432, align 4, !tbaa !6
  %indvars.iv.next84.1 = add nsw i64 %indvars.iv83, 2
  %433 = getelementptr inbounds i32, i32* %348, i64 %indvars.iv.next84
  %434 = load i32, i32* %433, align 4, !tbaa !6
  %435 = add nsw i32 %434, %431
  %436 = getelementptr inbounds i32, i32* %349, i64 %indvars.iv.next84.1
  store i32 %435, i32* %436, align 4, !tbaa !6
  %indvars.iv.next84.2 = add nsw i64 %indvars.iv83, 3
  %437 = getelementptr inbounds i32, i32* %348, i64 %indvars.iv.next84.1
  %438 = load i32, i32* %437, align 4, !tbaa !6
  %439 = add nsw i32 %438, %435
  %440 = getelementptr inbounds i32, i32* %349, i64 %indvars.iv.next84.2
  store i32 %439, i32* %440, align 4, !tbaa !6
  %indvars.iv.next84.3 = add nsw i64 %indvars.iv83, 4
  %441 = icmp slt i64 %indvars.iv.next84.3, %410
  br i1 %441, label %422, label %.loopexit12.loopexit.unr-lcssa

.loopexit12.loopexit.unr-lcssa:                   ; preds = %422
  br label %.loopexit12.loopexit

.loopexit12.loopexit:                             ; preds = %.lr.ph33.split, %.loopexit12.loopexit.unr-lcssa
  br label %.loopexit12

.loopexit12:                                      ; preds = %.loopexit12.loopexit, %407, %398
  %442 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv85
  %443 = load i32, i32* %442, align 4, !tbaa !6
  %444 = sext i32 %443 to i64
  %445 = getelementptr inbounds i64, i64* %54, i64 %444
  %446 = bitcast i64* %445 to i8*
  %447 = load i32, i32* %399, align 4, !tbaa !6
  %448 = call i32 @MPI_Gatherv(i8* %446, i32 %447, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %346, i32* nonnull %348, i32* nonnull %349, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 %401, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %449 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %indvars.iv.next86 = add nuw nsw i64 %indvars.iv85, 1
  %450 = load i32, i32* %Nthr, align 4, !tbaa !6
  %451 = sext i32 %450 to i64
  %452 = icmp slt i64 %indvars.iv.next86, %451
  br i1 %452, label %398, label %._crit_edge.37

._crit_edge.loopexit:                             ; preds = %scalar.ph154
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %middle.block153, %._crit_edge.37.thread, %._crit_edge.37
  %453 = phi i64** [ %371, %._crit_edge.37 ], [ %369, %._crit_edge.37.thread ], [ %371, %middle.block153 ], [ %371, %._crit_edge.loopexit ]
  %454 = phi i32 [ %.lcssa209, %._crit_edge.37 ], [ %283, %._crit_edge.37.thread ], [ %.lcssa209, %middle.block153 ], [ %.lcssa209, %._crit_edge.loopexit ]
  %455 = phi i8* [ %346, %._crit_edge.37 ], [ %.ph105, %._crit_edge.37.thread ], [ %346, %middle.block153 ], [ %346, %._crit_edge.loopexit ]
  %456 = phi i32* [ %348, %._crit_edge.37 ], [ %.ph103, %._crit_edge.37.thread ], [ %348, %middle.block153 ], [ %348, %._crit_edge.loopexit ]
  %457 = phi i32* [ %349, %._crit_edge.37 ], [ %.ph, %._crit_edge.37.thread ], [ %349, %middle.block153 ], [ %349, %._crit_edge.loopexit ]
  call void @multimerge(i64** nonnull %453, i32* nonnull %456, i32 %454, i64* %54)
  %458 = bitcast i32* %mysendLength to i8*
  call void @llvm.lifetime.start(i64 4, i8* %458) #7
  %459 = load i32, i32* %Nthr, align 4, !tbaa !6
  %460 = add nsw i32 %459, -1
  %461 = sext i32 %460 to i64
  %462 = getelementptr inbounds i32, i32* %457, i64 %461
  %463 = load i32, i32* %462, align 4, !tbaa !6
  %464 = getelementptr inbounds i32, i32* %456, i64 %461
  %465 = load i32, i32* %464, align 4, !tbaa !6
  %466 = add nsw i32 %465, %463
  store i32 %466, i32* %mysendLength, align 4, !tbaa !6
  %467 = zext i32 %459 to i64
  %468 = alloca i32, i64 %467, align 16
  %469 = alloca i32, i64 %467, align 16
  %470 = bitcast i32* %468 to i8*
  %471 = call i32 @MPI_Gather(i8* %458, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i8* %470, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %472 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %473 = load i32, i32* %taskid, align 4, !tbaa !6
  %474 = icmp eq i32 %473, 0
  br i1 %474, label %481, label %.loopexit

scalar.ph154:                                     ; preds = %scalar.ph154.preheader, %scalar.ph154
  %indvars.iv81 = phi i64 [ %indvars.iv.next82, %scalar.ph154 ], [ %indvars.iv81.ph, %scalar.ph154.preheader ]
  %475 = getelementptr inbounds i32, i32* %349, i64 %indvars.iv81
  %476 = load i32, i32* %475, align 4, !tbaa !6
  %477 = sext i32 %476 to i64
  %478 = getelementptr inbounds i64, i64* %347, i64 %477
  %479 = getelementptr inbounds i64*, i64** %371, i64 %indvars.iv81
  store i64* %478, i64** %479, align 8, !tbaa !8
  %indvars.iv.next82 = add nuw nsw i64 %indvars.iv81, 1
  %480 = icmp slt i64 %indvars.iv.next82, %373
  br i1 %480, label %scalar.ph154, label %._crit_edge.loopexit, !llvm.loop !22

; <label>:481                                     ; preds = %._crit_edge
  store i32 0, i32* %469, align 16, !tbaa !6
  %482 = load i32, i32* %Nthr, align 4, !tbaa !6
  %483 = icmp sgt i32 %482, 1
  br i1 %483, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %481
  %484 = sext i32 %482 to i64
  %485 = sext i32 %482 to i64
  %486 = add nsw i64 %485, 3
  %487 = add nsw i64 %485, -2
  %xtraiter = and i64 %486, 3
  %lcmp.mod = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod, label %.lr.ph.split, label %.preheader206

.preheader206:                                    ; preds = %.lr.ph
  br label %488

; <label>:488                                     ; preds = %.preheader206, %488
  %489 = phi i32 [ %493, %488 ], [ 0, %.preheader206 ]
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %488 ], [ 1, %.preheader206 ]
  %prol.iter = phi i64 [ %prol.iter.sub, %488 ], [ %xtraiter, %.preheader206 ]
  %490 = add nsw i64 %indvars.iv.prol, -1
  %491 = getelementptr inbounds i32, i32* %468, i64 %490
  %492 = load i32, i32* %491, align 4, !tbaa !6
  %493 = add nsw i32 %492, %489
  %494 = getelementptr inbounds i32, i32* %469, i64 %indvars.iv.prol
  store i32 %493, i32* %494, align 4, !tbaa !6
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %.lr.ph.split.loopexit, label %488, !llvm.loop !24

.lr.ph.split.loopexit:                            ; preds = %488
  %indvars.iv.next.prol.lcssa = phi i64 [ %indvars.iv.next.prol, %488 ]
  %.lcssa218 = phi i32 [ %493, %488 ]
  br label %.lr.ph.split

.lr.ph.split:                                     ; preds = %.lr.ph.split.loopexit, %.lr.ph
  %.unr = phi i32 [ 0, %.lr.ph ], [ %.lcssa218, %.lr.ph.split.loopexit ]
  %indvars.iv.unr = phi i64 [ 1, %.lr.ph ], [ %indvars.iv.next.prol.lcssa, %.lr.ph.split.loopexit ]
  %495 = icmp ult i64 %487, 3
  br i1 %495, label %.loopexit.loopexit, label %.lr.ph.split.split

.lr.ph.split.split:                               ; preds = %.lr.ph.split
  br label %496

; <label>:496                                     ; preds = %496, %.lr.ph.split.split
  %497 = phi i32 [ %.unr, %.lr.ph.split.split ], [ %513, %496 ]
  %indvars.iv = phi i64 [ %indvars.iv.unr, %.lr.ph.split.split ], [ %indvars.iv.next.3, %496 ]
  %498 = add nsw i64 %indvars.iv, -1
  %499 = getelementptr inbounds i32, i32* %468, i64 %498
  %500 = load i32, i32* %499, align 4, !tbaa !6
  %501 = add nsw i32 %500, %497
  %502 = getelementptr inbounds i32, i32* %469, i64 %indvars.iv
  store i32 %501, i32* %502, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %503 = getelementptr inbounds i32, i32* %468, i64 %indvars.iv
  %504 = load i32, i32* %503, align 4, !tbaa !6
  %505 = add nsw i32 %504, %501
  %506 = getelementptr inbounds i32, i32* %469, i64 %indvars.iv.next
  store i32 %505, i32* %506, align 4, !tbaa !6
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %507 = getelementptr inbounds i32, i32* %468, i64 %indvars.iv.next
  %508 = load i32, i32* %507, align 4, !tbaa !6
  %509 = add nsw i32 %508, %505
  %510 = getelementptr inbounds i32, i32* %469, i64 %indvars.iv.next.1
  store i32 %509, i32* %510, align 4, !tbaa !6
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %511 = getelementptr inbounds i32, i32* %468, i64 %indvars.iv.next.1
  %512 = load i32, i32* %511, align 4, !tbaa !6
  %513 = add nsw i32 %512, %509
  %514 = getelementptr inbounds i32, i32* %469, i64 %indvars.iv.next.2
  store i32 %513, i32* %514, align 4, !tbaa !6
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %515 = icmp slt i64 %indvars.iv.next.3, %484
  br i1 %515, label %496, label %.loopexit.loopexit.unr-lcssa

.loopexit.loopexit.unr-lcssa:                     ; preds = %496
  br label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %.lr.ph.split, %.loopexit.loopexit.unr-lcssa
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %481, %._crit_edge
  %516 = call i8* @calloc(i64 %52, i64 8) #7
  %517 = load i32, i32* %mysendLength, align 4, !tbaa !6
  %518 = call i32 @MPI_Gatherv(i8* %53, i32 %517, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %516, i32* nonnull %468, i32* nonnull %469, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %519 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %520 = load i32, i32* %taskid, align 4, !tbaa !6
  %521 = icmp eq i32 %520, 0
  br i1 %521, label %522, label %527

; <label>:522                                     ; preds = %.loopexit
  %523 = call double @MPI_Wtime() #7
  %524 = load i32, i32* %Nthr, align 4, !tbaa !6
  %525 = fsub double %523, %t_start.0
  %526 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %23, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.7, i64 0, i64 0), i32 %524, i32 %20, double %525) #7
  br label %527

; <label>:527                                     ; preds = %522, %.loopexit
  call void @free(i8* %53)
  call void @free(i8* %455)
  call void @free(i8* %516)
  call void @free(i8* %58)
  call void @free(i8* %61)
  call void @free(i8* %63)
  %528 = call i32 @fclose(%struct.__sFILE* %23) #7
  %529 = call i32 @MPI_Finalize() #7
  call void @llvm.lifetime.end(i64 4, i8* nonnull %458) #7
  call void @llvm.lifetime.end(i64 4, i8* nonnull %3) #7
  call void @llvm.lifetime.end(i64 4, i8* nonnull %2) #7
  ret i32 0

; <label>:530                                     ; preds = %.backedge
  %531 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv.next88
  %532 = load i32, i32* %323, align 4, !tbaa !6
  %533 = load i32, i32* %531, align 4, !tbaa !6
  %534 = sub nsw i32 %532, %533
  store i32 %534, i32* %361, align 4, !tbaa !6
  br label %.backedge.1

.backedge.1:                                      ; preds = %530, %.backedge
  %535 = icmp slt i64 %indvars.iv.next88.1, %324
  br i1 %535, label %351, label %._crit_edge.41.unr-lcssa

; <label>:536                                     ; preds = %341
  %537 = getelementptr inbounds i32, i32* %286, i64 %indvars.iv89
  %538 = load i32, i32* %537, align 4, !tbaa !6
  br label %539

; <label>:539                                     ; preds = %536, %341
  %.sink.1 = phi i32 [ %538, %536 ], [ 0, %341 ]
  %540 = getelementptr inbounds i32, i32* %293, i64 %indvars.iv.next90
  store i32 %.sink.1, i32* %540, align 4
  %indvars.iv.next90.1 = add nsw i64 %indvars.iv89, 2
  %541 = icmp slt i64 %indvars.iv.next90.1, %295
  br i1 %541, label %335, label %.preheader.unr-lcssa
}

declare i32 @MPI_Init(i32*, i8***) #4

declare i32 @MPI_Comm_size(%struct.ompi_communicator_t*, i32*) #4

declare i32 @MPI_Comm_rank(%struct.ompi_communicator_t*, i32*) #4

; Function Attrs: nounwind
declare i32 @fprintf(%struct.__sFILE* nocapture, i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @fflush(%struct.__sFILE* nocapture) #2

declare i32 @MPI_Finalize() #4

; Function Attrs: noreturn
declare void @exit(i32) #5

; Function Attrs: nounwind readonly
declare i32 @atoi(i8* nocapture) #6

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*) #4

declare void @srandom(i32) #4

declare i64 @random() #4

declare i32 @MPI_Scatterv(i8*, i32*, i32*, %struct.ompi_datatype_t*, i8*, i32, %struct.ompi_datatype_t*, i32, %struct.ompi_communicator_t*) #4

declare i32 @MPI_Barrier(%struct.ompi_communicator_t*) #4

declare double @MPI_Wtime() #4

declare void @qsort(i8*, i64, i64, i32 (i8*, i8*)* nocapture) #4

declare i32 @MPI_Gather(i8*, i32, %struct.ompi_datatype_t*, i8*, i32, %struct.ompi_datatype_t*, i32, %struct.ompi_communicator_t*) #4

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #7

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #7

declare i32 @MPI_Bcast(i8*, i32, %struct.ompi_datatype_t*, i32, %struct.ompi_communicator_t*) #4

declare i32 @MPI_Gatherv(i8*, i32, %struct.ompi_datatype_t*, i8*, i32*, i32*, %struct.ompi_datatype_t*, i32, %struct.ompi_communicator_t*) #4

; Function Attrs: nounwind
declare i32 @fclose(%struct.__sFILE* nocapture) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #7

; Function Attrs: nounwind
declare i64 @fwrite(i8* nocapture, i64, i64, %struct.__sFILE* nocapture) #7

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
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
!7 = !{!"int", !4, i64 0}
!8 = !{!9, !9, i64 0}
!9 = !{!"any pointer", !4, i64 0}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.unroll.disable"}
!12 = distinct !{!12, !11}
!13 = distinct !{!13, !14, !15}
!14 = !{!"llvm.loop.vectorize.width", i32 1}
!15 = !{!"llvm.loop.interleave.count", i32 1}
!16 = distinct !{!16, !14, !15}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !14, !15}
!19 = distinct !{!19, !14, !15}
!20 = distinct !{!20, !14, !15}
!21 = distinct !{!21, !11}
!22 = distinct !{!22, !23, !14, !15}
!23 = !{!"llvm.loop.unroll.runtime.disable"}
!24 = distinct !{!24, !11}
