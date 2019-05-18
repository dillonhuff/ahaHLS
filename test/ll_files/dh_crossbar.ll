; ModuleID = 'dh_crossbar.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

%"class.sc_core::sc_api_version_2_3_0" = type { i8 }
%"class.sc_dt::sc_uint" = type { %"class.sc_dt::sc_uint_base" }
%"class.sc_dt::sc_uint_base" = type { %"class.sc_dt::sc_value_base", i64, i32, i32 }
%"class.sc_dt::sc_value_base" = type { i32 (...)** }
%"class.sc_dt::sc_uint.0" = type { %"class.sc_dt::sc_uint_base" }
%"class.sc_dt::sc_signed" = type { %"class.sc_dt::sc_value_base", i32, i32, i32, i32* }
%"class.sc_dt::sc_unsigned" = type { %"class.sc_dt::sc_value_base", i32, i32, i32, i32* }

@_ZN7sc_coreL17api_version_checkE = internal global %"class.sc_core::sc_api_version_2_3_0" zeroinitializer, align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external global i8*
@_ZN5sc_dt9UINT_ZEROE = external constant i64, align 8
@_ZTVN5sc_dt7sc_uintILi2EEE = linkonce_odr unnamed_addr constant [13 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTIN5sc_dt7sc_uintILi2EEE to i8*), i8* bitcast (void (%"class.sc_dt::sc_value_base"*, i1)* @_ZN5sc_dt13sc_value_base17concat_clear_dataEb to i8*), i8* bitcast (i1 (%"class.sc_dt::sc_uint_base"*, i32*, i32)* @_ZNK5sc_dt12sc_uint_base15concat_get_ctrlEPji to i8*), i8* bitcast (i1 (%"class.sc_dt::sc_uint_base"*, i32*, i32)* @_ZNK5sc_dt12sc_uint_base15concat_get_dataEPji to i8*), i8* bitcast (i64 (%"class.sc_dt::sc_uint_base"*)* @_ZNK5sc_dt12sc_uint_base17concat_get_uint64Ev to i8*), i8* bitcast (i32 (%"class.sc_dt::sc_uint_base"*, i8*)* @_ZNK5sc_dt12sc_uint_base13concat_lengthEPb to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, i64, i32)* @_ZN5sc_dt12sc_uint_base10concat_setExi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, %"class.sc_dt::sc_signed"*, i32)* @_ZN5sc_dt12sc_uint_base10concat_setERKNS_9sc_signedEi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, %"class.sc_dt::sc_unsigned"*, i32)* @_ZN5sc_dt12sc_uint_base10concat_setERKNS_11sc_unsignedEi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, i64, i32)* @_ZN5sc_dt12sc_uint_base10concat_setEyi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint"*)* @_ZN5sc_dt7sc_uintILi2EED1Ev to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint"*)* @_ZN5sc_dt7sc_uintILi2EED0Ev to i8*)], align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTSN5sc_dt7sc_uintILi2EEE = linkonce_odr constant [23 x i8] c"N5sc_dt7sc_uintILi2EEE\00"
@_ZTIN5sc_dt12sc_uint_baseE = external constant i8*
@_ZTIN5sc_dt7sc_uintILi2EEE = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @_ZTSN5sc_dt7sc_uintILi2EEE, i32 0, i32 0), i8* bitcast (i8** @_ZTIN5sc_dt12sc_uint_baseE to i8*) }
@_ZTVN5sc_dt12sc_uint_baseE = external unnamed_addr constant [13 x i8*]
@_ZTVN5sc_dt13sc_value_baseE = external unnamed_addr constant [13 x i8*]
@_ZTVN5sc_dt7sc_uintILi8EEE = linkonce_odr unnamed_addr constant [13 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTIN5sc_dt7sc_uintILi8EEE to i8*), i8* bitcast (void (%"class.sc_dt::sc_value_base"*, i1)* @_ZN5sc_dt13sc_value_base17concat_clear_dataEb to i8*), i8* bitcast (i1 (%"class.sc_dt::sc_uint_base"*, i32*, i32)* @_ZNK5sc_dt12sc_uint_base15concat_get_ctrlEPji to i8*), i8* bitcast (i1 (%"class.sc_dt::sc_uint_base"*, i32*, i32)* @_ZNK5sc_dt12sc_uint_base15concat_get_dataEPji to i8*), i8* bitcast (i64 (%"class.sc_dt::sc_uint_base"*)* @_ZNK5sc_dt12sc_uint_base17concat_get_uint64Ev to i8*), i8* bitcast (i32 (%"class.sc_dt::sc_uint_base"*, i8*)* @_ZNK5sc_dt12sc_uint_base13concat_lengthEPb to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, i64, i32)* @_ZN5sc_dt12sc_uint_base10concat_setExi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, %"class.sc_dt::sc_signed"*, i32)* @_ZN5sc_dt12sc_uint_base10concat_setERKNS_9sc_signedEi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, %"class.sc_dt::sc_unsigned"*, i32)* @_ZN5sc_dt12sc_uint_base10concat_setERKNS_11sc_unsignedEi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint_base"*, i64, i32)* @_ZN5sc_dt12sc_uint_base10concat_setEyi to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint.0"*)* @_ZN5sc_dt7sc_uintILi8EED1Ev to i8*), i8* bitcast (void (%"class.sc_dt::sc_uint.0"*)* @_ZN5sc_dt7sc_uintILi8EED0Ev to i8*)], align 8
@_ZTSN5sc_dt7sc_uintILi8EEE = linkonce_odr constant [23 x i8] c"N5sc_dt7sc_uintILi8EEE\00"
@_ZTIN5sc_dt7sc_uintILi8EEE = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @_ZTSN5sc_dt7sc_uintILi8EEE, i32 0, i32 0), i8* bitcast (i8** @_ZTIN5sc_dt12sc_uint_baseE to i8*) }
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_dh_crossbar.cpp, i8* null }]

