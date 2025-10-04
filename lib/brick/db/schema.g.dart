// GENERATED CODE DO NOT EDIT
// This file should be version controlled
import 'package:brick_sqlite/db.dart';
part '20250930051644.migration.dart';
part '20251004134641.migration.dart';

/// All intelligently-generated migrations from all `@Migratable` classes on disk
final migrations = <Migration>{
  const Migration20250930051644(),
  const Migration20251004134641(),
};

/// A consumable database structure including the latest generated migration.
final schema = Schema(
  20251004134641,
  generatorVersion: 1,
  tables: <SchemaTable>{
    SchemaTable(
      'ItinerariesModel',
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
        SchemaColumn('notes', Column.varchar),
        SchemaColumn('start_time', Column.datetime),
        SchemaColumn('end_time', Column.datetime),
        SchemaColumn('created_at', Column.datetime),
        SchemaColumn('tourism_spot_id', Column.integer),
      },
      indices: <SchemaIndex>{
        SchemaIndex(columns: ['id'], unique: true),
      },
    ),
    SchemaTable(
      'TourismImageModel',
      columns: <SchemaColumn>{
        SchemaColumn(
          '_brick_id',
          Column.integer,
          autoincrement: true,
          nullable: false,
          isPrimaryKey: true,
        ),
        SchemaColumn('id', Column.integer, unique: true),
        SchemaColumn('tourism_spot_id', Column.integer),
        SchemaColumn('label', Column.varchar),
        SchemaColumn('image_url', Column.varchar),
        SchemaColumn('created_at', Column.datetime),
      },
      indices: <SchemaIndex>{
        SchemaIndex(columns: ['id'], unique: true),
      },
    ),
    SchemaTable(
      'TourismSpotModel',
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
    SchemaTable(
      'UserItinerariesModel',
      columns: <SchemaColumn>{
        SchemaColumn(
          '_brick_id',
          Column.integer,
          autoincrement: true,
          nullable: false,
          isPrimaryKey: true,
        ),
        SchemaColumn('id', Column.integer, unique: true),
        SchemaColumn('user_id', Column.integer),
        SchemaColumn('itineraries_id', Column.integer),
        SchemaColumn('created_at', Column.datetime),
      },
      indices: <SchemaIndex>{
        SchemaIndex(columns: ['id'], unique: true),
      },
    ),
  },
);
