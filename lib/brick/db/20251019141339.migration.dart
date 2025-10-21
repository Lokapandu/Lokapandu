// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20251019141339_up = [
  DropColumn('start_time', onTable: 'ItineraryModel'),
  DropColumn('end_time', onTable: 'ItineraryModel'),
  InsertColumn('start_time', Column.varchar, onTable: 'ItineraryModel'),
  InsertColumn('end_time', Column.varchar, onTable: 'ItineraryModel'),
];

const List<MigrationCommand> _migration_20251019141339_down = [
  DropColumn('start_time', onTable: 'ItineraryModel'),
  DropColumn('end_time', onTable: 'ItineraryModel'),
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20251019141339',
  up: _migration_20251019141339_up,
  down: _migration_20251019141339_down,
)
class Migration20251019141339 extends Migration {
  const Migration20251019141339()
    : super(
        version: 20251019141339,
        up: _migration_20251019141339_up,
        down: _migration_20251019141339_down,
      );
}
