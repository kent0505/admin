import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/blog.dart';
import '../blog_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final _repository = BlogRepository();

  BlogBloc() : super(BlogInitial()) {
    on<AddBlogEvent>((event, emit) async {
      final filled = event.blog.title.isNotEmpty &&
          event.blog.index.isNotEmpty &&
          event.blog.cid.isNotEmpty;

      if (filled) {
        emit(BlogLoadingState());

        int? status = await _repository.addBlog(event.blog);

        if (status == 200) {
          emit(BlogSuccessState());
        } else {
          emit(BlogErrorState());
        }
      } else {
        emit(BlogErrorState());
      }
    });

    on<UpdateBlogEvent>((event, emit) async {
      final filled = event.blog.title.isNotEmpty &&
          event.blog.index.isNotEmpty &&
          event.blog.cid.isNotEmpty;

      if (filled) {
        emit(BlogLoadingState());

        int? status = await _repository.updateBlog(event.blog);

        if (status == 200) {
          emit(BlogSuccessState());
        } else {
          emit(BlogErrorState());
        }
      } else {
        emit(BlogErrorState());
      }
    });

    on<DeleteBlogEvent>((event, emit) async {
      int? status = await _repository.deleteBlog(event.id);

      if (status == 200) {
        emit(BlogSuccessState());
      } else {
        emit(BlogErrorState());
      }
    });
  }
}
