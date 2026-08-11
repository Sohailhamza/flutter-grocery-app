import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;
  bool _liked = false;
  bool _showMore = false;

  @override
  void initState() {
    super.initState();
    _liked = widget.product['liked'] as bool? ?? false;
    _qty = (widget.product['qty'] as int?) ?? 1;
    if (_qty == 0) _qty = 1;
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;

    final String name = widget.product['name'] as String? ?? 'Product';
    final String price = widget.product['price'] as String? ?? '\$0.00';
    final String unit = widget.product['unit'] as String? ?? '';
    final String image = widget.product['image'] as String? ?? '';
    final Color bgColor = widget.product['color'] as Color? ?? const Color(0xFFF0FAE8);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Scrollable content ──────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero image section ──────────────────────
                  _buildHeroSection(topPadding, screenWidth, image, bgColor),

                  // ── Product info ────────────────────────────
                  _buildProductInfo(name, price, unit),
                ],
              ),
            ),
          ),

          // ── Bottom bar ──────────────────────────────────────
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Hero Section
  // ─────────────────────────────────────────────────────────────
  Widget _buildHeroSection(
    double topPadding,
    double screenWidth,
    String image,
    Color bgColor,
  ) {
    // Derive a slightly darker circle color from the product bg
    final Color circleColor = Color.lerp(bgColor, Colors.green.shade100, 0.4)!;

    return Stack(
      children: [
        // Light colored background
        Container(
          height: 320,
          width: double.infinity,
          color: bgColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Large soft circle
              Positioned(
                bottom: -30,
                child: Container(
                  width: screenWidth * 0.85,
                  height: screenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Product image
              Positioned(
                bottom: 0,
                child: Image.asset(
                  image,
                  height: 260,
                  width: screenWidth,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Container(
                    height: 260,
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.eco,
                      size: 120,
                      color: Colors.green.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Back arrow
        Positioned(
          top: topPadding + 8,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Product Info
  // ─────────────────────────────────────────────────────────────
  Widget _buildProductInfo(String name, String price, String unit) {
    const String fullDesc =
        'Organic Mountain works as a seller for many organic growers '
        'of this product. They are easy to spot in your produce aisle. '
        'They are just like regular products, but they will usually have '
        'a few more scars on the outside of the skin. '
        'These are considered to be the world\'s finest for juicing.';

    const String shortDesc =
        'Organic Mountain works as a seller for many organic growers '
        'of this product. They are easy to spot in your produce aisle. '
        'They are just like regular products, but they will usually have '
        'a few more scars on the outside of the skin. '
        'These are considered to be the world\'s finest lemon for juicing';

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F8F8),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price + Heart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFF7CC344),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _liked = !_liked),
                child: Icon(
                  _liked ? Icons.favorite : Icons.favorite_border,
                  color: _liked ? Colors.red : Colors.grey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Name
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),

          // Unit
          Text(
            unit,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),

          // Stars
          Row(
            children: [
              _buildStars(4.5),
              const SizedBox(width: 8),
              const Text(
                '(89 reviews)',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Description with "more"
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13.5,
                color: Colors.black87,
                height: 1.55,
              ),
              children: [
                TextSpan(text: _showMore ? fullDesc : shortDesc),
                if (!_showMore)
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => setState(() => _showMore = true),
                      child: const Text(
                        ' more',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Quantity row
          _buildQuantityRow(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Stars
  // ─────────────────────────────────────────────────────────────
  Widget _buildStars(double rating) {
    return Row(
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star, color: Color(0xFFFFC107), size: 18);
        } else if (i < rating) {
          return const Icon(Icons.star_half, color: Color(0xFFFFC107), size: 18);
        } else {
          return const Icon(Icons.star_border, color: Color(0xFFFFC107), size: 18);
        }
      }),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Quantity Row
  // ─────────────────────────────────────────────────────────────
  Widget _buildQuantityRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          const Text(
            'Quantity',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() {
              if (_qty > 1) _qty--;
            }),
            child: const Icon(Icons.remove, size: 22, color: Color(0xFF7CC344)),
          ),
          const SizedBox(width: 20),
          Text(
            '$_qty',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () => setState(() => _qty++),
            child: const Icon(Icons.add, size: 22, color: Color(0xFF7CC344)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Bottom Bar
  // ─────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFAEDC81), Color(0xFF7CC344)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Add to cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
