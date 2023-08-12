import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TableContentText extends StatefulWidget {
  const TableContentText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.style,
    this.maxLines = 2,
    required this.group,
  });

  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int maxLines;
  final AutoSizeGroup group;

  @override
  State<TableContentText> createState() => _TableContentTextState();
}

class _TableContentTextState extends State<TableContentText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        widget.text,
        textAlign: widget.textAlign,
        style: widget.style,
        maxFontSize: 16,
        minFontSize: 10,
        maxLines: widget.maxLines,
        group: widget.group,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
