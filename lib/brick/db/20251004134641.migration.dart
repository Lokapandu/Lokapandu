// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20251004134641_up = [
  DropColumn('tourism_spot_TourismSpotModel_brick_id', onTable: 'TourismImageModel'),
  InsertTable('ItinerariesModel'),
  InsertTable('UserItinerariesModel'),
  InsertColumn('id', Column.integer, onTable: 'ItinerariesModel', unique: true),
  InsertColumn('name', Column.varchar, onTable: 'ItinerariesModel'),
  InsertColumn('notes', Column.varchar, onTable: 'ItinerariesModel'),
  InsertColumn('start_time', Column.datetime, onTable: 'ItinerariesModel'),
  InsertColumn('end_time', Column.datetime, onTable: 'ItinerariesModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'ItinerariesModel'),
  InsertColumn('tourism_spot_id', Column.integer, onTable: 'ItinerariesModel'),
  InsertColumn('tourism_spot_id', Column.integer, onTable: 'TourismImageModel'),
  InsertColumn('id', Column.integer, onTable: 'UserItinerariesModel', unique: true),
  InsertColumn('user_id', Column.integer, onTable: 'UserItinerariesModel'),
  InsertColumn('itineraries_id', Column.integer, onTable: 'UserItinerariesModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'UserItinerariesModel'),
  CreateIndex(columns: ['id'], onTable: 'ItinerariesModel', unique: true),
  CreateIndex(columns: ['id'], onTable: 'UserItinerariesModel', unique: true)
];

const List<MigrationCommand> _migration_20251004134641_down = [
  DropTable('ItinerariesModel'),
  DropTable('UserItinerariesModel'),
  DropColumn('id', onTable: 'ItinerariesModel'),
  DropColumn('name', onTable: 'ItinerariesModel'),
  DropColumn('notes', onTable: 'ItinerariesModel'),
  DropColumn('start_time', onTable: 'ItinerariesModel'),
  DropColumn('end_time', onTable: 'ItinerariesModel'),
  DropColumn('created_at', onTable: 'ItinerariesModel'),
  DropColumn('tourism_spot_id', onTable: 'ItinerariesModel'),
  DropColumn('tourism_spot_id', onTable: 'TourismImageModel'),
  DropColumn('id', onTable: 'UserItinerariesModel'),
  DropColumn('user_id', onTable: 'UserItinerariesModel'),
  DropColumn('itineraries_id', onTable: 'UserItinerariesModel'),
  DropColumn('created_at', onTable: 'UserItinerariesModel'),
  DropIndex('index_ItinerariesModel_on_id'),
  DropIndex('index_UserItinerariesModel_on_id')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20251004134641',
  up: _migration_20251004134641_up,
  down: _migration_20251004134641_down,
)
class Migration20251004134641 extends Migration {
  const Migration20251004134641()
    : super(
        version: 20251004134641,
        up: _migration_20251004134641_up,
        down: _migration_20251004134641_down,
      );
}
