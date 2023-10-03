import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/services/scan_service.dart';
import 'package:food_x/styles/snack_bar.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeAddProduct>((event, emit) async {
      emit(const HomeLoading());
      try {
        if (event.mode == Mode.scanner) {
          final String code = await ScanService.scanBarcode();
          emit(HomeProductSuccess(barCode: code, mode: event.mode));
          showSuccessSnackBar('Scan successful. Product details retrieved.');
        } else {
          emit(HomeProductSuccess(barCode: null, mode: event.mode));
        }
      } on ScanException catch (e) {
        emit(const HomeProductFailure());
        showErrorSnackBar(e.error);
      } on FormatException {
        emit(const HomeProductFailure());
        showErrorSnackBar('Invalid Barcode');
      }
    });
  }
}
