; ModuleID = 'my_psrs.c'
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
@.str.7 = private unnamed_addr constant [7 x i8] c"Phase1\00", align 1
@.str.8 = private unnamed_addr constant [16 x i8] c"%s, %d, %d, %f\0A\00", align 1
@.str.9 = private unnamed_addr constant [7 x i8] c"Phase2\00", align 1
@ompi_mpi_int = external global %struct.ompi_predefined_datatype_t, align 1
@.str.10 = private unnamed_addr constant [7 x i8] c"Phase3\00", align 1
@.str.11 = private unnamed_addr constant [7 x i8] c"Phase4\00", align 1
@str.12 = private unnamed_addr constant [2 x i8] c"]\00"

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
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @str.12, i64 0, i64 0))
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
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @str.12, i64 0, i64 0))
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
  br i1 %66, label %79, label %.preheader21

.preheader21.loopexit:                            ; preds = %.lr.ph71
  br label %.preheader21

.preheader21:                                     ; preds = %.preheader21.loopexit, %79, %51
  %67 = load i32, i32* %Nthr, align 4, !tbaa !6
  %68 = icmp sgt i32 %67, 0
  br i1 %68, label %.lr.ph66, label %._crit_edge.67

.lr.ph66:                                         ; preds = %.preheader21
  %69 = sext i32 %55 to i64
  %70 = sext i32 %67 to i64
  %71 = sext i32 %67 to i64
  %72 = add nsw i64 %71, -1
  %xtraiter198 = and i64 %71, 3
  %lcmp.mod199 = icmp eq i64 %xtraiter198, 0
  br i1 %lcmp.mod199, label %.lr.ph66.split, label %.preheader203

.preheader203:                                    ; preds = %.lr.ph66
  br label %73

; <label>:73                                      ; preds = %.preheader203, %73
  %indvars.iv99.prol = phi i64 [ %indvars.iv.next100.prol, %73 ], [ 0, %.preheader203 ]
  %prol.iter200 = phi i64 [ %prol.iter200.sub, %73 ], [ %xtraiter198, %.preheader203 ]
  %74 = mul nsw i64 %indvars.iv99.prol, %69
  %75 = getelementptr inbounds i32, i32* %62, i64 %indvars.iv99.prol
  %76 = trunc i64 %74 to i32
  store i32 %76, i32* %75, align 4, !tbaa !6
  %77 = getelementptr inbounds i32, i32* %64, i64 %indvars.iv99.prol
  store i32 %55, i32* %77, align 4, !tbaa !6
  %indvars.iv.next100.prol = add nuw nsw i64 %indvars.iv99.prol, 1
  %prol.iter200.sub = add i64 %prol.iter200, -1
  %prol.iter200.cmp = icmp eq i64 %prol.iter200.sub, 0
  br i1 %prol.iter200.cmp, label %.lr.ph66.split.loopexit, label %73, !llvm.loop !10

.lr.ph66.split.loopexit:                          ; preds = %73
  %indvars.iv.next100.prol.lcssa = phi i64 [ %indvars.iv.next100.prol, %73 ]
  br label %.lr.ph66.split

.lr.ph66.split:                                   ; preds = %.lr.ph66.split.loopexit, %.lr.ph66
  %indvars.iv99.unr = phi i64 [ 0, %.lr.ph66 ], [ %indvars.iv.next100.prol.lcssa, %.lr.ph66.split.loopexit ]
  %78 = icmp ult i64 %72, 3
  br i1 %78, label %._crit_edge.67.loopexit, label %.lr.ph66.split.split

.lr.ph66.split.split:                             ; preds = %.lr.ph66.split
  br label %87

; <label>:79                                      ; preds = %51
  call void @srandom(i32 23478237) #7
  %80 = icmp sgt i32 %20, 0
  br i1 %80, label %.lr.ph71.preheader, label %.preheader21

.lr.ph71.preheader:                               ; preds = %79
  br label %.lr.ph71

.lr.ph71:                                         ; preds = %.lr.ph71.preheader, %.lr.ph71
  %indvars.iv101 = phi i64 [ %indvars.iv.next102, %.lr.ph71 ], [ 0, %.lr.ph71.preheader ]
  %81 = call i64 @random() #7
  %82 = srem i64 %81, 100
  %83 = getelementptr inbounds i64, i64* %54, i64 %indvars.iv101
  store i64 %82, i64* %83, align 8, !tbaa !2
  %indvars.iv.next102 = add nuw nsw i64 %indvars.iv101, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next102 to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %20
  br i1 %exitcond, label %.preheader21.loopexit, label %.lr.ph71

._crit_edge.67.loopexit.unr-lcssa:                ; preds = %87
  br label %._crit_edge.67.loopexit

._crit_edge.67.loopexit:                          ; preds = %.lr.ph66.split, %._crit_edge.67.loopexit.unr-lcssa
  br label %._crit_edge.67

._crit_edge.67:                                   ; preds = %._crit_edge.67.loopexit, %.preheader21
  %84 = load i32, i32* %taskid, align 4, !tbaa !6
  %85 = icmp eq i32 %84, 0
  %86 = sdiv i32 %20, %67
  br i1 %85, label %105, label %107

; <label>:87                                      ; preds = %87, %.lr.ph66.split.split
  %indvars.iv99 = phi i64 [ %indvars.iv99.unr, %.lr.ph66.split.split ], [ %indvars.iv.next100.3, %87 ]
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
  br i1 %104, label %87, label %._crit_edge.67.loopexit.unr-lcssa

; <label>:105                                     ; preds = %._crit_edge.67
  %106 = call i32 @MPI_Scatterv(i8* %53, i32* %64, i32* %62, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* nonnull inttoptr (i64 1 to i8*), i32 %86, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %109

; <label>:107                                     ; preds = %._crit_edge.67
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
  %117 = load i32, i32* %taskid, align 4, !tbaa !6
  %118 = icmp eq i32 %117, 0
  br i1 %118, label %119, label %.preheader20

; <label>:119                                     ; preds = %115
  %120 = call double @MPI_Wtime() #7
  %121 = load i32, i32* %Nthr, align 4, !tbaa !6
  %122 = fsub double %120, %t_start.0
  %123 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %23, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i64 0, i64 0), i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i64 0, i64 0), i32 %121, i32 %20, double %122) #7
  br label %.preheader20

.preheader20:                                     ; preds = %119, %115
  %124 = load i32, i32* %Nthr, align 4, !tbaa !6
  %125 = icmp sgt i32 %124, 0
  br i1 %125, label %.lr.ph63, label %._crit_edge.64

.lr.ph63:                                         ; preds = %.preheader20
  %126 = sext i32 %56 to i64
  %127 = sext i32 %124 to i64
  %128 = sext i32 %124 to i64
  %min.iters.check = icmp ult i32 %124, 4
  br i1 %min.iters.check, label %scalar.ph.preheader, label %min.iters.checked

scalar.ph.preheader:                              ; preds = %min.iters.checked, %middle.block, %.lr.ph63
  %indvars.iv97.ph = phi i64 [ 0, %min.iters.checked ], [ 0, %.lr.ph63 ], [ %n.vec, %middle.block ]
  br label %scalar.ph

min.iters.checked:                                ; preds = %.lr.ph63
  %n.vec = and i64 %128, -4
  %cmp.zero = icmp ne i64 %n.vec, 0
  %ident.check = icmp eq i32 %56, 1
  %or.cond = and i1 %cmp.zero, %ident.check
  br i1 %or.cond, label %vector.body.preheader, label %scalar.ph.preheader

vector.body.preheader:                            ; preds = %min.iters.checked
  %129 = sext i32 %124 to i64
  %130 = add nsw i64 %129, -4
  %131 = lshr i64 %130, 2
  %132 = add nuw nsw i64 %131, 1
  %xtraiter195 = and i64 %132, 3
  %lcmp.mod196 = icmp eq i64 %xtraiter195, 0
  br i1 %lcmp.mod196, label %vector.body.preheader.split, label %vector.body.prol.preheader

vector.body.prol.preheader:                       ; preds = %vector.body.preheader
  br label %vector.body.prol

