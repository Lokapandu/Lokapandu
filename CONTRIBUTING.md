# Contributing to Lokapandu

Thank you for your interest in contributing to the Lokapandu project\! This document provides guidelines to help you contribute effectively.

## 📋 Table of Contents

  - [Code of Conduct](https://www.google.com/search?q=%23code-of-conduct)
  - [Getting Started](https://www.google.com/search?q=%23getting-started)
  - [Development Workflow](https://www.google.com/search?q=%23development-workflow)
  - [Coding Standards](https://www.google.com/search?q=%23coding-standards)
  - [Commit Guidelines](https://www.google.com/search?q=%23commit-guidelines)
  - [Pull Request Process](https://www.google.com/search?q=%23pull-request-process)
  - [Testing Guidelines](https://www.google.com/search?q=%23testing-guidelines)
  - [Architecture Guidelines](https://www.google.com/search?q=%23architecture-guidelines)

## 🤝 Code of Conduct

This project adheres to a friendly and inclusive code of conduct. By participating, you are expected to uphold this standard. Please report any inappropriate behavior to the maintainer team.

## 🚀 Getting Started

### Prerequisites

Make sure you have installed:

  - Flutter SDK (^3.9.2)
  - Dart SDK (^3.9.2)
  - Git
  - An IDE (VS Code/Android Studio)

### Setup Development Environment

1.  **Fork the repository**

    ```bash
    # Fork the repository on GitHub, then clone it
    git clone https://github.com/your-username/lokapandu.git
    cd lokapandu
    ```

2.  **Setup upstream remote**

    ```bash
    git remote add upstream https://github.com/original-owner/lokapandu.git
    ```

3.  **Install dependencies**

    ```bash
    flutter pub get
    ```

4.  **Setup environment**

    ```bash
    cp .env.example .env
    # Edit .env with your development configuration
    ```

5.  **Generate code**

    ```bash
    flutter packages pub run build_runner build --delete-conflicting-outputs
    ```

6.  **Verify setup**

    ```bash
    flutter test
    flutter run
    ```

## 🔄 Development Workflow

### Branch Strategy

We use a modified **Git Flow**:

  - `main` - Production-ready code
  - `develop` - Integration branch for development
  - `feature/*` - Feature branches
  - `bugfix/*` - Bug fix branches
  - `hotfix/*` - Critical fixes for production

### Working on Features

1.  **Sync with upstream**

    ```bash
    git checkout develop
    git pull upstream develop
    ```

2.  **Create a feature branch**

    ```bash
    git checkout -b feature/your-feature-name
    ```

3.  **Develop and commit**

    ```bash
    # Make your changes
    git add .
    git commit -m "feat: describe the feature"
    ```

4.  **Push and create a PR**

    ```bash
    git push origin feature/your-feature-name
    # Create a Pull Request on GitHub
    ```

## 📝 Coding Standards

### Dart/Flutter Guidelines

1.  **Follow the Dart Style Guide**

      - Use `dart format` for formatting
      - Run `dart analyze` for static analysis

2.  **Naming Conventions**

    ```dart
    // Classes - PascalCase
    class TourismSpotModel {}

    // Variables & Functions - camelCase
    String tourismSpotName;
    void getTourismSpots() {}

    // Constants - lowerCamelCase
    const String apiBaseUrl = 'https://api.example.com';

    // Private members - underscore prefix
    String _privateVariable;
    ```

3.  **File Organization**

    ```
    lib/
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    └── presentation/
        ├── pages/
        ├── provider/
        └── widgets/
    ```

### Code Quality

1.  **Documentation**

    ```dart
    /// Retrieves a list of tourism spots from the remote data source.
    ///
    /// Returns [Right] with a list of [TourismSpot] on success,
    /// or [Left] with a [Failure] on error.
    Future<Either<Failure, List<TourismSpot>>> getTourismSpots();
    ```

2.  **Error Handling**

    ```dart
    try {
      final result = await remoteDataSource.getTourismSpots();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server error occurred'));
    } on SocketException {
      return Left(ConnectionFailure('No internet connection'));
    }
    ```

3.  **Null Safety**

      - Use null safety features
      - Avoid using the `!` operator unless absolutely necessary
      - Prefer the `?.` and `??` operators

## 📝 Commit Guidelines

Use the **Conventional Commits** format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation changes
  - `style`: Formatting, missing semicolons, etc.
  - `refactor`: Code refactoring
  - `test`: Adding or fixing tests
  - `chore`: Maintenance tasks

### Examples

```bash
feat(auth): add user authentication with Supabase
fix(tourism): resolve null pointer exception in tourism list
docs(readme): update installation instructions
refactor(data): restructure repository pattern implementation
test(domain): add unit tests for tourism spot use cases
```

## 🔍 Pull Request Process

### Before Creating a PR

1.  **Sync with the develop branch**

    ```bash
    git checkout develop
    git pull upstream develop
    git checkout feature/your-feature
    git rebase develop
    ```

2.  **Run tests and checks**

    ```bash
    flutter test
    flutter analyze
    dart format --set-exit-if-changed .
    ```

3.  **Update documentation** if necessary

### PR Template

Use the following template for the PR description:

```markdown
## Description
A brief description of the changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots for UI changes.

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review of my own code
- [ ] I have updated the documentation
- [ ] I have added/updated tests
```

### Review Process

1.  **Automated checks** must pass.
2.  **Code review** by at least one maintainer.
3.  **Testing** on a device/emulator.
4.  **Approval** from a maintainer.

## 🧪 Testing Guidelines

### Test Structure

```
test/
├── unit/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── widget/
└── integration/
```

### Writing Tests

1.  **Unit Tests**

    ```dart
    group('GetTourismSpotList', () {
      test('should return a list of tourism spots when the call is successful', () async {
        // arrange
        when(mockRepository.getTourismSpots())
            .thenAnswer((_) async => Right(tTourismSpotList));

        // act
        final result = await usecase(NoParams());

        // assert
        expect(result, Right(tTourismSpotList));
        verify(mockRepository.getTourismSpots());
      });
    });
    ```

2.  **Widget Tests**

    ```dart
    testWidgets('should display the tourism spot list', (WidgetTester tester) async {
      // arrange
      when(mockNotifier.tourismSpots).thenReturn(tTourismSpotList);

      // act
      await tester.pumpWidget(makeTestableWidget(TourismSpotPage()));

      // assert
      expect(find.text('Tourism Spot 1'), findsOneWidget);
    });
    ```

### Test Coverage

  - Maintain a **minimum of 80%** test coverage.
  - Focus on business logic and critical paths.
  - Mock external dependencies.

## 🏗️ Architecture Guidelines

### Clean Architecture Layers

1.  **Presentation Layer**

      - Pages (UI screens)
      - Widgets (reusable components)
      - Providers (state management)

2.  **Domain Layer**

      - Entities (business objects)
      - Use Cases (business logic)
      - Repository interfaces

3.  **Data Layer**

      - Models (data transfer objects)
      - Repository implementations
      - Data sources (remote/local)

### Dependency Injection

Use GetIt for dependency injection:

```dart
// injection.dart
void init() {
  // Use cases
  locator.registerLazySingleton(() => GetTourismSpotList(locator()));

  // Repositories
  locator.registerLazySingleton<TourismSpotRepository>(
    () => TourismSpotRepositoryImpl(remoteDataSource: locator()),
  );

  // Data sources
  locator.registerLazySingleton<TourismSpotRemoteDataSource>(
    () => TourismSpotRemoteDataSourceImpl(supabaseService: locator()),
  );
}
```

### State Management

Use the Provider pattern:

```dart
class TourismSpotNotifier extends ChangeNotifier {
  List<TourismSpot> _tourismSpots = [];
  bool _isLoading = false;

  List<TourismSpot> get tourismSpots => _tourismSpots;
  bool get isLoading => _isLoading;

  Future<void> loadTourismSpots() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getTourismSpotList(NoParams());
    result.fold(
      (failure) => _handleError(failure),
      (spots) => _tourismSpots = spots,
    );

    _isLoading = false;
    notifyListeners();
  }
}
```

## 🐛 Bug Reports

Use the following template for bug reports:

```markdown
**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment:**
- Device: [e.g., iPhone 12, Samsung Galaxy S21]
- OS: [e.g., iOS 15.0, Android 12]
- App Version: [e.g., 1.0.0]
```

## 💡 Feature Requests

Use the following template for feature requests:

```markdown
**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. "I'm always frustrated when..."

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.
```

## 📞 Getting Help

If you need assistance:

1.  **Check existing issues** on GitHub.
2.  **Read the documentation** in README.md and docs/.
3.  **Ask questions** in GitHub Discussions.
4.  **Contact maintainers** for urgent issues.

## 🙏 Recognition

Contributors will be recognized in:

  - The README.md contributors section
  - Release notes
  - The GitHub contributors page

-----

Thank you for contributing to Lokapandu\! 🚀