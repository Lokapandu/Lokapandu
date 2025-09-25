import 'package:get_it/get_it.dart';
import 'package:lokapandu/data/repositories/tourism_spot_repository_impl.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';
import 'package:lokapandu/domain/usecases/get_tourism_spot_list.dart';
import 'package:lokapandu/presentation/provider/counter_notifier.dart';
import 'package:lokapandu/presentation/provider/tourism_spot_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  locator.registerSingleton<SupabaseClient>(Supabase.instance.client);

  locator.registerSingleton<TourismSpotRepository>(TourismSpotRepositoryImpl());

  locator.registerLazySingleton<GetTourismSpotList>(
    () => GetTourismSpotList(locator<TourismSpotRepository>()),
  );

  locator.registerFactory<CounterNotifier>(
    () => CounterNotifier(),
  );

  locator.registerFactory<TourismSpotNotifier>(
    () => TourismSpotNotifier(locator<GetTourismSpotList>()),
  );
}