vector.body.prol:                                 ; preds = %vector.body.prol.preheader, %vector.body.prol
  %index.prol = phi i64 [ %index.next.prol, %vector.body.prol ], [ 0, %vector.body.prol.preheader ]
  %prol.iter197 = phi i64 [ %prol.iter197.sub, %vector.body.prol ], [ %xtraiter195, %vector.body.prol.preheader ]
  %133 = getelementptr inbounds i64, i64* %54, i64 %index.prol
  %134 = bitcast i64* %133 to <2 x i64>*
  %wide.load.prol = load <2 x i64>, <2 x i64>* %134, align 8, !tbaa !2
  %135 = getelementptr i64, i64* %133, i64 2
  %136 = bitcast i64* %135 to <2 x i64>*
  %wide.load121.prol = load <2 x i64>, <2 x i64>* %136, align 8, !tbaa !2
  %137 = getelementptr inbounds i64, i64* %59, i64 %index.prol
  %138 = bitcast i64* %137 to <2 x i64>*
  store <2 x i64> %wide.load.prol, <2 x i64>* %138, align 8, !tbaa !2
  %139 = getelementptr i64, i64* %137, i64 2
  %140 = bitcast i64* %139 to <2 x i64>*
  store <2 x i64> %wide.load121.prol, <2 x i64>* %140, align 8, !tbaa !2
  %index.next.prol = add i64 %index.prol, 4
  %prol.iter197.sub = add i64 %prol.iter197, -1
  %prol.iter197.cmp = icmp eq i64 %prol.iter197.sub, 0
  br i1 %prol.iter197.cmp, label %vector.body.preheader.split.loopexit, label %vector.body.prol, !llvm.loop !12

vector.body.preheader.split.loopexit:             ; preds = %vector.body.prol
  %index.next.prol.lcssa = phi i64 [ %index.next.prol, %vector.body.prol ]
  br label %vector.body.preheader.split

vector.body.preheader.split:                      ; preds = %vector.body.preheader.split.loopexit, %vector.body.preheader
  %index.unr = phi i64 [ 0, %vector.body.preheader ], [ %index.next.prol.lcssa, %vector.body.preheader.split.loopexit ]
  %141 = icmp ult i64 %130, 12
  br i1 %141, label %middle.block, label %vector.body.preheader.split.split

vector.body.preheader.split.split:                ; preds = %vector.body.preheader.split
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.body.preheader.split.split
  %index = phi i64 [ %index.unr, %vector.body.preheader.split.split ], [ %index.next.3, %vector.body ]
  %142 = getelementptr inbounds i64, i64* %54, i64 %index
  %143 = bitcast i64* %142 to <2 x i64>*
  %wide.load = load <2 x i64>, <2 x i64>* %143, align 8, !tbaa !2
  %144 = getelementptr i64, i64* %142, i64 2
  %145 = bitcast i64* %144 to <2 x i64>*
  %wide.load121 = load <2 x i64>, <2 x i64>* %145, align 8, !tbaa !2
  %146 = getelementptr inbounds i64, i64* %59, i64 %index
  %147 = bitcast i64* %146 to <2 x i64>*
  store <2 x i64> %wide.load, <2 x i64>* %147, align 8, !tbaa !2
  %148 = getelementptr i64, i64* %146, i64 2
  %149 = bitcast i64* %148 to <2 x i64>*
  store <2 x i64> %wide.load121, <2 x i64>* %149, align 8, !tbaa !2
  %index.next = add i64 %index, 4
  %150 = getelementptr inbounds i64, i64* %54, i64 %index.next
  %151 = bitcast i64* %150 to <2 x i64>*
  %wide.load.1 = load <2 x i64>, <2 x i64>* %151, align 8, !tbaa !2
  %152 = getelementptr i64, i64* %150, i64 2
  %153 = bitcast i64* %152 to <2 x i64>*
  %wide.load121.1 = load <2 x i64>, <2 x i64>* %153, align 8, !tbaa !2
  %154 = getelementptr inbounds i64, i64* %59, i64 %index.next
  %155 = bitcast i64* %154 to <2 x i64>*
  store <2 x i64> %wide.load.1, <2 x i64>* %155, align 8, !tbaa !2
  %156 = getelementptr i64, i64* %154, i64 2
  %157 = bitcast i64* %156 to <2 x i64>*
  store <2 x i64> %wide.load121.1, <2 x i64>* %157, align 8, !tbaa !2
  %index.next.1 = add i64 %index, 8
  %158 = getelementptr inbounds i64, i64* %54, i64 %index.next.1
  %159 = bitcast i64* %158 to <2 x i64>*
  %wide.load.2 = load <2 x i64>, <2 x i64>* %159, align 8, !tbaa !2
  %160 = getelementptr i64, i64* %158, i64 2
  %161 = bitcast i64* %160 to <2 x i64>*
  %wide.load121.2 = load <2 x i64>, <2 x i64>* %161, align 8, !tbaa !2
  %162 = getelementptr inbounds i64, i64* %59, i64 %index.next.1
  %163 = bitcast i64* %162 to <2 x i64>*
  store <2 x i64> %wide.load.2, <2 x i64>* %163, align 8, !tbaa !2
  %164 = getelementptr i64, i64* %162, i64 2
  %165 = bitcast i64* %164 to <2 x i64>*
  store <2 x i64> %wide.load121.2, <2 x i64>* %165, align 8, !tbaa !2
  %index.next.2 = add i64 %index, 12
  %166 = getelementptr inbounds i64, i64* %54, i64 %index.next.2
  %167 = bitcast i64* %166 to <2 x i64>*
  %wide.load.3 = load <2 x i64>, <2 x i64>* %167, align 8, !tbaa !2
  %168 = getelementptr i64, i64* %166, i64 2
  %169 = bitcast i64* %168 to <2 x i64>*
  %wide.load121.3 = load <2 x i64>, <2 x i64>* %169, align 8, !tbaa !2
  %170 = getelementptr inbounds i64, i64* %59, i64 %index.next.2
  %171 = bitcast i64* %170 to <2 x i64>*
  store <2 x i64> %wide.load.3, <2 x i64>* %171, align 8, !tbaa !2
  %172 = getelementptr i64, i64* %170, i64 2
  %173 = bitcast i64* %172 to <2 x i64>*
  store <2 x i64> %wide.load121.3, <2 x i64>* %173, align 8, !tbaa !2
  %index.next.3 = add i64 %index, 16
  %174 = icmp eq i64 %index.next.3, %n.vec
  br i1 %174, label %middle.block.unr-lcssa, label %vector.body, !llvm.loop !13

middle.block.unr-lcssa:                           ; preds = %vector.body
  br label %middle.block

middle.block:                                     ; preds = %vector.body.preheader.split, %middle.block.unr-lcssa
  %cmp.n = icmp eq i64 %128, %n.vec
  br i1 %cmp.n, label %._crit_edge.64, label %scalar.ph.preheader

._crit_edge.64.loopexit:                          ; preds = %scalar.ph
  br label %._crit_edge.64

._crit_edge.64:                                   ; preds = %._crit_edge.64.loopexit, %middle.block, %.preheader20
  %175 = load i32, i32* %taskid, align 4, !tbaa !6
  %176 = icmp eq i32 %175, 0
  br i1 %176, label %182, label %.thread

scalar.ph:                                        ; preds = %scalar.ph.preheader, %scalar.ph
  %indvars.iv97 = phi i64 [ %indvars.iv.next98, %scalar.ph ], [ %indvars.iv97.ph, %scalar.ph.preheader ]
  %177 = mul nsw i64 %indvars.iv97, %126
  %178 = getelementptr inbounds i64, i64* %54, i64 %177
  %179 = load i64, i64* %178, align 8, !tbaa !2
  %180 = getelementptr inbounds i64, i64* %59, i64 %indvars.iv97
  store i64 %179, i64* %180, align 8, !tbaa !2
  %indvars.iv.next98 = add nuw nsw i64 %indvars.iv97, 1
  %181 = icmp slt i64 %indvars.iv.next98, %127
  br i1 %181, label %scalar.ph, label %._crit_edge.64.loopexit, !llvm.loop !16

; <label>:182                                     ; preds = %._crit_edge.64
  %183 = call double @MPI_Wtime() #7
  %.pr = load i32, i32* %taskid, align 4, !tbaa !6
  %184 = icmp eq i32 %.pr, 0
  %185 = load i32, i32* %Nthr, align 4, !tbaa !6
  br i1 %184, label %186, label %.thread