; Function Attrs: ssp uwtable
define internal fastcc void @__cxx_global_var_init() #0 section "__TEXT,__StaticInit,regular,pure_instructions" {
  tail call void @_ZN7sc_core20sc_api_version_2_3_0C1Ev(%"class.sc_core::sc_api_version_2_3_0"* nonnull @_ZN7sc_coreL17api_version_checkE)
  ret void
}

declare void @_ZN7sc_core20sc_api_version_2_3_0C1Ev(%"class.sc_core::sc_api_version_2_3_0"*) #1

; Function Attrs: ssp uwtable
define void @_Z11dh_crossbarPiPbPN5sc_dt7sc_uintILi2EEES0_S_S0_(i32* nocapture readonly %inputs, i8* nocapture readonly %valid_in, %"class.sc_dt::sc_uint"* nocapture readonly %source, i8* nocapture readonly %valid_source, i32* nocapture %data_out, i8* nocapture %valid_out) #0 {
  tail call void @_Z8crossbarIiLj4ELj4EEvPT_PbPN5nvhls7nvhls_tIXsr5nvhls11index_widthIXT0_EEE3valEXlesr5nvhls11index_widthIXT0_EEE3valLi64EEE8nvuint_tES2_S1_S2_(i32* %inputs, i8* %valid_in, %"class.sc_dt::sc_uint"* %source, i8* %valid_source, i32* %data_out, i8* %valid_out)
  ret void
}

; Function Attrs: ssp uwtable
define linkonce_odr void @_Z8crossbarIiLj4ELj4EEvPT_PbPN5nvhls7nvhls_tIXsr5nvhls11index_widthIXT0_EEE3valEXlesr5nvhls11index_widthIXT0_EEE3valLi64EEE8nvuint_tES2_S1_S2_(i32* nocapture readonly %data_in, i8* nocapture readonly %valid_in, %"class.sc_dt::sc_uint"* nocapture readonly %source, i8* nocapture readonly %valid_source, i32* nocapture %data_out, i8* nocapture %valid_out) #0 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %source_tmp = alloca %"class.sc_dt::sc_uint", align 8
  %1 = bitcast %"class.sc_dt::sc_uint"* %source_tmp to i8*
  call void @llvm.lifetime.start(i64 24, i8* %1) #9
  call void @_ZN5sc_dt7sc_uintILi2EEC1Ev(%"class.sc_dt::sc_uint"* nonnull %source_tmp)
  %2 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %source_tmp, i64 0, i32 0
  br label %4

