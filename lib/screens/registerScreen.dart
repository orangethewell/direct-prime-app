import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/screens/register/roleSelectionScreen.dart';
import 'package:flutter/material.dart';

import 'register/detailsRegisterScreen.dart';
import 'register/locationSelectionScreen.dart';
import 'register/userRegisterScreen.dart';

class RegisterScreen extends StatefulWidget {
  
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final pageController = PageController();
  String role = "";
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final motorbikePlate = TextEditingController();
  final anyBikeColor = TextEditingController();
  final anyBikeBrand = TextEditingController();

  late var roleSetter = (value) {
    print("set to " + value);
    setState((){
      role = value;
    });
    print("set to " + role);
  };

  late var goNextPage = () {
    if (pageController.hasClients) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400), 
        curve: Curves.easeInOut
      );
    }
  };
  late var pages = [
    RoleSelectionPage(
      nextPageCallback: goNextPage,
      roleSetter: roleSetter,
    ),
    UserRegisterPage(
      username: usernameController,
      email: emailController,
      password: passwordController,
      nextPageCallback: goNextPage,
    ),
    LocationSelectionPage(
      nextPageCallback: goNextPage,
    ),
    DetailsRegisterPage(
      nextPageCallback: goNextPage,
      roleKind: () => role,
      
      motorbikePlate: motorbikePlate,
      anyBikeColor: anyBikeColor,
      anyBikeBrand: anyBikeBrand,
    )
  ];

  int currentPageIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void signUserIn (BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/lo");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: pages,
                  onPageChanged: (i) {
                    setState(() {
                      currentPageIndex = i;
                    });
                  },
                ),
              ),
          ),
          Container(
            child: currentPageIndex != 0 ? DFullBordedButton(
              onClick: () {
                if (pageController.hasClients) {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 400), 
                    curve: Curves.easeInOut
                  );
                }
              }, 
              child: const Text("Retornar")
            ) : null
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: LinearProgressIndicator(
              color: Colors.blue.shade700,
              value: (currentPageIndex + 1) / 4,
              borderRadius: BorderRadius.circular(10),
              minHeight: 20,
            )
          )
        ],
      )
    );
  }
}