; <label>:186                                     ; preds = %182
  %187 = call i32 @MPI_Gather(i8* nonnull inttoptr (i64 1 to i8*), i32 %185, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %58, i32 %185, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %190

.thread:                                          ; preds = %._crit_edge.64, %182
  %188 = phi i32 [ %185, %182 ], [ %124, %._crit_edge.64 ]
  %t_start.113 = phi double [ %183, %182 ], [ %t_start.0, %._crit_edge.64 ]
  %189 = call i32 @MPI_Gather(i8* %58, i32 %188, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %58, i32 %188, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  br label %190

; <label>:190                                     ; preds = %.thread, %186
  %t_start.112 = phi double [ %t_start.113, %.thread ], [ %183, %186 ]
  %191 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %192 = load i32, i32* %taskid, align 4, !tbaa !6
  %193 = icmp eq i32 %192, 0
  br i1 %193, label %194, label %289

; <label>:194                                     ; preds = %190
  %195 = load i32, i32* %Nthr, align 4, !tbaa !6
  %196 = zext i32 %195 to i64
  %197 = call i8* @llvm.stacksave()
  %198 = alloca i64*, i64 %196, align 16
  %199 = load i32, i32* %Nthr, align 4, !tbaa !6
  %200 = zext i32 %199 to i64
  %201 = alloca i32, i64 %200, align 16
  %202 = icmp sgt i32 %199, 0
  br i1 %202, label %.lr.ph59, label %._crit_edge.60

.lr.ph59:                                         ; preds = %194
  %203 = sext i32 %199 to i64
  %204 = sext i32 %199 to i64
  %205 = add nsw i64 %204, -1
  %xtraiter192 = and i64 %204, 3
  %lcmp.mod193 = icmp eq i64 %xtraiter192, 0
  br i1 %lcmp.mod193, label %.lr.ph59.split, label %.preheader202

.preheader202:                                    ; preds = %.lr.ph59
  br label %206

; <label>:206                                     ; preds = %.preheader202, %206
  %indvars.iv95.prol = phi i64 [ %indvars.iv.next96.prol, %206 ], [ 0, %.preheader202 ]
  %prol.iter194 = phi i64 [ %prol.iter194.sub, %206 ], [ %xtraiter192, %.preheader202 ]
  %207 = trunc i64 %indvars.iv95.prol to i32
  %208 = mul nsw i32 %199, %207
  %209 = sext i32 %208 to i64
  %210 = getelementptr inbounds i64, i64* %59, i64 %209
  %211 = getelementptr inbounds i64*, i64** %198, i64 %indvars.iv95.prol
  store i64* %210, i64** %211, align 8, !tbaa !8
  %212 = getelementptr inbounds i32, i32* %201, i64 %indvars.iv95.prol
  store i32 %199, i32* %212, align 4, !tbaa !6
  %indvars.iv.next96.prol = add nuw nsw i64 %indvars.iv95.prol, 1
  %prol.iter194.sub = add i64 %prol.iter194, -1
  %prol.iter194.cmp = icmp eq i64 %prol.iter194.sub, 0
  br i1 %prol.iter194.cmp, label %.lr.ph59.split.loopexit, label %206, !llvm.loop !17

.lr.ph59.split.loopexit:                          ; preds = %206
  %indvars.iv.next96.prol.lcssa = phi i64 [ %indvars.iv.next96.prol, %206 ]
  br label %.lr.ph59.split

.lr.ph59.split:                                   ; preds = %.lr.ph59.split.loopexit, %.lr.ph59
  %indvars.iv95.unr = phi i64 [ 0, %.lr.ph59 ], [ %indvars.iv.next96.prol.lcssa, %.lr.ph59.split.loopexit ]
  %213 = icmp ult i64 %205, 3
  br i1 %213, label %._crit_edge.60.loopexit, label %.lr.ph59.split.split

.lr.ph59.split.split:                             ; preds = %.lr.ph59.split
  br label %256

._crit_edge.60.loopexit.unr-lcssa:                ; preds = %256
  br label %._crit_edge.60.loopexit

._crit_edge.60.loopexit:                          ; preds = %.lr.ph59.split, %._crit_edge.60.loopexit.unr-lcssa
  br label %._crit_edge.60

._crit_edge.60:                                   ; preds = %._crit_edge.60.loopexit, %194
  %214 = mul nsw i32 %199, %199
  %215 = zext i32 %214 to i64
  %216 = alloca i64, i64 %215, align 16
  call void @multimerge(i64** nonnull %198, i32* nonnull %201, i32 %199, i64* nonnull %216)
  %217 = load i32, i32* %Nthr, align 4, !tbaa !6
  %218 = icmp sgt i32 %217, 1
  br i1 %218, label %.lr.ph55, label %._crit_edge.56

.lr.ph55:                                         ; preds = %._crit_edge.60
  %219 = add nsw i32 %217, -1
  %220 = sext i32 %219 to i64
  %221 = sext i32 %219 to i64
  %222 = icmp sgt i64 %221, 1
  %smax = select i1 %222, i64 %221, i64 1
  %min.iters.check127 = icmp ult i64 %smax, 4
  br i1 %min.iters.check127, label %scalar.ph126.preheader, label %min.iters.checked128

scalar.ph126.preheader:                           ; preds = %min.iters.checked128, %middle.block125, %.lr.ph55
  %indvars.iv93.ph = phi i64 [ 0, %min.iters.checked128 ], [ 0, %.lr.ph55 ], [ %n.vec130, %middle.block125 ]
  br label %scalar.ph126

min.iters.checked128:                             ; preds = %.lr.ph55
  %n.vec130 = and i64 %smax, -4
  %cmp.zero131 = icmp ne i64 %n.vec130, 0
  %ident.check133 = icmp eq i32 %217, 1
  %or.cond170 = and i1 %cmp.zero131, %ident.check133
  br i1 %or.cond170, label %vector.body124.preheader, label %scalar.ph126.preheader

vector.body124.preheader:                         ; preds = %min.iters.checked128
  %223 = add i32 %217, -1
  %224 = sext i32 %223 to i64
  %225 = icmp sgt i64 %224, 1
  %smax189 = select i1 %225, i64 %224, i64 1
  %226 = add nsw i64 %smax189, -4
  %227 = lshr i64 %226, 2
  %228 = and i64 %227, 1
  %lcmp.mod191 = icmp eq i64 %228, 0
  br i1 %lcmp.mod191, label %vector.body124.prol, label %vector.body124.preheader.split

vector.body124.prol:                              ; preds = %vector.body124.preheader
  %229 = getelementptr inbounds i64, i64* %216, i64 1
  %230 = bitcast i64* %229 to <2 x i64>*
  %wide.load144.prol = load <2 x i64>, <2 x i64>* %230, align 8, !tbaa !2
  %231 = getelementptr i64, i64* %216, i64 3
  %232 = bitcast i64* %231 to <2 x i64>*
  %wide.load145.prol = load <2 x i64>, <2 x i64>* %232, align 8, !tbaa !2
  %233 = bitcast i8* %58 to <2 x i64>*
  store <2 x i64> %wide.load144.prol, <2 x i64>* %233, align 8, !tbaa !2
  %234 = getelementptr i8, i8* %58, i64 16
  %235 = bitcast i8* %234 to <2 x i64>*
  store <2 x i64> %wide.load145.prol, <2 x i64>* %235, align 8, !tbaa !2
  br label %vector.body124.preheader.split

vector.body124.preheader.split:                   ; preds = %vector.body124.prol, %vector.body124.preheader
  %index136.unr = phi i64 [ 0, %vector.body124.preheader ], [ 4, %vector.body124.prol ]
  %236 = icmp eq i64 %227, 0
  br i1 %236, label %middle.block125, label %vector.body124.preheader.split.split

vector.body124.preheader.split.split:             ; preds = %vector.body124.preheader.split
  br label %vector.body124

vector.body124:                                   ; preds = %vector.body124, %vector.body124.preheader.split.split
  %index136 = phi i64 [ %index136.unr, %vector.body124.preheader.split.split ], [ %index.next137.1, %vector.body124 ]
  %.lhs.lhs = shl i64 %index136, 32
  %.lhs = ashr exact i64 %.lhs.lhs, 32
  %237 = or i64 %.lhs, 1
  %238 = getelementptr inbounds i64, i64* %216, i64 %237
  %239 = bitcast i64* %238 to <2 x i64>*
  %wide.load144 = load <2 x i64>, <2 x i64>* %239, align 8, !tbaa !2
  %240 = getelementptr i64, i64* %238, i64 2
  %241 = bitcast i64* %240 to <2 x i64>*
  %wide.load145 = load <2 x i64>, <2 x i64>* %241, align 8, !tbaa !2
  %242 = getelementptr inbounds i64, i64* %59, i64 %index136
  %243 = bitcast i64* %242 to <2 x i64>*
  store <2 x i64> %wide.load144, <2 x i64>* %243, align 8, !tbaa !2
  %244 = getelementptr i64, i64* %242, i64 2
  %245 = bitcast i64* %244 to <2 x i64>*
  store <2 x i64> %wide.load145, <2 x i64>* %245, align 8, !tbaa !2
  %index.next137 = add i64 %index136, 4
  %.lhs.lhs.1 = shl i64 %index.next137, 32
  %.lhs.1 = ashr exact i64 %.lhs.lhs.1, 32
  %246 = or i64 %.lhs.1, 1
  %247 = getelementptr inbounds i64, i64* %216, i64 %246
  %248 = bitcast i64* %247 to <2 x i64>*
  %wide.load144.1 = load <2 x i64>, <2 x i64>* %248, align 8, !tbaa !2
  %249 = getelementptr i64, i64* %247, i64 2
  %250 = bitcast i64* %249 to <2 x i64>*
  %wide.load145.1 = load <2 x i64>, <2 x i64>* %250, align 8, !tbaa !2
  %251 = getelementptr inbounds i64, i64* %59, i64 %index.next137
  %252 = bitcast i64* %251 to <2 x i64>*
  store <2 x i64> %wide.load144.1, <2 x i64>* %252, align 8, !tbaa !2
  %253 = getelementptr i64, i64* %251, i64 2
  %254 = bitcast i64* %253 to <2 x i64>*
  store <2 x i64> %wide.load145.1, <2 x i64>* %254, align 8, !tbaa !2
  %index.next137.1 = add i64 %index136, 8
  %255 = icmp eq i64 %index.next137.1, %n.vec130
  br i1 %255, label %middle.block125.unr-lcssa, label %vector.body124, !llvm.loop !18

middle.block125.unr-lcssa:                        ; preds = %vector.body124
  br label %middle.block125

middle.block125:                                  ; preds = %vector.body124.preheader.split, %middle.block125.unr-lcssa
  %cmp.n139 = icmp eq i64 %smax, %n.vec130
  br i1 %cmp.n139, label %._crit_edge.56, label %scalar.ph126.preheader

; <label>:256                                     ; preds = %256, %.lr.ph59.split.split
  %indvars.iv95 = phi i64 [ %indvars.iv95.unr, %.lr.ph59.split.split ], [ %indvars.iv.next96.3, %256 ]
  %257 = trunc i64 %indvars.iv95 to i32
  %258 = mul nsw i32 %199, %257
  %259 = sext i32 %258 to i64
  %260 = getelementptr inbounds i64, i64* %59, i64 %259
  %261 = getelementptr inbounds i64*, i64** %198, i64 %indvars.iv95
  store i64* %260, i64** %261, align 8, !tbaa !8
  %262 = getelementptr inbounds i32, i32* %201, i64 %indvars.iv95
  store i32 %199, i32* %262, align 4, !tbaa !6
  %indvars.iv.next96 = add nuw nsw i64 %indvars.iv95, 1
  %263 = trunc i64 %indvars.iv.next96 to i32
  %264 = mul nsw i32 %199, %263
  %265 = sext i32 %264 to i64
  %266 = getelementptr inbounds i64, i64* %59, i64 %265
  %267 = getelementptr inbounds i64*, i64** %198, i64 %indvars.iv.next96
  store i64* %266, i64** %267, align 8, !tbaa !8
  %268 = getelementptr inbounds i32, i32* %201, i64 %indvars.iv.next96
  store i32 %199, i32* %268, align 4, !tbaa !6
  %indvars.iv.next96.1 = add nsw i64 %indvars.iv95, 2
  %269 = trunc i64 %indvars.iv.next96.1 to i32
  %270 = mul nsw i32 %199, %269
  %271 = sext i32 %270 to i64
  %272 = getelementptr inbounds i64, i64* %59, i64 %271
  %273 = getelementptr inbounds i64*, i64** %198, i64 %indvars.iv.next96.1
  store i64* %272, i64** %273, align 8, !tbaa !8
  %274 = getelementptr inbounds i32, i32* %201, i64 %indvars.iv.next96.1
  store i32 %199, i32* %274, align 4, !tbaa !6
  %indvars.iv.next96.2 = add nsw i64 %indvars.iv95, 3
  %275 = trunc i64 %indvars.iv.next96.2 to i32
  %276 = mul nsw i32 %199, %275
  %277 = sext i32 %276 to i64
  %278 = getelementptr inbounds i64, i64* %59, i64 %277
  %279 = getelementptr inbounds i64*, i64** %198, i64 %indvars.iv.next96.2
  store i64* %278, i64** %279, align 8, !tbaa !8
  %280 = getelementptr inbounds i32, i32* %201, i64 %indvars.iv.next96.2
  store i32 %199, i32* %280, align 4, !tbaa !6
  %indvars.iv.next96.3 = add nsw i64 %indvars.iv95, 4
  %281 = icmp slt i64 %indvars.iv.next96.3, %203
  br i1 %281, label %256, label %._crit_edge.60.loopexit.unr-lcssa

._crit_edge.56.loopexit:                          ; preds = %scalar.ph126
  br label %._crit_edge.56

._crit_edge.56:                                   ; preds = %._crit_edge.56.loopexit, %middle.block125, %._crit_edge.60
  call void @llvm.stackrestore(i8* %197)
  br label %289

scalar.ph126:                                     ; preds = %scalar.ph126.preheader, %scalar.ph126
  %indvars.iv93 = phi i64 [ %indvars.iv.next94, %scalar.ph126 ], [ %indvars.iv93.ph, %scalar.ph126.preheader ]
  %indvars.iv.next94 = add nuw nsw i64 %indvars.iv93, 1
  %282 = trunc i64 %indvars.iv.next94 to i32
  %283 = mul nsw i32 %282, %217
  %284 = sext i32 %283 to i64
  %285 = getelementptr inbounds i64, i64* %216, i64 %284
  %286 = load i64, i64* %285, align 8, !tbaa !2
  %287 = getelementptr inbounds i64, i64* %59, i64 %indvars.iv93
  store i64 %286, i64* %287, align 8, !tbaa !2
  %288 = icmp slt i64 %indvars.iv.next94, %220
  br i1 %288, label %scalar.ph126, label %._crit_edge.56.loopexit, !llvm.loop !19

; <label>:289                                     ; preds = %._crit_edge.56, %190
  %290 = load i32, i32* %Nthr, align 4, !tbaa !6
  %291 = add nsw i32 %290, -1
  %292 = call i32 @MPI_Bcast(i8* %58, i32 %291, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %293 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %294 = load i32, i32* %taskid, align 4, !tbaa !6
  %295 = icmp eq i32 %294, 0
  br i1 %295, label %296, label %.thread15

; <label>:296                                     ; preds = %289
  %297 = call double @MPI_Wtime() #7
  %298 = load i32, i32* %Nthr, align 4, !tbaa !6
  %299 = fsub double %297, %t_start.112
  %300 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %23, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i64 0, i64 0), i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.9, i64 0, i64 0), i32 %298, i32 %20, double %299) #7
  %.pr14 = load i32, i32* %taskid, align 4, !tbaa !6
  %301 = icmp eq i32 %.pr14, 0
  br i1 %301, label %302, label %.thread15

