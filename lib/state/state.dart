import 'package:flutter/material.dart';
import 'package:leaddesk/database/database.dart';

class AppState extends ChangeNotifier {
  final AppDatabase _database;

  AppDatabase get database => _database;

  AppState(this._database) {
    loadAll();
  }

  final TextEditingController searchController = TextEditingController();

  bool _companyFilterActive = true;
  bool _tradeshowFilterActive = false;
  List<String> _suggestions = [];
  List<LeadCardData> _leads = [];
  int _convertedLeadCount = 0;
  bool _leadsLoading = true;

  List<EmployeeDashboardData> _employeeData = [];
  List<TradeShowDashboardData> _tradeShowData = [];
  double _overallConversionRate = 0;
  int _totalLeadCount = 0;
  bool _dashboardLoading = true;

  bool get companyFilterActive => _companyFilterActive;
  bool get tradeshowFilterActive => _tradeshowFilterActive;
  List<String> get suggestions => _suggestions;
  List<LeadCardData> get leads => _leads;
  int get convertedLeadCount => _convertedLeadCount;
  bool get leadsLoading => _leadsLoading;

  List<EmployeeDashboardData> get employeeData => _employeeData;
  List<TradeShowDashboardData> get tradeShowData => _tradeShowData;
  double get overallConversionRate => _overallConversionRate;
  int get totalLeadCount => _totalLeadCount;
  bool get dashboardLoading => _dashboardLoading;

  Future<void> loadAll() async {
    await Future.wait([refreshLeads(), refreshDashboard()]);
  }

  Future<void> refreshLeads() async {
    _leadsLoading = true;
    notifyListeners();

    final query = searchController.text.trim();

    final result = await _database.getLeadCards(
      search:
          query.isNotEmpty && !_companyFilterActive && !_tradeshowFilterActive
          ? query
          : null,
      company: query.isNotEmpty && _companyFilterActive ? query : null,
      tradeShowName: query.isNotEmpty && _tradeshowFilterActive ? query : null,
    );

    _convertedLeadCount = await _database.getConvertedLeadCount();
    _leads = result;
    _leadsLoading = false;
    notifyListeners();
  }

  Future<void> loadSuggestions(String input) async {
    final query = input.trim();

    if (query.isEmpty) {
      _suggestions = [];
      notifyListeners();
      await refreshLeads();
      return;
    }

    _suggestions = await _database.getLeadSearchSuggestions(
      query: query,
      includeCompanies: _companyFilterActive,
      includeTradeShows: _tradeshowFilterActive,
    );
    notifyListeners();
  }

  void selectSuggestion(String suggestion) {
    searchController.text = suggestion;
    clearSuggestions();
    refreshLeads();
  }

  void clearSuggestions() {
    _suggestions = [];
    notifyListeners();
  }

  void toggleCompanyFilter() {
    _companyFilterActive = !_companyFilterActive;
    loadSuggestions(searchController.text);
    refreshLeads();
  }

  void toggleTradeshowFilter() {
    _tradeshowFilterActive = !_tradeshowFilterActive;
    loadSuggestions(searchController.text);
    refreshLeads();
  }

  Future<void> refreshDashboard() async {
    _dashboardLoading = true;
    notifyListeners();

    final results = await Future.wait([
      _database.getEmployeeDashboardData(),
      _database.getTradeShowDashboardData(),
      _database.getOverallConversionRate(),
      _database.getTotalLeadCount(),
    ]);

    _employeeData = results[0] as List<EmployeeDashboardData>;
    _tradeShowData = results[1] as List<TradeShowDashboardData>;
    _overallConversionRate = results[2] as double;
    _totalLeadCount = results[3] as int;
    _dashboardLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
