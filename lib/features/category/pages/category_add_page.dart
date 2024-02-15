import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/category.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/category_bloc.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({super.key});

  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

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
                  title: Const.buttonAddText,
                  loading: state is CategoryLoadingState,
                  onTap: () async {
                    context.read<CategoryBloc>().add(AddCategoryEvent(
                          Category(
                            id: 0,
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
