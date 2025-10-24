import 'dart:async';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/common/services/impl/location_service_impl.dart';
import 'package:lokapandu/common/services/impl/routes_api_gateway.dart';
import 'package:lokapandu/common/services/impl/weather_api_gateway.dart';
import 'package:lokapandu/common/services/location_service.dart';
import 'package:lokapandu/common/services/routes_api_port.dart';
import 'package:lokapandu/common/services/weather_api_port.dart';
import 'package:lokapandu/data/datasources/services/auth_service.dart';
import 'package:lokapandu/data/datasources/services/supabase_service.dart';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source_impl.dart';
import 'package:lokapandu/data/repositories/brick/itinerary_repository_brick_impl.dart';
import 'package:lokapandu/data/repositories/supabase/tourism_spot_repository_supabase_impl.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';
import 'package:lokapandu/domain/usecases/get_current_weather.dart';
import 'package:lokapandu/domain/usecases/get_distance.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries_note.dart';
import 'package:lokapandu/domain/usecases/itineraries/delete_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/edit_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itinerary_by_id.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_detail.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spots_by_category.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/search_tourism_spots.dart';
import 'package:lokapandu/domain/validators/itinerary_validators.dart';
import 'package:lokapandu/presentation/ai_chat/provider/ai_chat_notifier.dart';
import 'package:lokapandu/presentation/auth/providers/auth_notifier.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_detail_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_editor_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_finding_notifier.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
import 'package:lokapandu/presentation/settings/providers/analytics_provider.dart';
import 'package:lokapandu/presentation/settings/providers/package_info_notifier.dart';
import 'package:lokapandu/presentation/settings/providers/theme_provider.dart';
import 'package:lokapandu/presentation/settings/providers/user_settings_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_calculation_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/repositories/brick/chat_repository_supabase_impl.dart';

final locator = GetIt.instance;

/// Initializes all dependencies following Clean Architecture principles.
///
/// Dependencies are organized by layers:
/// 1. External Services (Supabase, Firebase)
/// 2. Data Layer (Services, Data Sources, Repositories)
/// 3. Domain Layer (Use Cases)
/// 4. Presentation Layer (Providers/Notifiers)
///
/// Registration types:
/// - registerSingleton: Single instance created immediately
/// - registerLazySingleton: Single instance created when first requested
/// - registerFactory: New instance created each time requested

