part of 'product_bloc.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductFetched extends ProductState {
  const ProductFetched(this.details);

  final Map<String, dynamic> details;
}

class ProductUploaded extends ProductState {
  const ProductUploaded();
}

class ProductFailure extends ProductState {
  const ProductFailure(this.exception);

  final Exception exception;
}
