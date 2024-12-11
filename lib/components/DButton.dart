import 'package:flutter/material.dart';

class DFullBordedButton extends StatelessWidget {
  final Function()? onClick;
  final Widget child;

  const DFullBordedButton({
    super.key,
    required this.onClick,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.8, 
            style: BorderStyle.solid
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
        ), 
        child: child,
      )
    );
  }
}

class DFullFilledButton extends StatelessWidget {
  final Function()? onClick;
  final Widget child;

  const DFullFilledButton({
    super.key,
    this.onClick,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
      child: ElevatedButton(
        onPressed: onClick??onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).primaryColorLight,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
        ), 
        child: child,
      )
    );
  }
}