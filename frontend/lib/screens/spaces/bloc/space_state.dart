part of 'space_bloc.dart';

abstract class SpaceState {
  const SpaceState();
}

class SpaceInitial extends SpaceState {
  const SpaceInitial();
}

class SpaceLoading extends SpaceState {
  const SpaceLoading();
}

class SpaceLoaded extends SpaceState {
  const SpaceLoaded(this.spaces);

  final List<Space> spaces;
}

class SpaceFailure extends SpaceState {
  const SpaceFailure(this.exception);

  final Exception exception;
}
