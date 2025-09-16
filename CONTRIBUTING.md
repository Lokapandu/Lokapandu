# Contributing to Lokapandu

Terima kasih atas minat Anda untuk berkontribusi pada proyek Lokapandu! Dokumen ini berisi panduan untuk membantu Anda berkontribusi secara efektif.

## 📋 Daftar Isi

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Testing Guidelines](#testing-guidelines)
- [Architecture Guidelines](#architecture-guidelines)

## 🤝 Code of Conduct

Proyek ini mengikuti kode etik yang ramah dan inklusif. Dengan berpartisipasi, Anda diharapkan untuk menjaga standar ini. Laporkan perilaku yang tidak pantas kepada tim maintainer.

## 🚀 Getting Started

### Prerequisites

Pastikan Anda telah menginstall:
- Flutter SDK (^3.9.2)
- Dart SDK (^3.9.2)
- Git
- IDE (VS Code/Android Studio)

### Setup Development Environment

1. **Fork repository**
   ```bash
   # Fork repository di GitHub, kemudian clone
   git clone https://github.com/your-username/lokapandu.git
   cd lokapandu
   ```

2. **Setup upstream remote**
   ```bash
   git remote add upstream https://github.com/original-owner/lokapandu.git
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Setup environment**
   ```bash
   cp .env.example .env
   # Edit .env dengan konfigurasi development Anda
   ```

5. **Generate code**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

6. **Verify setup**
   ```bash
   flutter test
   flutter run
   ```

## 🔄 Development Workflow

### Branch Strategy

Kami menggunakan **Git Flow** dengan modifikasi:

- `main` - Production-ready code
- `develop` - Integration branch untuk development
- `feature/*` - Feature branches
- `bugfix/*` - Bug fix branches
- `hotfix/*` - Critical fixes untuk production

### Working on Features

1. **Sync dengan upstream**
   ```bash
   git checkout develop
   git pull upstream develop
   ```

2. **Buat feature branch**
   ```bash
   git checkout -b feature/nama-fitur-anda
   ```

3. **Develop dan commit**
   ```bash
   # Lakukan perubahan
   git add .
   git commit -m "feat: deskripsi fitur"
   ```

4. **Push dan buat PR**
   ```bash
   git push origin feature/nama-fitur-anda
   # Buat Pull Request di GitHub
   ```

## 📝 Coding Standards

### Dart/Flutter Guidelines

1. **Ikuti Dart Style Guide**
   - Gunakan `dart format` untuk formatting
   - Jalankan `dart analyze` untuk static analysis

2. **Naming Conventions**
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

3. **File Organization**
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

1. **Documentation**
   ```dart
   /// Retrieves a list of tourism spots from the remote data source.
   /// 
   /// Returns [Right] with list of [TourismSpot] on success,
   /// or [Left] with [Failure] on error.
   Future<Either<Failure, List<TourismSpot>>> getTourismSpots();
   ```

2. **Error Handling**
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

3. **Null Safety**
   - Gunakan null safety features
   - Hindari penggunaan `!` operator kecuali benar-benar yakin
   - Prefer `?.` dan `??` operators

## 📝 Commit Guidelines

Gunakan **Conventional Commits** format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- `feat`: Fitur baru
- `fix`: Bug fix
- `docs`: Perubahan dokumentasi
- `style`: Formatting, missing semicolons, etc
- `refactor`: Code refactoring
- `test`: Menambah atau memperbaiki tests
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

### Before Creating PR

1. **Sync dengan develop branch**
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout feature/your-feature
   git rebase develop
   ```

2. **Run tests dan checks**
   ```bash
   flutter test
   flutter analyze
   dart format --set-exit-if-changed .
   ```

3. **Update documentation** jika diperlukan

### PR Template

Gunakan template berikut untuk PR description:

```markdown
## Description
Brief description of changes

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
Add screenshots for UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

### Review Process

1. **Automated checks** harus pass
2. **Code review** oleh minimal 1 maintainer
3. **Testing** pada device/emulator
4. **Approval** dari maintainer

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

1. **Unit Tests**
   ```dart
   group('GetTourismSpotList', () {
     test('should return list of tourism spots when call is successful', () async {
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

2. **Widget Tests**
   ```dart
   testWidgets('should display tourism spot list', (WidgetTester tester) async {
     // arrange
     when(mockNotifier.tourismSpots).thenReturn(tTourismSpotList);
     
     // act
     await tester.pumpWidget(makeTestableWidget(TourismSpotPage()));
     
     // assert
     expect(find.text('Tourism Spot 1'), findsOneWidget);
   });
   ```

### Test Coverage

- Maintain **minimum 80%** test coverage
- Focus pada business logic dan critical paths
- Mock external dependencies

## 🏗️ Architecture Guidelines

### Clean Architecture Layers

1. **Presentation Layer**
   - Pages (UI screens)
   - Widgets (reusable components)
   - Providers (state management)

2. **Domain Layer**
   - Entities (business objects)
   - Use Cases (business logic)
   - Repository interfaces

3. **Data Layer**
   - Models (data transfer objects)
   - Repository implementations
   - Data sources (remote/local)

### Dependency Injection

Gunakan GetIt untuk dependency injection:

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

Gunakan Provider pattern:

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

Gunakan template berikut untuk bug reports:

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- Device: [e.g. iPhone 12, Samsung Galaxy S21]
- OS: [e.g. iOS 15.0, Android 12]
- App Version: [e.g. 1.0.0]
```

## 💡 Feature Requests

Gunakan template berikut untuk feature requests:

```markdown
**Is your feature request related to a problem?**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request.
```

## 📞 Getting Help

Jika Anda membutuhkan bantuan:

1. **Check existing issues** di GitHub
2. **Read documentation** di README.md dan docs/
3. **Ask questions** di GitHub Discussions
4. **Contact maintainers** untuk urgent issues

## 🙏 Recognition

Kontributor akan diakui dalam:
- README.md contributors section
- Release notes
- GitHub contributors page

---

Terima kasih telah berkontribusi pada Lokapandu! 🚀