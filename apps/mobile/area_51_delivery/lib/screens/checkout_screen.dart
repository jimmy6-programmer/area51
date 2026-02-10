import 'package:area_51_delivery/screens/order_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:url_launcher/url_launcher.dart'; // ← Added for dialer

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _couponController = TextEditingController();
  bool _isApplyingCoupon = false;
  double _discount = 0.0;
  String _couponMessage = '';

  String selectedAddress = "KN 5 Rd, Kicukiro, Kigali";

  // Sample order values
  final double subtotal = 24500;
  final double deliveryFee = 1500;
  final double serviceFee = 800;

  double get totalBeforeDiscount => subtotal + deliveryFee + serviceFee;
  double get total => totalBeforeDiscount - _discount;

  void _applyCoupon() async {
    final code = _couponController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() {
      _isApplyingCoupon = true;
      _couponMessage = '';
    });

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _isApplyingCoupon = false;
      if (code == "WELCOME51" || code == "AREA51") {
        _discount = 3000;
        _couponMessage = 'Coupon applied! -3,000 RWF';
      } else {
        _discount = 0;
        _couponMessage = 'Invalid or expired coupon';
      }
    });
  }

  void _showAddressPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.6,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            final TextEditingController addressController =
                TextEditingController(text: selectedAddress);

            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select or Search Address",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  GooglePlaceAutoCompleteTextField(
                    textEditingController: addressController,
                    textStyle: const TextStyle(color: Colors.white),
                    googleAPIKey: "AIzaSyCVa3bDTN02rbw5aIdBntj_Af0YDxu0lmE",
                    inputDecoration: InputDecoration(
                      hintText: "Search address (Kigali, Rwanda...)",
                      hintStyle: TextStyle(color: Colors.white60),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.08),
                    ),
                    debounceTime: 600,
                    countries: ["rw"],
                    isLatLngRequired: false,
                    itemClick: (Prediction prediction) {
                      setState(() {
                        selectedAddress = prediction.description ?? '';
                      });
                      Navigator.pop(context);
                    },
                    getPlaceDetailWithLatLng: (Prediction prediction) {},
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                prediction.description ?? '',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    seperatedBuilder: const Divider(),
                    isCrossBtnShown: true,
                  ),

                  const SizedBox(height: 24),
                  const Text("Or enter manually:", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Street, Sector, District...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.08),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        setState(() => selectedAddress = value.trim());
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ── New: Dial USSD codes ───────────────────────────────────────────────────
  Future<void> _dialUSSD(String ussdCode) async {
    final Uri uri = Uri.parse('tel:$ussdCode');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open dialer")),
      );
    }
  }

  void _placeOrder() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;
    final totalInt = total.toInt(); // for USSD

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Summary", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: green)),
                  const SizedBox(height: 16),

                  _OrderItemRow("Subtotal", subtotal),
                  _OrderItemRow("Delivery Fee", deliveryFee),
                  _OrderItemRow("Service Fee", serviceFee),

                  if (_discount > 0) ...[
                    const Divider(height: 24, color: Colors.white24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount", style: TextStyle(color: Colors.green)),
                        Text("-${_discount.toStringAsFixed(0)} RWF", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],

                  const Divider(height: 32, color: Colors.white24),
                  _OrderItemRow("Total", total, isBold: true, color: green),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery To", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      TextButton.icon(
                        onPressed: _showAddressPicker,
                        icon: const Icon(Icons.edit_location_outlined, size: 18),
                        label: const Text("Change"),
                        style: TextButton.styleFrom(foregroundColor: green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: green),
                      const SizedBox(width: 8),
                      Expanded(child: Text(selectedAddress, style: TextStyle(fontSize: 15, color: Colors.white70))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, color: green),
                      const SizedBox(width: 8),
                      Text("Estimated arrival: 25–35 min", style: TextStyle(fontSize: 15, color: Colors.white70)),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Text("Have a coupon?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _couponController,
                          decoration: InputDecoration(
                            hintText: "Enter code (e.g. WELCOME51)",
                            hintStyle: TextStyle(color: Colors.white60),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _isApplyingCoupon ? null : _applyCoupon,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isApplyingCoupon
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 3))
                            : const Text("Apply"),
                      ),
                    ],
                  ),
                  if (_couponMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _couponMessage,
                        style: TextStyle(
                          color: _discount > 0 ? Colors.green : Colors.redAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Payment Section with interactive dial buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: green)),
                  const SizedBox(height: 12),
                  Text("Pay using MTN MoMo", style: TextStyle(fontSize: 16, color: Colors.white70)),
                  const SizedBox(height: 24),

                  // Pay on Phone Button
                  ElevatedButton.icon(
                    onPressed: () {
                      final ussd = "*182*1*1*0788123456*$totalInt#";
                      _dialUSSD(ussd);
                    },
                    icon: const Icon(Icons.phone),
                    label: Text("Pay on Phone"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Pay on Code Button
                  ElevatedButton.icon(
                    onPressed: () {
                      final ussd = "*182*8*1*010203*$totalInt#";
                      _dialUSSD(ussd);
                    },
                    icon: const Icon(Icons.code),
                    label: Text("Pay on Code"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green.withOpacity(0.8),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Instruction box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.withOpacity(0.4)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "After dialing and completing payment on your phone, "
                            "come back to this screen and click the \"Place Order\" button below "
                            "to finalize your checkout.",
                            style: TextStyle(color: Colors.amber[100], height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 140)),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _placeOrder,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text("Place Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 8,
              shadowColor: green.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _OrderItemRow(String label, double amount, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 17 : 15,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            "${amount.toStringAsFixed(0)} RWF",
            style: TextStyle(
              fontSize: isBold ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: color ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}