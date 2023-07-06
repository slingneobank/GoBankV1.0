import 'package:flutter/material.dart';

class LogoAnimationScreen extends StatefulWidget {
  @override
  _LogoAnimationScreenState createState() => _LogoAnimationScreenState();
}

class _LogoAnimationScreenState extends State<LogoAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<Offset> _textAnimation;
  String _text = 'Sling ';
  int _textIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _textAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _startTextAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startTextAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _textIndex++;
      });
      if (_textIndex < _text.length) {
        _startTextAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoAnimation.value,
                  child: child,
                );
              },
              child: Image.asset('asset/images/ic_launcher.png'), // Replace with your logo image
            ),
            SizedBox(height: 20),
            SlideTransition(
              position: _textAnimation,
              child: Opacity(
                opacity: 1.0,
                child: Text(
                  _text.substring(0, _textIndex),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Gilroy Bold',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
