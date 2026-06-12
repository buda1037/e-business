import 'package:drift/drift.dart';

class Leads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text()();
}