; <label>:302                                     ; preds = %296
  %303 = call double @MPI_Wtime() #7
  br label %.thread15

.thread15:                                        ; preds = %289, %302, %296
  %t_start.2 = phi double [ %303, %302 ], [ %t_start.112, %296 ], [ %t_start.112, %289 ]
  %304 = load i32, i32* %Nthr, align 4, !tbaa !6
  %305 = add nsw i32 %304, -1
  %306 = zext i32 %305 to i64
  %307 = alloca i32, i64 %306, align 16
  %308 = zext i32 %304 to i64
  %309 = alloca i32, i64 %308, align 16
  %310 = icmp sgt i32 %304, 1
  br i1 %310, label %.lr.ph50, label %._crit_edge.51

.lr.ph50:                                         ; preds = %.thread15
  %311 = add nsw i32 %55, -1
  %312 = icmp slt i32 %55, 1
  %313 = sext i32 %305 to i64
  br label %321

._crit_edge.51.loopexit:                          ; preds = %binarySearch.exit
  br label %._crit_edge.51

._crit_edge.51:                                   ; preds = %._crit_edge.51.loopexit, %.thread15
  %314 = alloca i32, i64 %308, align 16
  %315 = icmp sgt i32 %304, 0
  br i1 %315, label %.lr.ph48, label %._crit_edge.45.thread

