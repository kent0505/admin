import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/blog.dart';
import '../blog_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final _repository = BlogRepository();

  BlogBloc() : super(BlogInitial()) {
    on<AddBlogEvent>((event, emit) async {
      if (event.blog.title.isNotEmpty) {
        emit(BlogLoadingState());

        int? status = await _repository.addBlog(event.blog);

        if (status == 200) {
          emit(BlogSuccessState(Const.toastBlogAdded, status!));
        } else {
          print('error 1');
          print(status);
          emit(BlogErrorState(Const.toastError, status));
        }
      } else {
        print('error 2');
        emit(BlogErrorState(Const.toastNull, null));
      }
    });

    on<UpdateBlogEvent>((event, emit) async {
      if (event.blog.title.isNotEmpty) {
        emit(BlogLoadingState());

        int? status = await _repository.updateBlog(event.blog);

        if (status == 200) {
          emit(BlogSuccessState(Const.toastBlogUpdated, status!));
        } else {
          emit(BlogErrorState(Const.toastError, status));
        }
      } else {
        emit(BlogErrorState(Const.toastNull, null));
      }
    });

    on<DeleteBlogEvent>((event, emit) async {
      int? status = await _repository.deleteBlog(event.blog);

      if (status == 200) {
        emit(BlogSuccessState(Const.toastBlogDeleted, status!));
      } else {
        emit(BlogErrorState(Const.toastError, status));
      }
    });
  }
}
