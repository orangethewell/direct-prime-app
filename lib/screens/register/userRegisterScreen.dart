import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DTextField.dart';
import 'package:flutter/material.dart';

class UserRegisterPage extends StatefulWidget {
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController cpf;
  final TextEditingController password;
    final TextEditingController repeatPassword;
  final VoidCallback nextPageCallback;
  
  const UserRegisterPage({
    super.key,
    required this.username,
    required this.email,
    required this.cpf,
    required this.password,
    required this.repeatPassword,
    required this.nextPageCallback
  });

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? validateName(String? text) {
    if (text == null || text.isEmpty || text.length <= 3) {
      return "Seu nome precisa ter mais de 3 caracteres!";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null) {
      return "Email vazio!";
    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);

    if (!emailValid) {
      return "Email inválido!";
    }

    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty || text.length <= 8) {
      return "Sua senha precisa ter mais de 8 caracteres!";
    }
    return null;
  }

  String? validateRepeatPassword(String? text) {
    if (text == null || text != widget.password.text) {
      return "As senhas não são iguais!";
    }
    return null;
  }

  String? validateCPForCNPJ(String? value) {
    if (value == null || value.isEmpty) {
      return "CPF ou CNPJ não pode ser vazio!";
    }

    // Remove caracteres não numéricos
    value = value.replaceAll(RegExp(r'\D'), '');

    if (value.length == 11) {
      return _validateCPF(value);
    } else if (value.length == 14) {
      return _validateCNPJ(value);
    } else {
      return "CPF deve ter 11 dígitos ou CNPJ 14 dígitos!";
    }
  }

  String? _validateCPF(String cpf) {
    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(.)\1{10}\$').hasMatch(cpf)) {
      return "CPF inválido!";
    }

    // Cálculo dos dígitos verificadores
    int calculateDigit(String base) {
      int sum = 0;
      for (int i = 0; i < base.length; i++) {
        sum += int.parse(base[i]) * (base.length + 1 - i);
      }
      int remainder = sum % 11;
      return remainder < 2 ? 0 : 11 - remainder;
    }

    String baseCPF = cpf.substring(0, 9);
    int firstDigit = calculateDigit(baseCPF);
    int secondDigit = calculateDigit(baseCPF + firstDigit.toString());

    if (cpf != baseCPF + firstDigit.toString() + secondDigit.toString()) {
      return "CPF inválido!";
    }

    return null;
  }

  String? _validateCNPJ(String cnpj) {
    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(.)\1{13}\$').hasMatch(cnpj)) {
      return "CNPJ inválido!";
    }

    // Cálculo dos dígitos verificadores
    int calculateDigit(String base, List<int> weights) {
      int sum = 0;
      for (int i = 0; i < base.length; i++) {
        sum += int.parse(base[i]) * weights[i];
      }
      int remainder = sum % 11;
      return remainder < 2 ? 0 : 11 - remainder;
    }

    List<int> firstWeights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> secondWeights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    String baseCNPJ = cnpj.substring(0, 12);
    int firstDigit = calculateDigit(baseCNPJ, firstWeights);
    int secondDigit = calculateDigit(baseCNPJ + firstDigit.toString(), secondWeights);

    if (cnpj != baseCNPJ + firstDigit.toString() + secondDigit.toString()) {
      return "CNPJ inválido!";
    }

    return null;
  }


  void validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.nextPageCallback();
    }
  }
  
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
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 50),
        Form(
          key: _formKey,
          child: Column(
            children: [
              DTextFormField(
                controller: widget.username, 
                hintText: "Nome Completo",
                validator: validateName,
              ),
              DTextFormField(
                controller: widget.email, 
                hintText: "Email",
                validator: validateEmail,
              ),
              DTextFormField(
                controller: widget.cpf, 
                hintText: "CPF/CNPJ",
                validator: validateCPForCNPJ,
              ),
              DTextFormField(
                controller: widget.password, 
                hintText: "Senha",
                obscureText: true,
                validator: validatePassword,
              ),
              DTextFormField(
                controller: widget.repeatPassword, 
                hintText: "Repita a senha",
                obscureText: true,
                validator: validateRepeatPassword,
              ),
              DFullFilledButton(
                onClick: validateAndSubmit,
                child: const Text("Continuar"),
              ),
            ],
          )
        )
      ],
    );
  }
}