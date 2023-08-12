import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/pages/validacion_puntaje_page/widgets/popup_validar_puntaje.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class HoverWidget extends StatefulWidget {
  const HoverWidget({
    Key? key,
    required this.puntajeSolicitado,
  }) : super(key: key);

  final PuntajeSolicitado puntajeSolicitado;

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool hover = false;
  //TODO: calcular espacio vertical entre mouse y limite de pantalla
  @override
  Widget build(BuildContext context) {
    final ValidacionPuntajeProvider provider =
        Provider.of<ValidacionPuntajeProvider>(context);
    return MouseRegion(
      child: PortalTarget(
        visible: hover,
        anchor: const Aligned(
          follower: Alignment.topRight,
          target: Alignment.centerLeft,
        ),
        portalFollower: HoverPopup(
          image: widget.puntajeSolicitado.imagen,
        ),
        child: AnimatedHoverButton(
          primaryColor: AppTheme.of(context).primaryColor,
          secondaryColor: AppTheme.of(context).primaryBackground,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return PopUpValidarPuntajeWidget(
                  puntajeSolicitado: widget.puntajeSolicitado,
                );
              },
            );
            await provider.getValidacionPuntaje();
          },
          icon: Icons.visibility,
          tooltip: 'Ver Detalle',
        ),
      ),
      onHover: (_) {
        hover = true;
        setState(() {});
      },
      onExit: (_) {
        hover = false;
        setState(() {});
      },
    );
  }
}

class HoverPopup extends StatefulWidget {
  const HoverPopup({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  State<HoverPopup> createState() => _HoverPopupState();
}

class _HoverPopupState extends State<HoverPopup> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ValidacionPuntajeProvider provider =
          Provider.of<ValidacionPuntajeProvider>(
        context,
        listen: false,
      );
      await provider.getPreviewImage(widget.image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.of(context).primaryColor,
              width: 2,
            ),
          ),
          child: FadeInImage(
            width: 400,
            height: 600,
            fit: BoxFit.contain,
            placeholder: const AssetImage(
              'assets/images/fadeInAnimation.gif',
            ),
            placeholderFit: BoxFit.fill,
            placeholderFilterQuality: FilterQuality.high,
            image: NetworkImage(widget.image),
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
