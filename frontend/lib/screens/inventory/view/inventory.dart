import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/router/constants.dart';
import 'package:food_x/router/router.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import 'package:food_x/screens/inventory/bloc/inventory_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/spaces/bloc/space_bloc.dart';
import 'package:food_x/styles/snack_bar.dart';
import 'package:food_x/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import '../../../styles/palette.dart';
import '../../../utilities/default_box_decoration.dart';
import '../../product/view/widgets/product_tile.dart';

class Inventory extends StatefulWidget {
  const Inventory({
    super.key,
    this.isShop,
    this.status,
    this.name,
    this.id,
    this.isSpace,
    this.spaceId,
  });

  final bool? isShop;
  final Status? status;
  final String? name;
  final String? id;
  final bool? isSpace;
  final String? spaceId;

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    context.read<InventoryBloc>().add(
          InventoryFetch(
            isShop: widget.isShop,
            status: widget.status,
            name: widget.name,
            id: widget.id,
            isSpace: widget.isSpace,
            spaceId: widget.spaceId,
          ),
        );
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
                    onChanged: (value) => context
                        .read<InventoryBloc>()
                        .add(InventorySearch(search.text)),
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
                child: BlocBuilder<InventoryBloc, InventoryState>(
                  builder: (context, state) {
                    if (state is InventoryLoading) {
                      return const Center(child: Loader());
                    } else if (state is InventoryFailure) {
                      return const Center(child: Text('Something went wrong'));
                    } else if (state is InventoryLoaded) {
                      if (state.products == null || state.products!.isEmpty) {
                        return const Center(child: Text('No products yet'));
                      } else {
                        return RefreshIndicator(
                          color: Palette.darkGreen,
                          onRefresh: () async =>
                              context.read<InventoryBloc>().add(InventoryFetch(
                                    isShop: widget.isShop,
                                    status: widget.status,
                                    name: widget.name,
                                    id: widget.id,
                                    isSpace: widget.isSpace,
                                    spaceId: widget.spaceId,
                                  )),
                          child: ListView(
                            children: state.products!
                                .map(
                                  (product) => GestureDetector(
                                    onLongPress: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: product.id));
                                      showSuccessSnackBar(
                                          '${product.name} copied successfully');
                                    },
                                    child: ProductTile(
                                      product: product,
                                      onTap: () => context.push(
                                          '${context.path}/$viewProduct',
                                          extra: product),
                                      onProductRemove: () {
                                        widget.spaceId == null
                                            ? context.read<InventoryBloc>().add(
                                                InventoryProductRemove(
                                                    product.id))
                                            : context.read<SpaceBloc>().add(
                                                SpaceUpdateProduct(
                                                    widget.spaceId!, product.id,
                                                    remove: true));
                                      },
                                    ),
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
