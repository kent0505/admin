part of 'category_bloc.dart';

abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final Category category;
  AddCategoryEvent(this.category);
}

class UpdateCategoryEvent extends CategoryEvent {
  final Category category;
  UpdateCategoryEvent(this.category);
}

class DeleteCategoryEvent extends CategoryEvent {
  final Category category;
  DeleteCategoryEvent(this.category);
}
