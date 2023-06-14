import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/button_widget.dart';
import 'package:rpl_b/common_widget/text_field_widget.dart';
import 'package:rpl_b/provider/login_provider.dart';
import 'package:rpl_b/ui/home_page.dart';
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
      body: Consumer<LoginProvider>(builder: (context, value, _) {
        if (value.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                    style: getBlackTextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24)),
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
                    } else {
                      value.loginWithEmailPassword(
                          _emailController.text, _passwordController.text);

                      if (value.state == ResultState.hasData) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login Success'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.routeName, (route) => false);
                      }
                      if (value.state == ResultState.error) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(value.message ?? 'Login Failed'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                      // try {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Login Process'),
                      //       backgroundColor: Colors.green,
                      //     ),
                      //   );
                      //   await _auth.signInWithEmailAndPassword(
                      //       email: _emailController.text,
                      //       password: _passwordController.text);
                      //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Login Success'),
                      //       backgroundColor: Colors.green,
                      //     ),
                      //   );
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context, HomePage.routeName, (route) => false);
                      // } on FirebaseAuthException catch (e) {
                      //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(e.message ?? 'Login Failed'),
                      //       backgroundColor: Colors.redAccent,
                      //     ),
                      //   );
                      // }
                    }
                  },
                  child: Text(
                    'Login',
                    style: getWhiteTextStyle(),
                  ),
                ),
              ],
            ));
      }),
    );
  }
}
