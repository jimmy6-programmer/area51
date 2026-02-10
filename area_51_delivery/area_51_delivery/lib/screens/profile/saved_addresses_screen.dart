import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class Address {
  final String title;
  final String fullAddress;
  final bool isDefault;

  Address({
    required this.title,
    required this.fullAddress,
    this.isDefault = false,
  });
}

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final List<Address> _addresses = [
    Address(
      title: "Home",
      fullAddress: "KN 5 Rd, Kicukiro, Kigali, Rwanda",
      isDefault: true,
    ),
    Address(
      title: "Office",
      fullAddress: "Nyarugenge, Kigali City Tower, 4th Floor",
      isDefault: false,
    ),
    Address(
      title: "Friend's Place",
      fullAddress: "Gisozi, Kimihurura, Kigali",
      isDefault: false,
    ),
  ];

  void _showAddEditAddressDialog({Address? existingAddress, int? index}) {
    final isEdit = existingAddress != null;
    final titleCtrl = TextEditingController(text: existingAddress?.title ?? '');
    final addressCtrl = TextEditingController(text: existingAddress?.fullAddress ?? '');
    bool isDefault = existingAddress?.isDefault ?? false;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF063E1F),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit ? "Edit Address" : "Add Address",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(dialogContext).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title field
                  TextField(
                    controller: titleCtrl,
                    decoration: InputDecoration(
                      hintText: 'Title (e.g. Home, Office)',
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Google Places Autocomplete
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: addressCtrl,
                    textStyle: const TextStyle(color: Colors.white),
                    googleAPIKey: "AIzaSyCVa3bDTN02rbw5aIdBntj_Af0YDxu0lmE",
                    inputDecoration: InputDecoration(
                      hintText: 'Search or enter full address',
                      hintStyle: TextStyle(color: Colors.white60),
                      prefixIcon: Icon(Icons.location_searching, color: Theme.of(dialogContext).colorScheme.primary),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.04),
                    ),
                    debounceTime: 600,
                    countries: ["rw"],
                    isLatLngRequired: false,
                    itemClick: (Prediction prediction) {
                      setDialogState(() {
                        addressCtrl.text = prediction.description ?? '';
                      });
                    },
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

                  const SizedBox(height: 16),

                  // Default checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isDefault,
                        onChanged: (v) => setDialogState(() => isDefault = v ?? false),
                        activeColor: Theme.of(dialogContext).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Set as default address',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          final newTitle = titleCtrl.text.trim();
                          final newAddress = addressCtrl.text.trim();

                          if (newTitle.isEmpty || newAddress.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please fill both title and address")),
                            );
                            return;
                          }

                          setState(() {
                            final newAddr = Address(
                              title: newTitle,
                              fullAddress: newAddress,
                              isDefault: isDefault,
                            );

                            if (isEdit && index != null) {
                              // Edit existing
                              _addresses[index] = newAddr;
                            } else {
                              // Add new
                              _addresses.add(newAddr);
                            }

                            // If set as default, clear others
                            if (isDefault) {
                              for (int i = 0; i < _addresses.length; i++) {
                                if (i != (index ?? _addresses.length - 1)) {
                                  _addresses[i] = Address(
                                    title: _addresses[i].title,
                                    fullAddress: _addresses[i].fullAddress,
                                    isDefault: false,
                                  );
                                }
                              }
                            }
                          });

                          Navigator.pop(dialogContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isEdit ? "Address updated" : "Address added"),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.black,
                        ),
                        child: Text(isEdit ? "Update" : "Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text("Saved Addresses")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => _showAddEditAddressDialog(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _addresses.length,
        itemBuilder: (context, index) {
          final address = _addresses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: const Color(0xFF112211),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Icon(
                Icons.location_on,
                color: address.isDefault ? green : Colors.white54,
              ),
              title: Text(
                address.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: address.isDefault ? green : null,
                ),
              ),
              subtitle: Text(
                address.fullAddress,
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (address.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "DEFAULT",
                        style: TextStyle(color: green, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white70),
                    onPressed: () => _showAddEditAddressDialog(existingAddress: address, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      setState(() => _addresses.removeAt(index));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Address deleted")),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}