; <label>:3                                       ; preds = %26
  call void @llvm.lifetime.end(i64 24, i8* %1) #9
  ret void

; <label>:4                                       ; preds = %26, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %26 ]
  %5 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %source, i64 %indvars.iv
  %6 = call dereferenceable(24) %"class.sc_dt::sc_uint"* @_ZN5sc_dt7sc_uintILi2EEaSERKS1_(%"class.sc_dt::sc_uint"* nonnull %source_tmp, %"class.sc_dt::sc_uint"* dereferenceable(24) %5)
  %7 = getelementptr inbounds i8, i8* %valid_source, i64 %indvars.iv
  %8 = load i8, i8* %7, align 1, !tbaa !2, !range !6
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %4
  %11 = call dereferenceable(24) %"class.sc_dt::sc_uint"* @_ZN5sc_dt7sc_uintILi2EEaSEi(%"class.sc_dt::sc_uint"* nonnull %source_tmp, i32 0)
  br label %12

; <label>:12                                      ; preds = %10, %4
  %13 = call i64 @_ZNK5sc_dt12sc_uint_basecvyEv(%"class.sc_dt::sc_uint_base"* %2)
  %14 = getelementptr inbounds i8, i8* %valid_in, i64 %13
  %15 = load i8, i8* %14, align 1, !tbaa !2, !range !6
  %16 = load i8, i8* %7, align 1, !tbaa !2, !range !6
  %17 = icmp eq i8 %16, 0
  %18 = icmp eq i8 %15, 0
  %or.cond = or i1 %18, %17
  %19 = getelementptr inbounds i32, i32* %data_out, i64 %indvars.iv
  br i1 %or.cond, label %24, label %20

; <label>:20                                      ; preds = %12
  %21 = getelementptr inbounds i32, i32* %data_in, i64 %13
  %22 = load i32, i32* %21, align 4, !tbaa !7
  store i32 %22, i32* %19, align 4, !tbaa !7
  %23 = getelementptr inbounds i8, i8* %valid_out, i64 %indvars.iv
  store i8 1, i8* %23, align 1, !tbaa !2
  br label %26

; <label>:24                                      ; preds = %12
  store i32 0, i32* %19, align 4, !tbaa !7
  %25 = getelementptr inbounds i8, i8* %valid_out, i64 %indvars.iv
  store i8 0, i8* %25, align 1, !tbaa !2
  br label %26

; <label>:26                                      ; preds = %20, %24
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 4
  br i1 %exitcond, label %3, label %4
}

; Function Attrs: ssp uwtable
define i32 @main() #0 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %inputs = alloca [4 x i32], align 16
  %valid_in = alloca [4 x i8], align 1
  %source = alloca [4 x %"class.sc_dt::sc_uint"], align 16
  %rand = alloca [4 x %"class.sc_dt::sc_uint.0"], align 16
  %valid_source = alloca [4 x i8], align 1
  %data_out = alloca [4 x i32], align 16
  %valid_out = alloca [4 x i8], align 1
  %1 = bitcast [4 x i32]* %inputs to i8*
  call void @llvm.lifetime.start(i64 16, i8* %1) #9
  %2 = getelementptr inbounds [4 x i8], [4 x i8]* %valid_in, i64 0, i64 0
  call void @llvm.lifetime.start(i64 4, i8* %2) #9
  %3 = bitcast [4 x %"class.sc_dt::sc_uint"]* %source to i8*
  call void @llvm.lifetime.start(i64 96, i8* %3) #9
  %4 = getelementptr inbounds [4 x %"class.sc_dt::sc_uint"], [4 x %"class.sc_dt::sc_uint"]* %source, i64 0, i64 0
  %5 = getelementptr inbounds [4 x %"class.sc_dt::sc_uint"], [4 x %"class.sc_dt::sc_uint"]* %source, i64 0, i64 4
  br label %6

