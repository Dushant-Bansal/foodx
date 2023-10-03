part of 'shop_bloc.dart';

abstract class ShopEvent {
  const ShopEvent();
}

class ShopFetch extends ShopEvent {
  const ShopFetch();
}

class ShopSearch extends ShopEvent {
  const ShopSearch(this.search);

  final String search;
}

class ShopRemove extends ShopEvent {
  const ShopRemove(this.id);

  final String id;
}
