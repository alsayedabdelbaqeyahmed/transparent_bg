import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remove_bg/cobtroller/image_bloc/pick_image_cubit.dart';
import 'package:remove_bg/cobtroller/image_bloc/pick_image_state.dart';
import 'package:remove_bg/model/constants/app_string_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerCubit, ImagePickerState>(
        listener: (context, state) {},
        builder: (ctx, state) {
          final cubit = ImagePickerCubit.get(ctx);
          return LayoutBuilder(
            builder: (context, size) => SingleChildScrollView(
              child: Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (cubit.selectedImage == null) {
                          cubit.selectThesourceofImage(context, size);
                          cubit.pickImage();
                        } else {
                          cubit.uploadImage(cubit.selectedImage!);
                        }
                      },
                      child: cubit.selectedImage == null
                          ? const Text(AppStringConstants.selectTheIamge)
                          : const Text(AppStringConstants.upload),
                    ),
                    SizedBox(
                      child: Image.file(cubit.selectedImage!),
                    ),
                    SizedBox(
                      child: Image.memory(cubit.uploadedImage!),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
