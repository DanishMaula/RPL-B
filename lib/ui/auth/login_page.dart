import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/common_widget/button_widget.dart';
import 'package:rpl_b/common_widget/text_field_widget.dart';
import 'package:rpl_b/provider/login_provider.dart';
import 'package:rpl_b/ui/home_page.dart';
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

  String? validationInput() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return 'Please fill the form';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                login(context, _emailController.text, _passwordController.text);
              },
              child: Text(
                'Login',
                style: getWhiteTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context, String email, String password) async {
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    try {
      await loginProvider.loginWithEmailPassword(email, password);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
