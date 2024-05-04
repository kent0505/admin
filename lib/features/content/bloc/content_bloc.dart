import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/content.dart';
import '../content_repository.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final _repository = ContentRepository();

  ContentBloc() : super(ContentInitial()) {
    on<AddContentEvent>((event, emit) async {
      if (event.content.title.isNotEmpty) {
        emit(ContentLoadingState());

        int? status = await _repository.addContent(event.content);

        if (status == 200) {
          emit(ContentSuccessState());
        } else {
          emit(ContentErrorState());
        }
      } else {
        emit(ContentErrorState());
      }
    });

    on<UpdateContentEvent>((event, emit) async {
      if (event.content.title.isNotEmpty) {
        emit(ContentLoadingState());

        int? status = await _repository.updateContent(event.content);

        if (status == 200) {
          emit(ContentSuccessState());
        } else {
          emit(ContentErrorState());
        }
      } else {
        emit(ContentErrorState());
      }
    });

    on<DeleteContentEvent>((event, emit) async {
      int? status = await _repository.deleteContent(event.content);

      if (status == 200) {
        emit(ContentSuccessState());
      } else {
        emit(ContentErrorState());
      }
    });
  }
}