.lr.ph48:                                         ; preds = %._crit_edge.51
  %316 = sext i32 %304 to i64
  %xtraiter187 = and i32 %304, 1
  %lcmp.mod188 = icmp eq i32 %xtraiter187, 0
  br i1 %lcmp.mod188, label %.lr.ph48.split, label %317

; <label>:317                                     ; preds = %.lr.ph48
  br i1 true, label %319, label %318

; <label>:318                                     ; preds = %317
  br label %319

; <label>:319                                     ; preds = %318, %317
  store i32 0, i32* %314, align 16
  br label %.lr.ph48.split

.lr.ph48.split:                                   ; preds = %.lr.ph48, %319
  %indvars.iv89.unr = phi i64 [ 0, %.lr.ph48 ], [ 1, %319 ]
  %320 = icmp eq i32 %304, 1
  br i1 %320, label %.preheader, label %.lr.ph48.split.split

.lr.ph48.split.split:                             ; preds = %.lr.ph48.split
  br label %356

; <label>:321                                     ; preds = %.lr.ph50, %binarySearch.exit
  %indvars.iv91 = phi i64 [ 0, %.lr.ph50 ], [ %indvars.iv.next92, %binarySearch.exit ]
  %322 = getelementptr inbounds i64, i64* %59, i64 %indvars.iv91
  %323 = load i64, i64* %322, align 8, !tbaa !2
  br i1 %312, label %binarySearch.exit, label %.lr.ph.i.preheader

.lr.ph.i.preheader:                               ; preds = %321
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i.preheader, %tailrecurse.outer.i
  %r.tr.ph8.i = phi i32 [ %r.tr5.i.lcssa204, %tailrecurse.outer.i ], [ %311, %.lr.ph.i.preheader ]
  %l.tr.ph7.i = phi i32 [ %338, %tailrecurse.outer.i ], [ 0, %.lr.ph.i.preheader ]
  br label %324

; <label>:324                                     ; preds = %tailrecurse.i, %.lr.ph.i
  %r.tr5.i = phi i32 [ %r.tr.ph8.i, %.lr.ph.i ], [ %336, %tailrecurse.i ]
  %325 = sub nsw i32 %r.tr5.i, %l.tr.ph7.i
  %326 = sdiv i32 %325, 2
  %327 = add nsw i32 %326, %l.tr.ph7.i
  %328 = sext i32 %327 to i64
  %329 = getelementptr inbounds i64, i64* %54, i64 %328
  %330 = load i64, i64* %329, align 8, !tbaa !2
  %331 = icmp eq i64 %330, %323
  br i1 %331, label %332, label %334

; <label>:332                                     ; preds = %324
  %.lcssa206 = phi i32 [ %327, %324 ]
  %333 = add nsw i32 %.lcssa206, 1
  br label %binarySearch.exit

; <label>:334                                     ; preds = %324
  %335 = icmp sgt i64 %330, %323
  br i1 %335, label %tailrecurse.i, label %tailrecurse.outer.i

tailrecurse.i:                                    ; preds = %334
  %336 = add nsw i32 %327, -1
  %337 = icmp slt i32 %325, 2
  br i1 %337, label %binarySearch.exit.loopexit, label %324

tailrecurse.outer.i:                              ; preds = %334
  %.lcssa207 = phi i32 [ %327, %334 ]
  %r.tr5.i.lcssa204 = phi i32 [ %r.tr5.i, %334 ]
  %338 = add nsw i32 %.lcssa207, 1
  %339 = icmp sgt i32 %r.tr5.i.lcssa204, %.lcssa207
  br i1 %339, label %.lr.ph.i, label %binarySearch.exit.loopexit171

binarySearch.exit.loopexit:                       ; preds = %tailrecurse.i
  %l.tr.ph7.i.lcssa210 = phi i32 [ %l.tr.ph7.i, %tailrecurse.i ]
  br label %binarySearch.exit

binarySearch.exit.loopexit171:                    ; preds = %tailrecurse.outer.i
  %.lcssa211 = phi i32 [ %338, %tailrecurse.outer.i ]
  br label %binarySearch.exit

binarySearch.exit:                                ; preds = %binarySearch.exit.loopexit171, %binarySearch.exit.loopexit, %321, %332
  %.1.i = phi i32 [ %333, %332 ], [ 0, %321 ], [ %l.tr.ph7.i.lcssa210, %binarySearch.exit.loopexit ], [ %.lcssa211, %binarySearch.exit.loopexit171 ]
  %340 = getelementptr inbounds i32, i32* %307, i64 %indvars.iv91
  store i32 %.1.i, i32* %340, align 4, !tbaa !6
  %indvars.iv.next92 = add nuw nsw i64 %indvars.iv91, 1
  %341 = icmp slt i64 %indvars.iv.next92, %313
  br i1 %341, label %321, label %._crit_edge.51.loopexit

.preheader.unr-lcssa:                             ; preds = %570
  br label %.preheader

.preheader:                                       ; preds = %.lr.ph48.split, %.preheader.unr-lcssa
  br i1 %315, label %.lr.ph44, label %._crit_edge.45.thread

.lr.ph44:                                         ; preds = %.preheader
  %342 = load i32, i32* %taskid, align 4, !tbaa !6
  %343 = sext i32 %342 to i64
  %344 = getelementptr inbounds i32, i32* %64, i64 %343
  %345 = sext i32 %304 to i64
  %.pre = load i32, i32* %314, align 16, !tbaa !6
  %xtraiter184 = and i32 %304, 1
  %lcmp.mod185 = icmp eq i32 %xtraiter184, 0
  br i1 %lcmp.mod185, label %.lr.ph44.split, label %346

; <label>:346                                     ; preds = %.lr.ph44
  %347 = getelementptr inbounds i32, i32* %314, i64 1
  %348 = load i32, i32* %347, align 4, !tbaa !6
  %349 = sub nsw i32 %348, %.pre
  store i32 %349, i32* %309, align 16, !tbaa !6
  %350 = icmp eq i32 %305, 0
  br i1 %350, label %351, label %.backedge.prol

; <label>:351                                     ; preds = %346
  %352 = load i32, i32* %344, align 4, !tbaa !6
  %353 = load i32, i32* %314, align 16, !tbaa !6
  %354 = sub nsw i32 %352, %353
  store i32 %354, i32* %309, align 16, !tbaa !6
  br label %.backedge.prol

.backedge.prol:                                   ; preds = %351, %346
  br label %.lr.ph44.split

.lr.ph44.split:                                   ; preds = %.lr.ph44, %.backedge.prol
  %.unr186 = phi i32 [ %.pre, %.lr.ph44 ], [ %348, %.backedge.prol ]
  %indvars.iv87.unr = phi i64 [ 0, %.lr.ph44 ], [ 1, %.backedge.prol ]
  %355 = icmp eq i32 %304, 1
  br i1 %355, label %._crit_edge.45, label %.lr.ph44.split.split

.lr.ph44.split.split:                             ; preds = %.lr.ph44.split
  br label %373

; <label>:356                                     ; preds = %570, %.lr.ph48.split.split
  %indvars.iv89 = phi i64 [ %indvars.iv89.unr, %.lr.ph48.split.split ], [ %indvars.iv.next90.1, %570 ]
  %357 = icmp eq i64 %indvars.iv89, 0
  br i1 %357, label %362, label %358

; <label>:358                                     ; preds = %356
  %359 = add nsw i64 %indvars.iv89, -1
  %360 = getelementptr inbounds i32, i32* %307, i64 %359
  %361 = load i32, i32* %360, align 4, !tbaa !6
  br label %362

; <label>:362                                     ; preds = %356, %358
  %.sink = phi i32 [ %361, %358 ], [ 0, %356 ]
  %363 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv89
  store i32 %.sink, i32* %363, align 4
  %indvars.iv.next90 = add nuw nsw i64 %indvars.iv89, 1
  br i1 false, label %570, label %567

._crit_edge.45.thread:                            ; preds = %.preheader, %._crit_edge.51
  %364 = call i8* @calloc(i64 %52, i64 8) #7
  %365 = bitcast i8* %364 to i64*
  %366 = alloca i32, i64 %308, align 16
  %367 = alloca i32, i64 %308, align 16
  br label %._crit_edge.42

._crit_edge.45.unr-lcssa:                         ; preds = %.backedge.1
  br label %._crit_edge.45

