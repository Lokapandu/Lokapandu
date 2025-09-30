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

Future<void> initDependencies() async {
  // EXTERNAL SERVICES
  locator.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // DATA LAYER
  locator.registerLazySingleton<SupabaseServiceInterface>(
    () => SupabaseService(),
  );

  locator.registerLazySingleton<TourismSpotRemoteDataSource>(
    () => TourismSpotRemoteDataSourceImpl(
      supabaseService: locator<SupabaseServiceInterface>(),
    ),
  );

  locator.registerLazySingleton<TourismSpotRepository>(
    () => TourismSpotRepositorySupabaseImpl(
      remoteDataSource: locator<TourismSpotRemoteDataSource>(),
    ),
  );

  // DOMAIN LAYER
  locator.registerLazySingleton<GetTourismSpotList>(
    () => GetTourismSpotList(locator<TourismSpotRepository>()),
  );
  locator.registerLazySingleton<GetTourismSpotDetail>(
    () => GetTourismSpotDetail(locator<TourismSpotRepository>()),
  );
  locator.registerLazySingleton<SearchTourismSpots>(
    () => SearchTourismSpots(locator<TourismSpotRepository>()),
  );

  // PRESENTATION LAYER
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