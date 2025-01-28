import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DTextField.dart';
import 'package:flutter/material.dart';

class CompanyDetailsRegisterPage extends StatefulWidget {
  final String roleKind;
  final VoidCallback nextPageCallback;
  
  const CompanyDetailsRegisterPage({
    super.key,
    required this.roleKind,
    required this.nextPageCallback,
  });


  @override
  State<CompanyDetailsRegisterPage> createState() => _CompanyDetailsRegisterPageState();
}

class _CompanyDetailsRegisterPageState extends State<CompanyDetailsRegisterPage> {
  String vehicleType = "Moto";
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Informações sobre sua empresa"),
        DropdownButton<String>(
          value: vehicleType,
          items: <String>[
            "Moto",
            "Bicicleta"
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), 
          onChanged: (value) { 
            setState(() {
              vehicleType = value!;
            });
           },
        ),
        DFullFilledButton(
          onClick: widget.nextPageCallback,
          child: Text("Continuar"),
        ),
      ],
    );
  }
}

class CourierDetailsRegisterPage extends StatefulWidget {
  final String roleKind;
  final VoidCallback nextPageCallback;

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController cpfController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  final TextEditingController motorbikePlate;
  final TextEditingController anyBikeColor;
  final TextEditingController anyBikeBrand;
  
  const CourierDetailsRegisterPage({
    super.key,
    required this.roleKind,
    required this.nextPageCallback,

    required this.usernameController,
    required this.emailController,
    required this.cpfController,
    required this.passwordController,
    required this.repeatPasswordController,

    required this.motorbikePlate,
    required this.anyBikeColor,
    required this.anyBikeBrand,
  });


  @override
  State<CourierDetailsRegisterPage> createState() => _CourierDetailsRegisterPageState();
}

class _CourierDetailsRegisterPageState extends State<CourierDetailsRegisterPage> {
  String vehicleType = "Moto";
  final _formMotorBikeKey = GlobalKey<FormState>();
  final _formBikeKey = GlobalKey<FormState>();
  
  String? validateBrazilianMotoPlate(String? plate) {
    if (plate == null || plate.isEmpty) {
      return "Placa não pode ser vazia!";
    }

    // Regex para validar placas no padrão Mercosul para motos
    if (!RegExp(r'^[A-Z]{3}[0-9][A-Z][0-9]{2}').hasMatch(plate)) {
      return "Placa inválida! O formato deve ser ABC1D23.";
    }

    return null;
  }

  String? validateFieldNonEmpty(String? text) {
    if (text == null || text.isEmpty) {
      return "Campo Obrigatório!";
    }

    return null;
  }

  void validateAndSubmit() {
    if (vehicleType == "Moto" && _formMotorBikeKey.currentState!.validate()) {
      widget.nextPageCallback();
    } else if (vehicleType == "Bicicleta" && _formBikeKey.currentState!.validate()) {
      widget.nextPageCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "Informações da Condução",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Estamos quase terminando seu cadastro! Só precisamos "
            "de uma última informação: as características de seu "
            "veículo. As pessoas sabem quem é você, mas será que "
            "elas sabem como você trabalha por aí? Nos ajude a descobrir!",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Tipo de Veículo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DropdownButton<String>(
          value: vehicleType,
          isExpanded: true,
          items: <String>[
            "Moto",
            "Bicicleta"
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), 
          onChanged: (value) { 
            setState(() {
              vehicleType = value!;
            });
          },
        ),
        () {
          if (vehicleType == "Moto") {
            return Form(
              key: _formMotorBikeKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Características da Moto",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Número da Placa",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DTextFormField(
                  controller: widget.motorbikePlate,
                  hintText: "Ex: BRA 1D23",
                  validator: validateBrazilianMotoPlate,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Cor da Moto",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DTextFormField(
                  controller: widget.anyBikeColor,
                  hintText: "Ex: Vermelho",
                  validator: validateFieldNonEmpty,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Modelo/Marca",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DTextFormField(
                  controller: widget.anyBikeBrand,
                  hintText: "Ex: Yamaha",
                  validator: validateFieldNonEmpty,
                ),
              ],
            )
          );
          } else {
            return Form(
              key: _formBikeKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Características da Bicicleta",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      "Cor da Bicicleta",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DTextFormField(
                    controller: widget.anyBikeColor,
                    hintText: "Ex: Preta",
                    validator: validateFieldNonEmpty,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      "Modelo/Marca",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DTextFormField(
                    controller: widget.anyBikeBrand,
                    hintText: "Ex: Mountain Bike",
                    validator: validateFieldNonEmpty,
                  ),
                ],
              )
            );
          }
        }(),
        DFullFilledButton(
          onClick: validateAndSubmit,
          child: const Text("Finalizar Cadastro"),
        ),
      ],
    );
  }
}

class DetailsRegisterPage extends StatefulWidget {
  late final ValueGetter<String> roleKind;
  final VoidCallback nextPageCallback;

  // Courier
  final TextEditingController motorbikePlate;
  final TextEditingController anyBikeColor;
  final TextEditingController anyBikeBrand;

  // Common
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController cpfController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  
  DetailsRegisterPage({
    super.key,
    required this.roleKind,
    required this.nextPageCallback,

    required this.motorbikePlate,
    required this.anyBikeColor,
    required this.anyBikeBrand,

    required this.usernameController,
    required this.emailController,
    required this.cpfController,
    required this.passwordController,
    required this.repeatPasswordController,
  });

  @override
  State<DetailsRegisterPage> createState() => _DetailsRegisterPageState();
}

class _DetailsRegisterPageState extends State<DetailsRegisterPage> {

  @override
  Widget build(BuildContext context) {
    return () {
      if (widget.roleKind() == 'Courier') {
        return CourierDetailsRegisterPage(
          roleKind: widget.roleKind(),
          nextPageCallback: widget.nextPageCallback,
          motorbikePlate: widget.motorbikePlate,
          anyBikeColor: widget.anyBikeColor,
          anyBikeBrand: widget.anyBikeBrand,
          usernameController: widget.usernameController,
          emailController: widget.emailController,
          cpfController: widget.cpfController,
          passwordController: widget.passwordController,
          repeatPasswordController: widget.repeatPasswordController,
        );
      } else {
        return CompanyDetailsRegisterPage(
          roleKind: widget.roleKind(),
          nextPageCallback: widget.nextPageCallback,
        );
      } 
    }();
  }
}