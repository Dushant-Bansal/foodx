import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_x/router/constants.dart';
import 'package:food_x/screens/auth/bloc/auth_bloc.dart';
import 'package:food_x/styles/snack_bar.dart';
import 'package:food_x/utilities/validators.dart';
import 'package:food_x/widgets/field.dart';
import 'package:food_x/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import '../../../../utilities/default_box_decoration.dart';
import '../../../../styles/palette.dart';
import '../../../../styles/text_style.dart';
import '../../../../utilities/size.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isOAuth = true;
  bool isSignUp = false;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(scale: animation, child: child),
        child: isOAuth
            ? _buildGoogleSignIn()
            : isSignUp
                ? _buildEmailSignUp()
                : _buildEmailSignIn(),
      ),
    );
  }

  Container _buildEmailSignIn() {
    return Container(
      key: const ValueKey<int>(0),
      height: kHeight(context) / 2.4,
      width: double.maxFinite,
      decoration: defaultBoxDecoration(Palette.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            'Enter your details to Continue',
            style: kPoppinsLightBold,
          ),
          const SizedBox(height: 10),
          TextInputField(
            controller: email,
            hintText: 'Enter your Email',
            iconData: Icons.email_outlined,
            validator: nullValidation('Email is Required'),
          ),
          TextInputField(
            controller: password,
            hintText: 'Enter you Password',
            iconData: Icons.password_outlined,
            validator: nullValidation('Password is Required'),
          ),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => setState(() => isSignUp = true),
            child: const Text('New here? Sign up now!'),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => setState(() => isOAuth = true),
            child: const Text('Continue With Google'),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Container _buildEmailSignUp() {
    return Container(
      key: const ValueKey<int>(1),
      height: kHeight(context) / 2,
      width: double.maxFinite,
      decoration: defaultBoxDecoration(Palette.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            'Enter your details to Continue',
            style: kPoppinsLightBold,
          ),
          const SizedBox(height: 10),
          TextInputField(
            controller: name,
            hintText: 'Enter your Name',
            iconData: Icons.person_outline,
            validator: nullValidation('Name is Required'),
          ),
          TextInputField(
            controller: email,
            hintText: 'Enter your Email',
            iconData: Icons.email_outlined,
            validator: nullValidation('Email is Required'),
          ),
          TextInputField(
            controller: password,
            hintText: 'Enter you Password',
            iconData: Icons.password_outlined,
            validator: nullValidation('Password is Required'),
          ),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => setState(() => isSignUp = false),
            child: const Text('Already have an account? Sign in here.'),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => setState(() => isOAuth = true),
            child: const Text('Continue With Google'),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Container _buildGoogleSignIn() {
    return Container(
      key: const ValueKey<int>(2),
      height: kHeight(context) / 2.8,
      width: double.maxFinite,
      decoration: defaultBoxDecoration(Palette.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            'Enter your name to Continue',
            style: kPoppinsLightBold,
          ),
          const SizedBox(height: 30),
          TextInputField(
            controller: name,
            hintText: 'Enter your Name',
            iconData: Icons.person_outline,
            validator: nullValidation('Name is Required'),
          ),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => setState(() => isOAuth = false),
            child: const Text('Continue With Email'),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  BlocConsumer<AuthBloc, AuthState> _buildButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) showLoader(context);
        if (state is AuthAuthenticated) context.go(home);
        if (state is AuthFailure) if (context.canPop()) context.pop();
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            try {
              if (isOAuth) {
                if (name.text.isEmpty) {
                  showErrorSnackBar('Name not provided');
                  return;
                }
              } else {
                if (isSignUp) {
                  if (email.text.isEmpty ||
                      password.text.isEmpty ||
                      name.text.isEmpty) {
                    showErrorSnackBar('All Fields are Required');
                    return;
                  }
                } else {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    showErrorSnackBar('All Fields are Required');
                    return;
                  }
                }
              }

              context.read<AuthBloc>().add(
                    AuthSignIn(
                      name: name.text,
                      email: email.text,
                      password: password.text,
                      oAuth: isOAuth,
                      signUp: isSignUp,
                    ),
                  );
            } catch (_) {}
          },
          child: Card(
            elevation: 5,
            shadowColor: Palette.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              width: kWidth(context) / 2,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Palette.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isOAuth
                      ? SvgPicture.asset('assets/icons/Google__G__Logo.svg')
                      : Icon(Icons.email, color: Palette.white),
                  Text(isSignUp ? 'Sign Up' : 'Sign In', style: kPoppinsWhite),
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 32.0,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
