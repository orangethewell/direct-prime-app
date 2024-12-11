import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DTextField.dart';
import 'package:flutter/material.dart';

class UserRegisterPage extends StatefulWidget {
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  final VoidCallback nextPageCallback;
  
  const UserRegisterPage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.nextPageCallback
  });

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: Text(
              "Seus dados de cadastro",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Que bom que decidiu participar da nossa equipe! "
            "Estamos preparando sua página, porém precisamos "
            "de mais algumas informações. Como não conhecemos "
            "você, precisamos assegurar que você é uma pessoa "
            "real e que vai contribuir para a comunidade do "
            "Direct Prime.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 50),
        Dtextfield(
          controller: widget.username, 
          hintText: "Nome Completo"
        ),
        Dtextfield(
          controller: widget.email, 
          hintText: "Email"
        ),
        Dtextfield(
          controller: widget.password, 
          hintText: "Senha",
          obscureText: true,
        ),
        Dtextfield(
          controller: widget.password, 
          hintText: "Repita a senha",
          obscureText: true,
        ),
        DFullFilledButton(
          onClick: widget.nextPageCallback,
          child: Text("Continuar"),
        ),
      ],
    );
  }
}