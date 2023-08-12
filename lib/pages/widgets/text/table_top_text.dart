import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TableTopText extends StatefulWidget {
  const TableTopText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.maxLines = 2,
    this.style,
    required this.group,
  });

  final String text;
  final TextAlign? textAlign;
  final int maxLines;
  final TextStyle? style;
  final AutoSizeGroup group;

  @override
  State<TableTopText> createState() => _TableTopTextState();
}

class _TableTopTextState extends State<TableTopText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        widget.text,
        textAlign: widget.textAlign,
        style: widget.style,
        maxFontSize: 18,
        minFontSize: 12,
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
        group: widget.group,
      ),
    );
  }
}