Future<void> initDependencies() async {
  // ========================================
  // EXTERNAL SERVICES
  // ========================================

  /// Supabase client - singleton as it manages connection state
  locator.registerSingleton<SupabaseClient>(Supabase.instance.client);

  /// genai
  locator.registerSingleton<GenerativeModel>(
    FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash'),
  );

  /// Location service - handles device location permissions
  locator.registerSingleton<Location>(Location());

  /// HTTP client - used for network requests
  locator.registerSingleton<http.Client>(http.Client());

  // ========================================
  // DATA LAYER
  // ========================================

  /// Services - Business logic services that handle external APIs
  locator.registerLazySingleton<SupabaseServiceInterface>(
    () => SupabaseService(),
  );

  /// Authentication service - handles Google Sign-In with Supabase
  final googleSignIn = GoogleSignIn.instance;

  locator.registerLazySingleton<AuthService>(
    () => AuthService(googleSignIn: googleSignIn),
  );

  /// Analytics service - handles Firebase Analytics
  locator.registerLazySingleton<AnalyticsManager>(() => AnalyticsManager());

  /// Data Sources - Handle data retrieval from external sources
  locator.registerLazySingleton<TourismSpotRemoteDataSource>(
    () => TourismSpotRemoteDataSourceImpl(
      supabaseService: locator<SupabaseServiceInterface>(),
    ),
  );
  locator.registerLazySingleton<LocationService>(
    () => LocationServiceImpl(locator<Location>()),
  );

  /// Weather remote data source - handles weather API requests
  locator.registerLazySingleton<WeatherPort>(
    () => WeatherApiGateway(client: locator<http.Client>()),
  );
  locator.registerLazySingleton<RoutesPort>(
    () => RoutesApiGateway(locator<SupabaseClient>()),
  );

  /// Repositories - Implement domain contracts and coordinate data sources
  locator.registerLazySingleton<TourismSpotRepository>(
    () => TourismSpotRepositorySupabaseImpl(
      remoteDataSource: locator<TourismSpotRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<ItineraryRepository>(
    () => ItineraryRepositoryImpl(),
  );

  locator.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());

  // ========================================
  // VALIDATORS
  // ========================================

  /// Validators - Handle business rule validations
  locator.registerLazySingleton<ItineraryValidators>(
    () => ItineraryValidators(locator<ItineraryRepository>()),
  );

  // ========================================
  // DOMAIN LAYER
  // ========================================

  /// Use Cases - Contain business logic and orchestrate data flow
  locator.registerLazySingleton<GetTourismSpotList>(
    () => GetTourismSpotList(locator<TourismSpotRepository>()),
  );
  locator.registerLazySingleton<GetTourismSpotDetail>(
    () => GetTourismSpotDetail(locator<TourismSpotRepository>()),
  );
  locator.registerLazySingleton<SearchTourismSpots>(
    () => SearchTourismSpots(locator<TourismSpotRepository>()),
  );
  locator.registerLazySingleton<GetTourismSpotsByCategory>(
    () => GetTourismSpotsByCategory(locator<TourismSpotRepository>()),
  );

  locator.registerLazySingleton<GetCurrentWeather>(
    () => GetCurrentWeather(locator<WeatherPort>()),
  );
  locator.registerLazySingleton<GetDistance>(
    () => GetDistance(locator<RoutesPort>()),
  );

  locator.registerLazySingleton<GetUserItineraries>(
    () => GetUserItineraries(locator<ItineraryRepository>()),
  );
  locator.registerLazySingleton<CreateUserItineraries>(
    () => CreateUserItineraries(
      locator<ItineraryRepository>(),
      locator<ItineraryValidators>(),
    ),
  );
  locator.registerLazySingleton<CreateUserItinerariesNote>(
    () => CreateUserItinerariesNote(
      locator<ItineraryRepository>(),
      locator<ItineraryValidators>(),
    ),
  );
  locator.registerLazySingleton<EditUserItineraries>(
    () => EditUserItineraries(
      locator<ItineraryRepository>(),
      locator<ItineraryValidators>(),
    ),
  );
  locator.registerLazySingleton<DeleteUserItineraries>(
    () => DeleteUserItineraries(locator<ItineraryRepository>()),
  );
  locator.registerLazySingleton<GetUserItineraryById>(
    () => GetUserItineraryById(locator<ItineraryRepository>()),
  );
  // ========================================
  // PRESENTATION LAYER
  // ========================================

  /// Providers/Notifiers - Manage UI state and user interactions
  /// Using factory registration for stateful providers to ensure fresh state
  locator.registerFactory<TourismSpotNotifier>(
    () => TourismSpotNotifier(
      locator<GetTourismSpotList>(),
      locator<SearchTourismSpots>(),
      locator<GetTourismSpotsByCategory>(),
    ),
  );

  locator.registerFactory<TourismSpotDetailNotifier>(
    () => TourismSpotDetailNotifier(locator<GetTourismSpotDetail>()),
  );

  /// Authentication providers - manages auth state
  locator.registerFactory<AuthNotifier>(
    () => AuthNotifier(
      authService: locator<AuthService>(),
      analyticsManager: locator<AnalyticsManager>(),
    ),
  );

  /// App Header Notifier - manages app header state
  locator.registerFactory<AppHeaderNotifier>(
    () => AppHeaderNotifier(
      locationService: locator<LocationService>(),
      analyticsManager: locator<AnalyticsManager>(),
      currentWeather: locator<GetCurrentWeather>(),
    ),
  );

  /// Tourism Spot Calculation Notifier - manages tourism spot calculation state
  locator.registerFactory<TourismSpotCalculationNotifier>(
    () => TourismSpotCalculationNotifier(
      getDistance: locator<GetDistance>(),
      analyticsManager: locator<AnalyticsManager>(),
      locationService: locator<LocationService>(),
    ),
  );

  locator.registerFactory<BookmarkProvider>(() => BookmarkProvider());
  locator.registerFactory<ThemeProvider>(
    () => ThemeProvider(locator<AnalyticsManager>()),
  );
  locator.registerFactory<AnalyticsProvider>(
    () => AnalyticsProvider(locator<AnalyticsManager>()),
  );
  locator.registerFactory<PackageInfoNotifier>(() => PackageInfoNotifier());
  locator.registerFactory<UserSettingsNotifier>(
    () => UserSettingsNotifier(locator<SupabaseClient>()),
  );
  locator.registerFactory<TourPlanEditorNotifier>(
    () => TourPlanEditorNotifier(
      analyticsManager: locator<AnalyticsManager>(),
      useCase: locator<CreateUserItineraries>(),
      createItineraryUseCase: locator<CreateUserItinerariesNote>(),
      editItineraryUseCase: locator<EditUserItineraries>(),
      validators: locator<ItineraryValidators>(),
    ),
  );
  locator.registerFactory<TourPlanNotifier>(
    () => TourPlanNotifier(
      locator<GetUserItineraries>(),
      locator<AnalyticsManager>(),
    ),
  );
  locator.registerFactory<TourPlanFindingNotifier>(
    () => TourPlanFindingNotifier(
      locator<GetTourismSpotList>(),
      locator<AnalyticsManager>(),
    ),
  );
  locator.registerFactory<TourPlanDetailNotifier>(
    () => TourPlanDetailNotifier(
      locator<GetUserItineraryById>(),
      locator<AnalyticsManager>(),
      locator<DeleteUserItineraries>(),
    ),
  );
  locator.registerFactory<AiChatNotifier>(
    () => AiChatNotifier(
      repository: locator<ChatRepository>(),
      manager: locator<AnalyticsManager>(),
    ),
  );
}
