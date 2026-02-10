import 'package:flutter/material.dart';

class OrderItem {
  final String orderId;
  final String date;
  final String status;
  final double total;
  final String itemsSummary;
  final Color statusColor;

  OrderItem({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.itemsSummary,
    required this.statusColor,
  });
}

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static final List<OrderItem> _orders = [
    OrderItem(
      orderId: "#A51-9876",
      date: "Feb 4, 2026",
      status: "Delivered",
      total: 24500,
      itemsSummary: "Hot Wings ×2, Galactic Fries",
      statusColor: Colors.green,
    ),
    OrderItem(
      orderId: "#A51-9875",
      date: "Jan 28, 2026",
      status: "Cancelled",
      total: 9500,
      itemsSummary: "Black Hole Burger",
      statusColor: Colors.redAccent,
    ),
    OrderItem(
      orderId: "#A51-9874",
      date: "Jan 15, 2026",
      status: "Processing",
      total: 16800,
      itemsSummary: "Meteor Margarita ×2, Fries",
      statusColor: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: _orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 80, color: Colors.white54),
                  const SizedBox(height: 16),
                  const Text(
                    "No orders yet",
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "When you place an order,\n it will appear here",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: const Color(0xFF112211),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // TODO: go to order details
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.orderId,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: order.statusColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  order.status,
                                  style: TextStyle(
                                    color: order.statusColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order.date,
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order.itemsSummary,
                            style: TextStyle(color: Colors.white54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${order.total.toStringAsFixed(0)} RWF",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.replay, size: 18),
                                label: const Text("Reorder"),
                                style: TextButton.styleFrom(foregroundColor: green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}