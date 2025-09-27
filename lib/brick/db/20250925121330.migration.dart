// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250925121330_up = [
  DropColumn('created_at', onTable: 'TourismSpot'),
  InsertTable('TourismImage'),
  InsertColumn('created_at', Column.datetime, onTable: 'TourismSpot'),
  InsertColumn('id', Column.integer, onTable: 'TourismImage', unique: true),
  InsertColumn('tourism_spot_id', Column.integer, onTable: 'TourismImage'),
  InsertColumn('label', Column.varchar, onTable: 'TourismImage'),
  InsertColumn('image_url', Column.varchar, onTable: 'TourismImage'),
  InsertColumn('created_at', Column.datetime, onTable: 'TourismImage'),
  CreateIndex(columns: ['id'], onTable: 'TourismImage', unique: true),
];

const List<MigrationCommand> _migration_20250925121330_down = [
  DropTable('TourismImage'),
  DropColumn('created_at', onTable: 'TourismSpot'),
  DropColumn('id', onTable: 'TourismImage'),
  DropColumn('tourism_spot_id', onTable: 'TourismImage'),
  DropColumn('label', onTable: 'TourismImage'),
  DropColumn('image_url', onTable: 'TourismImage'),
  DropColumn('created_at', onTable: 'TourismImage'),
  DropIndex('index_TourismImage_on_id'),
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250925121330',
  up: _migration_20250925121330_up,
  down: _migration_20250925121330_down,
)
class Migration20250925121330 extends Migration {
  const Migration20250925121330()
    : super(
        version: 20250925121330,
        up: _migration_20250925121330_up,
        down: _migration_20250925121330_down,
      );
}
