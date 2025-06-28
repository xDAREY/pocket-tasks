# Pocket Tasks

A simple and elegant task management app built with Flutter.

## Features

- ✅ Add, edit, delete, and mark tasks as complete/incomplete
- 📱 Clean and responsive UI with Material Design 3
- 🌙 Light and dark theme support
- 📊 Filter tasks by status (All, Active, Completed)
- 📅 Sort tasks by due date or creation date
- 💾 Local storage using Hive
- ✨ Smooth animations and transitions

## Screenshots

[Add screenshots here]

## Getting Started

### Prerequisites

- Flutter 3.22.0 or higher
- Dart SDK 3.0.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pocket_tasks.git
cd pocket_tasks

2. Install dependencies:
```bash
flutter pub get

3. Generate Hive adapters:
```bash

flutter packages pub run build_runner build

4. Run the app:
```bash
flutter run


## Architecture
# State Management
This app uses Riverpod for state management, chosen for its:

Compile-time safety
Better testing capabilities
Excellent provider composition
Built-in caching and automatic disposal

## Project Structure
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
├── providers/                # Riverpod providers
├── screens/                  # UI screens
├── widgets/                  # Reusable widgets
├── services/                 # Business logic services
└── utils/                    # Utilities and themes

## Key Design Decisions

1. Hive for Local Storage: Chosen for its performance and ease of use with custom objects
2. Material Design 3: Modern UI following Google's latest design guidelines
Provider Pattern: Clean separation of business logic from UI
Modular Architecture: Easy to maintain and extend

## Testing
Run tests with:
```bash
flutter test

The app includes:
    Unit tests for models and business logic
    Widget tests for UI components
    Integration tests for user workflows

Building

Debug Build
```bash
flutter run

# Release APK
```bash
flutter build apk --release


## The APK will be generated in build/app/outputs/flutter-apk/
Contributing

Fork the repository
Create a feature branch
Make your changes
Add tests for new features
Submit a pull request

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Commit Messages Examples

```bash
git commit -m "feat: add task model with Hive annotations"
git commit -m "feat: implement Riverpod state management"
git commit -m "feat: create home screen with task list"
git commit -m "feat: add task filtering and sorting"
git commit -m "feat: implement add/edit task functionality"
git commit -m "feat: add task details screen"
git commit -m "feat: implement theme switching"
git commit -m "test: add unit tests for task model"
git commit -m "test: add widget tests for task tile"
git commit -m "docs: update README with installation instructions"
git commit -m "build: configure release build settings"