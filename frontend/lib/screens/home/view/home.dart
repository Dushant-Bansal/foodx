import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/home/bloc/home_bloc.dart';
import 'package:food_x/screens/auth/bloc/auth_bloc.dart';
import 'package:food_x/screens/spaces/bloc/space_bloc.dart';
import 'package:food_x/services/dynamic_link_service.dart';
import 'package:food_x/services/notification_service.dart';
import 'package:food_x/styles/text_style.dart';
import 'package:food_x/utilities/extensions.dart';
import 'package:food_x/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import '../../../services/auth_service.dart';
import '../../../router/constants.dart';
import '../../../styles/palette.dart';
import 'widgets/services.dart';
import 'widgets/home_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    LocalNotification.intance.initialize(
      onClickNotification: (payload) =>
          context.read<BottomBarCubit>().update(1),
    );
    DynamicLinkService.intance.handleDynamicLinks(
      onLinkTapped: (url) {
        context.read<BottomBarCubit>().update(2);
        final spaceId = url.queryParameters['spaceId'];
        final role = url.queryParameters['role'];
        if (spaceId != null && role != null) {
          context.read<SpaceBloc>().add(SpaceAddUser(spaceId, role));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Auth Bloc Listener
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) context.go(initialPage);
            if (state is AuthLoading) showLoader(context);
            if (state is AuthFailure) context.go(initialPage);
          },
        ),

        // Home Bloc Listener
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoading) showLoader(context);
            if (state is HomeProductSuccess) {
              context.pop();
              context.go('$home/$addProduct', extra: state.mode);
            }
            if (state is HomeProductFailure) context.pop();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Hi, ${AuthService.name.capitalize()}',
            style: kPoppinsBoldWhiteSmall.copyWith(color: Palette.black),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () async =>
                  context.read<AuthBloc>().add(const AuthSignOut()),
              child: Icon(Icons.logout, color: Palette.black),
            ),
            const SizedBox(width: 16.0),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              context.read<HomeBloc>().add(const HomeAddProduct(Mode.scanner)),
          label: const Row(
            children: [
              Icon(Icons.document_scanner_rounded),
              SizedBox(width: 4),
              Text('Scan'),
            ],
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                Expanded(flex: 5, child: HomeCard()),
                Expanded(child: SizedBox()),
                Expanded(flex: 4, child: Services()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
