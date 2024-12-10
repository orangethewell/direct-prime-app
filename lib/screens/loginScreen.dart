import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn (BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/lo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              const Image(
                image: AssetImage("assets/logo-blue.png"),
                width: 200,
              ),
              const Text(
                "Bem-vindo a",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Direct Prime!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Dtextfield(
                controller: emailController, 
                hintText: "Email", 
              ),
              Dtextfield(
                controller: passwordController, 
                hintText: "Senha", 
                obscureText: true
              ),
              DFullFilledButton(
                onClick: () => signUserIn(context), 
                text: "Login"
              ),
              Text(
                "ou",
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                  ),
              ),
              DFullBordedButton(
                onClick: () => signUserIn(context), 
                text: "Registrar"
              ),
            ],
          ),
        ),
      ),
    );
  }
}