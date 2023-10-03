part of 'inventory_bloc.dart';

abstract class InventoryState {
  const InventoryState();
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState {
  const InventoryLoading();
}

class InventoryLoaded extends InventoryState {
  const InventoryLoaded(this.products, {this.search = ''});

  final List<Product>? products;
  final String search;
}

class InventoryFailure extends InventoryState {
  const InventoryFailure(this.exception);

  final Exception exception;
}
