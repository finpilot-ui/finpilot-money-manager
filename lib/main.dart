import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/welcome_auth_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/ai_copilot_chat_screen.dart';
import 'screens/analytics_cashflow_screen.dart';
import 'screens/my_cards_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FinPilotStarterApp());
}

class FinPilotStarterApp extends StatefulWidget {
  const FinPilotStarterApp({super.key});

  @override
  State<FinPilotStarterApp> createState() => _FinPilotStarterAppState();
}

class _FinPilotStarterAppState extends State<FinPilotStarterApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinPilot Starter Kit (5 Screens)',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: StarterGalleryScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: toggleTheme,
      ),
    );
  }
}

class StarterGalleryScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const StarterGalleryScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  static const String gumroadUrl = "https://gumroad.com/l/finpilot-ui-kit";

  @override
  Widget build(BuildContext context) {
    final textCol = isDarkMode ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final subTextCol = isDarkMode ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;
    final cardBg = isDarkMode ? AppTheme.darkSurface : AppTheme.lightSurface;
    final borderColor = isDarkMode ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;

    final screens = [
      {
        "number": "01",
        "title": "Welcome & Trust Auth",
        "category": "Onboarding & Trust Badges",
        "icon": Icons.verified_user_rounded,
        "color": AppTheme.primaryBlue,
        "builder": (BuildContext ctx) => const WelcomeAuthScreen(),
      },
      {
        "number": "02",
        "title": "Home Financial Dashboard",
        "category": "Glass Balance Card & Quick Actions",
        "icon": Icons.dashboard_rounded,
        "color": AppTheme.accentEmerald,
        "builder": (BuildContext ctx) => const HomeDashboardScreen(),
      },
      {
        "number": "03",
        "title": "AI Copilot Financial Chat",
        "category": "Interactive Chat & Expense Trends",
        "icon": Icons.auto_awesome_rounded,
        "color": AppTheme.accentViolet,
        "builder": (BuildContext ctx) => const AiCopilotChatScreen(),
      },
      {
        "number": "04",
        "title": "Cashflow Analytics & Trends",
        "category": "Native Grouped Bar Chart Canvas",
        "icon": Icons.bar_chart_rounded,
        "color": const Color(0xFF0284C7),
        "builder": (BuildContext ctx) => const AnalyticsCashflowScreen(),
      },
      {
        "number": "05",
        "title": "Virtual Cards & Spending Limits",
        "category": "3D Card Carousel & Dynamic Controls",
        "icon": Icons.credit_card_rounded,
        "color": const Color(0xFFF59E0B),
        "builder": (BuildContext ctx) => const MyCardsScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FinPilot Starter (5 Screens)"),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: AppTheme.primaryBlue),
            onPressed: onToggleTheme,
            tooltip: "Switch Theme",
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Pro Bundle Callout Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF2563EB), Color(0xFF7C3AED)],
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text("COMMERCIAL EDITION", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                      ),
                      const Spacer(),
                      const Text("\$29", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "FinPilot Mega Bundle\nFull 50 Screens + Figma Source",
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800, height: 1.25),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Includes all 50 screens: Budgets, Crypto/Equities, QR Scanner, Split Bill, Paywalls & Figma Auto-Layout.",
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.35),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Download Link: https://gumroad.com/l/finpilot-ui-kit"),
                            backgroundColor: AppTheme.accentEmerald,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                      label: const Text("Get Full 50-Screen Kit (\$29)", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "INCLUDED 5 FLAGSHIP SCREENS",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.8, color: subTextCol),
            ),
            const SizedBox(height: 10),

            ...screens.map((screen) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => (screen["builder"] as WidgetBuilder)(c)),
                      );
                    },
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (screen["color"] as Color).withOpacity(0.14),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      ),
                      child: Icon(screen["icon"] as IconData, color: screen["color"] as Color, size: 22),
                    ),
                    title: Text(
                      screen["title"] as String,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textCol),
                    ),
                    subtitle: Text(
                      screen["category"] as String,
                      style: TextStyle(fontSize: 11.5, color: subTextCol),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
