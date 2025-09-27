// GENERATED CODE EDIT WITH CAUTION
// THIS FILE **WILL NOT** BE REGENERATED
// This file should be version controlled and can be manually edited.
part of 'schema.g.dart';

// While migrations are intelligently created, the difference between some commands, such as
// DropTable vs. RenameTable, cannot be determined. For this reason, please review migrations after
// they are created to ensure the correct inference was made.

// The migration version must **always** mirror the file name

const List<MigrationCommand> _migration_20250925130134_up = [
  DropColumn('tourism_spot_id', onTable: 'TourismImage'),
  InsertForeignKey(
    'TourismImage',
    'TourismSpot',
    foreignKeyColumn: 'tourism_spot_TourismSpot_brick_id',
    onDeleteCascade: false,
    onDeleteSetDefault: false,
  ),
];

const List<MigrationCommand> _migration_20250925130134_down = [
  DropColumn('tourism_spot_TourismSpot_brick_id', onTable: 'TourismImage'),
];

//
// DO NOT EDIT BELOW THIS LINE
//

@Migratable(
  version: '20250925130134',
  up: _migration_20250925130134_up,
  down: _migration_20250925130134_down,
)
class Migration20250925130134 extends Migration {
  const Migration20250925130134()
    : super(
        version: 20250925130134,
        up: _migration_20250925130134_up,
        down: _migration_20250925130134_down,
      );
}
