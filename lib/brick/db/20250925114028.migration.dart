// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250925114028_up = [
  InsertTable('TourismSpot'),
  InsertColumn('id', Column.integer, onTable: 'TourismSpot', unique: true),
  InsertColumn('name', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('description', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('city', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('province', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('category', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('address', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('latitude', Column.Double, onTable: 'TourismSpot'),
  InsertColumn('longitude', Column.Double, onTable: 'TourismSpot'),
  InsertColumn('open_time', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('close_time', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('maps_link', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('facilities', Column.varchar, onTable: 'TourismSpot'),
  InsertColumn('created_at', Column.varchar, onTable: 'TourismSpot'),
  CreateIndex(columns: ['id'], onTable: 'TourismSpot', unique: true),
];

const List<MigrationCommand> _migration_20250925114028_down = [
  DropTable('TourismSpot'),
  DropColumn('id', onTable: 'TourismSpot'),
  DropColumn('name', onTable: 'TourismSpot'),
  DropColumn('description', onTable: 'TourismSpot'),
  DropColumn('city', onTable: 'TourismSpot'),
  DropColumn('province', onTable: 'TourismSpot'),
  DropColumn('category', onTable: 'TourismSpot'),
  DropColumn('address', onTable: 'TourismSpot'),
  DropColumn('latitude', onTable: 'TourismSpot'),
  DropColumn('longitude', onTable: 'TourismSpot'),
  DropColumn('open_time', onTable: 'TourismSpot'),
  DropColumn('close_time', onTable: 'TourismSpot'),
  DropColumn('maps_link', onTable: 'TourismSpot'),
  DropColumn('facilities', onTable: 'TourismSpot'),
  DropColumn('created_at', onTable: 'TourismSpot'),
  DropIndex('index_TourismSpot_on_id'),
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250925114028',
  up: _migration_20250925114028_up,
  down: _migration_20250925114028_down,
)
class Migration20250925114028 extends Migration {
  const Migration20250925114028()
    : super(
        version: 20250925114028,
        up: _migration_20250925114028_up,
        down: _migration_20250925114028_down,
      );
}
