import 'package:area_51_delivery/screens/home_screen_content.dart';
import 'package:area_51_delivery/screens/menu_screen_content.dart';
import 'package:area_51_delivery/screens/offers_screen_content.dart';
import 'package:area_51_delivery/screens/profile_screen_content.dart';
import 'package:area_51_delivery/widgets/alien_heartbeat_logo.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'cart_screen_content.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final String? initialMenuCategory;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
    this.initialMenuCategory,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  List<Widget> get _screens => [
    const HomeScreenContent(), // only content – no Scaffold, no bottom bar
    const OffersScreenContent(), // only content – no Scaffold, no bottom bar
    MenuScreenContent(selectedCategory: widget.initialMenuCategory),
    const ProfileScreenContent(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AlienHeartbeatLogo(size: 48), // ← your reusable logo widget
          ],
        ),
        centerTitle: false, // ← crucial: moves title to left
        actions: [
          // Shopping cart with badge
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AppBar(title: const Text('Cart')),
                          body: const CartScreenContent(),
                        ),
                      ),
                    );
                  },
                ),

                // Badge
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: const Center(
                      child: Text(
                        '3', // TODO: wire to real cart count
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: IndexedStack(index: _selectedIndex, children: _screens),

      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
