part of 'shop_bloc.dart';

abstract class ShopState {
  const ShopState();
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class ShopLoading extends ShopState {
  const ShopLoading();
}

class ShopLoaded extends ShopState {
  const ShopLoaded(this.products, {this.search = ''});

  final List<Product>? products;
  final String search;
}

class ShopFailure extends ShopState {
  const ShopFailure(this.exception);

  final Exception exception;
}
