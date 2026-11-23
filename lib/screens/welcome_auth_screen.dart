import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/common_widgets.dart';
import 'home_dashboard_screen.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppTheme.darkBg : AppTheme.lightBg;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final subTextCol = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // Logo & App Name
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryBlue, AppTheme.accentViolet],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.auto_graph_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 24),
              Text(
                "Supercharge Your\nFinancial Freedom.",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: textCol,
                  letterSpacing: -0.8,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Join over 250,000+ smart investors automating cashflow, tracking investments, and hitting early retirement.",
                style: TextStyle(
                  fontSize: 15,
                  color: subTextCol,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 36),

              // Trust Badges
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTrustBadge(Icons.lock_outline_rounded, "256-bit AES", isDark),
                    const SizedBox(width: 8),
                    _buildTrustBadge(Icons.verified_user_outlined, "FDIC Insured", isDark),
                    const SizedBox(width: 8),
                    _buildTrustBadge(Icons.speed_rounded, "Instant ACH Speed", isDark),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Auth Actions
              PrimaryButton(
                label: "Get Started (Enter Dashboard)",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeDashboardScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeDashboardScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    ),
                  ),
                  child: Text(
                    "Sign In to Existing Account",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textCol,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  "FinPilot Starter Kit • 5 Flagship Screens Demo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: isDark ? AppTheme.darkTextMuted : AppTheme.lightTextMuted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        border: Border.all(
          color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.accentEmerald),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