; <label>:6                                       ; preds = %8, %0
  %7 = phi %"class.sc_dt::sc_uint"* [ %4, %0 ], [ %9, %8 ]
  invoke void @_ZN5sc_dt7sc_uintILi2EEC1Ev(%"class.sc_dt::sc_uint"* %7)
          to label %8 unwind label %26

; <label>:8                                       ; preds = %6
  %9 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %7, i64 1
  %10 = icmp eq %"class.sc_dt::sc_uint"* %9, %5
  br i1 %10, label %11, label %6

; <label>:11                                      ; preds = %8
  %12 = bitcast [4 x %"class.sc_dt::sc_uint.0"]* %rand to i8*
  call void @llvm.lifetime.start(i64 96, i8* %12) #9
  %13 = getelementptr inbounds [4 x %"class.sc_dt::sc_uint.0"], [4 x %"class.sc_dt::sc_uint.0"]* %rand, i64 0, i64 0
  %14 = getelementptr inbounds [4 x %"class.sc_dt::sc_uint.0"], [4 x %"class.sc_dt::sc_uint.0"]* %rand, i64 0, i64 4
  br label %15

; <label>:15                                      ; preds = %17, %11
  %16 = phi %"class.sc_dt::sc_uint.0"* [ %13, %11 ], [ %18, %17 ]
  invoke void @_ZN5sc_dt7sc_uintILi8EEC1Ev(%"class.sc_dt::sc_uint.0"* %16)
          to label %17 unwind label %30

; <label>:17                                      ; preds = %15
  %18 = getelementptr inbounds %"class.sc_dt::sc_uint.0", %"class.sc_dt::sc_uint.0"* %16, i64 1
  %19 = icmp eq %"class.sc_dt::sc_uint.0"* %18, %14
  br i1 %19, label %20, label %15

; <label>:20                                      ; preds = %17
  %21 = getelementptr inbounds [4 x i8], [4 x i8]* %valid_source, i64 0, i64 0
  call void @llvm.lifetime.start(i64 4, i8* %21) #9
  %22 = bitcast [4 x i32]* %data_out to i8*
  call void @llvm.lifetime.start(i64 16, i8* %22) #9
  %23 = getelementptr inbounds [4 x i8], [4 x i8]* %valid_out, i64 0, i64 0
  call void @llvm.lifetime.start(i64 4, i8* %23) #9
  %24 = getelementptr inbounds [4 x i32], [4 x i32]* %inputs, i64 0, i64 0
  %25 = getelementptr inbounds [4 x i32], [4 x i32]* %data_out, i64 0, i64 0
  invoke void @_Z11dh_crossbarPiPbPN5sc_dt7sc_uintILi2EEES0_S_S0_(i32* %24, i8* %2, %"class.sc_dt::sc_uint"* %4, i8* %21, i32* %25, i8* %23)
          to label %.preheader unwind label %.loopexit3.loopexit

; <label>:26                                      ; preds = %6
  %27 = landingpad { i8*, i32 }
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  %29 = extractvalue { i8*, i32 } %27, 1
  br label %.loopexit

; <label>:30                                      ; preds = %15
  %31 = landingpad { i8*, i32 }
          cleanup
  %32 = extractvalue { i8*, i32 } %31, 0
  %33 = extractvalue { i8*, i32 } %31, 1
  br label %.loopexit

