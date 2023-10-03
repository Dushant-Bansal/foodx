import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/router/constants.dart';
import 'package:food_x/router/router.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import 'package:food_x/screens/spaces/bloc/space_bloc.dart';
import 'package:food_x/screens/spaces/view/widgets/add_space.dart';
import 'package:food_x/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'widgets/space_tile.dart';

import '../../../styles/palette.dart';
import '../../../styles/text_style.dart';

class Spaces extends StatefulWidget {
  const Spaces({super.key});

  @override
  State<Spaces> createState() => _SpacesState();
}

class _SpacesState extends State<Spaces> {
  @override
  void initState() {
    context.read<SpaceBloc>().add(const SpaceFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<BottomBarCubit>().update(0);
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 0,
          title: Text(
            'Spaces',
            style: kPoppinsBoldWhiteSmall.copyWith(color: Palette.black),
          ),
          centerTitle: false,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              builder: (ctx) => SingleChildScrollView(
                padding: const EdgeInsets.all(4.0),
                child: AddSpace(bloc: BlocProvider.of<SpaceBloc>(context)),
              ),
            );
          },
          label: const Row(
            children: [Icon(Icons.add), SizedBox(width: 4), Text('Create')],
          ),
        ),
        body: BlocBuilder<SpaceBloc, SpaceState>(
          builder: (context, state) {
            if (state is SpaceLoading) {
              return const Center(child: Loader());
            } else if (state is SpaceFailure) {
              return const Center(child: Text('Something went wrong'));
            } else if (state is SpaceLoaded) {
              if (state.spaces.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/storage.png'),
                      Text(
                        'Explore Spaces',
                        style: kPoppinsBold.copyWith(color: Palette.black),
                      ),
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  color: Palette.darkGreen,
                  onRefresh: () async =>
                      context.read<SpaceBloc>().add(const SpaceFetch()),
                  child: GridView.builder(
                    itemCount: state.spaces.length,
                    padding: const EdgeInsets.all(25.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onLongPress: () async {
                        ClipboardData? data =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        if (data != null && data.text != null) {
                          String id = data.text!;
                          // ignore: use_build_context_synchronously
                          context.read<SpaceBloc>().add(
                                SpaceUpdateProduct(state.spaces[index].id, id),
                              );
                        }
                      },
                      child: SpaceTile(
                        space: state.spaces[index],
                        onTap: () => context.go('${context.path}/$inventory?'
                            'isSpace=true&spaceId=${state.spaces[index].id}'),
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
