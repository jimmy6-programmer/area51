import 'dart:async';
import 'package:flutter/material.dart';

// BannerItem lives ONLY here – delete it from home_screen_content.dart
class BannerItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String buttonText;

  BannerItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.buttonText,
  });
}

class AutoBannerCarousel extends StatefulWidget {
  final List<BannerItem> banners;
  final Duration interval;

  const AutoBannerCarousel({
    super.key,
    required this.banners,
    this.interval = const Duration(seconds: 4),
  });

  @override
  State<AutoBannerCarousel> createState() => _AutoBannerCarouselState();
}

class _AutoBannerCarouselState extends State<AutoBannerCarousel> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.banners.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = widget.banners[_currentIndex];
    final green = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 380,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: Image.network(
              banner.imageUrl,
              key: ValueKey<int>(_currentIndex),
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.45),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  banner.title,
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    height: 1.05,
                    shadows: [Shadow(blurRadius: 12, color: Colors.black87)],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  banner.subtitle,
                  style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.85)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {}, // → add navigation later
                  child: Text(banner.buttonText),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: i == _currentIndex ? 24 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: i == _currentIndex ? green : Colors.white30,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}