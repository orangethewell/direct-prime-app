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

  final TextEditingController motorbikePlate;
  final TextEditingController anyBikeColor;
  final TextEditingController anyBikeBrand;
  
  const CourierDetailsRegisterPage({
    super.key,
    required this.roleKind,
    required this.nextPageCallback,
    required this.motorbikePlate,
    required this.anyBikeColor,
    required this.anyBikeBrand,
  });


  @override
  State<CourierDetailsRegisterPage> createState() => _CourierDetailsRegisterPageState();
}

class _CourierDetailsRegisterPageState extends State<CourierDetailsRegisterPage> {
  String vehicleType = "Moto";
  
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
            textAlign: TextAlign.center,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Número da Placa",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Dtextfield(
                  controller: widget.motorbikePlate,
                  hintText: "Ex: BRA 0S11",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Cor da Moto",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Dtextfield(
                  controller: widget.anyBikeColor,
                  hintText: "Ex: Vermelho",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Modelo/Marca",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Dtextfield(
                  controller: widget.anyBikeBrand,
                  hintText: "Ex: Yamaha",
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Cor da Bicicleta",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Dtextfield(
                  controller: widget.anyBikeColor,
                  hintText: "Ex: Preta",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Modelo/Marca",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Dtextfield(
                  controller: widget.anyBikeBrand,
                  hintText: "Ex: Mountain Bike",
                ),
              ],
            );
          }
        }(),
        DFullFilledButton(
          onClick: widget.nextPageCallback,
          child: Text("Finalizar Cadastro"),
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
  
  DetailsRegisterPage({
    super.key,
    required this.roleKind,
    required this.nextPageCallback,

    required this.motorbikePlate,
    required this.anyBikeColor,
    required this.anyBikeBrand,
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