import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:food_x/screens/auth/bloc/auth_bloc.dart';
import 'package:food_x/screens/home/bloc/home_bloc.dart';
import 'package:food_x/screens/inventory/bloc/inventory_bloc.dart';
import 'package:food_x/screens/spaces/bloc/space_bloc.dart';
import '../../styles/palette.dart';
import 'firebase_options.dart';
import '../router/router.dart';
import '../styles/snack_bar.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => InventoryBloc()),
        BlocProvider(create: (_) => SpaceBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Palette.white,
          fontFamily: 'Poppins',
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Palette.lightGreen,
            iconSize: 32.0,
          ),
        ),
        routerConfig: router,
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }
}
