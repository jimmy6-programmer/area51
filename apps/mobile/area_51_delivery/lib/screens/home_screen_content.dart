import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/auto_banner_carousel.dart';
import '../widgets/promo_card.dart';
import 'main_screen.dart';

// ── 2. Main Home Content Screen
class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  bool _isLoading = true;

  final List<BannerItem> _banners = [
    BannerItem(
      title: 'BITE INTO\nAREA 51\nGOODNESS',
      subtitle: 'Classified crispy perfection',
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80',
      buttonText: '8000 RWF',
    ),
    BannerItem(
      title: 'OUT OF THIS WORLD\nFLAVORS',
      subtitle: 'Secret recipes delivered at light speed',
      imageUrl:
          'https://images.unsplash.com/photo-1669895616443-5d21d5acc6e0?q=80&w=1025&auto=format&fit=crop&w=800&q=80',
      buttonText: '12000 RWF',
    ),
    BannerItem(
      title: 'ALIEN WINGS\nATTACK',
      subtitle: 'Spicy level: extraterrestrial',
      imageUrl:
          'https://images.unsplash.com/photo-1592415486689-125cbbfcbee2?q=80&w=1025&auto=format&fit=crop&w=800&q=80',
      buttonText: '7000 RWF',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      slivers: [
        _buildBannerSection(),
        _buildLimitedOffersSection(),
        _buildMenuCategoriesSection(),
        _buildReviewsSection(),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  // ── Modular Sections ────────────────────────────────────────────────────────

  Widget _buildBannerSection() {
    return SliverToBoxAdapter(child: AutoBannerCarousel(banners: _banners));
  }

  Widget _buildLimitedOffersSection() {
    final green = Theme.of(context).colorScheme.primary;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'LIMITED TIME OFFERS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('View all')),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  PromoCard(
                    title: 'GRILLED FISH',
                    subtitle: 'For the whole crew',
                    imageUrl:
                        'https://images.unsplash.com/photo-1673436977947-0787164a9abc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                  SizedBox(width: 16),
                  PromoCard(
                    title: 'MEGA WING BOX',
                    subtitle: 'Wings from another planet',
                    imageUrl:
                        'https://plus.unsplash.com/premium_photo-1664478291780-0c67f5fb15e6?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCategoriesSection() {
    final green = Theme.of(context).colorScheme.primary;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Menu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.35,
              children: [
                _CategoryImageCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1624726175512-19b9baf9fbd1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  label: 'Alien Wings',
                ),
                _CategoryImageCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=800&auto=format&fit=crop',
                  label: 'Classified Burgers',
                ),
                _CategoryImageCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?q=80&w=800&auto=format&fit=crop',
                  label: 'Interstellar Sides',
                ),
                _CategoryImageCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1551538827-9c037cb4f32a?q=80&w=800&auto=format&fit=crop',
                  label: 'Drinks from the Void',
                ),
                _CategoryImageCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?q=80&w=800&auto=format&fit=crop',
                  label: 'Sushi & Rice',
                ),
                _CategoryImageCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1587314168485-3236d6710814?q=80&w=1078&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  label: 'Desserts',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    final green = Theme.of(context).colorScheme.primary;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What Our Customers Say',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 160, child: _AutoScrollingReviews()),
          ],
        ),
      ),
    );
  }
}

// ── Reusable Widgets ────────────────────────────────────────────────────────

class _CategoryImageCard extends StatelessWidget {
  final String imageUrl;
  final String label;

  const _CategoryImageCard({required this.imageUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                MainScreen(initialIndex: 2, initialMenuCategory: label),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 8, color: Colors.black87)],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Auto-scrolling Reviews (independent widget) ──────────────────────────────

class _AutoScrollingReviews extends StatefulWidget {
  @override
  State<_AutoScrollingReviews> createState() => _AutoScrollingReviewsState();
}

class _AutoScrollingReviewsState extends State<_AutoScrollingReviews> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  static const double cardWidth = 280.0;
  static const int baseReviews = 5;

  static const List<Map<String, dynamic>> reviews = [
    {
      'name': 'Kagabo',
      'rating': 5,
      'text': 'The hot wings are literally out of this world! 🔥👽',
    },
    {
      'name': 'Aline',
      'rating': 4,
      'text': 'Fast delivery and the burger was huge. Will order again!',
    },
    {
      'name': 'Eric',
      'rating': 5,
      'text': 'Best fries in Kigali. Stardust seasoning is addictive.',
    },
    {
      'name': 'Divine',
      'rating': 5,
      'text': 'Margarita tasted like a meteor shower in my mouth!',
    },
    {
      'name': 'Olivier',
      'rating': 4,
      'text': 'Great value for money. Delivery was super quick.',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      if (!mounted || !_controller.hasClients) return;

      final max = _controller.position.maxScrollExtent;
      final current = _controller.offset;

      if (current >= max - 1) {
        _controller.jumpTo(0);
      } else {
        _controller.jumpTo(current + 1.8); // smooth speed
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return ListView.builder(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30, // enough for infinite feel
      itemBuilder: (context, index) {
        final review = reviews[index % baseReviews];
        return Container(
          width: cardWidth,
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF112211),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: green.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review['rating'] ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                review['text'],
                style: TextStyle(fontSize: 14, color: Colors.white70),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Text(
                "- ${review['name']}",
                style: TextStyle(
                  fontSize: 13,
                  color: green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
