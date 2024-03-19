import 'package:blogster/core/theme/app_pallete.dart';
import 'package:blogster/features/auth/presentation/pages/signup_page.dart';
import 'package:blogster/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogster/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const Login(),
      );
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              AuthField(hintText: "Email", controller: emailController),
              const SizedBox(height: 15),
              AuthField(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              AuthGradientButton(
                buttonText: 'Sign in',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SignUp.route(),
                  );
                },
                child: RichText(
                    text: TextSpan(
                  text: "Don't have an account?",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: List.generate(
                    1,
                    (index) => TextSpan(
                      text: " Sign Up",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppPallete.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 55:00