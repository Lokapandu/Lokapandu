import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lokapandu/data/repositories/brick/itinerary_repository_brick_impl.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/create_user_itineraries_note.dart';
import 'package:lokapandu/domain/usecases/itineraries/delete_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/edit_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/itineraries/get_user_itineraries.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_detail.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/search_tourism_spots.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spots_by_category.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:lokapandu/data/datasources/services/supabase_service.dart';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/data/datasources/services/auth_service.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source_impl.dart';
import 'package:lokapandu/data/repositories/supabase/tourism_spot_repository_supabase_impl.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';
import 'package:lokapandu/domain/usecases/tourism_spots/get_tourism_spot_list.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:lokapandu/presentation/auth/providers/auth_provider.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';

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

  /// Repositories - Implement domain contracts and coordinate data sources
  locator.registerLazySingleton<TourismSpotRepository>(
    () => TourismSpotRepositorySupabaseImpl(
      remoteDataSource: locator<TourismSpotRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<ItineraryRepository>(
    () => ItineraryRepositoryImpl(),
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

  locator.registerLazySingleton<GetUserItineraries>(
    () => GetUserItineraries(locator<ItineraryRepository>()),
  );
  locator.registerLazySingleton<CreateUserItineraries>(
    () => CreateUserItineraries(locator<ItineraryRepository>()),
  );
  locator.registerLazySingleton<CreateUserItinerariesNote>(
    () => CreateUserItinerariesNote(locator<ItineraryRepository>()),
  );
  locator.registerLazySingleton<EditUserItineraries>(
    () => EditUserItineraries(locator<ItineraryRepository>()),
  );
  locator.registerLazySingleton<DeleteUserItineraries>(
    () => DeleteUserItineraries(locator<ItineraryRepository>()),
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

  /// Authentication provider - manages auth state
  locator.registerFactory<AuthNotifier>(
    () => AuthNotifier(
      authService: locator<AuthService>(),
      analyticsManager: locator<AnalyticsManager>(),
    ),
  );
}
