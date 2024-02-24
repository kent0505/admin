part of 'category_bloc.dart';

abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  AddCategoryEvent(this.category);
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  UpdateCategoryEvent(this.category);
}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;
  DeleteCategoryEvent(this.id);
}
