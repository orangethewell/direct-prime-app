import 'package:flutter/material.dart';

class DMapDeliveryIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color color;

  const DMapDeliveryIcon({
    Key? key,
    required this.icon,
    this.size = 24.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  _DMapDeliveryIconState createState() => _DMapDeliveryIconState();
}

class _DMapDeliveryIconState extends State<DMapDeliveryIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _primaryScaleAnimation;
  late final Animation<double> _secondaryScaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _primaryScaleAnimation = Tween<double>(begin: 0.6, end: 2.2).animate(_controller);
    _secondaryScaleAnimation = Tween<double>(begin: 0.3, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
    _fadeAnimation = Tween<double>(begin: 1, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -25,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.center, 
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _primaryScaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.delivery_dining,
                          color: Colors.blue,
                          size: 32.0,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _secondaryScaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.delivery_dining,
                          color: Colors.blue,
                          size: 32.0,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.delivery_dining,
                      color: Colors.blue,
                      size: 32.0,
                    )
                  ),
                ),
              ),
            ]
          )
        ),
        Positioned(
          top: 2,
          child: const Icon(
            Icons.arrow_drop_down,
            size: 48.0,
            color: Colors.white,
          )
        )
      ]
    );
  }
}