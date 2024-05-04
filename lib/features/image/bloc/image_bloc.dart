import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/content.dart';
import '../../../core/utils.dart';
import '../../content/content_repository.dart';
import '../image_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  File? image;
  String? fileName;
  final _repository = ImageRepository();
  final _contentRepository = ContentRepository();

  ImageBloc() : super(ImageInitial()) {
    on<RemoveImageEvent>((event, emit) async {
      if (image != null) {
        print('REMOVE IMAGE EVENT');
        image = null;
        await Future.delayed(const Duration(milliseconds: 600), () {
          print('IMAGE REMOVED');
          emit(ImageInitial());
        });
      } else {
        print('IMAGE NULL');
      }
    });

    on<PickImageEvent>((event, emit) async {
      final file = await pickImage();

      if (file != null) {
        final croppedFile = await cropImage(file.path);

        if (croppedFile != null) {
          image = File(croppedFile.path);
          fileName = file.name;
          emit(ImagePickedState(image!));
        } else {
          image = File(file.path);
          fileName = file.name;
          emit(ImagePickedState(image!));
        }
      } else {
        emit(ImageInitial());
      }
    });

    on<UploadImageEvent>((event, emit) async {
      if (state is ImagePickedState) {
        emit(ImageLoadingState(image!));

        int? status = await _repository.uploadImage(
          image!,
          fileName!,
          event.content,
        );

        image = null;

        if (status == 200) {
          emit(ImageSuccessState());
        } else {
          emit(ImageErrorState());
        }
      } else {
        emit(ImageErrorState());
      }
    });

    on<UpdateImageEvent>((event, emit) async {
      if (state is ImagePickedState) {
        int? status = await _repository.updateImage(
          image!,
          fileName!,
          event.content,
        );

        image = null;

        if (status == 200) {
          emit(ImageSuccessState());
        } else {
          emit(ImageErrorState());
        }
      } else {
        int? status = await _contentRepository.updateContent(event.content);

        if (status == 200) {
          emit(ImageSuccessState());
        } else {
          emit(ImageErrorState());
        }
      }
    });

    on<DeleteImageEvent>((event, emit) async {
      int? status = await _contentRepository.deleteContent(event.content);

      if (status == 200) {
        emit(ImageSuccessState());
      } else {
        emit(ImageErrorState());
      }
    });
  }
}
