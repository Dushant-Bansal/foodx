import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/product/product_repository.dart';
import 'package:food_x/styles/snack_bar.dart';
import '../shop_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  List<Product>? products;

  ShopBloc() : super(const ShopInitial()) {
    on<ShopFetch>((event, emit) async {
      emit(const ShopLoading());
      try {
        products = await ShopRepository.instance.getProducts();
        emit(ShopLoaded(products));
      } on Exception catch (e) {
        emit(ShopFailure(e));
      }
    });
    on<ShopSearch>((event, emit) {
      emit(const ShopLoading());
      try {
        final filteredProducts = products
            ?.where(
                (product) => product.name.toLowerCase().contains(event.search))
            .toList();
        emit(ShopLoaded(filteredProducts, search: event.search));
      } on Exception catch (e) {
        emit(ShopFailure(e));
      }
    });
    on<ShopRemove>((event, emit) async {
      emit(const ShopLoading());
      try {
        if (products == null) return;
        final idx = products!.indexWhere((product) => product.id == event.id);
        await ProductRepository.instance
            .update(products![idx].copyWith(isShop: false));
        final product = products!.removeAt(idx);
        showSuccessSnackBar('${product.name} removed from Shopping List.');
        emit(ShopLoaded(products));
      } on Exception catch (e) {
        showErrorSnackBar('Error removing product. Please try again.');
        emit(ShopFailure(e));
      }
    });
  }
}
