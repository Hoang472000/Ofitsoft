import 'dart:async';
import 'package:diary_mobile/data/entity/setting/user_info.dart';
import 'package:diary_mobile/utils/constans/status_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/image/image_entity.dart';
import '../../../data/remote_data/object_model/object_result.dart';
import '../../../data/repository.dart';
import '../../../resource/assets.dart';
import '../../../utils/extenstion/extenstions.dart';
import '../../../utils/extenstion/input_register_model.dart';
import '../../../utils/extenstion/service_info_extension.dart';
import '../../../utils/form_submission_status.dart';
import '../../../utils/utils.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  final Repository repository;

  AccountInformationBloc(this.repository) : super(AccountInformationState()) {
    on<InitInfoEvent>(_initInfo);
    on<ChangeEditInfoEvent>(_changeEditInfo);
    on<ChangeDetailInfoEvent>(_changeDetailInfo);
    on<OnSelectValueEvent>(_onSelectValue);
    on<AddOrDeleteImageEvent>(_addOrDeleteImage);
    on<UpdateInfoEvent>(_updateInfo);
    add(InitInfoEvent(false));
  }

  bool edit = false;

  void _initView(Emitter<AccountInformationState> emitter) {
    List<InputRegisterModel> list = [];
    list.add(InputRegisterModel<String, String>(
        title: "Họ và tên:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.nameController,
        image: ImageAsset.imageFarmerProfile));
    list.add(InputRegisterModel(
        title: "Giới tính:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.genderController,
        image: ImageAsset.imageSex));
    list.add(InputRegisterModel(
        title: "Ngày sinh:",
        isCompulsory: false,
        typeInputEnum: TypeInputEnum.date,
        type: TypeInputRegister.Non,
        controller: state.dateController,
        icon: Icons.calendar_today,
        image: ImageAsset.imageCalendarPick));
    list.add(InputRegisterModel(
        title: "Địa chỉ:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.addressController,
        image: ImageAsset.imageLocation));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Trạng thái hoạt động:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.statusController,
        image: ImageAsset.imageStatus));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Vai trò:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.mainController,
        image: ImageAsset.imageCollaboration));
    emitter(state.copyWith(listWidget: list));
  }

  void _changeViewEdit(Emitter<AccountInformationState> emitter) {
    List<InputRegisterModel> list = [];
    list.add(InputRegisterModel<String, String>(
        title: "Họ và tên:",
        isCompulsory: false,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.nameController,
        image: ImageAsset.imageFarmerProfile));
    list.add(InputRegisterModel(
        title: "Giới tính:",
        isCompulsory: false,
        type: TypeInputRegister.Select,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        valueSelected: state.listGender[state.indexSex],
        listValue: state.listGender,
        icon: Icons.arrow_drop_down,
        image: ImageAsset.imageSex));
    if(state.dateController!.text.isNotEmpty) {
      list.add(InputRegisterModel(
          title: "Ngày sinh:",
          isCompulsory: false,
          typeInputEnum: TypeInputEnum.date,
          type: TypeInputRegister.Select,
          valueSelected: Utils.stringToDate(state.dateController!.text),
          icon: Icons.calendar_today,
          image: ImageAsset.imageCalendarPick));
    } else{
      list.add(InputRegisterModel(
          title: "Ngày sinh:",
          isCompulsory: false,
          typeInputEnum: TypeInputEnum.date,
          type: TypeInputRegister.Select,
          //valueSelected: Utils.stringToDate(state.dateController!.text),
          icon: Icons.calendar_today,
          image: ImageAsset.imageCalendarPick));
    }
    list.add(InputRegisterModel(
        title: "Địa chỉ:",
        isCompulsory: false,
        type: TypeInputRegister.TextField,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.addressController,
        image: ImageAsset.imageLocation));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Trạng thái hoạt động:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.statusController,
        image: ImageAsset.imageStatus));

    list.add(InputRegisterModel<String, DateTime>(
        title: "Vai trò:",
        isCompulsory: false,
        type: TypeInputRegister.Non,
        typeInput: TextInputType.text,
        maxLengthTextInput: 200,
        controller: state.mainController,
        image: ImageAsset.imageCollaboration));

    emitter(state.copyWith(listWidget: list));
  }

  void _initInfo(
      InitInfoEvent event, Emitter<AccountInformationState> emitter) async {
    UserInfo userInfo;
    if(event.resetView){
      emitter(state.copyWith(isShowProgress: true));
      userInfo = UserInfo.copy(state.userInfo ?? UserInfo());
    }else {
      emitter(state.copyWith(
          isShowProgress: true, listWidget: [], userInfo: UserInfo()));
      userInfo = await repository.getUserInfo();
    }
    //UserInfo userInfo = await repository.getUserInfo();
    List<Gender> listGender = [Gender("Nam"), Gender("Nữ"), Gender("Khác")];
    int index = listGender
        .indexWhere((element) => element.name == userInfo.gender);
    print("HoangCV: ${userInfo.mediaContent}");
    emitter(state.copyWith(
      isShowProgress: false,
      userInfo: userInfo,
      listGender: listGender,
      indexSex: index,
      nameController: TextEditingController(text: userInfo.name),
      genderController: TextEditingController(text: userInfo.gender),
      dateController: TextEditingController(
          text: Utils.formatDate(userInfo.dateOfBirth??'')),
      addressController: TextEditingController(text: userInfo.address),
      statusController: TextEditingController(text: userInfo.active ?? true ? "Đang hoạt động": "Ngưng hoạt động"),
      mainController: TextEditingController(text: userInfo.group),
    ));
    print("HoangCV: media content: ${userInfo.mediaContent}");
    _initView(emitter);

    emitter(state.copyWith(listWidget: state.listWidget));
  }

  FutureOr<void> _changeEditInfo(
      ChangeEditInfoEvent event, Emitter<AccountInformationState> emit) async {
    _changeViewEdit(emit);
  }

  FutureOr<void> _changeDetailInfo(ChangeDetailInfoEvent event,
      Emitter<AccountInformationState> emit) async {
    if(event.resetView){

    }
    _initView(emit);

  }

  Future<FutureOr<void>> _onSelectValue(
      OnSelectValueEvent event, Emitter<AccountInformationState> emit) async {
    int result;
/*    if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucTinh && dMucTinhResponse.tinh == null) {
      Toast.showLongTop("Không có danh mục tỉnh");
      return;
    }else if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucHuyen && dMucHuyenResponse.dmucHuyenTPS == null) {
      Toast.showLongTop("Không có danh mục huyện");
      return;
    }else if(inputRegisterModel.typeInputEnum == TypeInputEnum.dmucXa && dMucXaResponse.dmucXaTPS == null) {
      Toast.showLongTop("Không có danh mục xã");
      return;
    }*/
    if (event.list[event.index].valueSelected.runtimeType == DateTime ||
        event.list[event.index].typeInputEnum == TypeInputEnum.date) {
      int result1 = await ServiceInfoExtension()
          .selectValue(event.list[event.index], event.context, (modelInput) {});
      print(
          "HoangCV: result1: ${result1} : ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)}");
      if (result1 == 1) {
        if (event.list[event.index].title.compareTo("Ngày sinh:") == 0) {
          print(
              "HoangCV:1 event.list[event.index].valueSelected: ${Utils.formatDateTimeToString(event.list[event.index].valueSelected)}");
          emit(state.copyWith(
            dateController: TextEditingController(
                text: Utils.formatDateTimeToString(
                    event.list[event.index].valueSelected)),
          ));
        }
      }
    } else {
      result = await Extension().showBottomSheetSelection(
          event.context,
          event.list[event.index].listValue,
          event.list[event.index].positionSelected,
          "${event.list[event.index].title}",
          hasSearch: event.list[event.index].hasSearch ?? false);
      if (result != -1) {
        event.list[event.index].positionSelected = result;
        event.list[event.index].valueDefault = null;
        event.list[event.index].valueSelected =
            event.list[event.index].listValue[result];
        event.list[event.index].error = null;
        if (event.list[event.index].title.compareTo("Giới tính:") == 0) {
          emit(state.copyWith(
              genderController: TextEditingController(text: event.list[event.index].valueSelected.name),
              indexSex: result));
        }
      }
    }
  }

  FutureOr<void> _addOrDeleteImage(AddOrDeleteImageEvent event,
      Emitter<AccountInformationState> emit) async {
    print("HoangCV: event. image: ${event.listImage.length}");
    //List<ImageEntity> list = List.from(state.listImage);
    List<ImageEntity> list = [];
    list.addAll(event.listImage);
    UserInfo? userInfo = state.userInfo;
    userInfo!.mediaContent = list[0].fileContent;
    emit(state.copyWith(listImage: list, userInfo: userInfo));
  }

  FutureOr<void> _updateInfo(UpdateInfoEvent event, Emitter<AccountInformationState> emit) async{
    print("HoangCV: state.indexActivity: ${state.nameController!.text}");
    emit(state.copyWith(
      isShowProgress: true,
    ));
    bool validate = true;
   if(state.nameController!.text.isEmpty){
      validate = false;
      state.listWidget[0].error = "Vui lòng nhập họ và tên";
    }

    if (!validate) {
      emit(state.copyWith(isShowProgress: false));
    } else {
    UserInfo userInfo = UserInfo(
      id: state.userInfo?.id,
      name: state.nameController?.text,
      login: state.userInfo?.login,
      gender: state.genderController?.text,
      dateOfBirth: state.dateController?.text,
      address: state.addressController?.text,
      active: true,
      group: state.userInfo?.group, language: state.userInfo?.language,
      mediaContent: state.listImage.isNotEmpty ? state.listImage[0].fileContent : '',
    );
    ObjectResult objectResult = await repository.updateUserInfo(userInfo);
      if (objectResult.responseCode == StatusConst.code00) {
        _initView(emit);
      }
      if (objectResult.responseCode == StatusConst.code00) {
        //_changeViewDetail(emit);
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionSuccess(success: objectResult.message)));
      } else if (objectResult.responseCode == StatusConst.code01) {
        emit(state.copyWith(
            isShowProgress: false,
            formStatus: SubmissionFailed(objectResult.message)));
      }
    }
  }
}

