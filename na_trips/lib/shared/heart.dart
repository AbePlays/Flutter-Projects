import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> colorAnimation;
  Animation<double> sizeAnimation;
  Animation curve;

  bool isFav = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    curve = CurvedAnimation(parent: controller, curve: Curves.slowMiddle);
    colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(curve);
    sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(curve);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: colorAnimation.value,
            size: sizeAnimation.value,
          ),
          onPressed: () {
            if (isFav) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
        );
      },
    );
  }
}
