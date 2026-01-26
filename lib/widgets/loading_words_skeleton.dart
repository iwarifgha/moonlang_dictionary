import 'package:flutter/material.dart';

class LoadingWordsSkeleton extends StatelessWidget {
  const LoadingWordsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (_, __) {
        return const _SkeletonWordTile();
      },
    );
  }
}

class _SkeletonWordTile extends StatelessWidget {
  const _SkeletonWordTile();

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.grey.shade100,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ShimmerCircle(size: 44),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _ShimmerLine(width: 120, height: 16),
                  SizedBox(height: 10),
                  _ShimmerLine(width: double.infinity, height: 14),
                  SizedBox(height: 6),
                  _ShimmerLine(width: 180, height: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerLine extends StatefulWidget {
  final double width;
  final double height;

  const _ShimmerLine({required this.width, required this.height});

  @override
  State<_ShimmerLine> createState() => _ShimmerLineState();
}

class _ShimmerLineState extends State<_ShimmerLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1 + (2 * _controller.value), 0),
              end: Alignment(1 + (2 * _controller.value), 0),
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.2, 0.5, 0.8],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _ShimmerCircle extends StatefulWidget {
  final double size;
  const _ShimmerCircle({required this.size});

  @override
  State<_ShimmerCircle> createState() => _ShimmerCircleState();
}

class _ShimmerCircleState extends State<_ShimmerCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1 + (2 * _controller.value), 0),
              end: Alignment(1 + (2 * _controller.value), 0),
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.2, 0.5, 0.8],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
