import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import 'package:food_x/widgets/loader.dart';
import '../../../styles/palette.dart';
import '../../../utilities/default_box_decoration.dart';
import '../../product/view/widgets/product_tile.dart';
import '../bloc/shop_bloc.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    context.read<ShopBloc>().add(const ShopFetch());
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<BottomBarCubit>().update(0);
        return Future(() => true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: defaultBoxDecoration(Palette.lightGrey),
                  child: TextField(
                    controller: search,
                    cursorColor: Palette.darkGreen,
                    onChanged: (value) =>
                        context.read<ShopBloc>().add(ShopSearch(search.text)),
                    decoration: InputDecoration(
                      hintText: '  Search Products',
                      suffixIcon: Icon(Icons.search, color: Palette.darkGreen),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ShopBloc, ShopState>(
                  builder: (context, state) {
                    if (state is ShopLoading) {
                      return const Center(child: Loader());
                    } else if (state is ShopFailure) {
                      return const Center(child: Text('Something went wrong'));
                    } else if (state is ShopLoaded) {
                      if (state.products == null || state.products!.isEmpty) {
                        return const Center(child: Text('No products yet'));
                      } else {
                        return RefreshIndicator(
                          color: Palette.darkGreen,
                          onRefresh: () async =>
                              context.read<ShopBloc>().add(const ShopFetch()),
                          child: ListView(
                            children: state.products!
                                .map(
                                  (product) => ProductTile(
                                    product: product,
                                    onProductRemove: () => context
                                        .read<ShopBloc>()
                                        .add(ShopRemove(product.id)),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