.preheader:                                       ; preds = %20, %.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %.preheader ], [ 0, %20 ]
  %34 = getelementptr inbounds [4 x %"class.sc_dt::sc_uint.0"], [4 x %"class.sc_dt::sc_uint.0"]* %rand, i64 0, i64 %indvars.iv
  %35 = getelementptr inbounds %"class.sc_dt::sc_uint.0", %"class.sc_dt::sc_uint.0"* %34, i64 0, i32 0
  %36 = call i64 @_ZNK5sc_dt12sc_uint_basecvyEv(%"class.sc_dt::sc_uint_base"* %35)
  %37 = add i64 %36, 1
  %38 = call dereferenceable(24) %"class.sc_dt::sc_uint.0"* @_ZN5sc_dt7sc_uintILi8EEaSEy(%"class.sc_dt::sc_uint.0"* %34, i64 %37)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10
  br i1 %exitcond, label %39, label %.preheader

; <label>:39                                      ; preds = %.preheader
  call void @llvm.lifetime.end(i64 4, i8* %23) #9
  call void @llvm.lifetime.end(i64 16, i8* %22) #9
  call void @llvm.lifetime.end(i64 4, i8* %21) #9
  call void @llvm.lifetime.end(i64 96, i8* %12) #9
  call void @llvm.lifetime.end(i64 96, i8* %3) #9
  call void @llvm.lifetime.end(i64 4, i8* %2) #9
  call void @llvm.lifetime.end(i64 16, i8* %1) #9
  ret i32 0

.loopexit3.loopexit:                              ; preds = %20
  %40 = landingpad { i8*, i32 }
          cleanup
  %41 = extractvalue { i8*, i32 } %40, 0
  %42 = extractvalue { i8*, i32 } %40, 1
  br label %.loopexit

.loopexit:                                        ; preds = %30, %26, %.loopexit3.loopexit
  %.12 = phi i8* [ %41, %.loopexit3.loopexit ], [ %32, %30 ], [ %28, %26 ]
  %.1 = phi i32 [ %42, %.loopexit3.loopexit ], [ %33, %30 ], [ %29, %26 ]
  %43 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %44 = insertvalue { i8*, i32 } %43, i32 %.1, 1
  resume { i8*, i32 } %44
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi2EEC1Ev(%"class.sc_dt::sc_uint"* %this) unnamed_addr #0 align 2 {
  tail call void @_ZN5sc_dt7sc_uintILi2EEC2Ev(%"class.sc_dt::sc_uint"* %this)
  ret void
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: inlinehint nounwind readnone ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi2EED1Ev(%"class.sc_dt::sc_uint"* nocapture %this) unnamed_addr #3 align 2 {
  ret void
}

; Function Attrs: ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi8EEC1Ev(%"class.sc_dt::sc_uint.0"* %this) unnamed_addr #0 align 2 {
  tail call void @_ZN5sc_dt7sc_uintILi8EEC2Ev(%"class.sc_dt::sc_uint.0"* %this)
  ret void
}

; Function Attrs: inlinehint nounwind readnone ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi8EED1Ev(%"class.sc_dt::sc_uint.0"* nocapture %this) unnamed_addr #3 align 2 {
  ret void
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr dereferenceable(24) %"class.sc_dt::sc_uint.0"* @_ZN5sc_dt7sc_uintILi8EEaSEy(%"class.sc_dt::sc_uint.0"* %this, i64 %v) #4 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint.0", %"class.sc_dt::sc_uint.0"* %this, i64 0, i32 0
  %2 = tail call dereferenceable(24) %"class.sc_dt::sc_uint_base"* @_ZN5sc_dt12sc_uint_baseaSEy(%"class.sc_dt::sc_uint_base"* %1, i64 %v)
  ret %"class.sc_dt::sc_uint.0"* %this
}

; Function Attrs: nounwind readonly ssp uwtable
define linkonce_odr i64 @_ZNK5sc_dt12sc_uint_basecvyEv(%"class.sc_dt::sc_uint_base"* nocapture readonly %this) #5 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 1
  %2 = load i64, i64* %1, align 8, !tbaa !9
  ret i64 %2
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: inlinehint nounwind readnone ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi2EED2Ev(%"class.sc_dt::sc_uint"* nocapture %this) unnamed_addr #3 align 2 {
  ret void
}

