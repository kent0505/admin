import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/category.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/dropdown/dropdown_type.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/category_bloc.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({super.key});

  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFieldWidget(
            controller: controller1,
            hintText: 'Title',
            isTitle: true,
          ),
          TextFieldWidget(
            controller: controller2,
            hintText: 'Index',
          ),
          DropdownType(controller: controller3),
          const SizedBox(height: 20),
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategorySuccessState) {
                context.pop();
                context.read<HomeBloc>().add(LoadHomeEvent());
              }
              if (state is CategoryErrorState) {
                showToast(context, 'CategoryErrorState', true);
              }
            },
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return SaveButton(
                  title: Const.buttonAddText,
                  loading: state is CategoryLoadingState,
                  onTap: () {
                    context.read<CategoryBloc>().add(AddCategoryEvent(
                          CategoryModel(
                            title: controller1.text,
                            index: controller2.text,
                            type: controller3.text,
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
