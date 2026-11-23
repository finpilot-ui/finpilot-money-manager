import 'package:flutter/material.dart';

class MockTransaction {
  final String id;
  final String title;
  final String category;
  final String date;
  final double amount;
  final bool isExpense;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const MockTransaction({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.isExpense,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}

class MockContact {
  final String id;
  final String name;
  final String handle;
  final String avatarInitials;
  final Color avatarColor;
  final String? bankAccount;

  const MockContact({
    required this.id,
    required this.name,
    required this.handle,
    required this.avatarInitials,
    required this.avatarColor,
    this.bankAccount,
  });
}

class MockBank {
  final String id;
  final String name;
  final String code;
  final IconData icon;
  final Color color;
  final bool isPopular;

  const MockBank({
    required this.id,
    required this.name,
    required this.code,
    required this.icon,
    required this.color,
    this.isPopular = false,
  });
}

class MockVirtualCard {
  final String id;
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String cardType;
  final double balance;
  final double spendingLimit;
  final double spentThisMonth;
  final List<Color> gradientColors;
  final bool isFrozen;
  final bool isOnlineActive;
  final bool isInternationalActive;

  const MockVirtualCard({
    required this.id,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    required this.balance,
    required this.spendingLimit,
    required this.spentThisMonth,
    required this.gradientColors,
    this.isFrozen = false,
    this.isOnlineActive = true,
    this.isInternationalActive = false,
  });
}

class MockCategorySpend {
  final String name;
  final double amount;
  final double percentage;
  final Color color;
  final IconData icon;

  const MockCategorySpend({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
  });
}

class MockSavingsGoal {
  final String id;
  final String title;
  final String category;
  final double currentAmount;
  final double targetAmount;
  final IconData icon;
  final Color color;
  final String deadline;
  final bool isAutoSaveActive;

  const MockSavingsGoal({
    required this.id,
    required this.title,
    required this.category,
    required this.currentAmount,
    required this.targetAmount,
    required this.icon,
    required this.color,
    required this.deadline,
    this.isAutoSaveActive = true,
  });

  double get progressPercentage => (currentAmount / targetAmount).clamp(0.0, 1.0);
}

class MockInvestmentAsset {
  final String id;
  final String symbol;
  final String name;
  final String assetClass;
  final double currentPrice;
  final double changePercentage24h;
  final double holdingsValue;
  final double units;
  final List<double> sparklinePoints;
  final Color brandColor;

  const MockInvestmentAsset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.assetClass,
    required this.currentPrice,
    required this.changePercentage24h,
    required this.holdingsValue,
    required this.units,
    required this.sparklinePoints,
    required this.brandColor,
  });

  bool get isBullish => changePercentage24h >= 0;
}

// Batch 3 Models
class MockSubscription {
  final String id;
  final String name;
  final String plan;
  final double price;
  final String renewalDate;
  final IconData icon;
  final Color color;
  final bool isPaused;

  const MockSubscription({
    required this.id,
    required this.name,
    required this.plan,
    required this.price,
    required this.renewalDate,
    required this.icon,
    required this.color,
    this.isPaused = false,
  });
}

class MockBiller {
  final String id;
  final String name;
  final String category;
  final double amountDue;
  final String dueDate;
  final IconData icon;
  final Color color;

  const MockBiller({
    required this.id,
    required this.name,
    required this.category,
    required this.amountDue,
    required this.dueDate,
    required this.icon,
    required this.color,
  });
}

class MockConnectedAccount {
  final String id;
  final String institution;
  final String accountType;
  final String maskedNumber;
  final double balance;
  final String lastSynced;
  final IconData icon;
  final Color color;

  const MockConnectedAccount({
    required this.id,
    required this.institution,
    required this.accountType,
    required this.maskedNumber,
    required this.balance,
    required this.lastSynced,
    required this.icon,
    required this.color,
  });
}

class MockFaqItem {
  final String question;
  final String answer;
  final String category;

  const MockFaqItem({
    required this.question,
    required this.answer,
    required this.category,
  });
}

