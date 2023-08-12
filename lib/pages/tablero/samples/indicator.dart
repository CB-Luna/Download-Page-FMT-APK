import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  final String text;

  final Color textColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color colorGrafica;
  final void Function() onTap;
  final IconData icon;
  final String tooltip;

  const Indicator({
    Key? key,
    required this.text,
    this.textColor = const Color(0xff505050),
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTap,
    required this.icon,
    required this.tooltip,
    required this.colorGrafica,
  }) : super(key: key);

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  late Color primaryColor;
  late Color secondaryColor;
  late Color colorGrafica;

  void setColors(bool isPrimary) {
    if (isPrimary) {
      primaryColor = widget.primaryColor;
      secondaryColor = widget.secondaryColor;
    } else {
      primaryColor = widget.secondaryColor;
      secondaryColor = widget.primaryColor;
    }
  }

  @override
  void initState() {
    primaryColor = widget.primaryColor;
    secondaryColor = widget.secondaryColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Tooltip(
          message: widget.tooltip,
          child: GestureDetector(
            onTap: widget.onTap,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => setColors(false)),
              onExit: (_) => setState(() => setColors(true)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width:
                    ((MediaQuery.of(context).size.width * 45 / 1920 * 40) / 45),
                height:
                    ((MediaQuery.of(context).size.width * 45 / 1920 * 40) / 65),
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
                    size:
                        ((MediaQuery.of(context).size.width * 45 / 1920 * 15) /
                            45),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          widget.text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.textColor),
        ),
      ],
    );
  }
}
