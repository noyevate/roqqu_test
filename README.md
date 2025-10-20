# Roqqu Mobile Developer Assessment

This repository contains the completed task-based assessment for the Mobile Developer position at Roqqu. The application is built with Flutter and aims to replicate the provided Figma design while integrating a live WebSocket API for real-time data.

## 🚀 Project Showcase

A screen recording of the application running on an ios device, showcasing the implemented features, animations, and real-time data updates.


project demo link: https://drive.google.com/file/d/1zXHh69EZNuDKJeqOchI_gLL1ZI8_0pUZ/view?usp=sharing

##  Features Implemented

-   [x] **Onboarding:** A multi-page, swipeable onboarding experience.
-   [x] **Risk Profile Selection:** An interactive screen for users to choose their risk level.
-   [x] **Copy Trading Hub:** A screen displaying a list of "PRO Traders" with mock performance data.
-   [x] **Trader Details:** A comprehensive details screen with a sticky `TabBar` and multiple tabs:
    -   [x] **Chart Tab:** With a custom, multi-layered performance chart.
    -   [x] **Stats Tab:** A detailed breakdown of trader statistics.
    -   [x] **All Trades Tab:** A nested tab view for "Current Trades" and "History".
    -   [x] **Copiers Tab:** A list of users copying the trader.
-   [x] **Payment & Confirmation Flow:**
    -   [x] **Enter Amount Screen:** With native keyboard input for a familiar UX.
    -   [x] **Confirm Transaction Screen:** A clear summary of the transaction details.
    -   [x] **PIN Confirmation Screen:** A security screen with a custom keypad for PIN entry.
    -   [x] **Success Screen:** A final confirmation page with proper navigation stack management.
-   [x] **Homepage Dashboard:** A complex, data-rich home screen featuring:
    -   [x] A custom `BottomNavigationBar` with a central floating action button.
    -   [x] A "Stay Updated" carousel using a `PageView`.
    -   [x] A **real-time "Listed Coins" section** powered by a public WebSocket API.
-   [x] **Custom Modals & Action Sheets:**
    -   [x] A blurred background bottom sheet for risk warnings.
    -   [x] A full-screen modal with a floating action sheet that blurs the `AppBar` while keeping the `BottomNavBar` visible.

## Technical Stack & Libraries

-   **Framework:** Flutter
-   **Language:** Dart
-   **State Management:** `flutter_bloc` - Chosen for its predictability, scalability, and excellent support for stream-based architectures, making it ideal for handling real-time WebSocket data.
-   **API & Networking:**
    -   `web_socket_channel`: For live, real-time data streaming.
    -   `http`: For making REST API calls to fetch initial data.
-   **Charting:** `fl_chart` - A powerful and highly customizable charting library used for all performance graphs.
-   **Formatting:** `intl` - Used for robust and locale-aware number and currency formatting.

## Architectural Decisions

The application was built following professional software engineering principles to ensure it is scalable, maintainable, and testable.

### Clean Architecture

The project is structured around the principles of Clean Architecture, separating the code into three distinct layers:
-   **Presentation:** Contains all UI-related code (Widgets, BLoCs, Pages). It is responsible for displaying the data and handling user input.
-   **Domain:** The core of the application. It contains the business logic and defines the `Entities` (like `Coin` or `ProTrader`). This layer is independent of any frameworks.
-   **Data:** Responsible for all data operations. It includes `Repositories` that abstract the data sources and `DataSources` that communicate directly with the WebSocket and REST APIs.

### State Management: BLoC

The BLoC (Business Logic Component) pattern was chosen as the primary state management solution. This choice enforces a strict separation between the UI and the business logic, making the app easier to test and reason about. BLoC's stream-based nature, particularly the `emit.forEach` method, is a perfect fit for handling the continuous flow of data from the WebSocket API.

### Hybrid Data Fetching Strategy

For the real-time "Listed Coins" feature, a professional hybrid data-fetching strategy was implemented:
1.  **Initial HTTP Request:** On load, the app makes a one-time REST API call (to the Bitstamp Ticker endpoint) to fetch a complete snapshot of the coin data, including the crucial 24-hour percentage change.
2.  **Live WebSocket Updates:** After the initial data is loaded, the app subscribes to a WebSocket stream (Bitstamp's `live_trades` channel). This stream provides lightweight, real-time updates for the coin **prices only**.

This approach provides a complete and accurate initial state while ensuring subsequent updates are as efficient and performant as possible.

### Component-Based UI

The UI was built with a strong emphasis on creating small, reusable, and configurable widgets. Components like `GradientButton`, `TraderAvatar`, `PerformanceLineChart`, and various list item cards are defined once and reused across multiple screens. This improves development speed, ensures UI consistency, and makes the codebase much easier to maintain.

## Meeting the Evaluation Criteria

-   **Accuracy to Design:** Every effort was made to match the provided Figma design, with close attention to spacing, typography, component consistency, and responsive layouts for different screen sizes.
-   **Animations & Transitions:** `AnimatedContainer`, `AnimatedSwitcher`, and `AnimatedPositioned` were used to create smooth and intuitive UI transitions, such as the custom tab bar and the sliding action sheet.
-   **Architecture & Code Quality:** The project strictly follows Clean Architecture and OOP principles. State is managed predictably with BLoC, and the codebase is organized into modular, feature-based folders.
-   **API Integration & Real-Time Data Handling:** Successfully integrated a public WebSocket API (Bitstamp) for live price data. The BLoC pattern (`emit.forEach`) is used to efficiently handle real-time updates without unnecessary UI rebuilds. The connection logic is resilient and separated in the data layer.
-   **Performance & Optimization:** `ListView.builder` is used for long lists, `const` widgets are used where possible, and the BLoC state management is designed to minimize widget rebuilds.
-   **Testing & Maintainability:** The architecture (Clean Architecture + BLoC) is inherently testable. Repositories can be easily mocked to test the BLoC, and widgets are broken down into small, testable components.
-   **Best Practices:** The project utilizes responsive layouts (`MediaQuery`), adheres to Flutter and Dart best practices, and demonstrates a clear separation of concerns.
-   **Git Commits:** Git commits are structured following the **Conventional Commits** specification (e.g., `feat(home): ...`, `fix(dashboard): ...`). Commits are atomic and feature-based, telling a clear and professional story of the development process.

## ⚙️ Getting Started

Follow these instructions to set up and run the project locally.

### Prerequisites

-   Flutter SDK (version 3.x.x recommended)
-   An IDE like VS Code or Android Studio
-   An iOS Simulator or Android Emulator with an active internet connection.

### Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/roqqu-assessment.git
    cd roqqu-assessment
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```

### Notes on Implementation

-   **Data:** All user-specific data (e.g., "PRO Traders" lists, dashboard balances, trading history) has been mocked within the relevant widgets or data models. This is standard practice for a UI-focused assessment where access to a private backend API is not provided.
-   **Real-Time Data:** The "Listed Coins" section on the homepage is the primary feature that connects to a live, public WebSocket API (Bitstamp) to display real-time price updates. If you experience connection issues, please ensure your network does not have a firewall blocking access to `ws.bitstamp.net`.