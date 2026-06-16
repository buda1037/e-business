import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:leaddesk/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Contacts,
    Products,
    TradeShows,
    Users,
    Leads,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'leaddesk_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  // -------------------------
  // Basic Create Methods
  // -------------------------

  Future<int> createContact(ContactsCompanion contact) {
    return into(contacts).insert(contact);
  }

  Future<int> createProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  Future<int> createTradeShow(TradeShowsCompanion tradeShow) {
    return into(tradeShows).insert(tradeShow);
  }

  Future<int> createUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  Future<int> createLead(LeadsCompanion lead) {
    return into(leads).insert(lead);
  }

  // -------------------------
  // Basic Read Methods
  // -------------------------

  Future<List<Contact>> getAllContacts() {
    return select(contacts).get();
  }

  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }

  Future<List<TradeShow>> getAllTradeShows() {
    return select(tradeShows).get();
  }

  Future<List<User>> getAllUsers() {
    return select(users).get();
  }

  Future<List<Lead>> getAllLeads() {
    return select(leads).get();
  }

  // -------------------------
  // Basic Update Methods
  // -------------------------

  Future<bool> updateContact(Contact contact) {
    return update(contacts).replace(contact);
  }

  Future<bool> updateProduct(Product product) {
    return update(products).replace(product);
  }

  Future<bool> updateTradeShow(TradeShow tradeShow) {
    return update(tradeShows).replace(tradeShow);
  }

  Future<bool> updateUser(User user) {
    return update(users).replace(user);
  }

  Future<bool> updateLead(Lead lead) {
    return update(leads).replace(lead);
  }

  // -------------------------
  // Basic Delete Methods
  // -------------------------

  Future<int> deleteLeadById(int leadId) {
    return (delete(leads)..where((tbl) => tbl.id.equals(leadId))).go();
  }

  Future<int> deleteContactById(int contactId) {
    return (delete(contacts)..where((tbl) => tbl.id.equals(contactId))).go();
  }

  // -------------------------
  // Dashboard Numbers
  // -------------------------

  Future<int> getEmployeeCount() async {
    final allUsers = await select(users).get();
    return allUsers.length;
  }

  Future<int> getTotalLeadCount() async {
    final allLeads = await select(leads).get();
    return allLeads.length;
  }

  Future<int> getConvertedLeadCount() async {
    final convertedLeads = await (select(leads)
          ..where((tbl) => tbl.status.equalsValue(LeadStatus.converted)))
        .get();

    return convertedLeads.length;
  }

  Future<double> getOverallConversionRate() async {
    final total = await getTotalLeadCount();
    final converted = await getConvertedLeadCount();

    if (total == 0) {
      return 0;
    }

    return (converted / total) * 100;
  }

  Future<int> getLeadCountForYear(int year) async {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year + 1, 1, 1);

    final result = await (select(leads)
          ..where(
            (tbl) =>
                tbl.createdAt.isBiggerOrEqualValue(start) &
                tbl.createdAt.isSmallerThanValue(end),
          ))
        .get();

    return result.length;
  }

  Future<int> getConvertedLeadCountForYear(int year) async {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year + 1, 1, 1);

    final result = await (select(leads)
          ..where(
            (tbl) =>
                tbl.status.equalsValue(LeadStatus.converted) &
                tbl.createdAt.isBiggerOrEqualValue(start) &
                tbl.createdAt.isSmallerThanValue(end),
          ))
        .get();

    return result.length;
  }

  Future<double> getConversionRateForYear(int year) async {
    final total = await getLeadCountForYear(year);
    final converted = await getConvertedLeadCountForYear(year);

    if (total == 0) {
      return 0;
    }

    return (converted / total) * 100;
  }

  Future<int> getLeadCountForMonth(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);

    final result = await (select(leads)
          ..where(
            (tbl) =>
                tbl.createdAt.isBiggerOrEqualValue(start) &
                tbl.createdAt.isSmallerThanValue(end),
          ))
        .get();

    return result.length;
  }

  Future<int> getConvertedLeadCountForMonth(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = month == 12
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);

    final result = await (select(leads)
          ..where(
            (tbl) =>
                tbl.status.equalsValue(LeadStatus.converted) &
                tbl.createdAt.isBiggerOrEqualValue(start) &
                tbl.createdAt.isSmallerThanValue(end),
          ))
        .get();

    return result.length;
  }

  Future<double> getConversionRateForMonth(int year, int month) async {
    final total = await getLeadCountForMonth(year, month);
    final converted = await getConvertedLeadCountForMonth(year, month);

    if (total == 0) {
      return 0;
    }

    return (converted / total) * 100;
  }

  // -------------------------
  // Lead Search and Filters
  // -------------------------

  Future<List<LeadCardData>> getLeadCards({
  String? search,
  String? company,
  String? tradeShowName,
  int? tradeShowId,
}) async {
  final query = select(leads).join([
    innerJoin(contacts, contacts.id.equalsExp(leads.contactId)),
    innerJoin(products, products.id.equalsExp(leads.productId)),
    innerJoin(tradeShows, tradeShows.id.equalsExp(leads.tradeShowId)),
    innerJoin(users, users.id.equalsExp(leads.ownerId)),
  ]);

  final filters = <Expression<bool>>[];

  if (search != null && search.trim().isNotEmpty) {
  final searchValue = '%${search.trim()}%';

  final fullNameExpression = contacts.firstName + const Constant(' ') + contacts.lastName;

  filters.add(
    contacts.firstName.like(searchValue) |
        contacts.lastName.like(searchValue) |
        fullNameExpression.like(searchValue),
  );
}

  if (company != null && company.trim().isNotEmpty) {
    filters.add(
      contacts.company.like('%${company.trim()}%'),
    );
  }

  if (tradeShowName != null && tradeShowName.trim().isNotEmpty) {
    filters.add(
      tradeShows.name.like('%${tradeShowName.trim()}%'),
    );
  }

  if (filters.isNotEmpty) {
    query.where(
      filters.reduce((value, element) => value | element),
    );
  }

  if (tradeShowId != null) {
    query.where(leads.tradeShowId.equals(tradeShowId));
  }

  final rows = await query.get();

  return rows.map((row) {
    return LeadCardData(
      lead: row.readTable(leads),
      contact: row.readTable(contacts),
      product: row.readTable(products),
      tradeShow: row.readTable(tradeShows),
      owner: row.readTable(users),
    );
  }).toList();
}

  Future<LeadCardData?> getLeadDetails(int leadId) async {
    final query = select(leads).join([
      innerJoin(contacts, contacts.id.equalsExp(leads.contactId)),
      innerJoin(products, products.id.equalsExp(leads.productId)),
      innerJoin(tradeShows, tradeShows.id.equalsExp(leads.tradeShowId)),
      innerJoin(users, users.id.equalsExp(leads.ownerId)),
    ]);

    query.where(leads.id.equals(leadId));

    final row = await query.getSingleOrNull();

    if (row == null) {
      return null;
    }

    return LeadCardData(
      lead: row.readTable(leads),
      contact: row.readTable(contacts),
      product: row.readTable(products),
      tradeShow: row.readTable(tradeShows),
      owner: row.readTable(users),
    );
  }

  // -------------------------
  // Dashboard Employee Stats
  // -------------------------

  Future<List<EmployeeDashboardData>> getEmployeeDashboardData() async {
    final allUsers = await select(users).get();
    final allLeads = await select(leads).get();

    return allUsers.map((user) {
      final userLeads = allLeads
          .where((lead) => lead.ownerId == user.id)
          .toList();

      final convertedLeads = userLeads
          .where((lead) => lead.status == LeadStatus.converted)
          .length;

      final totalLeads = userLeads.length;

      final conversionRate = totalLeads == 0
          ? 0.0
          : (convertedLeads / totalLeads) * 100;

      return EmployeeDashboardData(
        user: user,
        leadCount: totalLeads,
        conversionRate: conversionRate,
      );
    }).toList();
  }

  // -------------------------
  // Dashboard TradeShow Stats
  // -------------------------

  Future<List<TradeShowDashboardData>> getTradeShowDashboardData() async {
    final allTradeShows = await select(tradeShows).get();
    final allLeads = await select(leads).get();

    return allTradeShows.map((tradeShow) {
      final tradeShowLeads = allLeads
          .where((lead) => lead.tradeShowId == tradeShow.id)
          .toList();

      final convertedLeads = tradeShowLeads
          .where((lead) => lead.status == LeadStatus.converted)
          .length;

      final totalLeads = tradeShowLeads.length;

      final conversionRate = totalLeads == 0
          ? 0.0
          : (convertedLeads / totalLeads) * 100;

      return TradeShowDashboardData(
        tradeShow: tradeShow,
        leadCount: totalLeads,
        conversionRate: conversionRate,
      );
    }).toList();
  }

  // -------------------------
  // Create Lead with Contact
  // -------------------------

  Future<int> createFullLead({
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required int productId,
    required int tradeShowId,
    required int ownerId,
    required LeadStatus status,
    required double score,
    required double volume,
    String? notes,
  }) async {
    return transaction(() async {
      final contactId = await into(contacts).insert(
        ContactsCompanion.insert(
          firstName: firstName,
          lastName: lastName,
          email: email,
          company: company,
        ),
      );

      final leadId = await into(leads).insert(
        LeadsCompanion.insert(
          contactId: contactId,
          productId: productId,
          tradeShowId: tradeShowId,
          ownerId: ownerId,
          status: status,
          score: score,
          volume: volume,
          notes: Value(notes),
          createdAt: DateTime.now(),
          updatedAt: const Value.absent(),
        ),
      );

      return leadId;
    });
  }

  // -------------------------
  // Update Lead and Contact
  // -------------------------

  Future<void> updateFullLead({
    required int leadId,
    required int contactId,
    required String firstName,
    required String lastName,
    required String email,
    required String company,
    required int productId,
    required int tradeShowId,
    required int ownerId,
    required LeadStatus status,
    required double score,
    required double volume,
    String? notes,
  }) async {
    await transaction(() async {
      await (update(contacts)..where((tbl) => tbl.id.equals(contactId))).write(
        ContactsCompanion(
          firstName: Value(firstName),
          lastName: Value(lastName),
          email: Value(email),
          company: Value(company),
        ),
      );

      await (update(leads)..where((tbl) => tbl.id.equals(leadId))).write(
        LeadsCompanion(
          productId: Value(productId),
          tradeShowId: Value(tradeShowId),
          ownerId: Value(ownerId),
          status: Value(status),
          score: Value(score),
          volume: Value(volume),
          notes: Value(notes),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<List<String>> getLeadSearchSuggestions({
  required String query,
  required bool includeCompanies,
  required bool includeTradeShows,
}) async {
  final trimmedQuery = query.trim();

  if (trimmedQuery.isEmpty) {
    return [];
  }

  final searchValue = '%$trimmedQuery%';
  final suggestions = <String>{};

  if (includeCompanies) {
    final companyRows = await (select(contacts)
          ..where((tbl) => tbl.company.like(searchValue)))
        .get();

    suggestions.addAll(companyRows.map((contact) => contact.company));
  }

  if (includeTradeShows) {
    final tradeShowRows = await (select(tradeShows)
          ..where((tbl) => tbl.name.like(searchValue)))
        .get();

    suggestions.addAll(tradeShowRows.map((tradeShow) => tradeShow.name));
  }

  if (!includeCompanies && !includeTradeShows) {
    final contactRows = await (select(contacts)
          ..where(
            (tbl) =>
                tbl.firstName.like(searchValue) |
                tbl.lastName.like(searchValue),
          ))
        .get();

    suggestions.addAll(
      contactRows.map((contact) => '${contact.firstName} ${contact.lastName}'),
    );
  }

  return suggestions.take(5).toList();
}
}

// -------------------------
// Helper Data Classes
// -------------------------

class LeadCardData {
  final Lead lead;
  final Contact contact;
  final Product product;
  final TradeShow tradeShow;
  final User owner;

  LeadCardData({
    required this.lead,
    required this.contact,
    required this.product,
    required this.tradeShow,
    required this.owner,
  });
}

class EmployeeDashboardData {
  final User user;
  final int leadCount;
  final double conversionRate;

  EmployeeDashboardData({
    required this.user,
    required this.leadCount,
    required this.conversionRate,
  });
}

class TradeShowDashboardData {
  final TradeShow tradeShow;
  final int leadCount;
  final double conversionRate;

  TradeShowDashboardData({
    required this.tradeShow,
    required this.leadCount,
    required this.conversionRate,
  });

  int get year => tradeShow.startDate.year;
}