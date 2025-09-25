// GENERATED CODE DO NOT EDIT
// This file should be version controlled
import 'package:brick_sqlite/db.dart';
part '20250925114028.migration.dart';
part '20250925121330.migration.dart';
part '20250925130134.migration.dart';

/// All intelligently-generated migrations from all `@Migratable` classes on disk
final migrations = <Migration>{
  const Migration20250925114028(),
  const Migration20250925121330(),
  const Migration20250925130134(),
};

/// A consumable database structure including the latest generated migration.
final schema = Schema(
  20250925130134,
  generatorVersion: 1,
  tables: <SchemaTable>{
    SchemaTable(
      'TourismImage',
      columns: <SchemaColumn>{
        SchemaColumn(
          '_brick_id',
          Column.integer,
          autoincrement: true,
          nullable: false,
          isPrimaryKey: true,
        ),
        SchemaColumn('id', Column.integer, unique: true),
        SchemaColumn(
          'tourism_spot_TourismSpot_brick_id',
          Column.integer,
          isForeignKey: true,
          foreignTableName: 'TourismSpot',
          onDeleteCascade: false,
          onDeleteSetDefault: false,
        ),
        SchemaColumn('label', Column.varchar),
        SchemaColumn('image_url', Column.varchar),
        SchemaColumn('created_at', Column.datetime),
      },
      indices: <SchemaIndex>{
        SchemaIndex(columns: ['id'], unique: true),
      },
    ),
    SchemaTable(
      'TourismSpot',
      columns: <SchemaColumn>{
        SchemaColumn(
          '_brick_id',
          Column.integer,
          autoincrement: true,
          nullable: false,
          isPrimaryKey: true,
        ),
        SchemaColumn('id', Column.integer, unique: true),
        SchemaColumn('name', Column.varchar),
        SchemaColumn('description', Column.varchar),
        SchemaColumn('city', Column.varchar),
        SchemaColumn('province', Column.varchar),
        SchemaColumn('category', Column.varchar),
        SchemaColumn('address', Column.varchar),
        SchemaColumn('latitude', Column.Double),
        SchemaColumn('longitude', Column.Double),
        SchemaColumn('open_time', Column.varchar),
        SchemaColumn('close_time', Column.varchar),
        SchemaColumn('maps_link', Column.varchar),
        SchemaColumn('facilities', Column.varchar),
        SchemaColumn('created_at', Column.datetime),
      },
      indices: <SchemaIndex>{
        SchemaIndex(columns: ['id'], unique: true),
      },
    ),
  },
);
