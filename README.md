[](https://codemagic.io/app/68d21507b129bcfa785c9173/68d21507b129bcfa785c9172/latest_build)

# Lokapandu

A Flutter application for exploring local Indonesian tourist attractions with Firebase and Supabase integration.

-----

## 📱 About The App

Lokapandu is a mobile application that allows users to discover and explore various local tourist spots in Indonesia. This app is built using Flutter with Clean Architecture and integrates Firebase AI and Supabase as its backend.

-----

## ✨ Key Features

  - 🗺️ Explore tourist attractions based on location
  - 📍 Detailed information about attractions (address, operating hours, facilities)
  - 🖼️ Photo gallery for each tourist spot
  - 🔗 Google Maps integration
  - 🤖 AI-powered recommendations (Firebase AI)
  - 📱 Responsive design for various screen sizes
  - 📅 Trip planning and itinerary management
  - 🔖 Bookmark favorite destinations

-----

## 🏗️ Architecture

This project uses **Clean Architecture** with **Brick Offline-First Architecture** for the following layer division:

```
lib/
├── brick/           # Brick offline-first configuration
├── data/            # Data layer (models, repositories, data sources)
├── domain/          # Domain layer (entities, repositories, use cases)
├── presentation/    # Presentation layer (screens, widgets, providers)
├── features/        # Feature-specific implementations
├── common/          # Shared utilities and failure handling
├── env/             # Environment configuration
└── injection.dart   # Dependency injection setup
```

### 🧱 Brick Offline-First Architecture

This application uses [Brick](https://github.com/GetDutchie/brick) for its offline-first implementation:

  - **Local Storage**: SQLite for local data storage
  - **Remote Sync**: Automatic synchronization with Supabase
  - **Offline Capability**: The app remains functional without an internet connection
  - **Data Consistency**: Automatic conflict resolution and data merging

**Benefits of Brick Architecture:**

  - ⚡ High performance with local data
  - 🔄 Automatic synchronization when online
  - 📱 Consistent user experience
  - 🛡️ Resilient to unstable connections

-----

## 🛠️ Tech Stack

  - **Framework**: Flutter (SDK ^3.9.2)
  - **Language**: Dart
  - **State Management**: Provider, Riverpod
  - **Navigation**: Go Router
  - **Backend**: Supabase (Database, Authentication, Storage)
  - **Offline-First**: Brick Architecture with SQLite
  - **AI Integration**: Firebase AI (Gemini)
  - **Firebase Services**: Analytics, Crashlytics, Authentication, Performance
  - **Architecture**: Clean Architecture + Brick Offline-First
  - **Code Generation**: Freezed, JSON Serialization
  - **Environment Management**: Envied
  - **Dependency Injection**: GetIt
  - **Maps**: Google Maps Flutter
  - **Location Services**: Location & Geocoding

-----

## 🚀 Installation & Setup

### Prerequisites

Make sure you have installed:

  - [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.9.2 or newer)
  - [Dart SDK](https://dart.dev/get-dart) (version 3.9.2 or newer)
  - [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
  - [Git](https://git-scm.com/)

### Installation Steps

1.  **Clone the repository**

    ```bash
    git clone https://github.com/your-username/lokapandu.git
    cd lokapandu
    ```

2.  **Install dependencies**

    ```bash
    flutter pub get
    ```

3.  **Setup Environment Variables**

    ```bash
    # Copy the .env.example file to .env
    cp .env.example .env

    # Edit the .env file and fill it with your configuration
    SUPABASE_URL=your-supabase-url
    SUPABASE_KEY=your-supabase-key
    ```

4.  **Setup Firebase**

      - Create a new project in the [Firebase Console](https://console.firebase.google.com/)
      - Download `google-services.json` for Android and place it in `android/app/`
      - Download `GoogleService-Info.plist` for iOS and place it in `ios/Runner/`
      - Run the Firebase CLI for configuration:
        ```bash
        firebase login
        flutterfire configure
        ```

5.  **Setup Supabase**

      - Create a new project on [Supabase](https://supabase.com/)
      - Get the URL and anon key from your Supabase dashboard
      - Update the `.env` file with your Supabase credentials

6.  **Generate Code**

    ```bash
    flutter packages pub run build_runner build --delete-conflicting-outputs
    ```

7.  **Run the Application**

    ```bash
    # Debug mode
    flutter run

    # Release mode
    flutter run --release
    ```

-----

## 📁 Project Structure

```
lokapandu/
├── android/                   # Android-specific files
├── ios/                       # iOS-specific files
├── assets/                    # App assets (images, icons, illustrations)
├── lib/
│   ├── app.dart               # Main app widget
│   ├── main.dart              # Entry point
│   ├── injection.dart         # Dependency injection
│   ├── firebase_options.dart  # Firebase configuration
│   ├── brick/                 # Brick offline-first configuration
│   │   ├── adapters/          # Data adapters for Brick
│   │   ├── db/                # SQLite database setup
│   │   ├── models/            # Brick models
│   │   └── repositories/      # Brick repository implementations
│   ├── common/                # Shared utilities
│   │   ├── analytics.dart     # Analytics tracking
│   │   ├── config/            # App configuration
│   │   ├── errors/            # Error handling
│   │   ├── observers/         # Navigation observers
│   │   ├── routes/            # Routing configuration
│   │   ├── services/          # Common services
│   │   ├── themes/            # App theming
│   │   └── utils/             # Utility functions
│   ├── data/
│   │   ├── datasources/       # Remote & local data sources
│   │   ├── models/            # Data models
│   │   ├── mappers/           # Data mappers
│   │   └── repositories/      # Repository implementations
│   ├── domain/
│   │   ├── entities/          # Business entities
│   │   ├── repositories/      # Repository contracts
│   │   ├── usecases/          # Business logic
│   │   └── validators/        # Input validation
│   ├── features/              # Feature-based organization
│   │   └── ai_chat/           # AI chat feature
│   ├── env/
│   │   └── env.dart           # Environment configuration
│   └── presentation/
│       ├── ai_chat/           # AI chat UI
│       ├── auth/              # Authentication UI
│       ├── bookmark/          # Bookmark UI
│       ├── common/            # Shared UI components
│       ├── home/              # Home screen
│       ├── plan/              # Trip planning UI
│       ├── settings/          # Settings UI
│       └── tourism_spot/      # Tourism spot UI
├── test/                      # Unit & widget tests
├── docs/                      # Project documentation
├── .env.example               # Environment variables template
├── pubspec.yaml               # Dependencies & project config
└── README.md                  # Project documentation
```

-----

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/path/to/test_file.dart
```

## 🤝 Contributing

Contributions are welcome! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the terms of the license found in the [LICENSE](LICENSE) file.

-----

## 📱 Build & Deploy

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Google Play Store)
flutter build appbundle --release
```

### iOS

```bash
# Build iOS
flutter build ios --release
```

-----

## 🔧 Development

### Code Generation

This project uses code generation for models and serialization:

```bash
# Generate code once
flutter packages pub run build_runner build

# Watch mode (auto-generates when files change)
flutter packages pub run build_runner watch

# Clean and rebuild
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Environment Variables

Use the `.env` file for environment configuration:

```env
SUPABASE_URL=your-supabase-url
SUPABASE_KEY=your-supabase-key
```

-----

## 🤝 Contributing

Please read [CONTRIBUTING.md](https://www.google.com/search?q=CONTRIBUTING.md) for contribution guidelines.

-----

## 📄 License

This project is licensed under the [MIT License](https://www.google.com/search?q=LICENSE).

-----

## 📞 Support

If you encounter any issues or have questions:

1.  Check existing [Issues](https://github.com/your-username/lokapandu/issues)
2.  Create a new issue if one doesn't already exist
3.  Contact the development team

-----

## 🙏 Acknowledgments

  - [Flutter Team](https://flutter.dev/) for the amazing framework
  - [Supabase](https://supabase.com/) for the backend-as-a-service
  - [Firebase](https://firebase.google.com/) for AI and analytics
  - The Flutter Indonesia Community

-----

**Happy Coding\! 🚀**