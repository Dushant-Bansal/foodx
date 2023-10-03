part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeProductSuccess extends HomeState {
  const HomeProductSuccess({this.barCode, required this.mode});

  final String? barCode;
  final Mode mode;
}

class HomeProductFailure extends HomeState {
  const HomeProductFailure();
}
