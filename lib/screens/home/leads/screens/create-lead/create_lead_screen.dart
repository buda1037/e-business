import 'dart:math';

import 'package:flutter/material.dart';

import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/database/tables.dart';
import 'package:leaddesk/styles/colors.dart';
import 'package:leaddesk/screens/home/leads/screens/create-lead/widgets/create_lead_header.dart';
import 'package:leaddesk/screens/home/leads/screens/create-lead/widgets/create_lead_button.dart';
import 'package:leaddesk/screens/home/leads/screens/create-lead/widgets/labeled_field.dart';
import 'package:leaddesk/screens/home/leads/screens/create-lead/widgets/section_header.dart';

class CreateLeadScreen extends StatefulWidget {
  final AppDatabase database;

  const CreateLeadScreen({super.key, required this.database});

  @override
  State<CreateLeadScreen> createState() => _CreateLeadScreenState();
}

class _CreateLeadScreenState extends State<CreateLeadScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _tradeshowController = TextEditingController();
  final TextEditingController _dealVolumeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
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
          backgroundColor: AppColors.red,
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
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    try {
      final productName = _productController.text.trim();
      final tradeShowName = _tradeshowController.text.trim();

      final product = await widget.database.getProductByName(productName);
      final tradeShow = await widget.database.getTradeShowByName(tradeShowName);

      if (!mounted) return;

      if (product == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product "$productName" does not exist.'),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      if (tradeShow == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tradeshow "$tradeShowName" does not exist.'),
            backgroundColor: AppColors.red,
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
        score: (Random().nextDouble() * 100).roundToDouble() / 10,
        volume: volume,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lead created'),
          backgroundColor: AppColors.green,
        ),
      );

      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not create lead: $error'),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              CreateLeadHeader(onBack: _onBack),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        color: AppColors.red,
                        label: 'Mandatory Fields',
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'First Name',
                        hint: 'e.g. Ingrid',
                        controller: _firstNameController,
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Last name',
                        hint: 'e.g. Gant',
                        controller: _lastNameController,
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Company',
                        hint: 'e.g. SAP',
                        controller: _companyController,
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Product',
                        hint: 'e.g. SAP Lizenz',
                        controller: _productController,
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Tradeshow',
                        hint: 'e.g. Cloud Fest',
                        controller: _tradeshowController,
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Deal Volume',
                        hint: 'e.g. 1.200.000,00 €',
                        controller: _dealVolumeController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'E-mail',
                        hint: 'e.g. ingrid.gant@sap.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 22),
                      const SectionHeader(
                        color: AppColors.green,
                        label: 'Optional Fields',
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Phone Number',
                        hint: 'e.g. +49 151 23456789',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 14),
                      LabeledField(
                        label: 'Notes',
                        hint: 'Add additional notes...',
                        controller: _notesController,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),
                      CreateLeadButton(onPressed: _onCreateLead),
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
}
