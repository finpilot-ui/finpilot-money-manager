import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AiCopilotChatScreen extends StatefulWidget {
  const AiCopilotChatScreen({super.key});

  @override
  State<AiCopilotChatScreen> createState() => _AiCopilotChatScreenState();
}

class _AiCopilotChatScreenState extends State<AiCopilotChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "isAi": true,
      "text": "Hello Alex! I'm your FinPilot Copilot. I've analyzed your expenses for November. What would you like to explore?",
      "time": "10:30 AM",
      "showChart": false,
    },
    {
      "isAi": false,
      "text": "How much did I spend on dining out this month compared to last month?",
      "time": "10:31 AM",
      "showChart": false,
    },
    {
      "isAi": true,
      "text": "You spent \$420 on dining & takeout in November. That is 18.2% lower than October (\$510)! Here is your weekly dining expenditure breakdown:",
      "time": "10:31 AM",
      "showChart": true,
    },
  ];

  final List<String> _quickPrompts = [
    "💡 How to save \$500 more?",
    "📊 Breakdown by category",
    "🎯 Am I on track for budget?",
    "🏦 Optimize credit card points",
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "isAi": false,
        "text": text,
        "time": "Just now",
        "showChart": false,
      });
      _messageController.clear();
    });

    // Auto AI reply
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _messages.add({
            "isAi": true,
            "text": "Based on your recurring subscriptions, switching your streaming bundle to annual billing could save you \$120 immediately.",
            "time": "Just now",
            "showChart": false,
          });
        });
      }
    });
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
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.accentViolet, AppTheme.primaryBlue]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("FinPilot Copilot", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textCol)),
                const Row(
                  children: [
                    CircleAvatar(radius: 3, backgroundColor: AppTheme.accentEmerald),
                    SizedBox(width: 4),
                    Text("Always Active & Private", style: TextStyle(fontSize: 10, color: AppTheme.accentEmerald, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat history
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final bool isAi = msg["isAi"] as bool;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isAi) ...[
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppTheme.accentViolet.withOpacity(0.18),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.smart_toy_rounded, color: AppTheme.accentViolet, size: 18),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Column(
                            crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isAi
                                      ? (isDark ? AppTheme.darkSurface : AppTheme.lightSurface)
                                      : AppTheme.primaryBlue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(AppTheme.radiusLg),
                                    topRight: const Radius.circular(AppTheme.radiusLg),
                                    bottomLeft: Radius.circular(isAi ? 4 : AppTheme.radiusLg),
                                    bottomRight: Radius.circular(isAi ? AppTheme.radiusLg : 4),
                                  ),
                                  border: isAi
                                      ? Border.all(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder)
                                      : null,
                                ),
                                child: Text(
                                  msg["text"] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: isAi ? textCol : Colors.white,
                                    fontWeight: isAi ? FontWeight.w500 : FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (msg["showChart"] == true) ...[
                                const SizedBox(height: 10),
                                _buildMiniExpenseBarChart(isDark, textCol, subTextCol),
                              ],
                              const SizedBox(height: 4),
                              Text(
                                msg["time"] as String,
                                style: TextStyle(fontSize: 10, color: subTextCol),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Quick Prompt Chips
            Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _quickPrompts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ActionChip(
                    label: Text(_quickPrompts[index], style: TextStyle(fontSize: 12, color: textCol)),
                    backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      side: BorderSide(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
                    ),
                    onPressed: () => _sendMessage(_quickPrompts[index]),
                  );
                },
              ),
            ),

            // Chat Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                border: Border(top: BorderSide(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(fontSize: 14, color: textCol),
                      decoration: InputDecoration(
                        hintText: "Ask FinPilot AI anything about money...",
                        hintStyle: TextStyle(fontSize: 13, color: subTextCol),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppTheme.primaryBlue),
                    onPressed: () => _sendMessage(_messageController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniExpenseBarChart(bool isDark, Color textCol, Color subTextCol) {
    final weeks = [
      {"label": "W1", "amount": 120, "height": 60.0},
      {"label": "W2", "amount": 140, "height": 80.0},
      {"label": "W3", "amount": 85, "height": 45.0},
      {"label": "W4", "amount": 75, "height": 35.0},
    ];

    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBg : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: isDark ? AppTheme.darkCardBorder : AppTheme.lightCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Dining Out Weekly Trend", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: textCol)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: weeks.map((w) {
              return Column(
                children: [
                  Container(
                    width: 28,
                    height: w["height"] as double,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [AppTheme.primaryBlue, AppTheme.accentViolet],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(w["label"] as String, style: TextStyle(fontSize: 10, color: subTextCol, fontWeight: FontWeight.w600)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
