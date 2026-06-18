import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import 'database.dart';
import 'tables.dart';

class DatabaseSeeder {
  final AppDatabase db;

  DatabaseSeeder(this.db);

  Future<void> seedIfNeeded() async {
    final existingLeads = await db.select(db.leads).get();

    if (existingLeads.isNotEmpty) {
      return;
    }

    final jsonString = await rootBundle.loadString(
      'assets/data/seed_data.json',
    );

    final data = jsonDecode(jsonString) as Map<String, dynamic>;

    await db.transaction(() async {
      await _insertUsers(data['users'] as List<dynamic>);
      await _insertProducts(data['products'] as List<dynamic>);
      await _insertTradeShows(data['tradeShows'] as List<dynamic>);
      await _insertContacts(data['contacts'] as List<dynamic>);
      await _insertLeads(data['leads'] as List<dynamic>);
    });
  }

  Future<void> _insertUsers(List<dynamic> usersData) async {
    for (final item in usersData) {
      final user = item as Map<String, dynamic>;

      await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              id: Value(user['id'] as int),
              managerId: Value(user['managerId'] as int?),
              email: user['email'] as String,
              phoneNumber: user['phoneNumber'] as String,
              firstName: user['firstName'] as String,
              lastName: user['lastName'] as String,
              passwordHash: user['passwordHash'] as String,
              passwordSalt: user['passwordSalt'] as String,
            ),
          );
    }
  }

  Future<void> _insertProducts(List<dynamic> productsData) async {
    for (final item in productsData) {
      final product = item as Map<String, dynamic>;

      await db
          .into(db.products)
          .insert(
            ProductsCompanion.insert(
              id: Value(product['id'] as int),
              name: product['name'] as String,
            ),
          );
    }
  }

  Future<void> _insertTradeShows(List<dynamic> tradeShowsData) async {
    for (final item in tradeShowsData) {
      final tradeShow = item as Map<String, dynamic>;

      await db
          .into(db.tradeShows)
          .insert(
            TradeShowsCompanion.insert(
              id: Value(tradeShow['id'] as int),
              name: tradeShow['name'] as String,
              startDate: DateTime.parse(tradeShow['startDate'] as String),
              endDate: DateTime.parse(tradeShow['endDate'] as String),
              location: tradeShow['location'] as String,
              description: Value(tradeShow['description'] as String?),
            ),
          );
    }
  }

  Future<void> _insertContacts(List<dynamic> contactsData) async {
    for (final item in contactsData) {
      final contact = item as Map<String, dynamic>;

      await db
          .into(db.contacts)
          .insert(
            ContactsCompanion.insert(
              id: Value(contact['id'] as int),
              firstName: contact['firstName'] as String,
              lastName: contact['lastName'] as String,
              email: contact['email'] as String,
              company: contact['company'] as String,
            ),
          );
    }
  }

  Future<void> _insertLeads(List<dynamic> leadsData) async {
    for (final item in leadsData) {
      final lead = item as Map<String, dynamic>;

      await db
          .into(db.leads)
          .insert(
            LeadsCompanion.insert(
              contactId: lead['contactId'] as int,
              productId: lead['productId'] as int,
              tradeShowId: lead['tradeShowId'] as int,
              ownerId: lead['ownerId'] as int,
              status: LeadStatus.values.byName(lead['status'] as String),
              score: (lead['score'] as num).toDouble(),
              volume: (lead['volume'] as num).toDouble(),
              notes: Value(lead['notes'] as String?),
              createdAt: DateTime.parse(lead['createdAt'] as String),
              updatedAt: const Value.absent(),
            ),
          );
    }
  }
}
