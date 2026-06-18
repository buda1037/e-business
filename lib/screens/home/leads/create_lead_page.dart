import 'package:flutter/material.dart';

import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/database/tables.dart';
// ---------------------------------------------------------------------------
// Design tokens – kept in sync with leads_page.dart
// ---------------------------------------------------------------------------

const Color _kAccent = Color(0xFF2563EB);
const Color _kBg = Color(0xFFF2F2F7);
const Color _kLabel = Color(0xFF1C1C1E);
const Color _kSubtle = Color(0xFF8E8E93);
const Color _kWhite = Colors.white;
const Color _kBorder = Color(0xFFE5E5EA);
const Color _kRed = Color(0xFFEF4444);
const Color _kGreen = Color(0xFF22C55E);

// ---------------------------------------------------------------------------
// CreateLeadPage
// ---------------------------------------------------------------------------

class CreateLeadPage extends StatefulWidget {
  final AppDatabase database;

  const CreateLeadPage({super.key, required this.database});

  @override
  State<CreateLeadPage> createState() => _CreateLeadPageState();
}

class _CreateLeadPageState extends State<CreateLeadPage> {
  // Mandatory fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _tradeshowController = TextEditingController();
  final TextEditingController _dealVolumeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  // Optional fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _productController.dispose();
    _tradeshowController.dispose();
    _dealVolumeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onBack() {
    Navigator.of(context).maybePop();
  }

  Future<void> _onCreateLead() async {
    final mandatoryFields = <String, TextEditingController>{
      'First name': _firstNameController,
      'Last name': _lastNameController,
      'Company': _companyController,
      'Product': _productController,
      'Tradeshow': _tradeshowController,
      'Deal volume': _dealVolumeController,
      'E-mail': _emailController,
    };

    final missing = mandatoryFields.entries
        .where((entry) => entry.value.text.trim().isEmpty)
        .map((entry) => entry.key)
        .toList();

    if (missing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in: ${missing.join(', ')}'),
          backgroundColor: _kRed,
        ),
      );
      return;
    }

    final rawVolume = _dealVolumeController.text
        .trim()
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .replaceAll('€', '')
        .trim();

    final volume = double.tryParse(rawVolume);

    if (volume == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid deal volume'),
          backgroundColor: _kRed,
        ),
      );
      return;
    }

    try {
      final productName = _productController.text.trim();
      final tradeShowName = _tradeshowController.text.trim();

      final product = await widget.database.getProductByName(productName);
      final tradeShow = await widget.database.getTradeShowByName(tradeShowName);

      if (product == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product "$productName" does not exist.'),
            backgroundColor: _kRed,
          ),
        );
        return;
      }

      if (tradeShow == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tradeshow "$tradeShowName" does not exist.'),
            backgroundColor: _kRed,
          ),
        );
        return;
      }

      await widget.database.createFullLead(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        company: _companyController.text.trim(),
        productId: product.id,
        tradeShowId: tradeShow.id,
        ownerId: 1,
        status: LeadStatus.newLead,
        score: 0.0,
        volume: volume,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lead created'), backgroundColor: _kGreen),
      );

      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not create lead: $error'),
          backgroundColor: _kRed,
        ),
      );
    }
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
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionHeader(
                        color: _kRed,
                        label: 'Mandatory Fields',
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'First Name',
                        hint: 'e.g. Ingrid',
                        controller: _firstNameController,
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Last name',
                        hint: 'e.g. Gant',
                        controller: _lastNameController,
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Company',
                        hint: 'e.g. SAP',
                        controller: _companyController,
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Product',
                        hint: 'e.g. SAP Lizenz',
                        controller: _productController,
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Tradeshow',
                        hint: 'e.g. Cloud Fest',
                        controller: _tradeshowController,
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Deal Volume',
                        hint: 'e.g. 1.200.000,00 €',
                        controller: _dealVolumeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'E-mail',
                        hint: 'e.g. ingrid.gant@sap.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 22),
                      const _SectionHeader(
                        color: _kGreen,
                        label: 'Optional Fields',
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Phone Number',
                        hint: 'e.g. +49 151 23456789',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 14),
                      _LabeledField(
                        label: 'Notes',
                        hint: 'Add additional notes...',
                        controller: _notesController,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),
                      _buildCreateButton(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        _CircleIconBtn(icon: Icons.arrow_back, onTap: _onBack),
        const Expanded(
          child: Center(
            child: Text(
              'Create new Lead',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _kLabel,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 36),
      ],
    );
  }

  // ── Create button ───────────────────────────────────────────────────────

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _onCreateLead,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kAccent,
          foregroundColor: _kWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Create Lead',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _CircleIconBtn  –  matches the circular icon button on LeadsPage
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
// _SectionHeader  –  colored dot + bold label (Mandatory / Optional Fields)
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final Color color;
  final String label;
  const _SectionHeader({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _kLabel,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _LabeledField  –  label above a white, rounded, bordered text field
// ---------------------------------------------------------------------------

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;

  const _LabeledField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _kLabel,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: _kBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: maxLines > 1 ? 12 : 0,
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: maxLines > 1 ? maxLines : null,
            style: const TextStyle(fontSize: 14, color: _kLabel),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: _kSubtle, fontSize: 14),
              border: InputBorder.none,
              isDense: true,
              contentPadding: maxLines > 1
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
        ),
      ],
    );
  }
}
