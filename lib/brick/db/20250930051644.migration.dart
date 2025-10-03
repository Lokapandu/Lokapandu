// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250930051644_up = [
  InsertTable('TourismImageModel'),
  InsertTable('TourismSpotModel'),
  InsertColumn(
    'id',
    Column.integer,
    onTable: 'TourismImageModel',
    unique: true,
  ),
  InsertForeignKey(
    'TourismImageModel',
    'TourismSpotModel',
    foreignKeyColumn: 'tourism_spot_TourismSpotModel_brick_id',
    onDeleteCascade: false,
    onDeleteSetDefault: false,
  ),
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
  CreateIndex(columns: ['id'], onTable: 'TourismImageModel', unique: true),
  CreateIndex(columns: ['id'], onTable: 'TourismSpotModel', unique: true),
];

const List<MigrationCommand> _migration_20250930051644_down = [
  DropTable('TourismImageModel'),
  DropTable('TourismSpotModel'),
  DropColumn('id', onTable: 'TourismImageModel'),
  DropColumn(
    'tourism_spot_TourismSpotModel_brick_id',
    onTable: 'TourismImageModel',
  ),
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
  DropIndex('index_TourismImageModel_on_id'),
  DropIndex('index_TourismSpotModel_on_id'),
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250930051644',
  up: _migration_20250930051644_up,
  down: _migration_20250930051644_down,
)
class Migration20250930051644 extends Migration {
  const Migration20250930051644()
    : super(
        version: 20250930051644,
        up: _migration_20250930051644_up,
        down: _migration_20250930051644_down,
      );
}
