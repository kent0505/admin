import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/category.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/delete_button.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/category_bloc.dart';

class CategoryUpdatePage extends StatefulWidget {
  const CategoryUpdatePage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryUpdatePage> createState() => _CategoryUpdatePageState();
}

class _CategoryUpdatePageState extends State<CategoryUpdatePage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller1.text = widget.category.title;
    _controller2.text = widget.category.index.toString();
    _controller3.text = widget.category.type.toString();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        actions: [
          DeleteButton(
            title: Const.alertDeleteCategory,
            onPressed: () {
              context
                  .read<CategoryBloc>()
                  .add(DeleteCategoryEvent(widget.category));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFieldWidget(
            controller: _controller1,
            hintText: 'Title',
            isTitle: true,
          ),
          TextFieldWidget(
            controller: _controller2,
            hintText: 'Index',
          ),
          TextFieldWidget(
            controller: _controller3,
            hintText: 'Type',
          ),
          const SizedBox(height: 20),
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategorySuccessState) {
                context.pop();
                context
                    .read<HomeBloc>()
                    .add(LoadHomeEvent(state.message, state.status));
              }

              if (state is CategoryErrorState) {
                Utils.showToast(context, state.message, state.status, true);
              }
            },
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return SaveButton(
                  title: Const.buttonUpdateText,
                  loading: state is CategoryLoadingState,
                  onTap: () async {
                    context.read<CategoryBloc>().add(UpdateCategoryEvent(
                          Category(
                            id: widget.category.id,
                            title: _controller1.text,
                            index: int.tryParse(_controller2.text) ?? 0,
                            type: int.tryParse(_controller3.text) ?? 0,
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
