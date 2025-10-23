// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20251023043113_up = [
  InsertTable('ChatModel'),
  InsertColumn('id', Column.varchar, onTable: 'ChatModel', unique: true),
  InsertColumn('user_id', Column.varchar, onTable: 'ChatModel'),
  InsertColumn('content', Column.varchar, onTable: 'ChatModel'),
  InsertColumn('is_from_user', Column.boolean, onTable: 'ChatModel'),
  InsertColumn('created_at', Column.datetime, onTable: 'ChatModel'),
  CreateIndex(columns: ['id'], onTable: 'ChatModel', unique: true)
];

const List<MigrationCommand> _migration_20251023043113_down = [
  DropTable('ChatModel'),
  DropColumn('id', onTable: 'ChatModel'),
  DropColumn('user_id', onTable: 'ChatModel'),
  DropColumn('content', onTable: 'ChatModel'),
  DropColumn('is_from_user', onTable: 'ChatModel'),
  DropColumn('created_at', onTable: 'ChatModel'),
  DropIndex('index_ChatModel_on_id')
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20251023043113',
  up: _migration_20251023043113_up,
  down: _migration_20251023043113_down,
)
class Migration20251023043113 extends Migration {
  const Migration20251023043113()
    : super(
        version: 20251023043113,
        up: _migration_20251023043113_up,
        down: _migration_20251023043113_down,
      );
}
