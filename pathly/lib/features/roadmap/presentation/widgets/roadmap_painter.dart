import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/roadmap_node.dart';
import '../../domain/models/roadmap_enums.dart';

class RoadmapPainter extends CustomPainter {
  final List<RoadmapNode> nodes;

  RoadmapPainter(this.nodes);

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Center Offsets matched with RoadmapPage
    const double offsetX = 1000.0;
    const double offsetY = 200.0;
    // Widget Width/Height adjustments
    // Nodes are 160px wide. Center is +80.
    // Nodes are dynamic height, assuming ~80px-100px. Let's assume center is +40 for now or just attach to top/bottom.
    // Let's attach from Bottom Center of Parent to Top Center of Child.

    // We need to approximate the node dimensions if we want perfect connection points.
    // For now, let's assume a fixed simplified connection point relative to the node's (x,y).
    // Node (x,y) in our model is the center-top or top-left?
    // In Page, we used: left: 1000 + node.x - 80. So node.x is the HORIZONTAL CENTER.
    // top: 200 + node.y. So node.y is the TOP.

    final nodeMap = {for (var node in nodes) node.id: node};

    for (final node in nodes) {
      for (final parentId in node.prerequisites) {
        final parent = nodeMap[parentId];
        if (parent != null) {
          final isPathActive =
              node.status != NodeStatus.locked &&
              parent.status == NodeStatus.completed;
          paint.color = isPathActive
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.surfaceHighlight;

          // Parent Bottom Center
          final startX = offsetX + parent.x;
          final startY =
              offsetY +
              parent.y +
              80; // Assuming ~80 height for now, or just connect centers?
          // Better to connect centers for Bezier if height varies.
          // Let's guess 80px height.

          // Child Top Center
          final endX = offsetX + node.x;
          final endY = offsetY + node.y;

          final path = Path();
          path.moveTo(startX, startY);

          final controlPoint1 = Offset(startX, startY + 50);
          final controlPoint2 = Offset(endX, endY - 50);

          path.cubicTo(
            controlPoint1.dx,
            controlPoint1.dy,
            controlPoint2.dx,
            controlPoint2.dy,
            endX,
            endY,
          );

          canvas.drawPath(path, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant RoadmapPainter oldDelegate) {
    return oldDelegate.nodes != nodes;
  }
}
