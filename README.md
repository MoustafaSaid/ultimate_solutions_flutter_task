# Ultimate Solution Flutter Task

A clean architecture Flutter project with feature-based organization.

## Project Structure

This project follows a clean architecture approach with feature-based organization:

```
lib/
├── core/
│   ├── constants/
│   │   ├── colors.dart
│   │   ├── strings.dart
│   │   └── dimensions.dart
│   ├── utils/
│   │   ├── error_handler.dart
│   │   ├── activity_manager.dart
│   ├── services/
│   │   ├── network_service.dart
│   │   ├── storage_service.dart
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── text_fields/
│   │   └── cards/
│   └── bloc/
│       └── bloc_observer.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
```

## Technology Stack

- **State Management**: BLoC/Cubit
- **API Integration**: Retrofit with Dio
- **Local Storage**: SQLite, Secure Storage
- **Code Generation**: JSON Serialization
- **Responsive UI**: screen_utils
- **Localization**: easy_localization
- **Dependency Injection**: GetIt

## Development Roadmap and Branching Strategy

### 1. Base Setup Branch
- Project configuration
- Add core packages
- Setup assets and resources
- Create core utilities (constants, colors, strings)
- Configure localization

### 2. Core Widgets Branch
- Create reusable buttons
- Create customized text form fields
- Create common UI components
- Setup theme and styling

### 3. Splash and Language Branch
- Implement splash screen
- Create language selection screen
- Setup language switching functionality
- Configure app initialization flow

### 4. Authentication Branch
- Login screen
- Authentication service
- Token management

### 5. Home Branch
- Orders

## Core Features and Services

- **Activity Manager**: Tracks 2-minute inactivity for session management
- **Error Handler**: Centralized error handling and reporting
- **BLoC Observer**: Monitors and logs state changes across the app
- **Network Service**: Handles API requests, retries, and connectivity
- **Storage Service**: Manages local data persistence
- **Responsive UI**: Ensures consistent layout across devices

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Make sure to have Flutter SDK installed and configured
4. Run `flutter run` to launch the application

## Guidelines for Contributors

- Follow the clean architecture principles
- Create feature branches from develop branch
- Update documentation when adding new components
- Follow the naming conventions established in the codebase

## Clarification
- For those concerned. 
- the task was sent to me on Wednesday and will be delivered on Friday.
- There wasn't enough time to work on Wednesday and Thursday since they are both work days. 
- I tried my best to complete the task as best as possible. 
- Sorry if it wasn't as expected. Thank you.
