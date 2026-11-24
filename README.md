# My Study Planner

A Flutter and Dart course project for a five-phase mobile application development assessment. This branch contains **Phase 1 only**: a static screen with three hard-coded study goals.

## Project Overview

Phase 1 establishes the app's visual structure. Later phases build on it in separate branches so each phase remains easy to assess.

## Technologies Used

- Flutter and Dart
- Material 3 widgets from Flutter's standalone `material_ui` package

## Phase Progress Tracker

| Phase | Focus | Status |
| --- | --- | --- |
| Phase 1 | Static screen | Complete |
| Phase 2 | Working goal list | Not started |
| Phase 3 | Statistics and reusable cards | Not started |
| Phase 4 | Add-goal screen and validation | Not started |
| Phase 5 | SQLite persistence | Not started |

## Features Completed in Phase 1

- App title and AppBar display **My Study Planner**.
- A heading appears above three hard-coded study-goal cards.
- Each card shows a subject and planned study hours.
- A floating action button is visible, with an intentionally empty callback.

## How Phase 1 Is Different From Future Phases

The goal cards are hard-coded in the widget tree. No state management exists, no user interaction exists, no database exists, and no navigation exists. The floating action button does not perform an action.

This branch is intentionally limited to Phase 1 so later-phase features remain distinguishable for assessment.

## Screenshots

See [`screenshots/README.md`](screenshots/README.md) for where to add a screenshot of the running Phase 1 screen.

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
├── .gitignore
├── analysis_options.yaml
├── README.md
└── pubspec.yaml
```

## Future Phases Roadmap

- **Phase 2 — Working List:** Store goals in memory and support adding, completing, and deleting goals.
- **Phase 3 — Statistics and Cards:** Show live summary values and introduce a reusable statistics card widget.
- **Phase 4 — Add Goal Screen:** Add navigation to a validated goal-entry form.
- **Phase 5 — Database Persistence:** Save and load goals with SQLite.

Recommended branches: `main`, `phase-1-static-screen`, `phase-2-working-list`, `phase-3-statistics-cards`, `phase-4-add-goal-screen`, and `phase-5-database-persistence`.

Recommended tags: `v1-phase1`, `v2-phase2`, `v3-phase3`, `v4-phase4`, and `v5-phase5`. Create a tag after each phase is complete and reviewed.

## Assessment Notes

- This branch completes Phase 1 only.
- The goal cards are intentionally hard-coded.
- Do not include Phase 2–5 functionality on this branch.
- Add a screenshot of the running app under `screenshots/` before submission.
