// lib/screens/menu_screen_content.dart
import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class MenuCategory {
  final String name;
  final IconData icon;
  final List<MenuItem> items;

  MenuCategory({required this.name, required this.icon, required this.items});
}

class MenuItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isPopular;
  final String? spiceLevel;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isPopular = false,
    this.spiceLevel,
  });
}

class MenuScreenContent extends StatefulWidget {
  final String? selectedCategory;

  const MenuScreenContent({super.key, this.selectedCategory});

  @override
  State<MenuScreenContent> createState() => _MenuScreenContentState();

  // Static data - categories with sample items
  static final List<MenuCategory> _categories = [
    MenuCategory(
      name: "Alien Wings",
      icon: Icons.dining,
      items: [
        MenuItem(
          name: "Extraterrestrial Hot Wings",
          description: "Crispy wings tossed in classified nebula sauce",
          price: 8500,
          imageUrl:
              "https://images.unsplash.com/photo-1567620832903-9fc6debc209f?q=80&w=780&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          isPopular: true,
          spiceLevel: "Level 9 - Warp Speed",
        ),
        MenuItem(
          name: "Mild Cosmic Wings",
          description: "Gentle introduction for earthling taste buds",
          price: 7200,
          imageUrl:
              "https://images.unsplash.com/photo-1608039829572-78524f79c4c7?auto=format&fit=crop&w=800&q=80",
          spiceLevel: "Level 2",
        ),
      ],
    ),
    MenuCategory(
      name: "Classified Burgers",
      icon: Icons.fastfood,
      items: [
        MenuItem(
          name: "Black Hole Burger",
          description: "Double patty, alien cheese, void sauce",
          price: 9500,
          imageUrl:
              "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80",
          isPopular: true,
        ),
        MenuItem(
          name: "UFO Melt",
          description: "Floating cheese layers, meteor mayo",
          price: 8800,
          imageUrl:
              "https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ),
      ],
    ),
    MenuCategory(
      name: "Interstellar Sides",
      icon: Icons.local_pizza,
      items: [
        MenuItem(
          name: "Galactic Fries",
          description: "Dusted with stardust seasoning",
          price: 4200,
          imageUrl:
              "https://images.unsplash.com/photo-1626700051175-6818013e1d4f?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          isPopular: true,
        ),
        MenuItem(
          name: "Nebula Onion Rings",
          description: "Crispy rings from another dimension",
          price: 3800,
          imageUrl:
              "https://images.unsplash.com/photo-1579208030886-b937da0925dc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ),
      ],
    ),
    MenuCategory(
      name: "Drinks from the Void",
      icon: Icons.local_drink,
      items: [
        MenuItem(
          name: "Meteor Margarita",
          description: "Frozen cosmic blast",
          price: 5500,
          imageUrl:
              "https://images.unsplash.com/photo-1551538827-9c037cb4f32a?auto=format&fit=crop&w=800&q=80",
        ),
        MenuItem(
          name: "Black Matter Cola",
          description: "Dark, fizzy, mysterious",
          price: 2800,
          imageUrl:
              "https://images.unsplash.com/photo-1765265432611-17d3f2da2d5d?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ),
      ],
    ),
  ];
}

class _MenuScreenContentState extends State<MenuScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;

    final displayCats = _buildDisplayCategories();

    return CustomScrollView(
      slivers: [
        // Header banner
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [green.withOpacity(0.25), green.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: green.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  "The Classified Menu",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Recipes not found on any known planet",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.75),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // Search field
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              color: Colors.transparent,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search menu, items, or categories',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: const Color(0xFF0F1A12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: green, width: 1.25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: green, width: 2.0),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Categories & Items
        if (displayCats.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 56,
                    color: green.withOpacity(0.6),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.selectedCategory != null
                        ? 'No items found in "${widget.selectedCategory}".'
                        : 'No items match your search.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try a different search or check other categories.',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...displayCats.map(
            (category) => SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Row(
                      children: [
                        Icon(category.icon, color: green, size: 28),
                        const SizedBox(width: 12),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: category.items.length,
                      itemBuilder: (context, index) {
                        final item = category.items[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                  name: item.name,
                                  description: item.description,
                                  price: item.price,
                                  imageUrl: item.imageUrl,
                                  isPopular: item.isPopular,
                                  spiceLevel: item.spiceLevel,
                                ),
                              ),
                            );
                          },
                          child: _MenuItemCard(item: item),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  List<MenuCategory> _buildDisplayCategories() {
    // Start from full list
    Iterable<MenuCategory> cats = MenuScreenContent._categories;

    // If a specific category was requested, filter to it first
    if (widget.selectedCategory != null) {
      cats = cats.where((c) => c.name == widget.selectedCategory);
    }

    final query = _searchQuery.toLowerCase();
    if (query.isEmpty) return cats.toList();

    // Filter by category name OR item name/description. Also filter items to match query.
    final List<MenuCategory> result = [];
    for (final c in cats) {
      final catMatch = c.name.toLowerCase().contains(query);
      final matchingItems = c.items
          .where(
            (i) =>
                i.name.toLowerCase().contains(query) ||
                i.description.toLowerCase().contains(query),
          )
          .toList();

      if (catMatch) {
        // include full category if category name matches
        result.add(c);
      } else if (matchingItems.isNotEmpty) {
        // include category but only with matching items
        result.add(
          MenuCategory(name: c.name, icon: c.icon, items: matchingItems),
        );
      }
    }

    return result;
  }
}

class _MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const _MenuItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;
    final screenWidth = MediaQuery.of(context).size.width;
    // Make card width responsive: use a fixed width on large screens,
    // but scale down on small devices to avoid overflow.
    // Slightly larger cards: increase base width and scaling on small screens
    final cardWidth = screenWidth < 420 ? screenWidth * 0.78 : 280.0;

    return Container(
      width: cardWidth,
      // Fill the available height from the parent horizontal ListView
      height: double.infinity,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF112211),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: green.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxH = constraints.maxHeight;
            final imageH = maxH * 0.58; // image takes ~58% of height
            final infoH = maxH - imageH;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: imageH,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Image.network(
                          item.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (item.isPopular)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "POPULAR",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      if (item.spiceLevel != null)
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.spiceLevel!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(
                  height: infoH,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Make description flexible so it can shrink on small/tight layouts
                        Flexible(
                          child: Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.75),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${item.price.toStringAsFixed(0)} RWF",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: green,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            const SizedBox(width: 8),

                            SizedBox(
                              width: 72,
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: green,
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(64, 36),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "ADD",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
