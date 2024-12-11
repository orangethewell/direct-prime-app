import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void signUserIn (BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/lo");
  }

  void signUserUp (BuildContext context) {
    Navigator.of(context).pushNamed("/register");
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
              DTextField(
                controller: widget.emailController, 
                hintText: "Email", 
              ),
              DTextField(
                controller: widget.passwordController, 
                hintText: "Senha", 
                obscureText: true
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DFullFilledButton(
                      onClick: () => signUserIn(context), 
                      child: Text("Login")
                    )
                  ]
                ),
              ),
              Text(
                "ou",
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                  ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DFullBordedButton(
                      onClick: () => signUserUp(context), 
                      child: Text("Registrar")
                    ),
                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}