class MockData {
  static const String userFullName = "Alex Morgan";
  static const String userEmail = "alex.morgan@finpilot.io";
  static const String userPhone = "+1 (415) 890-3412";
  static const String userUpiHandle = "@alexmorgan";
  static const String userCurrency = "\$";
  static const double userTotalBalance = 28450.50;
  static const double userMonthlySpent = 4820.00;
  static const double userMonthlyBudget = 7500.00;
  static const double userSavings = 14650.00;

  static const List<MockTransaction> transactions = [
    MockTransaction(
      id: "tx_01",
      title: "Apple One Premier",
      category: "Software & Cloud",
      date: "Today, 02:45 PM",
      amount: 37.95,
      isExpense: true,
      icon: Icons.cloud_outlined,
      iconColor: Color(0xFF2563EB),
      iconBg: Color(0xFFEFF6FF),
    ),
    MockTransaction(
      id: "tx_02",
      title: "Trader Joe's Groceries",
      category: "Dining & Food",
      date: "Today, 01:15 PM",
      amount: 68.40,
      isExpense: true,
      icon: Icons.restaurant_rounded,
      iconColor: Color(0xFFEF4444),
      iconBg: Color(0xFFFEF2F2),
    ),
    MockTransaction(
      id: "tx_03",
      title: "Consulting Retainer Deposit",
      category: "Consulting Income",
      date: "Yesterday, 06:30 PM",
      amount: 4500.00,
      isExpense: false,
      icon: Icons.arrow_downward_rounded,
      iconColor: Color(0xFF10B981),
      iconBg: Color(0xFFECFDF5),
    ),
    MockTransaction(
      id: "tx_04",
      title: "Blue Bottle Coffee",
      category: "Café & Hangouts",
      date: "Yesterday, 11:20 AM",
      amount: 7.50,
      isExpense: true,
      icon: Icons.local_cafe_rounded,
      iconColor: Color(0xFFF59E0B),
      iconBg: Color(0xFFFFFBEB),
    ),
    MockTransaction(
      id: "tx_05",
      title: "Vanguard S&P 500 Index (VOO)",
      category: "ETF Investment",
      date: "20 Nov 2026",
      amount: 500.00,
      isExpense: true,
      icon: Icons.trending_up_rounded,
      iconColor: Color(0xFF7C3AED),
      iconBg: Color(0xFFF5F3FF),
    ),
    MockTransaction(
      id: "tx_06",
      title: "Uber Premier Ride",
      category: "Travel & Transit",
      date: "19 Nov 2026",
      amount: 42.50,
      isExpense: true,
      icon: Icons.directions_car_rounded,
      iconColor: Color(0xFF0284C7),
      iconBg: Color(0xFFF0F9FF),
    ),
  ];

  static const List<MockContact> contacts = [
    MockContact(
      id: "c_1",
      name: "Sarah Jenkins",
      handle: "@sarah.j",
      avatarInitials: "SJ",
      avatarColor: Color(0xFF7C3AED),
      bankAccount: "Chase •• 8842",
    ),
    MockContact(
      id: "c_2",
      name: "Marcus Vance",
      handle: "@marcus.v",
      avatarInitials: "MV",
      avatarColor: Color(0xFF2563EB),
      bankAccount: "BofA •• 3190",
    ),
    MockContact(
      id: "c_3",
      name: "Emily Carter",
      handle: "@emily.c",
      avatarInitials: "EC",
      avatarColor: Color(0xFF10B981),
      bankAccount: "Wells Fargo •• 9021",
    ),
    MockContact(
      id: "c_4",
      name: "David Brooks",
      handle: "@david.b",
      avatarInitials: "DB",
      avatarColor: Color(0xFFF59E0B),
      bankAccount: "Citi •• 4511",
    ),
    MockContact(
      id: "c_5",
      name: "Chloe Bennett",
      handle: "@chloe.b",
      avatarInitials: "CB",
      avatarColor: Color(0xFFEC4899),
      bankAccount: "Capital One •• 1278",
    ),
  ];

