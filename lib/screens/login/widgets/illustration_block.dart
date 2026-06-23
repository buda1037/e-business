import 'package:flutter/material.dart';

class IllustrationBlock extends StatelessWidget {
  const IllustrationBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 30,
            top: 10,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-0.45)
                ..rotateX(0.15),
              alignment: Alignment.center,
              child: _IsoPanelCard(
                width: 110,
                height: 130,
                color: const Color(0xFFB2EBF2),
                accentColor: const Color(0xFF00BCD4),
                rows: 5,
              ),
            ),
          ),
          Positioned(
            left: 28,
            top: 20,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(0.3)
                ..rotateX(0.1),
              alignment: Alignment.center,
              child: _IsoBarChart(
                width: 100,
                height: 120,
                bgColor: const Color(0xFFEDE7F6),
                barColors: const [
                  Color(0xFFAB47BC),
                  Color(0xFF7E57C2),
                  Color(0xFF5C6BC0),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-0.25)
                ..rotateX(-0.08),
              alignment: Alignment.center,
              child: _IsoPanelCard(
                width: 95,
                height: 110,
                color: const Color(0xFFE8EAF6),
                accentColor: const Color(0xFF7986CB),
                rows: 4,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 80,
            child: Icon(
              Icons.flutter_dash,
              size: 28,
              color: const Color(0xFF7C83FF).withValues(alpha: 0.8),
            ),
          ),
          Positioned(
            top: 30,
            left: 50,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFFFCA28),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 22,
            left: 62,
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFFFF7043),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IsoPanelCard extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color accentColor;
  final int rows;

  const _IsoPanelCard({
    required this.width,
    required this.height,
    required this.color,
    required this.accentColor,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < rows; i++) ...[
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  height: 5,
                  width: width * 0.45 + (i.isEven ? 10 : 0),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            if (i < rows - 1) const SizedBox(height: 7),
          ],
        ],
      ),
    );
  }
}

class _IsoBarChart extends StatelessWidget {
  final double width;
  final double height;
  final Color bgColor;
  final List<Color> barColors;

  const _IsoBarChart({
    required this.width,
    required this.height,
    required this.bgColor,
    required this.barColors,
  });

  @override
  Widget build(BuildContext context) {
    final barHeights = [0.55, 0.85, 0.65, 0.45];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: barColors[1].withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 7,
            width: 40,
            decoration: BoxDecoration(
              color: barColors[1].withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(barColors.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: FractionallySizedBox(
                      heightFactor: barHeights[i],
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: barColors[i],
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
