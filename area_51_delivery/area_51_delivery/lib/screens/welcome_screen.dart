// lib/screens/welcome_screen.dart
import 'dart:async';
import 'package:area_51_delivery/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/alien_heartbeat_logo.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Minimum 3 seconds delay before navigating
    Timer(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background image
          Image.asset(
            'assets/images/back.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // 2. Dark overlay (keeps dark green-black mood + makes image visible)
          Container(
            color: const Color(0xFF0A1A0F).withOpacity(0.68), // ← main control here
            // Try values between 0.55 – 0.80 depending on how visible you want the bg image
          ),

          // 3. Content on top
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo / brand
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 48),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AlienHeartbeatLogo(size: 64),
                      ],
                    ),
                  ),

                  // Dancing chef animation
                  Expanded( 
                    child: Lottie.asset(
                      'assets/animations/star.json', 
                    fit: BoxFit.contain, 
                    repeat: true, ), 
                    ),


                  // Welcome text
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 80),
                    child: Column(
                      children: [
                        Text(
                          'Preparing extraterrestrial flavors...',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.94),
                            shadows: const [
                              Shadow(blurRadius: 8, color: Colors.black87),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your secret delivery is almost ready 👽',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.75),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}