## FitApp

Flutter Fitness App is a mobile application built using Flutter, BLoC architecture, and SQLite, designed to help users take control of their health and fitness goals. The app focuses on providing a simple and effective way to plan workouts, track progress, monitor diet, and keep an eye on weight — all while working completely offline.
This project reflects my interest in mobile development, clean architecture, and building real-life, practical apps that focus on user needs and performance. It’s built with scalability and maintainability in mind, following best practices for state management and data persistence.

**What the App Does**
- **Workout Planning** – Users can create and manage their own workout plans tailored to their goals.
- **Training Progress Tracking** – After each session, users can log what they did and view their progress over time.
- **Diet Monitoring** – The app allows users to record meals and track what they eat each day.
- **Weight Tracking** – Users can enter their weight daily or weekly and visualize changes over time.
- **Offline Functionality** – Thanks to SQLite, all data is stored locally, so no internet connection is required.

**Tech Stack**
- **Flutter** – Cross-platform mobile framework
- **Dart** – Programming language
- **BLoC** – State management
- **SQLite** – Local data storage

## Flutter Project File Structure

lib/
├── buisness/                       # Business logic of the app (handling actions, BLoC, states)
│   ├── action/                    # Definitions of actions triggered by the user or system
│   ├── bloc/                      # Business Logic Component – manages application state
│   └── states/                    # Definitions of various states used by the BLoC
├── config/
│   └── theme/                     # Application theme configuration (colors, styles)
│       ├── app_theme.dart        # Main theme setup (fonts, light/dark mode, etc.)
│       └── colors.dart           # Predefined color palette used throughout the app
├── data/                          # Responsible for data access and handling
│   ├── database/                  # Local database setup (e.g., SQLite, Moor/Drift)
│   │   ├── dao/                   # Data Access Objects – interfaces for database operations
│   │   ├── table/                 # Table definitions (schemas used in the DB)
│   │   └── app_database.dart     # Database configuration and initialization
│   ├── models/                    # Data models representing DB structures or DTOs
│   │   ├── diet/                  # Models related to diet (e.g., meals, calories)
│   │   ├── plan/                  # Models for exercise/training plans
│   │   ├── weight/                # Models for user body weight tracking
│   │   └── base_model.dart       # Base model class – shared properties or logic
│   ├── repositories/             # Repositories – abstraction layer between UI and DB
│   │   └── (e.g., diet_repository.dart, plan_repository.dart) # Example repositories
│   └── sql_result_formatter.dart # Utility to process and format raw SQL results
├── presentation/                  # App's user interface layer (screens, widgets, views)
│   ├── pages/                    # Main pages or tabs of the application
│   ├── screens/                  # Individual screens that make up each page
│   └── widgets/                  # Reusable UI components (e.g., buttons, cards)
├── utils/                         # Utility functions and helpers
│   ├── calculation.dart          # Calculation logic used throughout the app
│   ├── current_date.dart         # Date and time-related utility functions
│   ├── plan_exercise.dart        # Logic for planning exercises (possibly DB-related)
└── main.dart                      # Entry point of the Flutter application


#Link to YouTube Presentation:
[![Presentation of FitApp](https://img.youtube.com/vi/QLSvFpT-Fds/maxresdefault.jpg)](https://www.youtube.com/watch?v=QLSvFpT-Fds)