class AccountInformationEvent extends BlocEvent {
  @override
  List<Object?> get props => [];
}

class InitInfoEvent extends AccountInformationEvent {
  InitInfoEvent(this.resetView);
  bool resetView;
  @override
  List<Object?> get props => [resetView];
}

class ChangeEditInfoEvent extends AccountInformationEvent {
  ChangeEditInfoEvent();
}

class ChangeDetailInfoEvent extends AccountInformationEvent {
  bool resetView;
  ChangeDetailInfoEvent(this.resetView);
  @override
  List<Object?> get props => [resetView];
}

class UpdateInfoEvent extends AccountInformationEvent {
  UpdateInfoEvent();
}


class OnSelectValueEvent extends AccountInformationEvent {
  List<InputRegisterModel> list;
  int index;
  BuildContext context;

  OnSelectValueEvent(this.list, this.index, this.context);

  @override
  List<Object?> get props => [list, index, context];
}

class AddOrDeleteImageEvent extends AccountInformationEvent {
  final List<ImageEntity> listImage;
  final BuildContext context;

  AddOrDeleteImageEvent(this.listImage, this.context);

  @override
  List<Object?> get props => [listImage, context];
}

class UpdateAvatarEvent extends AccountInformationEvent {
  //final ImageSource source;
  UpdateAvatarEvent();
}

