import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/router/constants.dart';
import 'package:go_router/go_router.dart';

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);

  void update(int index) {
    emit(index);
    shellNavigatorKey.currentContext?.go(routes[index]);
  }
}
