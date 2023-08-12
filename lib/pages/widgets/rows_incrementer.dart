import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';

class RowsIncrementer extends StatefulWidget {
  const RowsIncrementer(
      {super.key,
      required this.incrementFunction,
      required this.decrementFunction,
      required this.setFunction,
      required this.count,
      required this.controller});

  final Future<void> incrementFunction;
  final Future<void> decrementFunction;
  final Future<void> Function(String) setFunction;
  final int count;
  final TextEditingController controller;

  @override
  State<RowsIncrementer> createState() => _RowsIncrementerState();
}

class _RowsIncrementerState extends State<RowsIncrementer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
      child: Container(
        width: 142,
        height: 51,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppTheme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    width: 25,
                    height: 23.5,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_drop_up_sharp,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  onTap: () async {
                    await widget.incrementFunction;
                  },
                ),
                InkWell(
                  child: Container(
                    width: 25,
                    height: 23.5,
                    decoration: BoxDecoration(
                      color: widget.count == 0
                          ? const Color(0XFF102047)
                          : AppTheme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  onTap: () async {
                    await widget.decrementFunction;
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Row(
                children: [
                  Text(
                    'Filas: ',
                    style: AppTheme.of(context).bodyText1,
                  ),
                  SizedBox(
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: widget.controller,
                        style: AppTheme.of(context).subtitle1.override(
                              fontSize: 14,
                              fontFamily: 'Gotham-Light',
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: false,
                            ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) async {
                          widget.setFunction(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
