import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_x/styles/snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../styles/text_style.dart';
import '../styles/palette.dart';
import '../utilities/default_box_decoration.dart';

enum FieldType { text, datetime, image }

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.iconData,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.type = FieldType.text,
    this.obscureText = false,
    this.isPrev = false,
    this.keyboardType,
    this.onUploadImage,
    this.validator,
  })  : assert(type != FieldType.image || onUploadImage != null),
        super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData? iconData;
  final int maxLines;
  final bool enabled;
  final bool readOnly;
  final FieldType type;
  final bool obscureText;
  final bool isPrev;
  final TextInputType? keyboardType;
  final void Function(File?)? onUploadImage;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final color = defaultBoxDecoration(Palette.lightGrey).color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: Palette.darkGreen,
        maxLines: maxLines,
        validator: validator,
        enabled: enabled,
        readOnly: readOnly,
        onTap: () async {
          try {
            switch (type) {
              case FieldType.text:
                return;

              case FieldType.datetime:
                final dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: isPrev ? DateTime(2000) : DateTime.now(),
                  lastDate: DateTime(2050),
                  builder: (context, child) => Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Palette.darkGreen,
                      ),
                    ),
                    child: child!,
                  ),
                );

                if (dateTime != null) {
                  controller.text = DateFormat('dd/MM/yyyy').format(dateTime);
                }
              case FieldType.image:
                final ImagePicker picker = ImagePicker();
                XFile? xFile = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 50);
                if (xFile == null) return;
                controller.text = xFile.path.split('/').last;
                onUploadImage?.call(File(xFile.path));
            }
          } on Exception catch (e) {
            showErrorSnackBar(e.toString());
            return;
          }
        },
        decoration: InputDecoration(
          fillColor: color,
          filled: true,
          hintText: '    $hintText',
          hintStyle: kPoppinsLightBold,
          suffixIcon: Icon(iconData, color: Palette.darkGreen),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
