part of 'space_bloc.dart';

abstract class SpaceEvent {
  const SpaceEvent();
}

class SpaceCreate extends SpaceEvent {
  const SpaceCreate({required this.name, this.description});

  final String name;
  final String? description;
}

class SpaceFetch extends SpaceEvent {
  const SpaceFetch();
}

class SpaceUpdateProduct extends SpaceEvent {
  const SpaceUpdateProduct(this.spaceId, this.productId, {this.remove = false});

  final String spaceId;
  final String productId;
  final bool remove;
}

class SpaceInviteUser extends SpaceEvent {
  const SpaceInviteUser(this.spaceId, this.by, this.role);

  final String spaceId;
  final String by;
  final String role;
}

class SpaceAddUser extends SpaceEvent {
  const SpaceAddUser(this.spaceId, this.role);

  final String spaceId;
  final String role;
}