  static const List<MockBank> banks = [
    MockBank(
      id: "b_1",
      name: "Chase Bank",
      code: "CHAS0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF117ACA),
      isPopular: true,
    ),
    MockBank(
      id: "b_2",
      name: "Bank of America",
      code: "BOFA0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFFE31837),
      isPopular: true,
    ),
    MockBank(
      id: "b_3",
      name: "Wells Fargo",
      code: "WF0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFFD71E28),
      isPopular: true,
    ),
    MockBank(
      id: "b_4",
      name: "Citibank",
      code: "CITI0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF003B70),
      isPopular: true,
    ),
    MockBank(
      id: "b_5",
      name: "Capital One",
      code: "CAP10001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF004977),
      isPopular: true,
    ),
    MockBank(
      id: "b_6",
      name: "SoFi Bank",
      code: "SOFI0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF00A3E0),
      isPopular: false,
    ),
    MockBank(
      id: "b_7",
      name: "Goldman Sachs",
      code: "GS0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2E6DA4),
      isPopular: false,
    ),
    MockBank(
      id: "b_8",
      name: "Morgan Stanley",
      code: "MS0001",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF002B49),
      isPopular: false,
    ),
  ];

  static const List<MockVirtualCard> virtualCards = [
    MockVirtualCard(
      id: "card_1",
      cardHolder: "ALEX MORGAN",
      cardNumber: "5399 4810 2938 8842",
      expiryDate: "09/29",
      cvv: "721",
      cardType: "MASTERCARD PLATINUM",
      balance: 4200.00,
      spendingLimit: 10000.00,
      spentThisMonth: 2800.00,
      gradientColors: [Color(0xFF1E3A8A), Color(0xFF2563EB), Color(0xFF3B82F6)],
      isFrozen: false,
      isOnlineActive: true,
      isInternationalActive: true,
    ),
    MockVirtualCard(
      id: "card_2",
      cardHolder: "ALEX MORGAN",
      cardNumber: "4111 8902 3314 9120",
      expiryDate: "12/28",
      cvv: "309",
      cardType: "VISA SIGNATURE BLACK",
      balance: 18650.50,
      spendingLimit: 25000.00,
      spentThisMonth: 4350.00,
      gradientColors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
      isFrozen: false,
      isOnlineActive: true,
      isInternationalActive: false,
    ),
    MockVirtualCard(
      id: "card_3",
      cardHolder: "ALEX MORGAN",
      cardNumber: "6521 7710 4401 5590",
      expiryDate: "04/30",
      cvv: "518",
      cardType: "VISA SAPPHIRE VIRTUAL",
      balance: 5600.00,
      spendingLimit: 10000.00,
      spentThisMonth: 1400.00,
      gradientColors: [Color(0xFF7C3AED), Color(0xFF9333EA), Color(0xFFA855F7)],
      isFrozen: true,
      isOnlineActive: false,
      isInternationalActive: false,
    ),
  ];

  static const List<MockCategorySpend> categoryBreakdown = [
    MockCategorySpend(
      name: "Housing & Rent",
      amount: 2100.00,
      percentage: 43.5,
      color: Color(0xFF2563EB),
      icon: Icons.home_rounded,
    ),
    MockCategorySpend(
      name: "Dining & Groceries",
      amount: 1150.00,
      percentage: 23.8,
      color: Color(0xFF10B981),
      icon: Icons.restaurant_rounded,
    ),
    MockCategorySpend(
      name: "Transit & Travel",
      amount: 580.00,
      percentage: 12.0,
      color: Color(0xFFF59E0B),
      icon: Icons.directions_car_rounded,
    ),
    MockCategorySpend(
      name: "Shopping & Tech",
      amount: 520.00,
      percentage: 10.8,
      color: Color(0xFFEC4899),
      icon: Icons.shopping_bag_rounded,
    ),
    MockCategorySpend(
      name: "Cloud Subscriptions",
      amount: 470.00,
      percentage: 9.9,
      color: Color(0xFF7C3AED),
      icon: Icons.cloud_outlined,
    ),
  ];

  static const List<Map<String, dynamic>> monthlyCashflow = [
    {"month": "Jun", "income": 8500.0, "expense": 4200.0},
    {"month": "Jul", "income": 9200.0, "expense": 4800.0},
    {"month": "Aug", "income": 8900.0, "expense": 4300.0},
    {"month": "Sep", "income": 9800.0, "expense": 5100.0},
    {"month": "Oct", "income": 11200.0, "expense": 4900.0},
    {"month": "Nov", "income": 12500.0, "expense": 4820.0},
  ];

  static const List<MockSavingsGoal> savingsGoals = [
    MockSavingsGoal(
      id: "goal_1",
      title: "Emergency Vault",
      category: "Contingency (6 Months)",
      currentAmount: 24000.0,
      targetAmount: 30000.0,
      icon: Icons.shield_rounded,
      color: Color(0xFF2563EB),
      deadline: "March 2027",
      isAutoSaveActive: true,
    ),
    MockSavingsGoal(
      id: "goal_2",
      title: "Dream Home Downpayment",
      category: "Real Estate Property",
      currentAmount: 85000.0,
      targetAmount: 150000.0,
      icon: Icons.villa_rounded,
      color: Color(0xFF10B981),
      deadline: "Dec 2028",
      isAutoSaveActive: true,
    ),
    MockSavingsGoal(
      id: "goal_3",
      title: "Hawaii Summer Vacation",
      category: "Vacation & Leisure",
      currentAmount: 4500.0,
      targetAmount: 6000.0,
      icon: Icons.flight_takeoff_rounded,
      color: Color(0xFFEC4899),
      deadline: "July 2027",
      isAutoSaveActive: true,
    ),
    MockSavingsGoal(
      id: "goal_4",
      title: "Tesla Model Y / EV Fund",
      category: "Automobile Purchase",
      currentAmount: 18000.0,
      targetAmount: 45000.0,
      icon: Icons.electric_car_rounded,
      color: Color(0xFF7C3AED),
      deadline: "August 2028",
      isAutoSaveActive: false,
    ),
  ];

  static const List<MockInvestmentAsset> investmentAssets = [
    MockInvestmentAsset(
      id: "inv_1",
      symbol: "VOO",
      name: "Vanguard S&P 500 ETF",
      assetClass: "Index ETF",
      currentPrice: 512.40,
      changePercentage24h: 1.45,
      holdingsValue: 15372.00,
      units: 30.0,
      sparklinePoints: [502, 504, 506, 508, 510, 511, 512.40],
      brandColor: Color(0xFF2563EB),
    ),
    MockInvestmentAsset(
      id: "inv_2",
      symbol: "BTC",
      name: "Bitcoin Core",
      assetClass: "Crypto Assets",
      currentPrice: 94500.00,
      changePercentage24h: 3.82,
      holdingsValue: 18900.00,
      units: 0.20,
      sparklinePoints: [91000, 92500, 92000, 93400, 93800, 94100, 94500],
      brandColor: Color(0xFFF59E0B),
    ),
    MockInvestmentAsset(
      id: "inv_3",
      symbol: "ETH",
      name: "Ethereum Network",
      assetClass: "Crypto Assets",
      currentPrice: 3450.00,
      changePercentage24h: -0.85,
      holdingsValue: 6900.00,
      units: 2.0,
      sparklinePoints: [3550, 3520, 3540, 3500, 3480, 3470, 3450],
      brandColor: Color(0xFF6366F1),
    ),
    MockInvestmentAsset(
      id: "inv_4",
      symbol: "AAPL",
      name: "Apple Inc. Common Stock",
      assetClass: "US Equities",
      currentPrice: 228.50,
      changePercentage24h: 0.65,
      holdingsValue: 9140.00,
      units: 40.0,
      sparklinePoints: [224, 225, 226, 227, 227.5, 228, 228.5],
      brandColor: Color(0xFF10B981),
    ),
  ];

  // Batch 3 Datasets
  static const List<MockSubscription> subscriptions = [
    MockSubscription(
      id: "sub_1",
      name: "Netflix 4K Ultra",
      plan: "Family Premium (4 Screens)",
      price: 22.99,
      renewalDate: "28 Nov 2026",
      icon: Icons.movie_filter_rounded,
      color: Color(0xFFE50914),
    ),
    MockSubscription(
      id: "sub_2",
      name: "Spotify Premium",
      plan: "Individual HiFi Plan",
      price: 11.99,
      renewalDate: "02 Dec 2026",
      icon: Icons.music_note_rounded,
      color: Color(0xFF1DB954),
    ),
    MockSubscription(
      id: "sub_3",
      name: "ChatGPT Plus & Copilot",
      plan: "GPT-4o Pro Model Tier",
      price: 20.00,
      renewalDate: "05 Dec 2026",
      icon: Icons.smart_toy_rounded,
      color: Color(0xFF10A37F),
    ),
    MockSubscription(
      id: "sub_4",
      name: "Google One Storage",
      plan: "2 TB Cloud Storage",
      price: 9.99,
      renewalDate: "12 Dec 2026",
      icon: Icons.cloud_queue_rounded,
      color: Color(0xFF4285F4),
    ),
    MockSubscription(
      id: "sub_5",
      name: "Equinox Digital Pass",
      plan: "Gym & Home Workouts",
      price: 45.00,
      renewalDate: "15 Dec 2026",
      icon: Icons.fitness_center_rounded,
      color: Color(0xFFFF3278),
      isPaused: true,
    ),
  ];

  static const List<MockBiller> utilityBillers = [
    MockBiller(
      id: "bil_1",
      name: "Con Edison Electric",
      category: "Electricity",
      amountDue: 148.50,
      dueDate: "Due in 3 Days",
      icon: Icons.bolt_rounded,
      color: Color(0xFFF59E0B),
    ),
    MockBiller(
      id: "bil_2",
      name: "Comcast Xfinity Gigabit",
      category: "Broadband Internet",
      amountDue: 85.00,
      dueDate: "Due 30 Nov",
      icon: Icons.wifi_rounded,
      color: Color(0xFF2563EB),
    ),
    MockBiller(
      id: "bil_3",
      name: "National Grid Gas",
      category: "Natural Gas Heating",
      amountDue: 62.40,
      dueDate: "Due 04 Dec",
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFEF4444),
    ),
    MockBiller(
      id: "bil_4",
      name: "AT&T 5G Unlimited",
      category: "Mobile Wireless",
      amountDue: 75.00,
      dueDate: "Auto-pay active",
      icon: Icons.phone_android_rounded,
      color: Color(0xFFDC2626),
    ),
  ];

  static const List<MockConnectedAccount> connectedAccounts = [
    MockConnectedAccount(
      id: "acc_1",
      institution: "Chase Bank NA",
      accountType: "Premier Checking",
      maskedNumber: "•••• 8842",
      balance: 18450.00,
      lastSynced: "Synced 5 mins ago",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF117ACA),
    ),
    MockConnectedAccount(
      id: "acc_2",
      institution: "Bank of America NA",
      accountType: "Advantage Savings",
      maskedNumber: "•••• 3190",
      balance: 7850.50,
      lastSynced: "Synced 2 hours ago",
      icon: Icons.account_balance_rounded,
      color: Color(0xFFE31837),
    ),
    MockConnectedAccount(
      id: "acc_3",
      institution: "Apple Cash Wallet",
      accountType: "Digital Stored Card",
      maskedNumber: "•••• 9120",
      balance: 2150.00,
      lastSynced: "Synced today, 10:15 AM",
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF000000),
    ),
  ];

  static const List<MockFaqItem> faqs = [
    MockFaqItem(
      category: "Security",
      question: "How does FinPilot keep my bank credentials safe?",
      answer: "FinPilot connects exclusively through Plaid and standard open-banking APIs with SOC2 Type II certification. Your deposits are FDIC-insured up to \$250,000 at our partner banks. All data streams are protected with 256-bit AES encryption.",
    ),
    MockFaqItem(
      category: "Payments",
      question: "Are there any convenience fees on ACH or bill payments?",
      answer: "No. All ACH transfers, peer-to-peer Cashtag payments, and standard utility bill payments are completely free with zero hidden platform charges.",
    ),
    MockFaqItem(
      category: "AI & Budgets",
      question: "How does the AI Copilot classify expenses?",
      answer: "Our edge financial model matches transaction metadata, merchant category codes (MCC), and invoice patterns locally on your device with complete privacy.",
    ),
    MockFaqItem(
      category: "Subscriptions",
      question: "Can FinPilot cancel unwanted subscriptions on my behalf?",
      answer: "Yes, you can freeze or pause recurring subscription authorizations and virtual cards instantly from the Subscription Manager screen.",
    ),
  ];
}
