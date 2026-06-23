import 'package:flutter/material.dart';
import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/styles/colors.dart';

import 'widgets/arrow_button.dart';
import 'widgets/indicator_dots.dart';
import 'widgets/score_block.dart';
import 'widgets/wave_top_clipper.dart';

class LeadPageLeadCard extends StatelessWidget {
  final LeadCardData leadData;
  final VoidCallback onTap;

  const LeadPageLeadCard({
    super.key,
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
        clipper: WaveTopClipper(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
          decoration: BoxDecoration(
            color: lead.status.name == 'converted'
                ? const Color(0xFF2C2C2E)
                : AppColors.accent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScoreBlock(intPart: scoreParts[0], decPart: scoreParts[1]),
                  const Spacer(),
                  IndicatorDots(
                    color: lead.status.name == 'converted'
                        ? AppColors.accent
                        : AppColors.yellow,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          contact.company,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightAccent,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                      color: Colors.white.withValues(
                                        alpha: 0.55,
                                      ),
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
                  const ArrowButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