class AccountInformationState extends BlocState {
  @override
  List<Object?> get props => [
        formStatus,
        isShowProgress,
        listGender,
        listWidget,
        listImage,
        nameController,
        isEdit,
        genderController,
        addressController,
        statusController,
        mainController,
        dateController,
        indexSex,
      ];
  final FormSubmissionStatus formStatus;
  final bool isShowProgress;
  UserInfo? userInfo;
  List<InputRegisterModel> listWidget;
  List<ImageEntity> listImage = [];
  TextEditingController? nameController = TextEditingController();
  TextEditingController? genderController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? statusController = TextEditingController();
  TextEditingController? mainController = TextEditingController();
  TextEditingController? dateController = TextEditingController();
  bool isEdit;
  List<Gender> listGender;
  int indexSex;

  AccountInformationState(
      {this.formStatus = const InitialFormStatus(),
      this.isShowProgress = true,
      this.userInfo,
      this.listGender = const [],
      this.listWidget = const [],
      this.listImage = const [],
      this.dateController,
      this.mainController,
      this.addressController,
      this.nameController,
      this.genderController,
      this.statusController,
      this.indexSex = 0,
      this.isEdit = false});

  AccountInformationState copyWith({
    FormSubmissionStatus? formStatus,
    UserInfo? userInfo,
    bool? isShowProgress,
    List<Gender>? listGender,
    List<InputRegisterModel>? listWidget,
    List<ImageEntity>? listImage,
    TextEditingController? nameController,
    TextEditingController? genderController,
    TextEditingController? addressController,
    TextEditingController? statusController,
    TextEditingController? mainController,
    TextEditingController? dateController,
    bool? isEdit,
    int? indexSex,
    double? imageWidth,
    double? imageHeight,
  }) {
    return AccountInformationState(
        formStatus: formStatus ?? this.formStatus,
        isShowProgress: isShowProgress ?? this.isShowProgress,
        userInfo: userInfo ?? this.userInfo,
        listGender: listGender ?? this.listGender,
        listWidget: listWidget ?? this.listWidget,
        listImage: listImage ?? this.listImage,
        nameController: nameController ?? this.nameController,
        genderController: genderController ?? this.genderController,
        addressController: addressController ?? this.addressController,
        statusController: statusController ?? this.statusController,
        mainController: mainController ?? this.mainController,
        dateController: dateController ?? this.dateController,
        indexSex: indexSex ?? this.indexSex,
        isEdit: isEdit ?? this.isEdit);
  }
}

class Gender{
  String name;
  String image;
  Gender(this.name, {this.image = ''});
}