; Function Attrs: nounwind readnone ssp uwtable
define linkonce_odr void @_ZN5sc_dt12sc_uint_baseD2Ev(%"class.sc_dt::sc_uint_base"* nocapture %this) unnamed_addr #6 align 2 {
  ret void
}

; Function Attrs: nounwind readnone ssp uwtable
define linkonce_odr void @_ZN5sc_dt13sc_value_baseD2Ev(%"class.sc_dt::sc_value_base"* nocapture %this) unnamed_addr #6 align 2 {
  ret void
}

; Function Attrs: inlinehint nounwind readnone ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi8EED2Ev(%"class.sc_dt::sc_uint.0"* nocapture %this) unnamed_addr #3 align 2 {
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #7

; Function Attrs: nounwind ssp uwtable
define linkonce_odr dereferenceable(24) %"class.sc_dt::sc_uint"* @_ZN5sc_dt7sc_uintILi2EEaSERKS1_(%"class.sc_dt::sc_uint"* %this, %"class.sc_dt::sc_uint"* nocapture readonly dereferenceable(24) %a) #4 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %a, i64 0, i32 0, i32 1
  %2 = load i64, i64* %1, align 8, !tbaa !9
  %3 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %this, i64 0, i32 0, i32 1
  store i64 %2, i64* %3, align 8, !tbaa !9
  ret %"class.sc_dt::sc_uint"* %this
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr dereferenceable(24) %"class.sc_dt::sc_uint"* @_ZN5sc_dt7sc_uintILi2EEaSEi(%"class.sc_dt::sc_uint"* %this, i32 %a) #4 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %this, i64 0, i32 0
  %2 = tail call dereferenceable(24) %"class.sc_dt::sc_uint_base"* @_ZN5sc_dt12sc_uint_baseaSEi(%"class.sc_dt::sc_uint_base"* %1, i32 %a)
  ret %"class.sc_dt::sc_uint"* %this
}

; Function Attrs: nounwind readnone ssp uwtable
define linkonce_odr i32 @_Z9zero_bitsIiET_v() #6 {
  ret i32 0
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr dereferenceable(24) %"class.sc_dt::sc_uint_base"* @_ZN5sc_dt12sc_uint_baseaSEi(%"class.sc_dt::sc_uint_base"* %this, i32 %a) #4 align 2 {
  %1 = sext i32 %a to i64
  %2 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 1
  store i64 %1, i64* %2, align 8, !tbaa !9
  tail call void @_ZN5sc_dt12sc_uint_base11extend_signEv(%"class.sc_dt::sc_uint_base"* %this)
  ret %"class.sc_dt::sc_uint_base"* %this
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr void @_ZN5sc_dt12sc_uint_base11extend_signEv(%"class.sc_dt::sc_uint_base"* nocapture %this) #4 align 2 {
  %1 = load i64, i64* @_ZN5sc_dt9UINT_ZEROE, align 8, !tbaa !12
  %2 = xor i64 %1, -1
  %3 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 3
  %4 = load i32, i32* %3, align 4, !tbaa !13
  %5 = zext i32 %4 to i64
  %6 = lshr i64 %2, %5
  %7 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 1
  %8 = load i64, i64* %7, align 8, !tbaa !9
  %9 = and i64 %6, %8
  store i64 %9, i64* %7, align 8, !tbaa !9
  ret void
}

; Function Attrs: ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi2EEC2Ev(%"class.sc_dt::sc_uint"* %this) unnamed_addr #0 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %this, i64 0, i32 0
  tail call void @_ZN5sc_dt12sc_uint_baseC2Ei(%"class.sc_dt::sc_uint_base"* %1, i32 2)
  %2 = getelementptr inbounds %"class.sc_dt::sc_uint", %"class.sc_dt::sc_uint"* %this, i64 0, i32 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([13 x i8*], [13 x i8*]* @_ZTVN5sc_dt7sc_uintILi2EEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %2, align 8, !tbaa !14
  ret void
}

