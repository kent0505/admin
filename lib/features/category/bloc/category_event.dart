part of 'category_bloc.dart';

abstract class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  AddCategoryEvent({required this.category});
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  UpdateCategoryEvent({required this.category});
}

class DeleteCategoryEvent extends CategoryEvent {
  final int id;
  DeleteCategoryEvent({required this.id});
}
