import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
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
          emit(CategorySuccessState(Const.toastCategoryAdded, status!));
        } else {
          emit(CategoryErrorState(Const.toastError, status));
        }
      } else {
        emit(CategoryErrorState(Const.toastNull, null));
        emit(CategoryInitial());
      }
    });

    on<UpdateCategoryEvent>((event, emit) async {
      if (event.category.title.isNotEmpty) {
        emit(CategoryLoadingState());

        int? status = await _repository.updateCategory(event.category);

        if (status == 200) {
          emit(CategorySuccessState(Const.toastCategoryUpdated, status!));
        } else {
          emit(CategoryErrorState(Const.toastError, status));
        }
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      int? status = await _repository.deleteCategory(event.category);

      if (status == 200) {
        emit(CategorySuccessState(Const.toastCategoryDeleted, status!));
      } else {
        emit(CategoryErrorState(Const.toastError, status));
      }
    });
  }
}
