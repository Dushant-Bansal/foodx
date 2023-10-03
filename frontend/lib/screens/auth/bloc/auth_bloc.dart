import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/auth/auth_repository.dart';
import 'package:food_x/services/auth_service.dart';
import 'package:food_x/styles/snack_bar.dart';
import 'package:food_x/utilities/check_device.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthSignIn>((event, emit) async {
      emit(const AuthLoading());
      try {
        if (event.oAuth) {
          if (isIOS) {
            // TODO: Handle IOS case
            throw const AuthException('Google Auth for IOS not enabled yet.');
          } else {
            final data = await AuthService.signInWithGoogle(event.name);
            await AuthRepository.instance.loginViaGoogle(
              userId: data.key,
              email: data.value,
              name: event.name,
            );
          }
        } else {
          if (event.signUp) {
            await AuthService.signUp(
              name: event.name,
              email: event.email,
              password: event.password,
            );
            await AuthRepository.instance.signUp(
              name: event.name,
              email: event.email,
              password: event.password,
            );
          } else {
            await AuthService.signIn(
              email: event.email,
              password: event.password,
            );
            await AuthRepository.instance.signIn(
              email: event.email,
              password: event.password,
            );
          }
        }

        emit(const AuthAuthenticated());
        showSuccessSnackBar('Signed-in successfully!');
      } on AuthException catch (e) {
        emit(AuthFailure(e));
        showErrorSnackBar(e.error);
      } on DioException catch (e) {
        final String error = e.response?.data['message'] ?? '';
        emit(AuthFailure(AuthException(error)));
      } on FirebaseAuthException catch (e) {
        e.code == 'network-request-failed'
            ? showErrorSnackBar('No Internet Connection')
            : showErrorSnackBar(
                'Authentication unsuccessful. Please check your information and try again.');
        emit(AuthFailure(AuthException(e.code)));
      }
    });

    on<AuthSignOut>((event, emit) async {
      emit(const AuthLoading());
      try {
        await AuthService.signOut();
        if (!event.forced) await AuthRepository.instance.logout();
        emit(const AuthInitial());
        if (!event.forced) showSuccessSnackBar('Signed-out successfully!');
      } on AuthException catch (e) {
        emit(AuthFailure(e));
        showErrorSnackBar(e.error);
      } on DioException catch (e) {
        final String error = e.response?.data['message'] ?? '';
        emit(AuthFailure(AuthException(error)));
      }
    });
  }
}
