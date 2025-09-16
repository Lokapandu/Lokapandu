import 'package:get_it/get_it.dart';
import 'package:lokapandu/data/datasources/services/supabase_service.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/repositories/tourism_spot_repository_impl.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_list.dart';
import 'package:lokapandu/presentation/provider/counter_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => CounterNotifier(),
  ); // TODO: this code only example, to be delete soon

  // use case
  locator.registerLazySingleton(() => GetTourismSpotList(locator()));

  // repository
  locator.registerLazySingleton<TourismSpotRepository>(
    () => TourismSpotRepositoryImpl(remoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<TourismSpotRemoteDataSource>(
    () => TourismSpotRemoteDataSourceImpl(supabaseService: locator()),
  );

  // services
  locator.registerLazySingleton<SupabaseService>(() => SupabaseService());
}
