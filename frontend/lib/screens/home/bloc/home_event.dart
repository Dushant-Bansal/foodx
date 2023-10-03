part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeAddProduct extends HomeEvent {
  const HomeAddProduct(this.mode);

  final Mode mode;
}
