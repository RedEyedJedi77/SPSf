import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:instagram_blocks_ui/instagram_blocks_ui.dart';
import 'package:sprung/sprung.dart';

typedef LikesText = String Function(int count);

class LikesCount extends StatefulWidget {
  const LikesCount({
    required this.likesCount,
    this.likesText,
    this.textBuilder,
    this.color,
    this.size,
    super.key,
  });

  final LikesText? likesText;

  final Stream<int> likesCount;

  final Color? color;

  final double? size;

  final Widget? Function(int count)? textBuilder;

  @override
  State<LikesCount> createState() => _LikesCountState();
}

class _LikesCountState extends State<LikesCount>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<int>(
      stream: widget.likesCount,
      builder: (context, snapshot) {
        final count = snapshot.data;
        final isVisible = count != null && count != 0;

        return AnimatedVisibility(
          height: 25,
          duration: 250.ms,
          isVisible: isVisible,
          curve: Sprung.criticallyDamped,
          child: widget.textBuilder?.call(count != null ? count - 1 : 0) ??
              Text(
                widget.likesText!.call(count ?? 0),
                style: context.titleMedium?.copyWith(
                  color: widget.color,
                  fontSize: widget.size,
                  overflow: TextOverflow.visible,
                ),
                textAlign: TextAlign.center,
              ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
