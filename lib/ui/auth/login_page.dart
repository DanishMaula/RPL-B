import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/button_widget.dart';
import 'package:rpl_b/common_widget/text_field_widget.dart';
import 'package:rpl_b/provider/login_provider.dart';
import 'package:rpl_b/utils/result_state.dart';
import 'package:rpl_b/utils/style_manager.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;

  String? validationInput() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return 'Please fill the form';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginProvider>(builder: (context, value, _) {
          if (value.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('RPL B',
                        style: getBlackTextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    const SizedBox(height: 16),
                    Image.asset(
                      'assets/images/photo_login.png',
                      width: double.infinity,
                      height: 230,
                    ),
                    const SizedBox(height: 16),
                    TextfieldWidget(
                      hintText: 'Email',
                      controller: _emailController,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    TextfieldWidget(
                      hintText: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    ButtonWidget(
                      color: Colors.redAccent,
                      onPressed: () async {
                        final _validationInput = validationInput();

                        if (_validationInput != null) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_validationInput),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                        value.loginWithEmailPassword(_emailController.text,
                            _passwordController.text, context);

                      },
                      child: Text(
                        'Login',
                        style: getWhiteTextStyle(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Not RPL B? see as guest.',
                        ))
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
