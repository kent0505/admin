import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/models/blog.dart';
import '../../../../core/models/category.dart';
import '../../../../core/models/content.dart';
import '../../../../core/network/result.dart';
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
      print('LOAD DATA');
      emit(HomeLoadingState());

      Result result1 = await _repository.fetchCategories();
      Result result2 = await _repository.fetchBlogs();
      Result result3 = await _repository.fetchContents();

      final successResults = result1 is CategoriesResult &&
          result2 is BlogsResult &&
          result3 is ContentsResult;

      if (successResults) {
        categories = result1.categories;
        blogs = result2.blogs;
        contents = result3.contents;

        emit(HomeLoadedState(
          categories,
          blogs,
          contents,
          event.message,
          200,
        ));
      } else if (result1 is ErrorResult) {
        emit(HomeErrorState(Const.toastError, result1.status));
      } else {
        emit(HomeErrorState(Const.toastError, 500));
      }
    });
  }
}
