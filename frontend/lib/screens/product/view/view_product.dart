import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_x/styles/palette.dart';
import 'package:food_x/styles/text_style.dart';

import '../models/product.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({
    super.key,
    required this.product,
    this.onProductDelete,
    this.onShoppingBagPressed,
    this.onSpacePressed,
  });

  final Product product;

  final Function(String id)? onProductDelete;
  final Function(Product product)? onShoppingBagPressed;
  final Function(Product product)? onSpacePressed;

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  late bool isShop = widget.product.isShop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.lightGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.onProductDelete == null
                    ? Container()
                    : IconButton(
                        onPressed: () =>
                            widget.onProductDelete?.call(widget.product.id),
                        icon: const Icon(Icons.delete),
                      ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  minScale: 1,
                  maxScale: 2,
                  panEnabled: false,
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    color: Palette.lightGrey,
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.product.name,
                          style: kPoppinsBold.copyWith(fontSize: 20.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Expires in\n${widget.product.getLeftDays}',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    widget.product.description ?? '',
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Manufacturing Date: ${widget.product.mfgDateString}'),
                          Text('Expiry Date: ${widget.product.expDateString}'),
                        ],
                      ),
                      Container(
                        transform: Matrix4.translationValues(20.0, 0, 0.0),
                        decoration: BoxDecoration(
                          color: Palette.lightGrey,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              widget.onShoppingBagPressed?.call(
                                  widget.product.copyWith(isShop: isShop));
                              isShop = !isShop;
                            });
                          },
                          icon: Icon(
                            isShop
                                ? Icons.shopping_bag
                                : Icons.shopping_bag_outlined,
                            size: 32,
                            color: isShop ? Palette.darkGreen : null,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
