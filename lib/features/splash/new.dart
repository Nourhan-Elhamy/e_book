import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../home/screens/category_screen.dart';
import '../home/screens/item_details.dart';
import '../home/screens/category_details.dart';



class AdvancedSplashScreen extends StatefulWidget {
  @override
  _AdvancedSplashScreenState createState() => _AdvancedSplashScreenState();
}

class _AdvancedSplashScreenState extends State<AdvancedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bookIconFadeController;
  late Animation<double> _bookIconFadeAnimation;
  late AnimationController _bookIconScaleController;
  late Animation<double> _bookIconScaleAnimation;

  late AnimationController _textFadeController;
  late Animation<double> _textFadeAnimation;

  late AnimationController _zoomOutController;
  late Animation<double> _zoomOutScaleAnimation;
  late Animation<double> _zoomOutFadeAnimation;

  bool _showText = false;

  @override
  void initState() {
    super.initState();

    // Stage 1
    _bookIconFadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _bookIconFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _bookIconFadeController,
          curve: Curves.easeIn,
        ));

    _bookIconScaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 300),
    );
    _bookIconScaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
          parent: _bookIconScaleController,
          curve: Curves.elasticOut,
        ));

    // Stage 2
    _textFadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _textFadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _textFadeController,
          curve: Curves.easeIn,
        ));

    // Stage 3
    _zoomOutController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _zoomOutScaleAnimation = Tween<double>(begin: 1.0, end: 3.0).animate(
        CurvedAnimation(parent: _zoomOutController, curve: Curves.easeInQuad));
    _zoomOutFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _zoomOutController, curve: Curves.easeOut));

    // Start stage 1
    _bookIconFadeController.forward();
    _bookIconScaleController.forward();

    // After icon animation, show text
    Future.delayed(Duration(milliseconds: 1300), () {
      setState(() {
        _showText = true;
      });
      _textFadeController.forward();
    });

    // After everything, start zoom out and navigate
    Future.delayed(Duration(milliseconds: 3000), () async {
      await _zoomOutController.forward();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CategoryScreen()),
      );
    });
  }

  @override
  void dispose() {
    _bookIconFadeController.dispose();
    _bookIconScaleController.dispose();
    _textFadeController.dispose();
    _zoomOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: AnimatedBuilder(
          animation: _zoomOutController,
          builder: (context, child) {
            return Transform.scale(
              scale: _zoomOutScaleAnimation.value,
              child: Opacity(
                opacity: _zoomOutFadeAnimation.value,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _bookIconFadeAnimation,
                child: ScaleTransition(
                  scale: _bookIconScaleAnimation,
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 100,
                    color: Colors.brown[800],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_showText)
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    'Book Haven',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
