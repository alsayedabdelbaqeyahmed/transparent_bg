import 'dart:io';

import 'package:dio/dio.dart';
import 'package:remove_bg/model/constants/app_api_constants.dart';
import 'package:remove_bg/model/constants/app_string_constants.dart';

class DioHelper {
  static Dio? _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future uploadedImage(File path) async {
    final fileName = path.path.split("/").last;

    FormData data = FormData.fromMap({
      AppStringConstants.sourceImageFile:
          await MultipartFile.fromFile(path.path, filename: fileName),
    });
    await _dio!.post(
      AppApiConstants.apiPath,
      data: data,
      options: Options(
        headers: {
          AppStringConstants.apiKey: AppApiConstants.apiKey,
        },
        responseType: ResponseType.bytes,
      ),
    );
  }
}
