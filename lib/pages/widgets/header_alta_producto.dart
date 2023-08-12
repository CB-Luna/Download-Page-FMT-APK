import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';

import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

import '../../providers/productos_provider.dart';

class AltaProductoHeader extends StatefulWidget {
  const AltaProductoHeader({
    Key? key,
    required this.formKey,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<AltaProductoHeader> createState() => _AltaProductoHeaderState();
}

class _AltaProductoHeaderState extends State<AltaProductoHeader> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final ProductosProvider provider = Provider.of<ProductosProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.of(context).secondaryColor,
            ),
            child: FittedBox(
              child: AnimatedHoverButton(
                size: 45,
                tooltip: 'Limpiar',
                primaryColor: AppTheme.of(context).primaryColor,
                secondaryColor: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.of(context).primaryBackground.withAlpha(200)
                    : AppTheme.of(context).primaryBackground,
                icon: Icons.cleaning_services,
                onTap: () {
                  provider.clearControllers();
                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(width: 25),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.of(context).secondaryColor,
            ),
            child: FittedBox(
              child: AnimatedHoverButton(
                size: 45,
                tooltip: 'Guardar',
                primaryColor: AppTheme.of(context).primaryColor,
                secondaryColor: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.of(context).primaryBackground.withAlpha(200)
                    : AppTheme.of(context).primaryBackground,
                icon: Icons.save,
                onTap: () async {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