; Function Attrs: ssp uwtable
define linkonce_odr void @_ZN5sc_dt12sc_uint_baseC2Ei(%"class.sc_dt::sc_uint_base"* %this, i32 %w) unnamed_addr #0 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 0
  tail call void @_ZN5sc_dt13sc_value_baseC2Ev(%"class.sc_dt::sc_value_base"* %1) #9
  %2 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([13 x i8*], [13 x i8*]* @_ZTVN5sc_dt12sc_uint_baseE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %2, align 8, !tbaa !14
  %3 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 1
  store i64 0, i64* %3, align 8, !tbaa !9
  %4 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 2
  store i32 %w, i32* %4, align 8, !tbaa !16
  %5 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 3
  %6 = sub nsw i32 64, %w
  store i32 %6, i32* %5, align 4, !tbaa !13
  tail call void @_ZNK5sc_dt12sc_uint_base12check_lengthEv(%"class.sc_dt::sc_uint_base"* %this)
  ret void
}

declare void @_ZN5sc_dt13sc_value_base17concat_clear_dataEb(%"class.sc_dt::sc_value_base"*, i1 zeroext) #1

declare zeroext i1 @_ZNK5sc_dt12sc_uint_base15concat_get_ctrlEPji(%"class.sc_dt::sc_uint_base"*, i32*, i32) #1

declare zeroext i1 @_ZNK5sc_dt12sc_uint_base15concat_get_dataEPji(%"class.sc_dt::sc_uint_base"*, i32*, i32) #1

; Function Attrs: nounwind readonly ssp uwtable
define linkonce_odr i64 @_ZNK5sc_dt12sc_uint_base17concat_get_uint64Ev(%"class.sc_dt::sc_uint_base"* nocapture readonly %this) unnamed_addr #5 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 1
  %2 = load i64, i64* %1, align 8, !tbaa !9
  ret i64 %2
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr i32 @_ZNK5sc_dt12sc_uint_base13concat_lengthEPb(%"class.sc_dt::sc_uint_base"* nocapture readonly %this, i8* %xz_present_p) unnamed_addr #4 align 2 {
  %1 = icmp eq i8* %xz_present_p, null
  br i1 %1, label %3, label %2

; <label>:2                                       ; preds = %0
  store i8 0, i8* %xz_present_p, align 1, !tbaa !2
  br label %3

; <label>:3                                       ; preds = %0, %2
  %4 = tail call i32 @_ZNK5sc_dt12sc_uint_base6lengthEv(%"class.sc_dt::sc_uint_base"* %this)
  ret i32 %4
}

declare void @_ZN5sc_dt12sc_uint_base10concat_setExi(%"class.sc_dt::sc_uint_base"*, i64, i32) #1

declare void @_ZN5sc_dt12sc_uint_base10concat_setERKNS_9sc_signedEi(%"class.sc_dt::sc_uint_base"*, %"class.sc_dt::sc_signed"* dereferenceable(32), i32) #1

declare void @_ZN5sc_dt12sc_uint_base10concat_setERKNS_11sc_unsignedEi(%"class.sc_dt::sc_uint_base"*, %"class.sc_dt::sc_unsigned"* dereferenceable(32), i32) #1

declare void @_ZN5sc_dt12sc_uint_base10concat_setEyi(%"class.sc_dt::sc_uint_base"*, i64, i32) #1

; Function Attrs: inlinehint nounwind ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi2EED0Ev(%"class.sc_dt::sc_uint"* %this) unnamed_addr #8 align 2 {
  %1 = bitcast %"class.sc_dt::sc_uint"* %this to i8*
  tail call void @_ZdlPv(i8* %1) #10
  ret void
}

; Function Attrs: inlinehint nounwind ssp uwtable
define linkonce_odr void @_ZN5sc_dt13sc_value_baseC2Ev(%"class.sc_dt::sc_value_base"* nocapture %this) unnamed_addr #8 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_value_base", %"class.sc_dt::sc_value_base"* %this, i64 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([13 x i8*], [13 x i8*]* @_ZTVN5sc_dt13sc_value_baseE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %1, align 8, !tbaa !14
  ret void
}

