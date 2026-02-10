// lib/screens/cart_screen_content.dart
import 'package:flutter/material.dart';
import 'package:area_51_delivery/screens/checkout_screen.dart';

class CartItem {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final String? note;

  CartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.note,
  });
}

class CartScreenContent extends StatelessWidget {
  const CartScreenContent({super.key});

  // Static sample cart data
  static final List<CartItem> _cartItems = [
    CartItem(
      name: "Extraterrestrial Hot Wings (12 pcs)",
      imageUrl:
          "https://images.unsplash.com/photo-1624153064067-566cae78993d?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 8500,
      quantity: 2,
      note: "Extra spicy please",
    ),
    CartItem(
      name: "Black Hole Burger",
      imageUrl:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80",
      price: 9500,
      quantity: 1,
    ),
    CartItem(
      name: "Galactic Fries (Large)",
      imageUrl:
          "https://images.unsplash.com/photo-1626700051175-6818013e1d4f?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0",
      price: 4200,
      quantity: 1,
    ),
  ];

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  double get _deliveryFee => 1500;
  double get _serviceFee => 800;
  double get _total => _subtotal + _deliveryFee + _serviceFee;

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return CustomScrollView(
      slivers: [
        // Header / summary
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Cart",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${_cartItems.length} items • Kigali delivery",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Cart items list
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = _cartItems[index];
            return _CartItemTile(item: item);
          }, childCount: _cartItems.length),
        ),

        // Bottom summary & checkout button (pinned at bottom)
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF112211),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _SummaryRow(context, "Subtotal", _subtotal),
                    _SummaryRow(context, "Delivery Fee", _deliveryFee),
                    _SummaryRow(context, "Service Fee", _serviceFee),
                    const Divider(height: 24, color: Colors.white24),
                    _SummaryRow(context, "Total", _total, isTotal: true),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutScreen(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: green.withOpacity(0.5),
                        ),
                        child: const Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Fixed: now receives context so Theme.of(context) works
  Widget _SummaryRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
  }) {
    final green = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.white : Colors.white70,
            ),
          ),
          Text(
            "${amount.toStringAsFixed(0)} RWF",
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? green : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;

  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: const Color(0xFF112211),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Optional: edit item / go to product detail
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.fastfood, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.note != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          "Note: ${item.note}",
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item.price.toStringAsFixed(0)} RWF",
                            style: TextStyle(
                              fontSize: 16,
                              color: green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 28,
                                ),
                                color: Colors.white70,
                                onPressed: () {}, // decrease quantity
                              ),
                              Text(
                                "${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 28,
                                ),
                                color: green,
                                onPressed: () {}, // increase quantity
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
