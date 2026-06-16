import 'package:flutter/material.dart';
import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/screens/home/leads/create_lead_page.dart';

List<LeadCardData> _leads = [];


// ---------------------------------------------------------------------------
// Design tokens – calibrated to Figma 375 px screen
// ---------------------------------------------------------------------------

const Color _kAccent = Color(0xFF2563EB);
const Color _kYellow = Color(0xFFEAB308);
const Color _kBg = Color(0xFFF2F2F7);
const Color _kLabel = Color(0xFF1C1C1E);
const Color _kSubtle = Color(0xFF8E8E93);
const Color _kWhite = Colors.white;

// ---------------------------------------------------------------------------
// LeadsPage
// ---------------------------------------------------------------------------

class LeadsPage extends StatefulWidget {
  final AppDatabase database;

  const LeadsPage({
    super.key,
    required this.database,
  });

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _FilterChipButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChipButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? _kAccent : _kWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive ? _kAccent : const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 13,
              color: isActive ? _kWhite : _kSubtle,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? _kWhite : _kLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeadsPageState extends State<LeadsPage> {
  final TextEditingController _searchController = TextEditingController();

  bool _companyFilterActive = true;
  bool _tradeshowFilterActive = false;
    
  List<String> _suggestions = [];
  List<LeadCardData> _leads = [];
  int _convertedLeadCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeads();
}

@override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }  

  Future<void> _loadLeads() async {
  setState(() {
    _isLoading = true;
  });

  final query = _searchController.text.trim();

  final result = await widget.database.getLeadCards(
    search: query.isNotEmpty &&
            !_companyFilterActive &&
            !_tradeshowFilterActive
        ? query
        : null,
    company: query.isNotEmpty && _companyFilterActive ? query : null,
    tradeShowName: query.isNotEmpty && _tradeshowFilterActive ? query : null,
  );

  final convertedCount = await widget.database.getConvertedLeadCount();

  setState(() {
    _leads = result;
    _convertedLeadCount = convertedCount;
    _isLoading = false;
  });
}

Future<void> _loadSuggestions(String input) async {
  final query = input.trim();

  if (query.isEmpty) {
    setState(() {
      _suggestions = [];
    });
    await _loadLeads();
    return;
  }

  final suggestions = await widget.database.getLeadSearchSuggestions(
    query: query,
    includeCompanies: _companyFilterActive,
    includeTradeShows: _tradeshowFilterActive,
  );

  setState(() {
    _suggestions = suggestions;
  });
}



  void _onExport() {
    // TODO: implement export
  }

  void _onAddLead() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateLeadPage(),
      ),
    );
  }

  void _onLeadTap(LeadCardData leadData) {
  debugPrint('Open lead with id: ${leadData.lead.id}');
  // TODO: navigate to lead detail screen
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              _buildHeader(),
              const SizedBox(height: 14),
              _buildStatusRow(),
              const SizedBox(height: 14),
              _buildSearchBar(),
              _buildSuggestions(),
              const SizedBox(height: 12),
              _buildFilterRow(),
              const SizedBox(height: 16),
              Expanded(child: _buildLeadList()),
            ],
          ),
        ),
      ),
    );
  }

 // ── Suggestion ──────────────────────────────────────────────────────────────

Widget _buildSuggestions() {
  if (_suggestions.isEmpty) {
    return const SizedBox.shrink();
  }

  return Container(
    margin: const EdgeInsets.only(top: 6),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: _suggestions.map((suggestion) {
        return ListTile(
          dense: true,
          title: Text(
            suggestion,
            style: const TextStyle(
              fontSize: 14,
              color: _kLabel,
            ),
          ),
          onTap: () {
            _searchController.text = suggestion;
            setState(() {
              _suggestions = [];
            });
            _loadLeads();
          },
        );
      }).toList(),
    ),
  );
}

  // ── Header ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'All leads',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _kLabel,
              letterSpacing: -0.3,
              height: 1.1,
            ),
          ),
        ),
        _CircleIconBtn(icon: Icons.arrow_upward_rounded, onTap: _onExport),
        const SizedBox(width: 8),
        _CircleIconBtn(icon: Icons.add, onTap: _onAddLead),
      ],
    );
  }

  // ── Status row ──────────────────────────────────────────────────────────

  Widget _buildStatusRow() {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: _kYellow,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          'Converted',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _kLabel,
          ),
        ),
        const Spacer(),
        const Text(
          '5 leads',
          style: TextStyle(fontSize: 13, color: _kSubtle),
        ),
      ],
    );
  }

  // ── Search bar ──────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _loadSuggestions(value);
              },
              onSubmitted: (_) {
                setState(() {
                  _suggestions = [];
                });
                _loadLeads();
              },
              style: const TextStyle(fontSize: 14, color: _kLabel),
              decoration: const InputDecoration(
                hintText: 'Type...',
                hintStyle: TextStyle(color: _kSubtle, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            )
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search, color: _kSubtle, size: 20),
          ),
        ],
      ),
    );
  }

  

  // ── Filter chips ────────────────────────────────────────────────────────

  Widget _buildFilterRow() {
  return Row(
    children: [
      _FilterChipButton(
        label: 'Company',
        isActive: _companyFilterActive,
        onTap: () {
          setState(() {
            _companyFilterActive = !_companyFilterActive;
          });

          _loadSuggestions(_searchController.text);
          _loadLeads();
        },
      ),
      const SizedBox(width: 8),
      _FilterChipButton(
        label: 'Tradeshow',
        isActive: _tradeshowFilterActive,
        onTap: () {
          setState(() {
            _tradeshowFilterActive = !_tradeshowFilterActive;
          });

          _loadSuggestions(_searchController.text);
          _loadLeads();
        },
      ),
    ],
  );
}

