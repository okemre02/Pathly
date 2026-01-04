import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Pathly Logo - Stencil/Broken 'P' design
/// A minimalist, geometric P with a floating curved part
/// Follows "Less is More" philosophy with app's purple theme
class PathlyLogo extends StatelessWidget {
  final double size;
  final Color? primaryColor;
  final Color? secondaryColor;
  final bool enableGlow;
  final bool useGradient;

  const PathlyLogo({
    super.key,
    this.size = 80,
    this.primaryColor,
    this.secondaryColor,
    this.enableGlow = true,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PathlyLogoPainter(
          primaryColor: primaryColor ?? AppColors.primary,
          secondaryColor: secondaryColor ?? AppColors.secondary,
          enableGlow: enableGlow,
          useGradient: useGradient,
        ),
        size: Size(size, size),
      ),
    );
  }
}

class _PathlyLogoPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final bool enableGlow;
  final bool useGradient;

  _PathlyLogoPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.enableGlow,
    required this.useGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width;
    final double strokeWidth = s * 0.11;
    final double gap = s * 0.05;

    // Layout proportions
    final double leftX = s * 0.28;
    final double topY = s * 0.12;
    final double bottomY = s * 0.88;
    final double curveMidY = s * 0.44;
    final double curveRightX = s * 0.80;
    final double verticalStartY = curveMidY + gap;

    // Create gradient shader for the stroke
    final Rect gradientRect = Rect.fromLTWH(0, 0, s, s);
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: useGradient
          ? [primaryColor, secondaryColor]
          : [primaryColor, primaryColor],
    );

    // === GLOW LAYER ===
    if (enableGlow) {
      final glowPaint = Paint()
        ..shader = gradient.createShader(gradientRect)
        ..strokeWidth = strokeWidth * 2.2
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.06);

      _drawLogoPaths(
        canvas,
        s,
        strokeWidth,
        gap,
        glowPaint,
        leftX,
        topY,
        bottomY,
        curveMidY,
        curveRightX,
        verticalStartY,
      );
    }

    // === MAIN LAYER ===
    final mainPaint = Paint()
      ..shader = gradient.createShader(gradientRect)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    _drawLogoPaths(
      canvas,
      s,
      strokeWidth,
      gap,
      mainPaint,
      leftX,
      topY,
      bottomY,
      curveMidY,
      curveRightX,
      verticalStartY,
    );

    // === INNER HIGHLIGHT ===
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = strokeWidth * 0.25
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    _drawLogoPaths(
      canvas,
      s,
      strokeWidth,
      gap,
      highlightPaint,
      leftX,
      topY,
      bottomY,
      curveMidY,
      curveRightX,
      verticalStartY,
    );
  }

  void _drawLogoPaths(
    Canvas canvas,
    double s,
    double strokeWidth,
    double gap,
    Paint paint,
    double leftX,
    double topY,
    double bottomY,
    double curveMidY,
    double curveRightX,
    double verticalStartY,
  ) {
    // === VERTICAL LINE (Broken at top) ===
    canvas.drawLine(
      Offset(leftX, verticalStartY),
      Offset(leftX, bottomY),
      paint,
    );

    // === FLOATING CURVE (Reverse C shape) ===
    final curveRect = Rect.fromLTRB(
      leftX + gap,
      topY,
      curveRightX,
      curveMidY * 2 - topY,
    );

    canvas.drawArc(curveRect, -math.pi / 2, math.pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant _PathlyLogoPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.enableGlow != enableGlow ||
        oldDelegate.useGradient != useGradient;
  }
}

/// Animated version with pulsing glow effect
class PathlyLogoAnimated extends StatefulWidget {
  final double size;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Duration pulseDuration;

  const PathlyLogoAnimated({
    super.key,
    this.size = 80,
    this.primaryColor,
    this.secondaryColor,
    this.pulseDuration = const Duration(milliseconds: 2500),
  });

  @override
  State<PathlyLogoAnimated> createState() => _PathlyLogoAnimatedState();
}

class _PathlyLogoAnimatedState extends State<PathlyLogoAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.pulseDuration,
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (_glowAnimation.value * 0.05),
          child: Opacity(
            opacity: 0.85 + (_glowAnimation.value * 0.15),
            child: PathlyLogo(
              size: widget.size,
              primaryColor: widget.primaryColor,
              secondaryColor: widget.secondaryColor,
              enableGlow: true,
              useGradient: true,
            ),
          ),
        );
      },
    );
  }
}

/// Static logo for app icon export (no glow, solid color)
class PathlyLogoStatic extends StatelessWidget {
  final double size;
  final Color color;

  const PathlyLogoStatic({
    super.key,
    this.size = 512,
    this.color = const Color(0xFF8B5CF6), // Violet
  });

  @override
  Widget build(BuildContext context) {
    return PathlyLogo(
      size: size,
      primaryColor: color,
      secondaryColor: color,
      enableGlow: false,
      useGradient: false,
    );
  }
}
