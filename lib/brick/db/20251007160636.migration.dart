// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20251007160636_up = [
  DropColumn('id', onTable: 'ItineraryModel'),
  DropColumn('itineraries_id', onTable: 'UserItineraryModel'),
  InsertColumn('id', Column.varchar, onTable: 'ItineraryModel', unique: true),
  InsertColumn('itineraries_id', Column.varchar, onTable: 'UserItineraryModel')
];

const List<MigrationCommand> _migration_20251007160636_down = [
  DropColumn('id', onTable: 'ItineraryModel'),
  DropColumn('itineraries_id', onTable: 'UserItineraryModel')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20251007160636',
  up: _migration_20251007160636_up,
  down: _migration_20251007160636_down,
)
class Migration20251007160636 extends Migration {
  const Migration20251007160636()
    : super(
        version: 20251007160636,
        up: _migration_20251007160636_up,
        down: _migration_20251007160636_down,
      );
}