; Function Attrs: ssp uwtable
define linkonce_odr void @_ZNK5sc_dt12sc_uint_base12check_lengthEv(%"class.sc_dt::sc_uint_base"* %this) #0 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 2
  %2 = load i32, i32* %1, align 8, !tbaa !16
  %.off = add i32 %2, -1
  %3 = icmp ugt i32 %.off, 63
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  tail call void @_ZNK5sc_dt12sc_uint_base14invalid_lengthEv(%"class.sc_dt::sc_uint_base"* nonnull %this)
  br label %5

; <label>:5                                       ; preds = %0, %4
  ret void
}

declare void @_ZNK5sc_dt12sc_uint_base14invalid_lengthEv(%"class.sc_dt::sc_uint_base"*) #1

; Function Attrs: nounwind readonly ssp uwtable
define linkonce_odr i32 @_ZNK5sc_dt12sc_uint_base6lengthEv(%"class.sc_dt::sc_uint_base"* nocapture readonly %this) #5 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 2
  %2 = load i32, i32* %1, align 8, !tbaa !16
  ret i32 %2
}

; Function Attrs: ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi8EEC2Ev(%"class.sc_dt::sc_uint.0"* %this) unnamed_addr #0 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint.0", %"class.sc_dt::sc_uint.0"* %this, i64 0, i32 0
  tail call void @_ZN5sc_dt12sc_uint_baseC2Ei(%"class.sc_dt::sc_uint_base"* %1, i32 8)
  %2 = getelementptr inbounds %"class.sc_dt::sc_uint.0", %"class.sc_dt::sc_uint.0"* %this, i64 0, i32 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([13 x i8*], [13 x i8*]* @_ZTVN5sc_dt7sc_uintILi8EEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %2, align 8, !tbaa !14
  ret void
}

; Function Attrs: inlinehint nounwind ssp uwtable
define linkonce_odr void @_ZN5sc_dt7sc_uintILi8EED0Ev(%"class.sc_dt::sc_uint.0"* %this) unnamed_addr #8 align 2 {
  %1 = bitcast %"class.sc_dt::sc_uint.0"* %this to i8*
  tail call void @_ZdlPv(i8* %1) #10
  ret void
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr dereferenceable(24) %"class.sc_dt::sc_uint_base"* @_ZN5sc_dt12sc_uint_baseaSEy(%"class.sc_dt::sc_uint_base"* %this, i64 %v) #4 align 2 {
  %1 = getelementptr inbounds %"class.sc_dt::sc_uint_base", %"class.sc_dt::sc_uint_base"* %this, i64 0, i32 1
  store i64 %v, i64* %1, align 8, !tbaa !9
  tail call void @_ZN5sc_dt12sc_uint_base11extend_signEv(%"class.sc_dt::sc_uint_base"* %this)
  ret %"class.sc_dt::sc_uint_base"* %this
}

; Function Attrs: ssp uwtable
define internal void @_GLOBAL__sub_I_dh_crossbar.cpp() #0 section "__TEXT,__StaticInit,regular,pure_instructions" {
  tail call fastcc void @__cxx_global_var_init()
  ret void
}

attributes #0 = { ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { inlinehint nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nobuiltin nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { inlinehint nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nounwind }
attributes #10 = { builtin nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 7.3.0 (clang-703.0.31)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"bool", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{i8 0, i8 2}
!7 = !{!8, !8, i64 0}
!8 = !{!"int", !4, i64 0}
!9 = !{!10, !11, i64 8}
!10 = !{!"_ZTSN5sc_dt12sc_uint_baseE", !11, i64 8, !8, i64 16, !8, i64 20}
!11 = !{!"long long", !4, i64 0}
!12 = !{!11, !11, i64 0}
!13 = !{!10, !8, i64 20}
!14 = !{!15, !15, i64 0}
!15 = !{!"vtable pointer", !5, i64 0}
!16 = !{!10, !8, i64 16}
