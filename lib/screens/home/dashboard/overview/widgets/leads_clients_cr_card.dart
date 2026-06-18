import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadsClientsCrCards extends StatelessWidget {
  final String keyFigureValue;
  final String keyFigureName;
  final String keyFigureChange;

  const LeadsClientsCrCards({
    super.key,
    required this.keyFigureValue,
    required this.keyFigureName,
    required this.keyFigureChange,
  });

  static const _primaryDarkColor = Color(0xFF212E37);
  static const _positiveGreenColor = Color(0xFF00CC11);
  static const _mutedGrayColor = Color(0xFF9AA5B1);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildValueSection(),
            const SizedBox(height: 0),
            _buildNameSection(),
            const SizedBox(height: 5),
            _buildTrendSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildValueSection() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        keyFigureValue,
        style: GoogleFonts.inter(
          fontSize: 38,
          fontWeight: FontWeight.w800,
          color: _primaryDarkColor,
          height: 1.1,
        ),
      ),
    );
  }

  Widget _buildNameSection() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        keyFigureName,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: _primaryDarkColor,
        ),
      ),
    );
  }

  Widget _buildTrendSection() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: _positiveGreenColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_upward_rounded,
              size: 10,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            keyFigureChange,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _positiveGreenColor,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            "VS LAST YEAR",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _mutedGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}
