import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/spaces/bloc/space_bloc.dart';
import 'package:food_x/styles/text_style.dart';
import 'package:food_x/utilities/validators.dart';
import 'package:food_x/widgets/field.dart';
import 'package:food_x/widgets/gradient_button.dart';
import 'package:food_x/widgets/loader.dart';
import 'package:go_router/go_router.dart';

class AddSpace extends StatefulWidget {
  const AddSpace({super.key, required this.bloc});

  final SpaceBloc bloc;

  @override
  State<AddSpace> createState() => _AddSpaceState();
}

class _AddSpaceState extends State<AddSpace> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is SpaceLoading) showLoader(context);
        if (state is SpaceLoaded) {
          if (context.canPop()) context.pop(); // Pop Loader
          if (context.canPop()) context.pop(); // Pop Bottom Sheet
        }
        if (state is SpaceFailure) if (context.canPop()) context.pop();
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextInputField(
                controller: name,
                hintText: 'Space Name',
                iconData: Icons.category_outlined,
                validator: nullValidation('Space Name is required'),
              ),
              TextInputField(
                controller: description,
                hintText: 'Space Description',
                iconData: Icons.description_outlined,
                maxLines: 4,
              ),
              GradientButton(
                child: Text('Submit', style: kPoppinsLightWhiteLarge),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    widget.bloc.add(
                      SpaceCreate(
                        name: name.text,
                        description: description.text,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
