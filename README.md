ColorMeUp

A simple Flutter project that showcases dynamic background color generation, text visibility control, and in-app editing using a custom floating action button (FAB). Built with clean architecture in mind and structured for easy testing and scaling.

Features

Tap anywhere to generate a random RGB background color

Display customizable text ("Hello there" by default)

Toggle text visibility using a FAB

Edit the displayed text via dialog

Linted with solid_lints

Includes unit and widget tests

Project Structure

lib/
├── app.dart
├── main.dart
├── screens/
│   └── main_color_screen.dart
├── widgets/
    └── text_fab/
        ├── control_fab.dart
        ├── edit_dialog.dart
        └── text_display.dart

test/
├── unit/
│   └── color_logic_test.dart
└── widgets/text_fab/
    ├── control_fab_test.dart
    ├── edit_dialog_test.dart
    └── text_display_test.dart

Linting Configuration

This project uses solid_lints as its base rule set.

Root-level analysis_options.yaml

include: package:solid_lints/analysis_options.yaml

This ensures strict and consistent linting rules across the entire codebase.

Test-specific rules (optional)

You may include a relaxed rule set for tests. To do this, place the following file in your test/ directory:

# test/analysis_options.yaml
include: package:solid_lints/analysis_options_test.yaml

This can help when you want to allow prints or slightly looser constraints in unit tests.

Getting Started

Fetch dependencies:

flutter pub get

Run the app:

flutter run

Run tests:

flutter test

Run linter manually:

dart analyze
dart run custom_lint

Tech Stack

Flutter 3.19+

Dart 3.8+

solid_lints for static analysis

flutter_test for unit/widget testing

Notes

The original project contained a wrong linter path: package:solid_lints/solid_lints.yaml, which does not exist. It was fixed to package:solid_lints/analysis_options.yaml.

Linting now works properly with full support for test files and CI compatibility.