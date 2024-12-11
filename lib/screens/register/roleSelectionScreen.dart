import 'package:direct_prime_app/components/DButton.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatefulWidget {
  final VoidCallback nextPageCallback;
  final ValueSetter<String>? roleSetter;
  
  const RoleSelectionPage({
    super.key,
    required this.nextPageCallback,
    required this.roleSetter,
  });

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  void setRole(String roleName) {
    if (widget.roleSetter != null) {
      widget.roleSetter!(roleName);
    }
    widget.nextPageCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Text(
            "Escolha sua categoria",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DFullFilledButton(
              onClick: () {setRole("Courier");},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage("assets/courier_icon.png"),
                    width: 95,
                    ),
                  Text("Quero ser entregador!")
                ],
              )
            ),
            DFullFilledButton(
              onClick: () {setRole("Company");},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Represento uma empresa!"),
                  Image(
                    image: AssetImage("assets/company_icon.png"),
                    width: 85,
                  ),
                ],
              )
            )
          ],
        )
      ],
    );
  }
}