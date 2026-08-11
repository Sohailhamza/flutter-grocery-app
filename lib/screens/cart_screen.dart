import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? initialCartItems;

  const CartScreen({super.key, this.initialCartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Demo cart items matching the schema used in HomeScreen
  late List<Map<String, dynamic>> _cartItems;

  @override
  void initState() {
    super.initState();
    // Use passed items or default demo items for preview
    _cartItems = widget.initialCartItems ??
        [
          {
            'name': 'Avacoda',
            'unit': '2.0 lbs',
            'price': 7.00,
            'color': const Color(0xFFF0F7E6),
            'image': 'assets/images/avocado.png',
            'qty': 1,
          },
          {
            'name': 'Pomegranate',
            'unit': '1.50 lbs',
            'price': 2.09,
            'color': const Color(0xFFFFEBEE),
            'image': 'assets/images/pomegranate.png',
            'qty': 2,
          },
        ];
  }

  // Calculate subtotal dynamically
  double get _subtotal {
    return _cartItems.fold(0.0, (sum, item) {
      final double price = item['price'] is double
          ? item['price']
          : double.tryParse(item['price'].toString().replaceAll('\$', '')) ?? 0.0;
      final int qty = item['qty'] as int;
      return sum + (price * qty);
    });
  }

  final double _shippingFee = 3.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  _cartItems.clear();
                });
              },
            ),
        ],
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartList(),
      bottomNavigationBar: _cartItems.isEmpty ? null : _buildCheckoutSection(),
    );
  }

  // ─── Empty Cart State ──────────────────────────────────────────
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 60,
              color: Color(0xFF7CC344),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Cart is Totally Empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Looks like you haven\'t added anything\nto your cart yet.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.maybePop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7CC344),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Start Shopping',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Cart Items List ───────────────────────────────────────────
  Widget _buildCartList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _cartItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        final double price = item['price'] is double
            ? item['price']
            : double.tryParse(item['price'].toString().replaceAll('\$', '')) ?? 0.0;

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFF0F0F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Product Image Container
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: (item['color'] as Color? ?? const Color(0xFFE8F5E9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    item['image'] as String,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.eco,
                      color: Color(0xFF7CC344),
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['unit'] as String,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7CC344),
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity Selector
              _buildQtySelector(index),
            ],
          ),
        );
      },
    );
  }

  // ─── Quantity Control Widget ──────────────────────────────────
  Widget _buildQtySelector(int index) {
    final int qty = _cartItems[index]['qty'] as int;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (qty > 1) {
                _cartItems[index]['qty'] = qty - 1;
              } else {
                _cartItems.removeAt(index);
              }
            });
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              qty == 1 ? Icons.delete_outline : Icons.remove,
              size: 16,
              color: qty == 1 ? Colors.redAccent : Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$qty',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _cartItems[index]['qty'] = qty + 1;
            });
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF7CC344),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.add, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ─── Bottom Checkout Section ──────────────────────────────────
  Widget _buildCheckoutSection() {
    final double total = _subtotal + _shippingFee;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text('\$${_subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping Fee', style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text('\$${_shippingFee.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7CC344),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Checkout logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7CC344),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}