import 'package:flutter/material.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class AnimatedHoverButton extends StatefulWidget {
  const AnimatedHoverButton({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
    required this.icon,
    required this.tooltip,
    this.size = 45,
    this.iconSize = 30,
    this.enable = true,
    this.showLoading = false,
  }) : super(key: key);

  final Color primaryColor;
  final Color secondaryColor;
  final Function() onTap;
  final IconData icon;
  final String tooltip;
  final double? size;
  final double? iconSize;
  final bool? enable;
  final bool showLoading;

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  late Color primaryColor;
  late Color secondaryColor;

  bool loading = false;

  void setColors(bool isPrimary) {
    if (isPrimary) {
      primaryColor = widget.primaryColor;
      secondaryColor = widget.secondaryColor;
    } else {
      primaryColor = widget.secondaryColor;
      secondaryColor = widget.primaryColor;
    }
  }

  void changeLoading() {
    loading = !loading;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    primaryColor = widget.primaryColor;
    secondaryColor = widget.secondaryColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        onTap: widget.enable == true
            ? () async {
                changeLoading();
                await widget.onTap();
                changeLoading();
              }
            : null,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => setColors(false)),
          onExit: (_) => setState(() => setColors(true)),
          child: widget.showLoading
              ? !loading
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.icon,
                          color: primaryColor,
                          size: widget.iconSize,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryBackground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: CircularProgressIndicator(
                        color: AppTheme.of(context).primaryColor,
                      ),
                    )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon,
                      color: primaryColor,
                      size: widget.iconSize,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
