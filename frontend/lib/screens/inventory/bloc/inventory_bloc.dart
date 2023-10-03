import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/product/product_repository.dart';
import 'package:food_x/styles/snack_bar.dart';
import '../inventory_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List<Product>? products;

  InventoryBloc() : super(const InventoryInitial()) {
    on<InventoryFetch>((event, emit) async {
      emit(const InventoryLoading());
      try {
        products = await InventoryRepository.instance.getProducts(
          isShop: event.isShop,
          status: event.status,
          name: event.name,
          id: event.id,
          isSpace: event.isSpace,
          spaceId: event.spaceId,
        );
        emit(InventoryLoaded(products));
      } on Exception catch (e) {
        emit(InventoryFailure(e));
      }
    });
    on<InventorySearch>((event, emit) {
      emit(const InventoryLoading());
      try {
        final filteredProducts = products
            ?.where(
                (product) => product.name.toLowerCase().contains(event.search))
            .toList();
        emit(InventoryLoaded(filteredProducts, search: event.search));
      } on Exception catch (e) {
        emit(InventoryFailure(e));
      }
    });
    on<InventoryProductUpdate>((event, emit) async {
      emit(const InventoryLoading());
      try {
        if (products == null) return;
        await ProductRepository.instance.update(event.updatedProduct);
        final idx = products!
            .indexWhere((product) => product.id == event.updatedProduct.id);
        products![idx] = event.updatedProduct;
        if (event.showSnackbar) {
          showSuccessSnackBar(
              '${event.updatedProduct.name} updated successfully!');
        }
        emit(InventoryLoaded(products));
      } on Exception catch (e) {
        showErrorSnackBar('Error updating product. Please try again.');
        emit(InventoryFailure(e));
      }
    });
    on<InventoryProductRemove>((event, emit) async {
      try {
        if (products == null) return;
        await ProductRepository.instance.delete(event.id);
        final idx = products!.indexWhere((product) => product.id == event.id);
        final product = products!.removeAt(idx);
        showSuccessSnackBar('${product.name} deleted successfully!');
        emit(InventoryLoaded(products));
      } on Exception catch (e) {
        showErrorSnackBar('Error deleting product. Please try again.');
        emit(InventoryFailure(e));
      }
    });
  }
}
