import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/styles/palette.dart';
import 'package:food_x/styles/text_style.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    this.onTap,
    this.onProductRemove,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onProductRemove;

  @override
  Widget build(BuildContext context) {
    return onProductRemove == null
        ? _buildProduct()
        : Dismissible(
            key: Key(product.id),
            onDismissed: (direction) => onProductRemove?.call(),
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              color: const Color(0xFFF44336),
              child:
                  Icon(Icons.delete_outlined, size: 30.0, color: Palette.white),
            ),
            direction: DismissDirection.startToEnd,
            dismissThresholds: const {DismissDirection.startToEnd: 0.8},
            child: _buildProduct(),
          );
  }

  Card _buildProduct() {
    return Card(
      child: ListTile(
        isThreeLine: true,
        leading: SizedBox(
          height: 100,
          width: 100,
          child: CachedNetworkImage(
            imageUrl: product.image,
            errorWidget: (context, url, error) =>
                const Icon(Icons.image_not_supported_outlined, size: 40),
          ),
        ),
        title: Text(
          product.name,
          style: kPoppinsLightBold,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          product.description ?? '',
          style: kPoppinsLightBold,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          'Expires in\n${product.getLeftDays}',
          style: kPoppinsLightBold,
        ),
        onTap: onTap,
      ),
    );
  }
}