._crit_edge.45:                                   ; preds = %.lr.ph44.split, %._crit_edge.45.unr-lcssa
  %368 = call i8* @calloc(i64 %52, i64 8) #7
  %369 = bitcast i8* %368 to i64*
  %370 = alloca i32, i64 %308, align 16
  %371 = alloca i32, i64 %308, align 16
  br i1 %315, label %.lr.ph41, label %._crit_edge.42

.lr.ph41:                                         ; preds = %._crit_edge.45
  %372 = bitcast i32* %370 to i8*
  br label %396

; <label>:373                                     ; preds = %.backedge.1, %.lr.ph44.split.split
  %374 = phi i32 [ %.unr186, %.lr.ph44.split.split ], [ %381, %.backedge.1 ]
  %indvars.iv87 = phi i64 [ %indvars.iv87.unr, %.lr.ph44.split.split ], [ %indvars.iv.next88.1, %.backedge.1 ]
  %indvars.iv.next88 = add nuw nsw i64 %indvars.iv87, 1
  %375 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv.next88
  %376 = load i32, i32* %375, align 4, !tbaa !6
  %377 = sub nsw i32 %376, %374
  %378 = getelementptr inbounds i32, i32* %309, i64 %indvars.iv87
  store i32 %377, i32* %378, align 4, !tbaa !6
  %379 = icmp eq i64 %indvars.iv87, %306
  br i1 %379, label %385, label %.backedge

.backedge:                                        ; preds = %373, %385
  %indvars.iv.next88.1 = add nsw i64 %indvars.iv87, 2
  %380 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv.next88.1
  %381 = load i32, i32* %380, align 4, !tbaa !6
  %382 = sub nsw i32 %381, %376
  %383 = getelementptr inbounds i32, i32* %309, i64 %indvars.iv.next88
  store i32 %382, i32* %383, align 4, !tbaa !6
  %384 = icmp eq i64 %indvars.iv.next88, %306
  br i1 %384, label %561, label %.backedge.1

; <label>:385                                     ; preds = %373
  %386 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv87
  %387 = load i32, i32* %344, align 4, !tbaa !6
  %388 = load i32, i32* %386, align 4, !tbaa !6
  %389 = sub nsw i32 %387, %388
  store i32 %389, i32* %378, align 4, !tbaa !6
  br label %.backedge

._crit_edge.42.loopexit:                          ; preds = %.loopexit18
  br label %._crit_edge.42

._crit_edge.42:                                   ; preds = %._crit_edge.42.loopexit, %._crit_edge.45.thread, %._crit_edge.45
  %390 = phi i32* [ %367, %._crit_edge.45.thread ], [ %371, %._crit_edge.45 ], [ %371, %._crit_edge.42.loopexit ]
  %391 = phi i32* [ %366, %._crit_edge.45.thread ], [ %370, %._crit_edge.45 ], [ %370, %._crit_edge.42.loopexit ]
  %392 = phi i64* [ %365, %._crit_edge.45.thread ], [ %369, %._crit_edge.45 ], [ %369, %._crit_edge.42.loopexit ]
  %393 = phi i8* [ %364, %._crit_edge.45.thread ], [ %368, %._crit_edge.45 ], [ %368, %._crit_edge.42.loopexit ]
  %394 = load i32, i32* %taskid, align 4, !tbaa !6
  %395 = icmp eq i32 %394, 0
  br i1 %395, label %451, label %.thread17

; <label>:396                                     ; preds = %.lr.ph41, %.loopexit18
  %indvars.iv85 = phi i64 [ 0, %.lr.ph41 ], [ %indvars.iv.next86, %.loopexit18 ]
  %397 = getelementptr inbounds i32, i32* %309, i64 %indvars.iv85
  %398 = bitcast i32* %397 to i8*
  %399 = trunc i64 %indvars.iv85 to i32
  %400 = call i32 @MPI_Gather(i8* %398, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i8* %372, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 %399, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %401 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %402 = load i32, i32* %taskid, align 4, !tbaa !6
  %403 = zext i32 %402 to i64
  %404 = icmp eq i64 %403, %indvars.iv85
  br i1 %404, label %405, label %.loopexit18

; <label>:405                                     ; preds = %396
  store i32 0, i32* %371, align 16, !tbaa !6
  %406 = load i32, i32* %Nthr, align 4, !tbaa !6
  %407 = icmp sgt i32 %406, 1
  br i1 %407, label %.lr.ph38, label %.loopexit18

.lr.ph38:                                         ; preds = %405
  %408 = sext i32 %406 to i64
  %409 = sext i32 %406 to i64
  %410 = add nsw i64 %409, 3
  %411 = add nsw i64 %409, -2
  %xtraiter179 = and i64 %410, 3
  %lcmp.mod180 = icmp eq i64 %xtraiter179, 0
  br i1 %lcmp.mod180, label %.lr.ph38.split, label %.preheader183

.preheader183:                                    ; preds = %.lr.ph38
  br label %412

; <label>:412                                     ; preds = %412, %.preheader183
  %413 = phi i32 [ %417, %412 ], [ 0, %.preheader183 ]
  %indvars.iv83.prol = phi i64 [ %indvars.iv.next84.prol, %412 ], [ 1, %.preheader183 ]
  %prol.iter181 = phi i64 [ %prol.iter181.sub, %412 ], [ %xtraiter179, %.preheader183 ]
  %414 = add nsw i64 %indvars.iv83.prol, -1
  %415 = getelementptr inbounds i32, i32* %370, i64 %414
  %416 = load i32, i32* %415, align 4, !tbaa !6
  %417 = add nsw i32 %416, %413
  %418 = getelementptr inbounds i32, i32* %371, i64 %indvars.iv83.prol
  store i32 %417, i32* %418, align 4, !tbaa !6
  %indvars.iv.next84.prol = add nuw nsw i64 %indvars.iv83.prol, 1
  %prol.iter181.sub = add i64 %prol.iter181, -1
  %prol.iter181.cmp = icmp eq i64 %prol.iter181.sub, 0
  br i1 %prol.iter181.cmp, label %.lr.ph38.split.loopexit, label %412, !llvm.loop !20

.lr.ph38.split.loopexit:                          ; preds = %412
  %indvars.iv.next84.prol.lcssa = phi i64 [ %indvars.iv.next84.prol, %412 ]
  %.lcssa = phi i32 [ %417, %412 ]
  br label %.lr.ph38.split

.lr.ph38.split:                                   ; preds = %.lr.ph38, %.lr.ph38.split.loopexit
  %.unr182 = phi i32 [ 0, %.lr.ph38 ], [ %.lcssa, %.lr.ph38.split.loopexit ]
  %indvars.iv83.unr = phi i64 [ 1, %.lr.ph38 ], [ %indvars.iv.next84.prol.lcssa, %.lr.ph38.split.loopexit ]
  %419 = icmp ult i64 %411, 3
  br i1 %419, label %.loopexit18.loopexit, label %.lr.ph38.split.split

.lr.ph38.split.split:                             ; preds = %.lr.ph38.split
  br label %420

; <label>:420                                     ; preds = %420, %.lr.ph38.split.split
  %421 = phi i32 [ %.unr182, %.lr.ph38.split.split ], [ %437, %420 ]
  %indvars.iv83 = phi i64 [ %indvars.iv83.unr, %.lr.ph38.split.split ], [ %indvars.iv.next84.3, %420 ]
  %422 = add nsw i64 %indvars.iv83, -1
  %423 = getelementptr inbounds i32, i32* %370, i64 %422
  %424 = load i32, i32* %423, align 4, !tbaa !6
  %425 = add nsw i32 %424, %421
  %426 = getelementptr inbounds i32, i32* %371, i64 %indvars.iv83
  store i32 %425, i32* %426, align 4, !tbaa !6
  %indvars.iv.next84 = add nuw nsw i64 %indvars.iv83, 1
  %427 = getelementptr inbounds i32, i32* %370, i64 %indvars.iv83
  %428 = load i32, i32* %427, align 4, !tbaa !6
  %429 = add nsw i32 %428, %425
  %430 = getelementptr inbounds i32, i32* %371, i64 %indvars.iv.next84
  store i32 %429, i32* %430, align 4, !tbaa !6
  %indvars.iv.next84.1 = add nsw i64 %indvars.iv83, 2
  %431 = getelementptr inbounds i32, i32* %370, i64 %indvars.iv.next84
  %432 = load i32, i32* %431, align 4, !tbaa !6
  %433 = add nsw i32 %432, %429
  %434 = getelementptr inbounds i32, i32* %371, i64 %indvars.iv.next84.1
  store i32 %433, i32* %434, align 4, !tbaa !6
  %indvars.iv.next84.2 = add nsw i64 %indvars.iv83, 3
  %435 = getelementptr inbounds i32, i32* %370, i64 %indvars.iv.next84.1
  %436 = load i32, i32* %435, align 4, !tbaa !6
  %437 = add nsw i32 %436, %433
  %438 = getelementptr inbounds i32, i32* %371, i64 %indvars.iv.next84.2
  store i32 %437, i32* %438, align 4, !tbaa !6
  %indvars.iv.next84.3 = add nsw i64 %indvars.iv83, 4
  %439 = icmp slt i64 %indvars.iv.next84.3, %408
  br i1 %439, label %420, label %.loopexit18.loopexit.unr-lcssa

.loopexit18.loopexit.unr-lcssa:                   ; preds = %420
  br label %.loopexit18.loopexit

.loopexit18.loopexit:                             ; preds = %.lr.ph38.split, %.loopexit18.loopexit.unr-lcssa
  br label %.loopexit18

.loopexit18:                                      ; preds = %.loopexit18.loopexit, %405, %396
  %440 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv85
  %441 = load i32, i32* %440, align 4, !tbaa !6
  %442 = sext i32 %441 to i64
  %443 = getelementptr inbounds i64, i64* %54, i64 %442
  %444 = bitcast i64* %443 to i8*
  %445 = load i32, i32* %397, align 4, !tbaa !6
  %446 = call i32 @MPI_Gatherv(i8* %444, i32 %445, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %368, i32* nonnull %370, i32* nonnull %371, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 %399, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %447 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %indvars.iv.next86 = add nuw nsw i64 %indvars.iv85, 1
  %448 = load i32, i32* %Nthr, align 4, !tbaa !6
  %449 = sext i32 %448 to i64
  %450 = icmp slt i64 %indvars.iv.next86, %449
  br i1 %450, label %396, label %._crit_edge.42.loopexit

; <label>:451                                     ; preds = %._crit_edge.42
  %452 = call double @MPI_Wtime() #7
  %453 = load i32, i32* %Nthr, align 4, !tbaa !6
  %454 = fsub double %452, %t_start.2
  %455 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %23, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i64 0, i64 0), i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.10, i64 0, i64 0), i32 %453, i32 %20, double %454) #7
  %.pr16 = load i32, i32* %taskid, align 4, !tbaa !6
  %456 = icmp eq i32 %.pr16, 0
  br i1 %456, label %457, label %.thread17

