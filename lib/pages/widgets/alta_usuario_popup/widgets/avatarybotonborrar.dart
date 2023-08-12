import 'package:flutter/material.dart';

import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../animated_hover_button.dart';

class AvatarYbotonBorrar extends StatefulWidget {
  const AvatarYbotonBorrar({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final UsuariosProvider provider;

  @override
  State<AvatarYbotonBorrar> createState() => _AvatarYbotonBorrarState();
}

class _AvatarYbotonBorrarState extends State<AvatarYbotonBorrar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            await widget.provider.selectImage();
            setState(() {});
          },
          child: Consumer<UsuariosProvider>(
            builder: (context, provider, child) {
              return Container(
                width: 200,
                height: 200,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.of(context).secondaryColor,
                ),
                child: getUserImage(provider.webImage),
              );
            },
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.of(context).secondaryColor,
          ),
          child: FittedBox(
            child: AnimatedHoverButton(
              icon: Icons.delete_rounded,
              tooltip: 'Eliminar imagen',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.of(context).primaryBackground.withAlpha(200)
                  : AppTheme.of(context).primaryBackground,
              onTap: () async {
                widget.provider.clearImage();
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
