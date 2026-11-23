import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/common_widgets.dart';
import '../data/mock_data.dart';
import 'ai_copilot_chat_screen.dart';
import 'analytics_cashflow_screen.dart';
import 'my_cards_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  final bool isDarkShowcase;

  const HomeDashboardScreen({super.key, this.isDarkShowcase = false});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDarkShowcase;
  }

  void _showProFeatureToast(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature is included in the Full 50-Screen Kit (\$29)'),
        backgroundColor: AppTheme.primaryBlue,
        action: SnackBarAction(
          label: 'Learn More',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBg = _isDark ? AppTheme.darkBg : AppTheme.lightBg;
    final textCol = _isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final subTextCol = _isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Theme(
      data: _isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: scaffoldBg,
        drawer: AppDrawer(
          isDarkMode: _isDark,
          onThemeChanged: (val) => setState(() => _isDark = val),
        ),
        appBar: AppBar(
          backgroundColor: scaffoldBg,
          elevation: 0,
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.menu_rounded, color: textCol),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: AppTheme.primaryBlue.withOpacity(0.15),
                child: const Text("AM", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.primaryBlue)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi, Alex 👋", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textCol)),
                  Text("FinPilot Starter", style: TextStyle(fontSize: 11, color: subTextCol)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () => _showProFeatureToast("Notification Hub"),
            ),
            IconButton(
              icon: Icon(_isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: AppTheme.primaryBlue),
              onPressed: () => setState(() => _isDark = !_isDark),
              tooltip: "Quick Toggle Theme",
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gradient Balance Card with Send / Request / TopUp
                GlassBalanceCard(
                  balance: MockData.userTotalBalance,
                  monthlyExpense: MockData.userMonthlySpent,
                  monthlySavings: MockData.userSavings,
                  onSend: () => _showProFeatureToast("Send Money Flow"),
                  onReceive: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cashtag & Payment Link copied!")),
                    );
                  },
                  onTopUp: () => _showProFeatureToast("Auto-Deposit Gateway"),
                ),

                const SizedBox(height: 20),

                // AI Smart Insight Floating Banner
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AiCopilotChatScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _isDark ? AppTheme.darkSurface : AppTheme.accentVioletBg,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      border: Border.all(
                        color: _isDark ? AppTheme.darkCardBorder : AppTheme.accentViolet.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.accentViolet.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          ),
                          child: const Icon(Icons.auto_awesome_rounded, color: AppTheme.accentViolet, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "AI Copilot Insights",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: _isDark ? Colors.white : AppTheme.accentViolet,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.accentEmerald,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text("NEW", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "You're \$340 under budget this week! Tap to launch AI Copilot.",
                                style: TextStyle(fontSize: 12, color: subTextCol),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded, color: subTextCol, size: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Quick Action Grid (Navigates to Starter Screens)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickAction(Icons.smart_toy_rounded, "AI Copilot", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AiCopilotChatScreen()),
                      );
                    }, _isDark),
                    _buildQuickAction(Icons.bar_chart_rounded, "Cashflow", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AnalyticsCashflowScreen()),
                      );
                    }, _isDark),
                    _buildQuickAction(Icons.credit_card_rounded, "Cards", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyCardsScreen()),
                      );
                    }, _isDark),
                    _buildQuickAction(Icons.diamond_rounded, "Pro Kit (\$29)", () {
                      _showProFeatureToast("50-Screen Mega Bundle + Figma Source");
                    }, _isDark),
                  ],
                ),

                const SizedBox(height: 28),

                // Recent Transactions Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "RECENT TRANSACTIONS",
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: subTextCol,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showProFeatureToast("Full Transaction History Filter"),
                      child: const Text(
                        "See All",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.primaryBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Transactions List
                ...MockData.transactions.take(5).map((tx) {
                  return TransactionTile(
                    title: tx.title,
                    category: tx.category,
                    date: tx.date,
                    amount: tx.amount,
                    isExpense: tx.isExpense,
                    icon: tx.icon,
                    iconColor: tx.iconColor,
                    iconBg: tx.iconBg,
                    onTap: () => _showProFeatureToast("Interactive Transaction Receipt"),
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
