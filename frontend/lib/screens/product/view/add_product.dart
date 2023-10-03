import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/router/constants.dart';
import 'package:food_x/screens/home/bloc/home_bloc.dart';
import 'package:food_x/screens/product/bloc/product_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/utilities/validators.dart';
import 'package:food_x/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/field.dart';
import '../../../styles/text_style.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key, required this.mode});

  final Mode mode;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController manufactured = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();

  File? file;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final state = context.read<HomeBloc>().state;
    if (state is HomeProductSuccess && widget.mode == Mode.scanner) {
      context.read<ProductBloc>().add(ProductScan(state.barCode!));
    }
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    image.dispose();
    manufactured.dispose();
    expiry.dispose();
    description.dispose();
    stock.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductLoading) showLoader(context);
        if (state is ProductUploaded) context.go(home);
        if (state is ProductFailure) if (context.canPop()) context.pop();
        if (state is ProductFetched) {
          try {
            name.text = state.details['title'] as String;
            image.text = state.details['images'].first as String;
            description.text = state.details['description'] as String;
          } catch (_) {}
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInputField(
                          controller: name,
                          hintText: 'Name*',
                          iconData: Icons.category_outlined,
                          validator: nullValidation('Name is required'),
                        ),
                        TextInputField(
                          controller: image,
                          hintText: 'Image*',
                          iconData: Icons.image_outlined,
                          readOnly: true,
                          type: widget.mode == Mode.scanner
                              ? FieldType.text
                              : FieldType.image,
                          validator: nullValidation('Image is Required'),
                          onUploadImage: (image) => file = image,
                        ),
                        TextInputField(
                          controller: manufactured,
                          hintText: 'Manufactured Date*',
                          iconData: Icons.calendar_month_outlined,
                          readOnly: true,
                          isPrev: true,
                          validator:
                              nullValidation('Manufactured Date is Required'),
                          type: FieldType.datetime,
                        ),
                        TextInputField(
                          controller: expiry,
                          hintText: 'Expiry Date*',
                          iconData: Icons.calendar_month_outlined,
                          readOnly: true,
                          validator: nullValidation('Expiry Date is Required'),
                          type: FieldType.datetime,
                        ),
                        TextInputField(
                          controller: description,
                          hintText: 'Description',
                          iconData: Icons.description_outlined,
                          maxLines: 4,
                        ),
                        TextInputField(
                          controller: stock,
                          hintText: 'Stock',
                          iconData: Icons.inventory_2_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        TextInputField(
                          controller: price,
                          hintText: 'Price',
                          iconData: Icons.currency_rupee,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: GradientButton(
            child: Text('Submit', style: kPoppinsLightWhiteLarge),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.read<ProductBloc>().add(
                      ProductAdd(
                        name: name.text,
                        image: file,
                        imageLink: image.text,
                        manufactured: manufactured.text,
                        expiry: expiry.text,
                        description: description.text,
                        stock: int.tryParse(stock.text),
                        price: int.tryParse(price.text),
                        mode: widget.mode,
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }
}
