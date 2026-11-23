import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/common_widgets.dart';
import '../data/mock_data.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  int _activeCardIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  void _showProFeature(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature is included in the Full 50-Screen Commercial Bundle (\$29)'),
        backgroundColor: AppTheme.primaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppTheme.darkBg : AppTheme.lightBg;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final subTextCol = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    final activeCard = MockData.virtualCards[_activeCardIndex];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Cards & Limits"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => _showProFeature("Instant Virtual Card Generator"),
            tooltip: "Issue Virtual Card",
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Swipeable 3D Cards Carousel
              SizedBox(
                height: 215,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: MockData.virtualCards.length,
                  onPageChanged: (index) => setState(() => _activeCardIndex = index),
                  itemBuilder: (context, index) {
                    final card = MockData.virtualCards[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: VirtualCardWidget(
                        card: card,
                        onTap: () => _showProFeature("Card Security Controls & Freeze"),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              // Dot Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(MockData.virtualCards.length, (idx) {
                  final isCurrent = _activeCardIndex == idx;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isCurrent ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: isCurrent ? AppTheme.primaryBlue : (isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              // Fast Card Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _actionBtn(Icons.lock_reset_rounded, "Freeze", () => _showProFeature("Instant Card Freeze"), isDark, textCol),
                    _actionBtn(Icons.visibility_outlined, "Reveal PIN", () => _showProFeature("Biometric PIN Reveal"), isDark, textCol),
                    _actionBtn(Icons.tune_rounded, "Limits", () => _showProFeature("Custom Dynamic Spending Limits"), isDark, textCol),
                    _actionBtn(Icons.add_card_rounded, "New Card", () => _showProFeature("Virtual Card Creator"), isDark, textCol),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Spending Limit Progress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Card Spending Limit", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textCol)),
                          Text(
                            "\$${activeCard.spentThisMonth.toStringAsFixed(0)} / \$${activeCard.spendingLimit.toStringAsFixed(0)}",
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.primaryBlue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: (activeCard.spentThisMonth / activeCard.spendingLimit).clamp(0.0, 1.0),
                          minHeight: 8,
                          backgroundColor: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${((activeCard.spentThisMonth / activeCard.spendingLimit) * 100).toStringAsFixed(0)}% Utilized",
                            style: TextStyle(fontSize: 11, color: subTextCol, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\$${(activeCard.spendingLimit - activeCard.spentThisMonth).toStringAsFixed(0)} Remaining",
                            style: const TextStyle(fontSize: 11, color: AppTheme.accentEmerald, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Upgrade to 50 Screens Callout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)]),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 28),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upgrade to Full 50-Screen Kit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.5)),
                            SizedBox(height: 2),
                            Text("Unlock Crypto, Split Bill, Utilities & Figma (.fig)", style: TextStyle(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text("\$29", style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.w900, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onTap, bool isDark, Color textCol) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
              shape: BoxShape.circle,
              border: Border.all(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
            ),
            child: Icon(icon, size: 20, color: AppTheme.primaryBlue),
          ),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textCol)),
        ],
      ),
    );
  }
}
