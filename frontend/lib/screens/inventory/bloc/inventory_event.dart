part of 'inventory_bloc.dart';

abstract class InventoryEvent {
  const InventoryEvent();
}

class InventoryFetch extends InventoryEvent {
  const InventoryFetch({
    this.isShop,
    this.status,
    this.name,
    this.id,
    this.isSpace,
    this.spaceId,
  });

  final bool? isShop;
  final Status? status;
  final String? name;
  final String? id;
  final bool? isSpace;
  final String? spaceId;
}

class InventorySearch extends InventoryEvent {
  const InventorySearch(this.search);

  final String search;
}

class InventoryProductUpdate extends InventoryEvent {
  const InventoryProductUpdate(
    this.updatedProduct, {
    this.showSnackbar = false,
  });

  final Product updatedProduct;
  final bool showSnackbar;
}

class InventoryProductRemove extends InventoryEvent {
  const InventoryProductRemove(this.id);

  final String id;
}
