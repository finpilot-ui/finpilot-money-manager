# FinPilot Money Manager — Flutter Starter Kit

[![Flutter 3.x](https://img.shields.io/badge/Flutter-3.x%20%7C%20Dart%203.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Zero External Dependencies](https://img.shields.io/badge/Dependencies-Zero%20External-10B981?logo=dart&logoColor=white)](https://pub.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform Support](https://img.shields.io/badge/Platforms-iOS%20%7C%20Android%20%7C%20Web%20%7C%20macOS-blueviolet)](https://flutter.dev)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/finpilot-ui/finpilot-money-manager/pulls)
[![Commercial UI Kit](https://img.shields.io/badge/Full%20Bundle-50%20Screens%20%2B%20Figma-7C3AED)](https://gumroad.com/l/finpilot-ui-kit)

> **FinPilot Money Manager** is an enterprise-grade, commercial Flutter UI Kit designed for modern FinTech applications, personal finance trackers, digital banking suites, and wealth management platforms. 
> 
> This open-source repository provides the **Free 5-Screen Starter Kit** alongside an interactive web demo of the full 50-screen commercial suite.

---

### 🌐 Live Interactive Web Showcase
Experience all 50 screens in real time inside a mobile phone preview wrapper directly in your browser:
👉 **[Launch Live Interactive Web Demo](https://finpilot-ui.github.io/finpilot-money-manager/)**

---

### 🚀 Get the Full 50-Screen Commercial Bundle + Figma File
Accelerate your mobile banking or personal finance application by months. Get full access to all 50 production-ready screens, custom canvas painters, mock data models, and the complete design system in Figma:

[![Download Full Bundle](https://img.shields.io/badge/Gumroad-Download%20Full%2050--Screen%20UI%20Kit%20%28%2429%29-2563EB?style=for-the-badge&logo=gumroad&logoColor=white)](https://gumroad.com/l/finpilot-ui-kit)

👉 **[Download Full 50-Screen Flutter Source Code + Figma File ($29)](https://gumroad.com/l/finpilot-ui-kit)**

---

## ⚡ Architectural Highlights

FinPilot is engineered following strict Clean Architecture and Flutter UI best practices:

* **Zero Third-Party Dependencies:** Built entirely with standard `flutter/material.dart` and `dart:math`. Zero reliance on third-party charting libraries (such as `fl_chart`), font loaders, or icon fonts. This guarantees that the kit compiles cleanly on any Flutter 3.x SDK with **zero version conflicts** or dependency drift.
* **Native CustomPainter Graphics:** Every financial chart, sparkline, donut distribution gauge, circular progress ring, and biometric viewfinder is drawn directly on the canvas using custom `CustomPainter` classes. This provides 60fps/120fps hardware-accelerated rendering across low-end mobile devices and web browsers.
* **Pixel-Perfect Adaptive Theming:** Complete support for both **Light Mode** (`#FFFFFF` background, `#F8FAFC` card surfaces, `#0F172A` text) and **Dark Mode** (`#0B0F19` midnight canvas, `#131A2A` card surfaces, `#F8FAFC` text). Colors adhere to WCAG AAA contrast accessibility standards.
* **United States Financial Market Localization:** Pre-configured with authentic US financial conventions:
  * US Dollar formatting (`$12,450.00`, `$48.50/mo`).
  * US banking integrations (Chase, Bank of America, Wells Fargo, Citi, Fidelity).
  * Plaid and Stripe identity flow mockups.
  * US phone numbers (`+1 (415) 890-3412`), US addresses, and IRS/FinCEN compliance UI tags.
* **Multi-Platform Ready:** Compiles out-of-the-box for iOS, Android, Web, macOS, Windows, and Linux.

---

## 📱 5 Flagship Starter Screens Included

This starter repository includes 5 fully functional, production-ready screens:

| # | Screen | Description | File Location |
|---|---|---|---|
| **01** | **Welcome & Trust Auth** | High-converting onboarding screen featuring biometric face unlock, Google/Apple OAuth buttons, security guarantees, and bank-grade encryption trust badges. | `lib/screens/welcome_auth_screen.dart` |
| **02** | **Home Financial Dashboard** | Comprehensive overview with glassmorphic net worth card, income vs. expense sparklines, quick action buttons (Send, Receive, Add Money, More), and recent transaction stream. | `lib/screens/home_dashboard_screen.dart` |
| **03** | **AI Copilot Financial Chat** | Conversational FinTech assistant UI with custom AI response bubbles, prompt suggestions ("Where did my money go?", "Forecast my savings"), and actionable financial insights. | `lib/screens/ai_copilot_chat_screen.dart` |
| **04** | **Cashflow Analytics & Trends** | Interactive financial analytics dashboard featuring a native grouped dual-bar canvas chart (Cash In vs. Cash Out), month-over-month percentage delta badges, and category breakdown bars. | `lib/screens/analytics_cashflow_screen.dart` |
| **05** | **Virtual Cards & Limits** | Virtual card management screen with dynamic card carousel, real-time lock/freeze toggle, dynamic online spending limit sliders, and secure CVV reveal controls. | `lib/screens/my_cards_screen.dart` |

---

## 📊 Free Starter Kit vs. Full Commercial UI Kit ($29)

| Feature / Screen | Free Starter Kit (This Repo) | Full Commercial UI Kit ($29) |
|---|:---:|:---:|
| **Total Production Screens** | **5 Screens** | **50 Screens** |
| **Figma Design System File (.fig)** | ❌ | ✅ Included |
| **Zero External Dependencies** | ✅ | ✅ |
| **Light & Dark Mode Parity** | ✅ | ✅ |
| **US Financial Market Localization** | ✅ | ✅ |
| **Auth & Biometrics (Face ID/PIN)** | Screen 1 | Screens 1–5 (Full KYC Flow) |
| **Financial Dashboard & Transactions** | Screen 2 | Screens 6–15 (Detailed Filters, Receipts) |
| **AI Copilot & Smart Insights** | Screen 3 | Screens 16–20 (Full AI Suite) |
| **Virtual & Physical Cards Management** | Screen 5 | Screens 21–25 (Card Ordering, Apple Pay) |
| **Budgets & Micro-Savings Goals** | ❌ | Screens 26–30 (Vaults, Auto-save rules) |
| **Crypto & Stock Portfolio Tracking** | ❌ | Screens 31–35 (Candlestick charts, P&L) |
| **QR Code Scanner & POS Terminal** | ❌ | Screens 36–38 (Native Canvas QR Matrix) |
| **Split Bill & Group Expense Calculator** | ❌ | Screens 39–41 (Tip calculator, split shares) |
| **Freelance Invoicing & PDF Export** | ❌ | Screens 42–44 (Itemized tax & invoices) |
| **US Tax Deduction Estimator** | ❌ | Screens 45–46 (W-2/1099 deductible tracker) |
| **Security Audit & Device Management** | ❌ | Screens 47–48 (Active sessions, 2FA setup) |
| **24/7 Priority Support & Help Center** | ❌ | Screens 49–50 (Live agent chat & ticket log) |
| **Commercial License** | MIT | Unlimited Commercial Projects |

👉 **[Unlock All 50 Screens on Gumroad ($29)](https://gumroad.com/l/finpilot-ui-kit)**

---

## 🗂️ Complete 50-Screen Commercial UI Kit Catalog

The full commercial package contains 50 meticulously engineered screens divided into 3 focused modules:

<details>
<summary><strong>Module 1: Onboarding, Authentication, Core Dashboard & Transactions (Screens 1–20)</strong></summary>

* **Screen 01 — Welcome & Trust Auth:** Biometric Face ID, OAuth login, bank-grade encryption badges.
* **Screen 02 — Phone / Email OTP Verification:** 6-digit auto-advancing verification code inputs with countdown timer.
* **Screen 03 — Create Secure Security PIN:** 4-digit financial keypad with obfuscated numeric dots.
* **Screen 04 — KYC Identity Verification:** Document scanner frame (Passport/Driver's License) with checklist.
* **Screen 05 — Identity Verified Success:** Animated checkmark badge and Tier 1 banking limit confirmation.
* **Screen 06 — Home Financial Dashboard:** Net worth card, quick actions, recent transactions, spending summary.
* **Screen 07 — Detailed Transaction History:** Search bar, date range filters, category chips, status pills.
* **Screen 08 — Transaction Detail & Receipt:** Downloadable digital receipt, merchant logo, breakdown, re-order.
* **Screen 09 — Send Money / P2P Transfer:** Recipient avatar carousel, quick amount chips, note input.
* **Screen 10 — Transfer Review & Confirmation:** Fees breakdown, exchange rates, slide-to-confirm button.
* **Screen 11 — Transfer Success Receipt:** Confirmation animation, transaction reference ID, share receipt.
* **Screen 12 — Request Money / Split Prompt:** Custom payment link generation, QR preview, note field.
* **Screen 13 — Linked Bank Accounts (Plaid Mock):** Connected banks list, account balances, "Link New Bank" modal.
* **Screen 14 — Add New Bank Account:** Routing number, account number, micro-deposit verification banner.
* **Screen 15 — Account Statements & Tax Export:** Monthly PDF statement list, date range selector, CSV export.
* **Screen 16 — User Profile & Tier Overview:** Tier badge (Pro Member), verification status, user details.
* **Screen 17 — Account & Privacy Settings:** Two-factor authentication, biometric switches, data privacy controls.
* **Screen 18 — Notification Preferences:** Push, SMS, and email toggles for transactions, security, and news.
* **Screen 19 — App Appearance & Theme Customizer:** System, Light, and Dark mode selectors with accent swatches.
* **Screen 20 — Currency & Region Selector:** Global currency picker with USD default, exchange rate indicators.
</details>

<details>
<summary><strong>Module 2: Cards, Analytics, Budgets, Goals & Investments (Screens 21–35)</strong></summary>

* **Screen 21 — Virtual & Physical Cards Management:** Card slider, lock/freeze switch, online limits, card details.
* **Screen 22 — Order New Debit / Credit Card:** Physical vs Virtual selection, delivery address, card tier benefits.
* **Screen 23 — Card Security & PIN Management:** Change ATM PIN, disable international transactions, toggle contactless.
* **Screen 24 — Monthly Spending Analytics:** Native donut chart canvas, category percentages, top merchants list.
* **Screen 25 — Cashflow Trends & Projections:** Grouped bar chart (Cash In vs Cash Out) with trend forecasting.
* **Screen 26 — Category Budget Planner:** Budget progress bars, over-budget warnings, monthly allocation sliders.
* **Screen 27 — Create New Category Budget:** Category selector, recurring limit, push alert thresholds.
* **Screen 28 — Savings Goals & Vaults:** Goal progress rings, target dates, emergency fund lockboxes.
* **Screen 29 — Create New Savings Goal:** Milestone targets, auto-deposit rules, round-up spare change toggle.
* **Screen 30 — Goal Milestone Celebration:** Confetti vector illustration, savings projection calculator.
* **Screen 31 — Investment & Crypto Portfolio:** Total portfolio value, 24h P&L sparkline, asset allocation chart.
* **Screen 32 — Asset Detail & Candlestick Chart:** Native canvas candlestick chart, buy/sell quick action triggers.
* **Screen 33 — Buy / Sell Order Execution:** Order type selector (Market, Limit), fee calculation, order confirmation.
* **Screen 34 — Recurring Auto-Invest Rules:** DCA (Dollar Cost Averaging) scheduler, asset basket, payment method.
* **Screen 35 — Dividend & Yield Tracking:** Yield distribution schedule, annualized return rate metrics.
</details>

<details>
<summary><strong>Module 3: QR Scanner, Invoicing, Tax, Security & Support (Screens 36–50)</strong></summary>

* **Screen 36 — QR Code Scanner & Viewfinder:** Native custom viewfinder frame, flashlight toggle, gallery picker.
* **Screen 37 — My Personal Payment QR:** Stylized vector QR matrix canvas, customizable amount, save to photos.
* **Screen 38 — Merchant POS Checkout:** Tap-to-pay interface, tip percentage selector (15%, 18%, 20%, Custom).
* **Screen 39 — Split Bill & Group Expense:** Participant selector, unequal share slider, itemized split list.
* **Screen 40 — Split Bill Settlement Summary:** "Who owes what" matrix, one-tap reminder push notifications.
* **Screen 41 — Recurring Subscriptions Manager:** Active subscriptions list (Netflix, Spotify), calendar renewal view.
* **Screen 42 — Freelance Invoicing & Billing:** Outstanding invoices, client list, payment status tracker.
* **Screen 43 — Create Professional Invoice:** Line items builder, tax/VAT calculation, payment due dates.
* **Screen 44 — Invoice PDF Preview & Send:** Formatted digital invoice view, send via email or shareable link.
* **Screen 45 — US Tax Deduction Estimator:** 1099/W-2 tax bracket calculator, deductible business expense logger.
* **Screen 46 — Tax Document Vault:** Form 1099-INT, 1099-B, and W-9 downloads, CPA share button.
* **Screen 47 — Security Audit & Active Sessions:** Connected device list, IP address audit, remote sign-out buttons.
* **Screen 48 — 2FA & Hardware Security Keys:** Authenticator app setup, backup codes generator, YubiKey support.
* **Screen 49 — Help Center & FAQ Knowledgebase:** Searchable support articles, category cards, status dashboard.
* **Screen 50 — 24/7 Priority Support Live Chat:** Real-time messaging interface, agent avatar, attachment upload.
</details>

---

## 🛠️ Project Structure

```
FinPilot_GitHub_Starter/
├── android/                        # Native Android configuration
├── ios/                            # Native iOS configuration
├── web/                            # Web engine host files
├── docs/                           # Compiled release web build for GitHub Pages
│   ├── index.html
│   ├── flutter.js
│   ├── main.dart.js
│   └── .nojekyll                   # Bypasses Jekyll processing on GitHub Pages
├── lib/
│   ├── main.dart                   # Starter app entrypoint & flagship gallery
│   ├── core/
│   │   ├── theme/
│   │   │   └── app_theme.dart      # Production Light & Dark theme tokens
│   │   └── widgets/
│   │       └── common_widgets.dart # Reusable native CustomPainter widgets & cards
│   ├── data/
│   │   └── mock_data.dart          # Localized US financial data sets & models
│   └── screens/
│       ├── welcome_auth_screen.dart
│       ├── home_dashboard_screen.dart
│       ├── ai_copilot_chat_screen.dart
│       ├── analytics_cashflow_screen.dart
│       └── my_cards_screen.dart
├── test/
│   └── widget_test.dart            # Smoke test suite
├── pubspec.yaml                    # Zero external dependencies
└── README.md
```

---

## 🚀 Quickstart Guide

### Prerequisites
* Flutter SDK `3.19.0` or higher
* Dart SDK `3.3.0` or higher

### Local Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/finpilot-ui/finpilot-money-manager.git
   cd finpilot-money-manager
   ```

2. **Fetch Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run static analysis:**
   ```bash
   flutter analyze
   ```

4. **Execute test suite:**
   ```bash
   flutter test
   ```

5. **Launch on your target device:**
   ```bash
   # Run on Chrome
   flutter run -d chrome

   # Run on iOS Simulator
   flutter run -d iphone

   # Run on Android Emulator
   flutter run -d android
   ```

---

## 💡 Customization & Theming

FinPilot uses a centralized design system located in `lib/core/theme/app_theme.dart`. You can easily adjust colors, radii, and typography to fit your brand:

```dart
// Change brand primary color across all screens
static const Color primaryBlue = Color(0xFF2563EB); // Royal Blue
static const Color accentEmerald = Color(0xFF10B981); // Emerald Green
static const Color accentViolet = Color(0xFF7C3AED); // Modern Violet

// Adjust card corners
static const double radiusLg = 16.0;
static const double radiusXl = 24.0;
```

---

## 📄 License & Commercial Terms

* **Free Starter Kit:** Released under the permissive **[MIT License](LICENSE)**. You are free to use, modify, and distribute the starter code for personal and open-source projects.
* **Full 50-Screen Commercial Bundle:** Distributed under a **Commercial Developer License** via Gumroad. Grants you lifetime usage across unlimited commercial client projects, SaaS products, and apps without attribution requirements.

---

### 💬 Support & Inquiries
For feature requests, bug reports, or commercial enterprise licensing inquiries:
* **GitHub Issues:** [Open an Issue](https://github.com/finpilot-ui/finpilot-money-manager/issues)
* **Full Bundle Support:** [Download on Gumroad](https://gumroad.com/l/finpilot-ui-kit)
