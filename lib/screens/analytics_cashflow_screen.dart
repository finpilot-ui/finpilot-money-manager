import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/common_widgets.dart';
import '../data/mock_data.dart';

class AnalyticsCashflowScreen extends StatefulWidget {
  const AnalyticsCashflowScreen({super.key});

  @override
  State<AnalyticsCashflowScreen> createState() => _AnalyticsCashflowScreenState();
}

class _AnalyticsCashflowScreenState extends State<AnalyticsCashflowScreen> {
  String _timeframe = "6M";

  void _showProAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Category Breakdown & Envelopes available in Full 50-Screen Kit (\$29)"),
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

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Cashflow & Analytics"),
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart_outline_rounded),
            onPressed: _showProAlert,
            tooltip: "Category Breakdown",
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeframe Segment
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["1M", "3M", "6M", "1Y", "ALL"].map((t) {
                    final isSelected = _timeframe == t;
                    return GestureDetector(
                      onTap: () => setState(() => _timeframe = t),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryBlue : (isDark ? AppTheme.darkSurface : AppTheme.lightSurface),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                          border: Border.all(color: isSelected ? Colors.transparent : (isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder)),
                        ),
                        child: Text(
                          t,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : textCol,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Summary Net Savings Pill
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                ),
                child: Row(
                  children: [
                    Expanded(child: _metricCol("Total Inflow", "\$12,500", AppTheme.accentEmerald)),
                    Container(height: 32, width: 1, color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                    Expanded(child: _metricCol("Total Outflow", "\$4,820", AppTheme.dangerRose)),
                    Container(height: 32, width: 1, color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                    Expanded(child: _metricCol("Net Saved", "+\$7,680", AppTheme.primaryBlue)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Custom Grouped Bar Chart Canvas
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Income vs Expense Trend", style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: textCol)),
                        Row(
                          children: [
                            _legendDot(AppTheme.accentEmerald, "Income"),
                            const SizedBox(width: 10),
                            _legendDot(AppTheme.dangerRose, "Expense"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: CustomBarChartPainter(
                          data: MockData.monthlyCashflow,
                          incomeColor: AppTheme.accentEmerald,
                          expenseColor: AppTheme.dangerRose,
                          gridLineColor: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: MockData.monthlyCashflow.map((m) {
                        return Text(m["month"] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: subTextCol));
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Category Quick Link Banner
              InkWell(
                onTap: _showProAlert,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.accentVioletBg,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(color: AppTheme.accentViolet.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.pie_chart_rounded, color: AppTheme.accentViolet, size: 24),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("View Expense Category Breakdown", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppTheme.accentViolet)),
                            Text("Unlock 5 itemized spending categories in Pro Bundle", style: TextStyle(fontSize: 11, color: subTextCol)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.accentViolet),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricCol(String title, String val, Color col) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 10.5, color: Colors.grey, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(val, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: col)),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
