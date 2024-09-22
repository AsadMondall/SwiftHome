import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateYAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      // Optionally, add a delay based on the widget's delay parameter
      // You can adjust this delay based on your needs
      // e.g., Duration(milliseconds: (500 * widget.delay).round()),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            Interval(0.0, 1.0, curve: Curves.easeOut), // Adjust curve as needed
      ),
    );

    _translateYAnimation = Tween<double>(begin: -30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            Interval(0.0, 1.0, curve: Curves.easeOut), // Adjust curve as needed
      ),
    );

    // Optionally, add delay to animation start
    Future.delayed(Duration(milliseconds: (500 * widget.delay).round()), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _translateYAnimation.value),
            child: widget.child,
          ),
        );
      },
    );
  }
}