; <label>:457                                     ; preds = %451
  %458 = call double @MPI_Wtime() #7
  br label %.thread17

.thread17:                                        ; preds = %._crit_edge.42, %457, %451
  %t_start.3 = phi double [ %458, %457 ], [ %t_start.2, %451 ], [ %t_start.2, %._crit_edge.42 ]
  %459 = load i32, i32* %Nthr, align 4, !tbaa !6
  %460 = zext i32 %459 to i64
  %461 = alloca i64*, i64 %460, align 16
  %462 = icmp sgt i32 %459, 0
  br i1 %462, label %.lr.ph35, label %._crit_edge

.lr.ph35:                                         ; preds = %.thread17
  %463 = sext i32 %459 to i64
  %464 = sext i32 %459 to i64
  %min.iters.check151 = icmp ult i32 %459, 4
  br i1 %min.iters.check151, label %scalar.ph150.preheader, label %min.iters.checked152

scalar.ph150.preheader:                           ; preds = %middle.block149, %min.iters.checked152, %.lr.ph35
  %indvars.iv81.ph = phi i64 [ 0, %min.iters.checked152 ], [ 0, %.lr.ph35 ], [ %n.vec154, %middle.block149 ]
  br label %scalar.ph150

min.iters.checked152:                             ; preds = %.lr.ph35
  %n.vec154 = and i64 %464, -4
  %cmp.zero155 = icmp eq i64 %n.vec154, 0
  br i1 %cmp.zero155, label %scalar.ph150.preheader, label %vector.body148.preheader

vector.body148.preheader:                         ; preds = %min.iters.checked152
  br label %vector.body148

vector.body148:                                   ; preds = %vector.body148.preheader, %vector.body148
  %index157 = phi i64 [ %index.next158, %vector.body148 ], [ 0, %vector.body148.preheader ]
  %465 = getelementptr inbounds i32, i32* %390, i64 %index157
  %466 = bitcast i32* %465 to <2 x i32>*
  %wide.load165 = load <2 x i32>, <2 x i32>* %466, align 16, !tbaa !6
  %467 = getelementptr i32, i32* %465, i64 2
  %468 = bitcast i32* %467 to <2 x i32>*
  %wide.load166 = load <2 x i32>, <2 x i32>* %468, align 8, !tbaa !6
  %469 = sext <2 x i32> %wide.load165 to <2 x i64>
  %470 = sext <2 x i32> %wide.load166 to <2 x i64>
  %471 = extractelement <2 x i64> %469, i32 0
  %472 = getelementptr inbounds i64, i64* %392, i64 %471
  %473 = insertelement <2 x i64*> undef, i64* %472, i32 0
  %474 = extractelement <2 x i64> %469, i32 1
  %475 = getelementptr inbounds i64, i64* %392, i64 %474
  %476 = insertelement <2 x i64*> %473, i64* %475, i32 1
  %477 = extractelement <2 x i64> %470, i32 0
  %478 = getelementptr inbounds i64, i64* %392, i64 %477
  %479 = insertelement <2 x i64*> undef, i64* %478, i32 0
  %480 = extractelement <2 x i64> %470, i32 1
  %481 = getelementptr inbounds i64, i64* %392, i64 %480
  %482 = insertelement <2 x i64*> %479, i64* %481, i32 1
  %483 = getelementptr inbounds i64*, i64** %461, i64 %index157
  %484 = bitcast i64** %483 to <2 x i64*>*
  store <2 x i64*> %476, <2 x i64*>* %484, align 16, !tbaa !8
  %485 = getelementptr i64*, i64** %483, i64 2
  %486 = bitcast i64** %485 to <2 x i64*>*
  store <2 x i64*> %482, <2 x i64*>* %486, align 16, !tbaa !8
  %index.next158 = add i64 %index157, 4
  %487 = icmp eq i64 %index.next158, %n.vec154
  br i1 %487, label %middle.block149, label %vector.body148, !llvm.loop !21

middle.block149:                                  ; preds = %vector.body148
  %cmp.n160 = icmp eq i64 %464, %n.vec154
  br i1 %cmp.n160, label %._crit_edge, label %scalar.ph150.preheader

._crit_edge.loopexit:                             ; preds = %scalar.ph150
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %middle.block149, %.thread17
  call void @multimerge(i64** nonnull %461, i32* nonnull %391, i32 %459, i64* %54)
  %488 = bitcast i32* %mysendLength to i8*
  call void @llvm.lifetime.start(i64 4, i8* %488) #7
  %489 = load i32, i32* %Nthr, align 4, !tbaa !6
  %490 = add nsw i32 %489, -1
  %491 = sext i32 %490 to i64
  %492 = getelementptr inbounds i32, i32* %390, i64 %491
  %493 = load i32, i32* %492, align 4, !tbaa !6
  %494 = getelementptr inbounds i32, i32* %391, i64 %491
  %495 = load i32, i32* %494, align 4, !tbaa !6
  %496 = add nsw i32 %495, %493
  store i32 %496, i32* %mysendLength, align 4, !tbaa !6
  %497 = load i32, i32* %taskid, align 4, !tbaa !6
  %498 = icmp eq i32 %497, 0
  br i1 %498, label %505, label %510

scalar.ph150:                                     ; preds = %scalar.ph150.preheader, %scalar.ph150
  %indvars.iv81 = phi i64 [ %indvars.iv.next82, %scalar.ph150 ], [ %indvars.iv81.ph, %scalar.ph150.preheader ]
  %499 = getelementptr inbounds i32, i32* %390, i64 %indvars.iv81
  %500 = load i32, i32* %499, align 4, !tbaa !6
  %501 = sext i32 %500 to i64
  %502 = getelementptr inbounds i64, i64* %392, i64 %501
  %503 = getelementptr inbounds i64*, i64** %461, i64 %indvars.iv81
  store i64* %502, i64** %503, align 8, !tbaa !8
  %indvars.iv.next82 = add nuw nsw i64 %indvars.iv81, 1
  %504 = icmp slt i64 %indvars.iv.next82, %463
  br i1 %504, label %scalar.ph150, label %._crit_edge.loopexit, !llvm.loop !22

