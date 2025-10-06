// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20251006073628_up = [
  InsertTable('TourismImageModel'),
  InsertTable('TourismSpotModel'),
  InsertTable('ItineraryModel'),
  InsertTable('UserItineraryModel'),
  InsertColumn('id', Column.integer, onTable: 'TourismImageModel', unique: true),
  InsertColumn('tourism_spot_id', Column.integer, onTable: 'TourismImageModel'),
  InsertColumn('label', Column.varchar, onTable: 'TourismImageModel'),
  InsertColumn('image_url', Column.varchar, onTable: 'TourismImageModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'TourismImageModel'),
  InsertColumn('id', Column.integer, onTable: 'TourismSpotModel', unique: true),
  InsertColumn('name', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('description', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('city', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('province', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('category', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('address', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('latitude', Column.Double, onTable: 'TourismSpotModel'),
  InsertColumn('longitude', Column.Double, onTable: 'TourismSpotModel'),
  InsertColumn('open_time', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('close_time', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('maps_link', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('facilities', Column.varchar, onTable: 'TourismSpotModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'TourismSpotModel'),
  InsertColumn('id', Column.integer, onTable: 'ItineraryModel', unique: true),
  InsertColumn('name', Column.varchar, onTable: 'ItineraryModel'),
  InsertColumn('notes', Column.varchar, onTable: 'ItineraryModel'),
  InsertColumn('start_time', Column.datetime, onTable: 'ItineraryModel'),
  InsertColumn('end_time', Column.datetime, onTable: 'ItineraryModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'ItineraryModel'),
  InsertColumn('tourism_spot_id', Column.integer, onTable: 'ItineraryModel'),
  InsertColumn('id', Column.integer, onTable: 'UserItineraryModel', unique: true),
  InsertColumn('user_id', Column.integer, onTable: 'UserItineraryModel'),
  InsertColumn('itineraries_id', Column.integer, onTable: 'UserItineraryModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'UserItineraryModel'),
  CreateIndex(columns: ['id'], onTable: 'TourismImageModel', unique: true),
  CreateIndex(columns: ['id'], onTable: 'TourismSpotModel', unique: true),
  CreateIndex(columns: ['id'], onTable: 'ItineraryModel', unique: true),
  CreateIndex(columns: ['id'], onTable: 'UserItineraryModel', unique: true)
];

const List<MigrationCommand> _migration_20251006073628_down = [
  DropTable('TourismImageModel'),
  DropTable('TourismSpotModel'),
  DropTable('ItineraryModel'),
  DropTable('UserItineraryModel'),
  DropColumn('id', onTable: 'TourismImageModel'),
  DropColumn('tourism_spot_id', onTable: 'TourismImageModel'),
  DropColumn('label', onTable: 'TourismImageModel'),
  DropColumn('image_url', onTable: 'TourismImageModel'),
  DropColumn('created_at', onTable: 'TourismImageModel'),
  DropColumn('id', onTable: 'TourismSpotModel'),
  DropColumn('name', onTable: 'TourismSpotModel'),
  DropColumn('description', onTable: 'TourismSpotModel'),
  DropColumn('city', onTable: 'TourismSpotModel'),
  DropColumn('province', onTable: 'TourismSpotModel'),
  DropColumn('category', onTable: 'TourismSpotModel'),
  DropColumn('address', onTable: 'TourismSpotModel'),
  DropColumn('latitude', onTable: 'TourismSpotModel'),
  DropColumn('longitude', onTable: 'TourismSpotModel'),
  DropColumn('open_time', onTable: 'TourismSpotModel'),
  DropColumn('close_time', onTable: 'TourismSpotModel'),
  DropColumn('maps_link', onTable: 'TourismSpotModel'),
  DropColumn('facilities', onTable: 'TourismSpotModel'),
  DropColumn('created_at', onTable: 'TourismSpotModel'),
  DropColumn('id', onTable: 'ItineraryModel'),
  DropColumn('name', onTable: 'ItineraryModel'),
  DropColumn('notes', onTable: 'ItineraryModel'),
  DropColumn('start_time', onTable: 'ItineraryModel'),
  DropColumn('end_time', onTable: 'ItineraryModel'),
  DropColumn('created_at', onTable: 'ItineraryModel'),
  DropColumn('tourism_spot_id', onTable: 'ItineraryModel'),
  DropColumn('id', onTable: 'UserItineraryModel'),
  DropColumn('user_id', onTable: 'UserItineraryModel'),
  DropColumn('itineraries_id', onTable: 'UserItineraryModel'),
  DropColumn('created_at', onTable: 'UserItineraryModel'),
  DropIndex('index_TourismImageModel_on_id'),
  DropIndex('index_TourismSpotModel_on_id'),
  DropIndex('index_ItineraryModel_on_id'),
  DropIndex('index_UserItineraryModel_on_id')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20251006073628',
  up: _migration_20251006073628_up,
  down: _migration_20251006073628_down,
)
class Migration20251006073628 extends Migration {
  const Migration20251006073628()
    : super(
        version: 20251006073628,
        up: _migration_20251006073628_up,
        down: _migration_20251006073628_down,
      );
}
