// lib/screens/offers_screen_content.dart
import 'package:flutter/material.dart';

class OfferItem {
  final String title;
  final String description;
  final String code;
  final String discountText;
  final String? validity;
  final String imageUrl;
  final bool isExclusive;
  final Color? accentColor;

  OfferItem({
    required this.title,
    required this.description,
    required this.code,
    required this.discountText,
    this.validity,
    this.imageUrl = '',
    this.isExclusive = false,
    this.accentColor,
  });
}

class OffersScreenContent extends StatelessWidget {
  const OffersScreenContent({super.key});

  // Static data (same as before)
  static final List<OfferItem> _offers = [
    OfferItem(
      title: "First Contact Discount",
      description: "New earthlings get 50% off their first mission (max 15,000 RWF)",
      code: "WELCOME51",
      discountText: "50% OFF",
      validity: "Valid for first order only • Expires in 30 days",
      imageUrl:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80",
      isExclusive: true,
      accentColor: const Color(0xFF00FF41),
    ),
    OfferItem(
      title: "Warp Speed Delivery",
      description: "Free delivery on all orders above 8,000 RWF",
      code: "WARP8K",
      discountText: "FREE DELIVERY",
      validity: "No expiry • Minimum order 8,000 RWF",
      imageUrl:
          "https://images.unsplash.com/photo-1671572578870-1fcac451899b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      accentColor: const Color(0xFF39FF14),
    ),
    OfferItem(
      title: "Galactic Feast Deal",
      description: "Family size combo • 2 large items + 2 sides + 2 drinks",
      code: "GALAXY4",
      discountText: "SAVE 25%",
      validity: "Valid until February 28, 2026",
      imageUrl:
          "https://images.unsplash.com/photo-1681072530653-db8fe2538631?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      isExclusive: false,
    ),
    OfferItem(
      title: "Midnight Alien Munchies",
      description: "20% off everything between 22:00 – 02:00",
      code: "NIGHT51",
      discountText: "20% OFF",
      validity: "Daily 10 PM – 2 AM",
      imageUrl: "",
      accentColor: Colors.deepPurpleAccent,
    ),
    OfferItem(
      title: "Refer a Human",
      description: "Invite a friend → both get 5,000 RWF credit after first order",
      code: "BEAMAFRIEND",
      discountText: "5,000 RWF EACH",
      validity: "Unlimited referrals",
      isExclusive: true,
      accentColor: const Color(0xFF00E5FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [green.withOpacity(0.25), green.withOpacity(0.08)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: green.withOpacity(0.4), width: 1.5),
            ),
            child: Column(
              children: [
                Text(
                  "Unlock Classified Deals 👽",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Active promotions • Limited time only",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Fixed SliverList – now using the local _offers list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final offer = _offers[index];
              return _OfferCard(offer: offer);
            },
            childCount: _offers.length,
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }
}

// The card widget – must be defined here (or moved to widgets/ folder)
class _OfferCard extends StatelessWidget {
  final OfferItem offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    final accent = offer.accentColor ?? green;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF112211),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accent.withOpacity(offer.isExclusive ? 0.7 : 0.3),
          width: offer.isExclusive ? 1.8 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (offer.imageUrl.isNotEmpty)
              SizedBox(
                height: 140,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      offer.imageUrl,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.45),
                      colorBlendMode: BlendMode.darken,
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          offer.discountText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    if (offer.isExclusive)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "EXCLUSIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    offer.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.85),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: accent.withOpacity(0.5)),
                        ),
                        child: Text(
                          offer.code,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: accent,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.copy, size: 18, color: Colors.white54),
                      const SizedBox(width: 4),
                      Text(
                        "Tap to copy",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),

                  if (offer.validity != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      offer.validity!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.55),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}