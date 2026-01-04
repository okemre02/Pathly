# Pathly 🚀

Pathly is an interactive career roadmap application designed to guide developers through their learning journey. Whether you are aspiring to be a Mobile App Developer, Web Developer, or Data Scientist, Pathly provides structured learning paths, progress tracking, and detailed modules to help you master the necessary skills.

## ✨ Features

- **Interactive Roadmaps**: Visual learning paths for various technology stacks (Flutter, React, Python, etc.).
- **Branching Paths**: Specialized sub-paths (e.g., Game Development -> Unity vs. Unreal) to tailor your learning experience.
- **Progress Tracking**: Track your completion status across different nodes and modules.
- **Detailed Learning Modules**: In-depth content for each topic, including quizzes and practical examples.
- **Gamified Experience**: Unlock new modules as you progress and maintain your daily streak.
- **Cross-Platform**: Built with Flutter for a seamless experience on both iOS and Android.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Backend/Auth**: [Firebase](https://firebase.google.com/) (Auth, Firestore)
- **UI Components**: `flutter_animate`, `google_fonts`, `cupertino_icons`
- **Markdown Rendering**: `flutter_markdown`
- **Local Storage**: `shared_preferences`

## 📂 Project Structure

The project follows a Clean Architecture approach organized by features:

```
lib/
├── core/           # Shared utilities, theme, and constants
├── features/       # Feature-specific code
│   ├── dashboard/  # User dashboard and progress overview
│   ├── home/       # Main landing page and path selection
│   ├── learning/   # Learning modules and content display
│   ├── onboarding/ # User onboarding flow
│   └── roadmap/    # Roadmap visualization and logic
└── main.dart       # Application entry point
```

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.9.2 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE (VS Code or Android Studio) with Flutter extensions installed.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/pathly.git
    cd pathly
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the application:**

    ```bash
    flutter run
    ```

## 🤝 Contributing

Contributions are welcome! If you have suggestions or want to improve the content, please create a pull request or open an issue.

## 📄 License

This project is licensed under the generic MIT License - see the LICENSE file for details.
