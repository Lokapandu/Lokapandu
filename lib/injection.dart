import 'package:get_it/get_it.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_detail.dart';
import 'package:lokapandu/domain/usecases/search_tourism_spots.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:lokapandu/data/datasources/services/supabase_service.dart';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source_impl.dart';
import 'package:lokapandu/data/repositories/tourism_spot_repository_supabase_impl.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_list.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';

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

  // ========================================
  // PRESENTATION LAYER
  // ========================================

  /// Providers/Notifiers - Manage UI state and user interactions
  /// Using factory registration for stateful providers to ensure fresh state
  locator.registerFactory<TourismSpotNotifier>(
    () => TourismSpotNotifier(
      locator<GetTourismSpotList>(),
      locator<SearchTourismSpots>(),
    ),
  );

  locator.registerFactory<TourismSpotDetailNotifier>(
    () => TourismSpotDetailNotifier(locator<GetTourismSpotDetail>()),
  );
}