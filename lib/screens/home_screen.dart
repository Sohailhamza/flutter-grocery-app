import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBanner = 0;
  int _bottomNavIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.eco, 'label': 'Vegetables', 'color': Color(0xFF4CAF50), 'bg': Color(0xFFE8F5E9)},
    {'icon': Icons.apple, 'label': 'Fruits', 'color': Color(0xFFE53935), 'bg': Color(0xFFFFEBEE)},
    {'icon': Icons.local_drink, 'label': 'Beverages', 'color': Color(0xFFFFA726), 'bg': Color(0xFFFFF3E0)},
    {'icon': Icons.shopping_basket, 'label': 'Grocery', 'color': Color(0xFF7B1FA2), 'bg': Color(0xFFF3E5F5)},
    {'icon': Icons.water_drop, 'label': 'Edible oil', 'color': Color(0xFF00ACC1), 'bg': Color(0xFFE0F7FA)},
    {'icon': Icons.home, 'label': 'Househ...', 'color': Color(0xFFEC407A), 'bg': Color(0xFFFCE4EC)},
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Fresh Peach',
      'unit': 'dozen',
      'price': '\$8.00',
      'color': Color(0xFFFFF0E6),
      'image': 'assets/images/peach.png',
      'badge': null,
      'liked': false,
      'inCart': false,
      'qty': 0,
    },
    {
      'name': 'Avacoda',
      'unit': '2.0 lbs',
      'price': '\$7.00',
      'color': Color(0xFFF0F7E6),
      'image': 'assets/images/avacoda.png',
      'badge': 'NEW',
      'liked': false,
      'inCart': true,
      'qty': 1,
    },
    {
      'name': 'Pineapple',
      'unit': '1.50 lbs',
      'price': '\$9.90',
      'color': Color(0xFFFFF8E1),
      'image': 'assets/images/pineapple.png',
      'badge': null,
      'liked': true,
      'inCart': false,
      'qty': 0,
    },
    {
      'name': 'Black Grapes',
      'unit': '5.0 lbs',
      'price': '\$7.05',
      'color': Color(0xFFF8E8F0),
      'image': 'assets/images/grapes.png',
      'badge': '-16%',
      'liked': false,
      'inCart': false,
      'qty': 0,
    },
    {
      'name': 'Pomegranate',
      'unit': '1.50 lbs',
      'price': '\$2.09',
      'color': Color(0xFFFFEBEE),
      'image': 'assets/images/pomegranate.png',
      'badge': 'NEW',
      'liked': false,
      'inCart': true,
      'qty': 1,
    },
    {
      'name': 'Fresh Broccoli',
      'unit': '1 kg',
      'price': '\$3.00',
      'color': Color(0xFFE8F5E9),
      'image': 'assets/images/broccoli.png',
      'badge': null,
      'liked': true,
      'inCart': false,
      'qty': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Slider
                    _buildBannerSlider(),
                    const SizedBox(height: 20),

                    // Categories
                    _buildSectionHeader('Categories'),
                    const SizedBox(height: 14),
                    _buildCategories(),
                    const SizedBox(height: 20),

                    // Featured Products
                    _buildSectionHeader('Featured products'),
                    const SizedBox(height: 14),
                    _buildProductGrid(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(),

      // Floating Cart Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF7CC344),
        shape: const CircleBorder(),
        child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 26),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  // ─── Search Bar ───────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search, color: Colors.grey, size: 22),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Search keywords..',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.tune, color: Colors.grey, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Banner Slider ────────────────────────────────────────────
  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: 3,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                decoration: const BoxDecoration(
                  color: Color(0xFF8BC34A),
                ),
                child: Stack(
                  children: [
                    // Background pattern / image placeholder
                    Positioned.fill(
                      child: Container(
                        color: const Color(0xFFAED581),
                        child: Row(
                          children: [
                            // Left text area
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      '20% off on your\nfirst purchase',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Right image area
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: const Color(0xFFCDDC39).withOpacity(0.3),
                                child: const Center(
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 80,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Dots indicator
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBanner == i ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentBanner == i
                    ? const Color(0xFF7CC344)
                    : const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ─── Section Header ───────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  // ─── Categories ───────────────────────────────────────────────
  Widget _buildCategories() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: cat['bg'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    cat['icon'] as IconData,
                    color: cat['color'] as Color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  cat['label'] as String,
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Product Grid ─────────────────────────────────────────────
  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(index);
        },
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final product = _products[index];
    final bool inCart = product['inCart'] as bool;
    final bool liked = product['liked'] as bool;
    final String? badge = product['badge'] as String?;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Expanded(
            child: Stack(
              children: [
                // Product image background
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: product['color'] as Color,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        product['image'] as String,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => Icon(
                          Icons.eco,
                          size: 60,
                          color: (product['color'] as Color).withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),

                // Badge (NEW / discount)
                if (badge != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: badge == 'NEW'
                            ? const Color(0xFFFFA726)
                            : const Color(0xFFE53935),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // Heart icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _products[index]['liked'] = !liked),
                    child: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product info
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['price'] as String,
                  style: const TextStyle(
                    color: Color(0xFF7CC344),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product['unit'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),

                // Add to cart OR quantity selector
                inCart
                    ? _buildQtySelector(index)
                    : _buildAddToCartButton(index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(int index) {
    return GestureDetector(
      onTap: () => setState(() {
        _products[index]['inCart'] = true;
        _products[index]['qty'] = 1;
      }),
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_bag_outlined, size: 16, color: Colors.grey),
            SizedBox(width: 6),
            Text(
              'Add to cart',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQtySelector(int index) {
    final int qty = _products[index]['qty'] as int;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() {
            if (qty > 1) {
              _products[index]['qty'] = qty - 1;
            } else {
              _products[index]['inCart'] = false;
              _products[index]['qty'] = 0;
            }
          }),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.remove, size: 16, color: Colors.grey),
          ),
        ),
        Text(
          '$qty',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _products[index]['qty'] = qty + 1),
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

  // ─── Bottom Nav ───────────────────────────────────────────────
  Widget _buildBottomNav() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_outlined, Icons.home, 0),
            _navItem(Icons.person_outline, Icons.person, 1),
            _navItem(Icons.favorite_border, Icons.favorite, 2),
            const SizedBox(width: 48), // space for FAB
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData outline, IconData filled, int index) {
    final bool active = _bottomNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _bottomNavIndex = index),
      child: Icon(
        active ? filled : outline,
        color: active ? const Color(0xFF7CC344) : Colors.grey,
        size: 26,
      ),
    );
  }
}