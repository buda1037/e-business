import 'package:drift/drift.dart';

enum LeadStatus {
  newLead,
  qualified,
  converted,
  lost,
}

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  TextColumn get email => text().unique()();

  TextColumn get company => text()();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();
}

class TradeShows extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime()();

  TextColumn get location => text()();

  TextColumn get description => text().nullable()();
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get managerId => integer()
      .nullable()
      .references(Users, #id)();

  TextColumn get email => text().unique()();

  TextColumn get phoneNumber => text().unique()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  TextColumn get passwordHash => text()();

  TextColumn get passwordSalt => text()();
}

class Leads extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get contactId => integer().references(Contacts, #id)();

  IntColumn get productId => integer().references(Products, #id)();

  IntColumn get tradeShowId => integer().references(TradeShows, #id)();

  IntColumn get ownerId => integer().references(Users, #id)();

  TextColumn get status => textEnum<LeadStatus>()();

  RealColumn get score => real()();

  RealColumn get volume => real()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}