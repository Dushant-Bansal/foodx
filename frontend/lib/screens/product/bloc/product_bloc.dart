import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/product/product_repository.dart';
import 'package:food_x/services/notification_service.dart';

import '../../../styles/snack_bar.dart';
import '../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Map<String, dynamic> details = {};

  ProductBloc() : super(const ProductInitial()) {
    on<ProductScan>((event, emit) async {
      emit(const ProductLoading());
      try {
        details = await ProductRepository.instance
            .getProductDetailsViaScanning(barcode: event.barcode);
        emit(ProductFetched(details));
        showSuccessSnackBar('Product details retrieved successfully.');
      } on Exception catch (e) {
        emit(ProductFailure(e));
        showErrorSnackBar(
            'Error fetching product details. Please check the barcode and try again.');
      }
    });
    on<ProductAdd>((event, emit) async {
      emit(const ProductLoading());
      Product? product;
      try {
        switch (event.mode) {
          case Mode.scanner:
            product = await ProductRepository.instance.addProduct(
              name: event.name,
              image: event.imageLink,
              mfgDate: event.manufactured,
              expDate: event.expiry,
              description: event.description,
              stock: event.stock,
              price: event.price,
              barcode: details['barcode_number'],
              mode: Mode.scanner,
            );
            break;

          case Mode.manual:
            final String link =
                await ProductRepository.instance.upload(event.image!);
            product = await ProductRepository.instance.addProduct(
              name: event.name,
              image: link,
              mfgDate: event.manufactured,
              expDate: event.expiry,
              description: event.description,
              stock: event.stock,
              price: event.price,
              mode: Mode.manual,
            );
            break;
        }

        LocalNotification.intance.scheduleExpiry(product: product);
        emit(const ProductUploaded());
        showSuccessSnackBar('Product uploaded successfully.');
      } on Exception catch (e) {
        emit(ProductFailure(e));
        showErrorSnackBar(
            'Error uploading product. Please check your connection and try again.');
      }
    });
  }
}
