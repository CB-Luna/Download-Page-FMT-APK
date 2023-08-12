import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile({
    Key? key,
    this.value = false,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final Future<void> Function(bool) onChanged;

  @override
  State<CustomSwitchListTile> createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  bool switchListTileValue = false;

  @override
  void initState() {
    super.initState();
    switchListTileValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      key: widget.key,
      value: switchListTileValue,
      onChanged: (value) async {
        await widget.onChanged(value);
      },
      activeColor: AppTheme.of(context).primaryColor,
      activeTrackColor: AppTheme.of(context).primaryColor,
      dense: false,
      controlAffinity: ListTileControlAffinity.platform,
      contentPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 90, 0),
    );
  }
}
//save