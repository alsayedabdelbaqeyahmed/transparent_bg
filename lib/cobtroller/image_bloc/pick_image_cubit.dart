import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remove_bg/cobtroller/image_bloc/pick_image_state.dart';
import 'package:remove_bg/model/constants/app_string_constants.dart';
import 'package:remove_bg/model/dio_helper.dart/di_helper.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitState());

  static ImagePickerCubit get(context) => BlocProvider.of(context);

  File? selectedImage;
  String? sourceofImage;
  Uint8List? uploadedImage;
  final picker = ImagePicker();
  bool? isTaking = false;
  bool? isFinished = false;

  Future selectThesourceofImage(BuildContext context, BoxConstraints size) {
    return AwesomeDialog(
      padding: const EdgeInsets.all(10),
      context: context,
      dialogType: DialogType.QUESTION,
      body: Column(children: [
        Text(
          'select the source Image',
          style:
              TextStyle(color: Colors.black, fontSize: size.maxHeight * 0.02),
        ),
        SizedBox(height: size.maxHeight * 0.005),
        Text(
          AppStringConstants.choseSource,
          style: TextStyle(color: Colors.red, fontSize: size.maxHeight * 0.025),
        ),
      ]),
      btnOkText: AppStringConstants.camera,
      btnOkOnPress: () {
        emit(SelectThesourceofImage());
        return sourceofImage = AppStringConstants.camera;
      },
      btnCancelText: AppStringConstants.gallery,
      btnCancelOnPress: () {
        emit(SelectThesourceofImage());
        return sourceofImage = AppStringConstants.gallery;
      },
    ).show();
  }

  Future pickImage() async {
    final pickedImage = await picker.pickImage(
      source: sourceofImage == AppStringConstants.camera.trim()
          ? ImageSource.camera
          : sourceofImage == AppStringConstants.gallery.trim()
              ? ImageSource.gallery
              : ImageSource.camera,
    );
    if (pickedImage == null) {
      emit(ImagePickerTakeImage());
      return;
    }
    emit(ImagePickerTakeImage());
    return selectedImage = File(pickedImage.path);
  }

  Future uploadImage(File path) async {
    final responce = await DioHelper.uploadedImage(path);
    uploadedImage = responce.data;
    emit(ImagePickerUploadImage());
  }
}
