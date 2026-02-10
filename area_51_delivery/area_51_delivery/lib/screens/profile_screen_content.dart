// lib/screens/profile_screen_content.dart
import 'package:area_51_delivery/screens/profile/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:area_51_delivery/screens/profile/my_orders_screen.dart';
import 'package:area_51_delivery/screens/profile/saved_addresses_screen.dart';
import 'package:area_51_delivery/screens/profile/settings_screen.dart';
import 'package:area_51_delivery/screens/profile/help_support_screen.dart';

class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;

    return CustomScrollView(
      slivers: [
        // Profile Header
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  green.withOpacity(0.25),
                  green.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: green.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),

                // Name & Info
                const Text(
                  "Gatera",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "gatera@example.com • Joined Jan 2025",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),

                // Membership / Level
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: green.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: green, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        "Area 51 Customer",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Quick Stats
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatItem(
                  icon: Icons.receipt_long,
                  value: "42",
                  label: "Orders",
                ),
                _StatItem(
                  icon: Icons.monetization_on,
                  value: "12,450",
                  label: "Points",
                ),
                _StatItem(icon: Icons.favorite, value: "7", label: "Favorites"),
              ],
            ),
          ),
        ),

        // Menu Options
        SliverList(
          delegate: SliverChildListDelegate([
            _ProfileTile(
              icon: Icons.history,
              title: "My Orders",
              subtitle: "View past orders and reorder",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
              ),
            ),
            _ProfileTile(
              icon: Icons.location_on,
              title: "Saved Addresses",
              subtitle: "Manage delivery locations",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedAddressesScreen()),
              ),
            ),
            // _ProfileTile(
            //   icon: Icons.payment,
            //   title: "Payment Methods",
            //   subtitle: "Cards, Mobile Money, etc.",
            //   onTap: () {},
            // ),
            _ProfileTile(
              icon: Icons.favorite_border,
              title: "Favorites",
              subtitle: "Your most loved items",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              ),
            ),
            // _ProfileTile(
            //   icon: Icons.notifications,
            //   title: "Notifications",
            //   subtitle: "Manage alerts & promotions",
            //   onTap: () {},
            // ),
            _ProfileTile(
              icon: Icons.settings,
              title: "Settings",
              subtitle: "App preferences & account",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            _ProfileTile(
              icon: Icons.help_outline,
              title: "Help & Support",
              subtitle: "FAQs, contact us",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Colors.white12),
            _ProfileTile(
              icon: Icons.logout,
              title: "Log Out",
              subtitle: null,
              color: Colors.redAccent,
              onTap: () {
                // TODO: logout logic
              },
            ),
          ]),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Icon(icon, color: green, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.65)),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = color ?? Colors.white.withOpacity(0.9);

    return ListTile(
      leading: Icon(icon, color: tileColor, size: 26),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          color: tileColor,
          fontWeight: title == "Log Out" ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.65),
              ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      onTap: onTap,
    );
  }
}
