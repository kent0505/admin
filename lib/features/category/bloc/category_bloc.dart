import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/category.dart';
import '../category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final _repository = CategoryRepository();

  CategoryBloc() : super(CategoryInitial()) {
    on<AddCategoryEvent>((event, emit) async {
      if (event.category.title.isNotEmpty) {
        emit(CategoryLoadingState());

        int? status = await _repository.addCategory(event.category);

        if (status == 200) {
          emit(CategorySuccessState());
        } else {
          emit(CategoryErrorState());
        }
      } else {
        emit(CategoryErrorState());
        emit(CategoryInitial());
      }
    });

    on<UpdateCategoryEvent>((event, emit) async {
      if (event.category.title.isNotEmpty) {
        emit(CategoryLoadingState());

        int? status = await _repository.updateCategory(event.category);

        if (status == 200) {
          emit(CategorySuccessState());
        } else {
          emit(CategoryErrorState());
        }
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      int? status = await _repository.deleteCategory(event.id);

      if (status == 200) {
        emit(CategorySuccessState());
      } else {
        emit(CategoryErrorState());
      }
    });
  }
}