; <label>:505                                     ; preds = %._crit_edge
  %506 = call double @MPI_Wtime() #7
  %507 = load i32, i32* %Nthr, align 4, !tbaa !6
  %508 = fsub double %506, %t_start.3
  %509 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %23, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i64 0, i64 0), i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.11, i64 0, i64 0), i32 %507, i32 %20, double %508) #7
  %.pre103 = load i32, i32* %Nthr, align 4, !tbaa !6
  br label %510

; <label>:510                                     ; preds = %505, %._crit_edge
  %511 = phi i32 [ %.pre103, %505 ], [ %489, %._crit_edge ]
  %512 = zext i32 %511 to i64
  %513 = alloca i32, i64 %512, align 16
  %514 = alloca i32, i64 %512, align 16
  %515 = bitcast i32* %513 to i8*
  %516 = call i32 @MPI_Gather(i8* %488, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i8* %515, i32 1, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_int to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %517 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %518 = load i32, i32* %taskid, align 4, !tbaa !6
  %519 = icmp eq i32 %518, 0
  br i1 %519, label %520, label %.loopexit

; <label>:520                                     ; preds = %510
  store i32 0, i32* %514, align 16, !tbaa !6
  %521 = load i32, i32* %Nthr, align 4, !tbaa !6
  %522 = icmp sgt i32 %521, 1
  br i1 %522, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %520
  %523 = sext i32 %521 to i64
  %524 = sext i32 %521 to i64
  %525 = add nsw i64 %524, 3
  %526 = add nsw i64 %524, -2
  %xtraiter = and i64 %525, 3
  %lcmp.mod = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod, label %.lr.ph.split, label %.preheader201

.preheader201:                                    ; preds = %.lr.ph
  br label %527

; <label>:527                                     ; preds = %.preheader201, %527
  %528 = phi i32 [ %532, %527 ], [ 0, %.preheader201 ]
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %527 ], [ 1, %.preheader201 ]
  %prol.iter = phi i64 [ %prol.iter.sub, %527 ], [ %xtraiter, %.preheader201 ]
  %529 = add nsw i64 %indvars.iv.prol, -1
  %530 = getelementptr inbounds i32, i32* %513, i64 %529
  %531 = load i32, i32* %530, align 4, !tbaa !6
  %532 = add nsw i32 %531, %528
  %533 = getelementptr inbounds i32, i32* %514, i64 %indvars.iv.prol
  store i32 %532, i32* %533, align 4, !tbaa !6
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %.lr.ph.split.loopexit, label %527, !llvm.loop !24

.lr.ph.split.loopexit:                            ; preds = %527
  %indvars.iv.next.prol.lcssa = phi i64 [ %indvars.iv.next.prol, %527 ]
  %.lcssa212 = phi i32 [ %532, %527 ]
  br label %.lr.ph.split

.lr.ph.split:                                     ; preds = %.lr.ph.split.loopexit, %.lr.ph
  %.unr = phi i32 [ 0, %.lr.ph ], [ %.lcssa212, %.lr.ph.split.loopexit ]
  %indvars.iv.unr = phi i64 [ 1, %.lr.ph ], [ %indvars.iv.next.prol.lcssa, %.lr.ph.split.loopexit ]
  %534 = icmp ult i64 %526, 3
  br i1 %534, label %.loopexit.loopexit, label %.lr.ph.split.split

.lr.ph.split.split:                               ; preds = %.lr.ph.split
  br label %535

; <label>:535                                     ; preds = %535, %.lr.ph.split.split
  %536 = phi i32 [ %.unr, %.lr.ph.split.split ], [ %552, %535 ]
  %indvars.iv = phi i64 [ %indvars.iv.unr, %.lr.ph.split.split ], [ %indvars.iv.next.3, %535 ]
  %537 = add nsw i64 %indvars.iv, -1
  %538 = getelementptr inbounds i32, i32* %513, i64 %537
  %539 = load i32, i32* %538, align 4, !tbaa !6
  %540 = add nsw i32 %539, %536
  %541 = getelementptr inbounds i32, i32* %514, i64 %indvars.iv
  store i32 %540, i32* %541, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %542 = getelementptr inbounds i32, i32* %513, i64 %indvars.iv
  %543 = load i32, i32* %542, align 4, !tbaa !6
  %544 = add nsw i32 %543, %540
  %545 = getelementptr inbounds i32, i32* %514, i64 %indvars.iv.next
  store i32 %544, i32* %545, align 4, !tbaa !6
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %546 = getelementptr inbounds i32, i32* %513, i64 %indvars.iv.next
  %547 = load i32, i32* %546, align 4, !tbaa !6
  %548 = add nsw i32 %547, %544
  %549 = getelementptr inbounds i32, i32* %514, i64 %indvars.iv.next.1
  store i32 %548, i32* %549, align 4, !tbaa !6
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %550 = getelementptr inbounds i32, i32* %513, i64 %indvars.iv.next.1
  %551 = load i32, i32* %550, align 4, !tbaa !6
  %552 = add nsw i32 %551, %548
  %553 = getelementptr inbounds i32, i32* %514, i64 %indvars.iv.next.2
  store i32 %552, i32* %553, align 4, !tbaa !6
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %554 = icmp slt i64 %indvars.iv.next.3, %523
  br i1 %554, label %535, label %.loopexit.loopexit.unr-lcssa

.loopexit.loopexit.unr-lcssa:                     ; preds = %535
  br label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %.lr.ph.split, %.loopexit.loopexit.unr-lcssa
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %520, %510
  %555 = call i8* @calloc(i64 %52, i64 8) #7
  %556 = load i32, i32* %mysendLength, align 4, !tbaa !6
  %557 = call i32 @MPI_Gatherv(i8* %53, i32 %556, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i8* %555, i32* nonnull %513, i32* nonnull %514, %struct.ompi_datatype_t* nonnull bitcast (%struct.ompi_predefined_datatype_t* @ompi_mpi_long to %struct.ompi_datatype_t*), i32 0, %struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  %558 = call i32 @MPI_Barrier(%struct.ompi_communicator_t* nonnull bitcast (%struct.ompi_predefined_communicator_t* @ompi_mpi_comm_world to %struct.ompi_communicator_t*)) #7
  call void @free(i8* %53)
  call void @free(i8* %393)
  call void @free(i8* %555)
  call void @free(i8* %58)
  call void @free(i8* %61)
  call void @free(i8* %63)
  %559 = call i32 @fclose(%struct.__sFILE* %23) #7
  %560 = call i32 @MPI_Finalize() #7
  call void @llvm.lifetime.end(i64 4, i8* %488) #7
  call void @llvm.lifetime.end(i64 4, i8* nonnull %3) #7
  call void @llvm.lifetime.end(i64 4, i8* %2) #7
  ret i32 0

; <label>:561                                     ; preds = %.backedge
  %562 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv.next88
  %563 = load i32, i32* %344, align 4, !tbaa !6
  %564 = load i32, i32* %562, align 4, !tbaa !6
  %565 = sub nsw i32 %563, %564
  store i32 %565, i32* %383, align 4, !tbaa !6
  br label %.backedge.1

.backedge.1:                                      ; preds = %561, %.backedge
  %566 = icmp slt i64 %indvars.iv.next88.1, %345
  br i1 %566, label %373, label %._crit_edge.45.unr-lcssa

; <label>:567                                     ; preds = %362
  %568 = getelementptr inbounds i32, i32* %307, i64 %indvars.iv89
  %569 = load i32, i32* %568, align 4, !tbaa !6
  br label %570

; <label>:570                                     ; preds = %567, %362
  %.sink.1 = phi i32 [ %569, %567 ], [ 0, %362 ]
  %571 = getelementptr inbounds i32, i32* %314, i64 %indvars.iv.next90
  store i32 %.sink.1, i32* %571, align 4
  %indvars.iv.next90.1 = add nsw i64 %indvars.iv89, 2
  %572 = icmp slt i64 %indvars.iv.next90.1, %316
  br i1 %572, label %356, label %.preheader.unr-lcssa
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
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !14, !15}
!22 = distinct !{!22, !23, !14, !15}
!23 = !{!"llvm.loop.unroll.runtime.disable"}
!24 = distinct !{!24, !11}
