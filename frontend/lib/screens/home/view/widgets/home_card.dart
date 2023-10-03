import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/product/models/product.dart';
import 'package:food_x/screens/home/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';
import 'drawing_mountain.dart';
import '../../../../styles/palette.dart';
import '../../../../utilities/default_box_decoration.dart';
import 'home_card_text.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultBoxDecoration(Palette.lightGreen).copyWith(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Palette.lightGreen, Palette.darkGreen],
          stops: const [0.7, 0.9],
        ),
      ),
      child: Stack(
        children: [
          const DrawingMountain(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const HomeCardText(),
                      Expanded(child: Image.asset('assets/images/dustbin.png')),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        builder: (context) => SingleChildScrollView(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  context
                                      .read<HomeBloc>()
                                      .add(const HomeAddProduct(Mode.scanner));
                                  context.pop();
                                },
                                child: const ListTile(
                                  leading: Icon(Icons.document_scanner_rounded),
                                  title: Text('Scan Barcode'),
                                ),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () async {
                                  context
                                      .read<HomeBloc>()
                                      .add(const HomeAddProduct(Mode.manual));
                                  context.pop();
                                },
                                child: const ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Add Manually'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: defaultBoxDecoration(Palette.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SubHomeCardText(),
                          Image.asset('assets/icons/delivery.png')
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
