import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabCategoryState()) {
    on<ChangeTabEvent>((event, emit) {
      if (event.index == 0) {
        emit(TabCategoryState());
      } else if (event.index == 1) {
        emit(TabBlogState());
      } else {
        emit(TabContentState());
      }
    });
  }
}
