# ColorMeUp

A minimal Flutter project that focuses on interaction, clean architecture, and UI state handling. The app demonstrates core Flutter concepts such as state management, widget composition, and widget testing, while remaining easy to understand and extend.

## Overview

ColorMeUp is a single-screen app that allows users to:
- Tap anywhere on the screen to generate a random background color
- Edit or hide an on-screen text overlay
- View and copy the last 5 generated colors in both RGB and HEX formats

The app is built with testability and clean separation of concerns in mind.

## Features

### Color Generation
- Tap anywhere on the screen to generate a new random color.
- The current color is saved to a history list, limited to the 5 most recent entries.
- A click counter in the history modal shows how many colors have been generated overall.
- Color generation logic uses `dart:math` without any external packages.

### Editable Text Overlay
- A default message (“Hello there”) is displayed in the center of the screen.
- Users can edit or toggle the visibility of the text using a control menu triggered by a floating action button.
- An input dialog allows simple customization of the message.

### Color History Modal
- A dedicated floating button opens a bottom modal displaying the 5 most recently generated colors.
- Each color tile includes:
  - A visual color preview
  - RGB format (e.g. `RGB(123, 45, 67)`)
  - HEX format (e.g. `#7B2D43`)
  - Copy buttons for both formats
  - A snackbar confirmation when a value is copied

### Floating Action Buttons
The app includes several custom FABs:
- **Main FAB**: Regenerates a random color
- **Text FAB**: Shows/hides a static message
- **Control FAB**: Opens a dialog to edit or hide the text
- **History FAB**: Opens the color history modal

## Technical Details

- **Framework**: Flutter
- **Architecture**: Clean widget composition (no external state management libraries)
- **State**: Managed locally in `StatefulWidget`
- **Color Logic**: Uses `dart:math` for color randomness
- **Linter**: `solid_lints` ruleset for production and test code
- **Minimum Flutter SDK**: 3.16+

## Testing

Widget-level tests are written using the `flutter_test` package. Covered test cases include:
- Visibility and interaction of floating buttons
- Proper rendering of color history items
- Snackbar behavior when copying RGB or HEX values

No third-party dependencies are used in the testing setup.

## Getting Started

To run the project locally:

```bash
flutter pub get
flutter run