// ── Lead list ───────────────────────────────────────────────────────────

  Widget _buildLeadList() {
    if(_isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_leads.isEmpty) {
      return const Center(
        child: Text(
          'No leads found',
          style: TextStyle(
            fontSize: 14,
            color: _kSubtle,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: _leads.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _LeadCard(
        leadData: _leads[i],
        onTap: () => _onLeadTap(_leads[i]),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _CircleIconBtn
// ---------------------------------------------------------------------------

class _CircleIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: _kWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 17, color: _kLabel),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _LeadCard  –  with wave-top ClipPath
// ---------------------------------------------------------------------------

class _LeadCard extends StatelessWidget {
  final LeadCardData leadData;
  final VoidCallback onTap;

  const _LeadCard({
    required this.leadData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final lead = leadData.lead;
    final contact = leadData.contact;

    final scoreParts = lead.score.toStringAsFixed(1).split('.');

    return GestureDetector(
      onTap: onTap,
      child: ClipPath(
        clipper: _WaveTopClipper(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
          decoration: BoxDecoration(
            color: lead.status.name == 'converted'
            ? const Color(0xFF2C2C2E)
            : _kAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Row 1: Score block + indicator dots ──────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Score: number left, "Score" label top-right of number
                  _ScoreBlock(
                    intPart: scoreParts[0],
                    decPart: scoreParts[1],
                  ),
                  const Spacer(),
                  _IndicatorDots(color: lead.status.name == 'converted' ? _kAccent : _kYellow),
                ],
              ),

              const SizedBox(height: 14),

              // ── Row 2: Company / contact info + arrow ────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Company name
                        Text(
                          contact.company,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF93C5FD), // Figma: light-blue tint
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Avatar + name + email
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Placeholder avatar circle
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.22),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 13,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'${contact.firstName} ${contact.lastName}'} •',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      height: 1.3,
                                    ),
                                  ),
                                  Text(
                                    contact.email,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: Colors.white.withValues(alpha: 0.55),
                                      height: 1.3,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Arrow button
                  _ArrowBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ScoreBlock  –  "Score" label top-right, big number bottom-left
// ---------------------------------------------------------------------------

class _ScoreBlock extends StatelessWidget {
  final String intPart;
  final String decPart;
  const _ScoreBlock({required this.intPart, required this.decPart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Big score number
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              intPart,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.0,
                letterSpacing: -1,
              ),
            ),
            Text(
              '.$decPart',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ],
        ),
        // "Score" label – floated top-right of the number block
        Positioned(
          top: -12,
          right: -28,
          child: Text(
            'Score',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.65),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _IndicatorDots  –  two overlapping circles, smaller & tighter
// ---------------------------------------------------------------------------

class _IndicatorDots extends StatelessWidget {
  final Color color;
  const _IndicatorDots({required this.color});

  @override
  Widget build(BuildContext context) {
    const double r = 18; // circle diameter
    const double overlap = 10; // how much they overlap
    const double totalW = r * 2 - overlap;

    return SizedBox(
      width: totalW,
      height: r,
      child: Stack(
        children: [
          // Back circle (semi-transparent / white-ish)
          Positioned(
            left: 0,
            child: Container(
              width: r,
              height: r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.28),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Front circle (colored indicator)
          Positioned(
            left: totalW - r,
            child: Container(
              width: r,
              height: r,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ArrowBtn  –  circle outline with chevron
// ---------------------------------------------------------------------------

class _ArrowBtn extends StatelessWidget {
  const _ArrowBtn();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WaveTopClipper  –  subtle concave dip on the top edge of each card
// ---------------------------------------------------------------------------

class _WaveTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double waveDepth = 8.0; // depth of the concave dip
    const double radius = 20.0; // card corner radius

    final path = Path();

    // Start at top-left corner (after rounded corner)
    path.moveTo(radius, 0);

    // Top edge: gentle concave arc (wave dip in the upper-middle)
    final double midX = size.width / 2;
    path.cubicTo(
      midX * 0.35,
      0,
      midX * 0.35,
      waveDepth,
      midX,
      waveDepth,
    );
    path.cubicTo(
      midX + midX * 0.35,
      waveDepth,
      midX + midX * 0.35,
      0,
      size.width - radius,
      0,
    );

    // Top-right rounded corner
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );

    // Right edge → bottom-right corner
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: const Radius.circular(radius),
    );

    // Bottom edge → bottom-left corner
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: const Radius.circular(radius),
    );

    // Left edge → top-left corner
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: const Radius.circular(radius),
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveTopClipper old) => false;
}