import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../data/mock_data.dart';

/// Reusable primary action button with loading state
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.height = 54.0,
    this.borderRadius = AppTheme.radiusLg,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppTheme.primaryBlue;
    final fg = textColor ?? Colors.white;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: fg),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: fg,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Custom clean input field with border states & prefix/suffix
class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;
    final fill = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final textColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final hintColor = isDark ? AppTheme.darkTextMuted : AppTheme.lightTextMuted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintColor, fontSize: 14),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fill,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppTheme.dangerRose, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppTheme.dangerRose, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

/// Native Canvas QR Code Painter (Zero External QR Dependencies)
class CustomQrPainter extends CustomPainter {
  final String data;
  final Color codeColor;

  CustomQrPainter({
    required this.data,
    this.codeColor = const Color(0xFF0F172A),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = codeColor
      ..style = PaintingStyle.fill;

    const int matrixSize = 25;
    final double cellSize = size.width / matrixSize;

    // Corner Finder Patterns
    _drawFinderPattern(canvas, 0, 0, cellSize, paint);
    _drawFinderPattern(canvas, (matrixSize - 7) * cellSize, 0, cellSize, paint);
    _drawFinderPattern(canvas, 0, (matrixSize - 7) * cellSize, cellSize, paint);

    // Deterministic data matrix dots using hash of data
    final int seed = data.hashCode.abs();
    final math.Random rng = math.Random(seed);

    for (int r = 0; r < matrixSize; r++) {
      for (int c = 0; c < matrixSize; c++) {
        // Skip finder pattern zones
        final bool inTopLeft = r < 7 && c < 7;
        final bool inTopRight = r < 7 && c >= matrixSize - 7;
        final bool inBottomLeft = r >= matrixSize - 7 && c < 7;

        if (!inTopLeft && !inTopRight && !inBottomLeft) {
          if (rng.nextBool()) {
            final rect = RRect.fromRectAndRadius(
              Rect.fromLTWH(c * cellSize + 0.8, r * cellSize + 0.8, cellSize - 1.6, cellSize - 1.6),
              const Radius.circular(2.0),
            );
            canvas.drawRRect(rect, paint);
          }
        }
      }
    }
  }

  void _drawFinderPattern(Canvas canvas, double left, double top, double cellSize, Paint paint) {
    // Outer 7x7 box
    final outerRect = Rect.fromLTWH(left, top, cellSize * 7, cellSize * 7);
    canvas.drawRRect(RRect.fromRectAndRadius(outerRect, Radius.circular(cellSize * 1.5)), paint);

    // Inner 5x5 cutout
    final clearPaint = Paint()..blendMode = BlendMode.clear;
    final cutoutRect = Rect.fromLTWH(left + cellSize, top + cellSize, cellSize * 5, cellSize * 5);
    canvas.drawRRect(RRect.fromRectAndRadius(cutoutRect, Radius.circular(cellSize)), clearPaint);

    // Center 3x3 solid core
    final coreRect = Rect.fromLTWH(left + (cellSize * 2), top + (cellSize * 2), cellSize * 3, cellSize * 3);
    canvas.drawRRect(RRect.fromRectAndRadius(coreRect, Radius.circular(cellSize * 0.8)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomQrPainter oldDelegate) => oldDelegate.data != data || oldDelegate.codeColor != codeColor;
}

/// Native Canvas Minimal Illustration Painter for Empty & Error States
enum IllustrationType { emptyTransactions, noWifi, notFound, paymentFailed }

class CustomIllustrationPainter extends CustomPainter {
  final IllustrationType type;
  final Color primaryColor;
  final Color secondaryColor;

  CustomIllustrationPainter({
    required this.type,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final bgCirclePaint = Paint()
      ..color = primaryColor.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width * 0.42, bgCirclePaint);

    final strokePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final accentPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    switch (type) {
      case IllustrationType.emptyTransactions:
        // Stylized receipt document with dashed lines
        final docRect = RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 80, height: 100),
          const Radius.circular(12),
        );
        canvas.drawRRect(docRect, strokePaint);
        canvas.drawLine(Offset(center.dx - 22, center.dy - 20), Offset(center.dx + 22, center.dy - 20), strokePaint..strokeWidth = 2.5);
        canvas.drawLine(Offset(center.dx - 22, center.dy), Offset(center.dx + 22, center.dy), strokePaint);
        canvas.drawLine(Offset(center.dx - 22, center.dy + 20), Offset(center.dx + 5, center.dy + 20), strokePaint);
        canvas.drawCircle(Offset(center.dx + 25, center.dy + 25), 6, accentPaint);
        break;

      case IllustrationType.noWifi:
        // Stylized Wifi arcs with warning slash
        final arcRect1 = Rect.fromCircle(center: Offset(center.dx, center.dy + 20), radius: 50);
        final arcRect2 = Rect.fromCircle(center: Offset(center.dx, center.dy + 20), radius: 32);
        canvas.drawArc(arcRect1, -math.pi * 0.8, math.pi * 0.6, false, strokePaint..strokeWidth = 3);
        canvas.drawArc(arcRect2, -math.pi * 0.8, math.pi * 0.6, false, strokePaint);
        canvas.drawCircle(Offset(center.dx, center.dy + 20), 5, accentPaint);
        canvas.drawLine(Offset(center.dx - 40, center.dy - 30), Offset(center.dx + 40, center.dy + 35), Paint()..color = secondaryColor..strokeWidth = 3.5..strokeCap = StrokeCap.round);
        break;

      case IllustrationType.notFound:
        // Stylized magnifying glass looking over empty dotted matrix
        canvas.drawCircle(Offset(center.dx - 10, center.dy - 10), 30, strokePaint..strokeWidth = 3.5);
        canvas.drawLine(Offset(center.dx + 12, center.dy + 12), Offset(center.dx + 35, center.dy + 35), strokePaint..strokeWidth = 4);
        canvas.drawCircle(Offset(center.dx - 10, center.dy - 10), 8, accentPaint);
        break;

      case IllustrationType.paymentFailed:
        // Stylized credit card with alert exclamation shield
        final cardR = RRect.fromRectAndRadius(
          Rect.fromCenter(center: center, width: 100, height: 65),
          const Radius.circular(10),
        );
        canvas.drawRRect(cardR, strokePaint..strokeWidth = 2.5);
        canvas.drawLine(Offset(center.dx - 50, center.dy - 10), Offset(center.dx + 50, center.dy - 10), Paint()..color = primaryColor..strokeWidth = 6);
        // Alert shield
        final alertCenter = Offset(center.dx + 30, center.dy + 20);
        canvas.drawCircle(alertCenter, 16, Paint()..color = secondaryColor);
        canvas.drawLine(Offset(alertCenter.dx, alertCenter.dy - 7), Offset(alertCenter.dx, alertCenter.dy + 2), Paint()..color = Colors.white..strokeWidth = 2.5..strokeCap = StrokeCap.round);
        canvas.drawCircle(Offset(alertCenter.dx, alertCenter.dy + 6), 1.5, Paint()..color = Colors.white);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomIllustrationPainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.primaryColor != primaryColor;
}

/// Pro Feature Comparison Row for SaaS Paywalls
class ProFeatureRow extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ProFeatureRow({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final subTextCol = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.accentViolet.withOpacity(0.14),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Icon(icon, color: AppTheme.accentViolet, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: textCol)),
                const SizedBox(height: 2),
                Text(description, style: TextStyle(fontSize: 12, color: subTextCol, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 3D-Styled Virtual & Physical Card Widget
class VirtualCardWidget extends StatelessWidget {
  final MockVirtualCard card;
  final VoidCallback? onTap;
  final bool showFullCardNumber;

  const VirtualCardWidget({
    super.key,
    required this.card,
    this.onTap,
    this.showFullCardNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      child: Container(
        height: 205,
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: card.isFrozen
                ? [const Color(0xFF334155), const Color(0xFF475569)]
                : card.gradientColors,
          ),
          boxShadow: [
            BoxShadow(
              color: card.gradientColors.first.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(
                        card.cardType,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    if (card.isFrozen) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.dangerRose,
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        ),
                        child: const Text(
                          "FROZEN",
                          style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ],
                ),
                const Icon(Icons.contactless_rounded, color: Colors.white70, size: 24),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 38,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFD97706), width: 1),
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 8, left: 0, right: 0, child: Container(height: 1, color: Colors.black26)),
                      Positioned(bottom: 8, left: 0, right: 0, child: Container(height: 1, color: Colors.black26)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.flash_on_rounded, color: Colors.white54, size: 16),
              ],
            ),
            Text(
              showFullCardNumber
                  ? card.cardNumber
                  : "•••• •••• •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.2,
                fontFamily: 'monospace',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("CARD HOLDER", style: TextStyle(color: Colors.white60, fontSize: 9, fontWeight: FontWeight.w600)),
                    Text(card.cardHolder, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("EXPIRES", style: TextStyle(color: Colors.white60, fontSize: 9, fontWeight: FontWeight.w600)),
                    Text(card.expiryDate, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Native Canvas Donut Chart for Category Breakdown
class CustomDonutChartPainter extends CustomPainter {
  final List<MockCategorySpend> items;
  final double strokeWidth;

  CustomDonutChartPainter({
    required this.items,
    this.strokeWidth = 24.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    double startAngle = -math.pi / 2;

    for (var item in items) {
      final sweepAngle = (item.percentage / 100.0) * 2 * math.pi;
      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle - 0.04,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomDonutChartPainter oldDelegate) => true;
}

/// Native Canvas Grouped Bar Chart for Monthly Income vs Expense
class CustomBarChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final Color incomeColor;
  final Color expenseColor;
  final Color gridLineColor;

  CustomBarChartPainter({
    required this.data,
    required this.incomeColor,
    required this.expenseColor,
    required this.gridLineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    double maxVal = 0;
    for (var d in data) {
      maxVal = math.max(maxVal, math.max(d["income"] as double, d["expense"] as double));
    }
    maxVal = maxVal * 1.15;

    final groupWidth = size.width / data.length;
    final barWidth = groupWidth * 0.28;

    final gridPaint = Paint()..color = gridLineColor..strokeWidth = 1;
    for (int i = 0; i <= 3; i++) {
      final y = size.height * (i / 3.0);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final incomePaint = Paint()..color = incomeColor;
    final expensePaint = Paint()..color = expenseColor;

    for (int i = 0; i < data.length; i++) {
      final d = data[i];
      final groupCenterX = (i * groupWidth) + (groupWidth / 2);

      final incH = ((d["income"] as double) / maxVal) * size.height;
      final incRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(groupCenterX - barWidth - 2, size.height - incH, barWidth, incH),
        const Radius.circular(4),
      );
      canvas.drawRRect(incRect, incomePaint);

      final expH = ((d["expense"] as double) / maxVal) * size.height;
      final expRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(groupCenterX + 2, size.height - expH, barWidth, expH),
        const Radius.circular(4),
      );
      canvas.drawRRect(expRect, expensePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomBarChartPainter oldDelegate) => true;
}

/// Native Canvas Candlestick Chart for Market Asset & Crypto Detail
class CustomCandlestickPainter extends CustomPainter {
  final List<double> prices;
  final Color bullColor;
  final Color bearColor;

  CustomCandlestickPainter({
    required this.prices,
    required this.bullColor,
    required this.bearColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (prices.length < 2) return;

    final minPrice = prices.reduce(math.min);
    final maxPrice = prices.reduce(math.max);
    final range = (maxPrice - minPrice) == 0 ? 1.0 : (maxPrice - minPrice);

    final stepX = size.width / (prices.length - 1);

    final linePaint = Paint()
      ..color = bullColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPath = Path();
    final linePath = Path();

    for (int i = 0; i < prices.length; i++) {
      final x = i * stepX;
      final normY = (prices[i] - minPrice) / range;
      final y = size.height - (normY * (size.height * 0.75)) - (size.height * 0.12);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      if (i == prices.length - 1) {
        fillPath.lineTo(x, size.height);
        fillPath.close();
      }
    }

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [bullColor.withOpacity(0.3), bullColor.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomCandlestickPainter oldDelegate) => true;
}

/// Glass Balance Card with Royal Blue gradient, sparkline accent, and action buttons
class GlassBalanceCard extends StatelessWidget {
  final double balance;
  final double monthlyExpense;
  final double monthlySavings;
  final VoidCallback onSend;
  final VoidCallback onReceive;
  final VoidCallback onTopUp;

  const GlassBalanceCard({
    super.key,
    required this.balance,
    required this.monthlyExpense,
    required this.monthlySavings,
    required this.onSend,
    required this.onReceive,
    required this.onTopUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E3A8A),
            Color(0xFF2563EB),
            Color(0xFF3B82F6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -10,
            child: Opacity(
              opacity: 0.12,
              child: CustomPaint(
                size: const Size(220, 120),
                painter: CardWavePainter(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                            ),
                            child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 8),
                          const Flexible(
                            child: Text(
                              "Total Net Worth",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accentEmerald.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        border: Border.all(color: AppTheme.accentEmerald.withOpacity(0.5), width: 1),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.trending_up_rounded, color: Colors.white, size: 13),
                          SizedBox(width: 3),
                          Text("+14.2%", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "\$${balance.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetricCol("Monthly Spent", "\$${monthlyExpense.toStringAsFixed(0)}", Icons.arrow_upward_rounded, const Color(0xFFFCA5A5)),
                      Container(height: 24, width: 1, color: Colors.white24),
                      _buildMetricCol("Saved This Month", "\$${monthlySavings.toStringAsFixed(0)}", Icons.arrow_downward_rounded, const Color(0xFF6EE7B7)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildActionButton(icon: Icons.send_rounded, label: "Send", onTap: onSend)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildActionButton(icon: Icons.call_received_rounded, label: "Request", onTap: onReceive)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildActionButton(icon: Icons.add_circle_outline_rounded, label: "Top Up", onTap: onTopUp)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w500),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.white.withOpacity(0.16),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Wave Painter for Card Background
class CardWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.2, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.8, size.width, size.height * 0.3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Sparkline Chart Painter for transaction & balance trend previews
class CustomSparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final Color fillColor;
  final bool showFill;

  CustomSparklinePainter({
    required this.data,
    required this.lineColor,
    required this.fillColor,
    this.showFill = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double minVal = data.reduce(math.min);
    final double maxVal = data.reduce(math.max);
    final double range = (maxVal - minVal) == 0 ? 1 : (maxVal - minVal);

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final fillPath = Path();
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedY = (data[i] - minVal) / range;
      final y = size.height - (normalizedY * size.height * 0.8) - (size.height * 0.1);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      if (i == data.length - 1) {
        fillPath.lineTo(x, size.height);
        fillPath.close();
      }
    }

    if (showFill) {
      final fillPaint = Paint()..color = fillColor..style = PaintingStyle.fill;
      canvas.drawPath(fillPath, fillPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomSparklinePainter oldDelegate) => oldDelegate.data != data;
}

/// Transaction Tile
class TransactionTile extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final double amount;
  final bool isExpense;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.isExpense,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final borderColor = isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder;
    final primaryTextColor = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final secondaryTextColor = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark ? iconColor.withOpacity(0.18) : iconBg,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "$category • $date",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: secondaryTextColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${isExpense ? '-' : '+'}\$${amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isExpense
                        ? (isDark ? const Color(0xFFF87171) : AppTheme.dangerRose)
                        : (isDark ? const Color(0xFF34D399) : AppTheme.accentEmerald),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// App Drawer with Light/Dark Mode toggle & fast navigation
class AppDrawer extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final void Function(int screenIndex)? onNavigateToScreen;

  const AppDrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.onNavigateToScreen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? AppTheme.darkBg : AppTheme.lightBg;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary;
    final subTextCol = isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary;

    return Drawer(
      backgroundColor: bg,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryBlue, AppTheme.accentViolet],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: const Icon(Icons.auto_graph_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FinPilot Pro",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: textCol,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          "50-Screen Mega UI Kit",
                          style: TextStyle(
                            fontSize: 12,
                            color: subTextCol,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(
                  color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.amber.withOpacity(0.15) : AppTheme.primaryBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: isDark ? Colors.amber : AppTheme.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isDark ? "Dark Theme" : "Light Theme",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textCol,
                          ),
                        ),
                        Text(
                          isDark ? "#0B0F19 Canvas" : "#FFFFFF Canvas",
                          style: TextStyle(
                            fontSize: 11,
                            color: subTextCol,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: onThemeChanged,
                    activeThumbColor: AppTheme.primaryBlue,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _drawerItem(
                    icon: Icons.dashboard_rounded,
                    title: "Home Dashboard",
                    subtitle: "Screen 10",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(9);
                    },
                  ),
                  _drawerItem(
                    icon: Icons.credit_card_rounded,
                    title: "Virtual Cards Center",
                    subtitle: "Screen 21",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(20);
                    },
                  ),
                  _drawerItem(
                    icon: Icons.bar_chart_rounded,
                    title: "Cashflow Analytics",
                    subtitle: "Screen 24",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(23);
                    },
                  ),
                  _drawerItem(
                    icon: Icons.subscriptions_rounded,
                    title: "Subscription Manager",
                    subtitle: "Screen 36",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(35);
                    },
                  ),
                  _drawerItem(
                    icon: Icons.qr_code_scanner_rounded,
                    title: "Scan & Pay QR",
                    subtitle: "Screen 38",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(37);
                    },
                  ),
                  _drawerItem(
                    icon: Icons.call_split_rounded,
                    title: "Split Bill Group",
                    subtitle: "Screen 40",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(39);
                    },
                  ),
                  _drawerItem(
                    icon: Icons.workspace_premium_rounded,
                    title: "FinPilot Pro Upgrade",
                    subtitle: "Screen 50",
                    onTap: () {
                      Navigator.pop(context);
                      onNavigateToScreen?.call(49);
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "FinPilot UI Kit v3.0 • All 50 Screens Ready",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: subTextCol),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      onTap: onTap,
    );
  }
}
