# My Study Planner

A Flutter and Dart course project developed in five assessed phases. This branch completes **Phase 2**: students can add sample goals, mark goals done, and delete goals. Goals are stored in memory and reset when the app restarts.

## Project Overview

My Study Planner starts with a static screen and builds toward a persistent study-goal app. Each phase is kept distinct so its work can be assessed on its own branch.

## Technologies Used

- Flutter and Dart
- Material 3 widgets from Flutter's standalone `material_ui` package
- `StatefulWidget` and `setState()` for Phase 2's in-memory updates

## Phase Progress Tracker

| Phase | Focus | Status |
| --- | --- | --- |
| Phase 1 | Static screen | Complete |
| Phase 2 | Working goal list | Complete |
| Phase 3 | Statistics and reusable cards | Not started |
| Phase 4 | Add-goal screen and validation | Not started |
| Phase 5 | SQLite persistence | Not started |

## Features Completed in Phase 2

- Stores goals in a `List` of maps with `subject`, `hours`, and `done` values.
- Builds goal cards with `ListView.builder`.
- Adds a sample History goal with the floating action button.
- Marks a goal done by tapping its checkbox or row; completed goals are crossed out.
- Deletes a goal with its delete icon.
- Updates the screen with `setState()` after each change.

## How Phase 1 Is Different From Future Phases

Phase 1 displayed three hard-coded goal cards. It had no state management, user interaction, database, or navigation. Phase 2 replaces those fixed cards with an in-memory list and adds the basic add, complete, and delete actions.

Phase 2 intentionally has no statistics, reusable statistics cards, navigation, form, validation, or database. Goals are lost when the app closes. These features are reserved for Phases 3–5.

## Screenshots

See [`screenshots/README.md`](screenshots/README.md) for where to add screenshots of the Phase 2 list, completed goal, and added sample goal.

## Installation Steps

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Clone this repository and enter the project directory:

   ```bash
   git clone <repository-url>
   cd study_planner
   ```

3. Install packages and generate platform scaffolding if needed:

   ```bash
   flutter pub get
   flutter create --project-name study_planner --platforms android,web .
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Repository Structure

```text
study_planner/
├── assets/
│   └── .gitkeep
├── lib/
│   └── main.dart
├── screenshots/
│   └── README.md
├── test/
│   └── widget_test.dart
├── .gitignore
├── analysis_options.yaml
├── README.md
├── pubspec.lock
└── pubspec.yaml
```

## Future Phases Roadmap

- **Phase 3 — Statistics and Cards:** Show live summary values and introduce a reusable statistics card widget.
- **Phase 4 — Add Goal Screen:** Add navigation to a validated goal-entry form.
- **Phase 5 — Database Persistence:** Save and load goals with SQLite.

Recommended branches:

- `main`
- `phase-1-static-screen`
- `phase-2-working-list`
- `phase-3-statistics-cards`
- `phase-4-add-goal-screen`
- `phase-5-database-persistence`

Recommended phase tags: `v1-phase1`, `v2-phase2`, `v3-phase3`, `v4-phase4`, and `v5-phase5`. Create each tag after that phase is complete and reviewed.

## Assessment Notes

- This branch completes Phase 2 and retains the Phase 1 screen structure.
- Goal data is held only in a Dart list while the app is open.
- The floating action button adds a sample goal; entering custom goals is reserved for Phase 4.
- Statistics and persistence are intentionally deferred to later phases.
- Capture the required screenshots and add them under `screenshots/` before submission.
