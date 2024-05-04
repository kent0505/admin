import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/blog.dart';
import '../../../../core/models/category.dart';
import '../../../../core/models/content.dart';
import '../../home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _repository = HomeRepository();

  late List<Category> categories;
  late List<Blog> blogs;
  late List<Content> contents;

  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeEvent>((event, emit) async {
      log('LOAD HOME EVENT');
      emit(HomeLoadingState());

      HomeResult result1 = await _repository.fetchCategories();
      HomeResult result2 = await _repository.fetchBlogs();
      HomeResult result3 = await _repository.fetchContents();

      final successResults = result1 is HomeCategoriesResult &&
          result2 is HomeBlogsResult &&
          result3 is HomeContentsResult;

      if (successResults) {
        categories = result1.categories;
        blogs = result2.blogs;
        contents = result3.contents;

        emit(HomeLoadedState(
          categories: categories,
          blogs: blogs,
          contents: contents,
        ));
      } else if (result1 is HomeErrorResult) {
        emit(HomeErrorState());
      } else {
        emit(HomeErrorState());
      }
    });
  }
}
