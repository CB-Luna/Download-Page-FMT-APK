import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helpers/responsive.dart';
import '../../../theme/theme.dart';

class PedidoGeneradoPopup extends StatelessWidget with Popup {
  const PedidoGeneradoPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    const double mobileTitle = 14;
    const double mobileText = 10.5;
    double boxPadding = mobile(context) ? 20.0 : 30.0;

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      content: Container(
        color: AppTheme.of(context).primaryBackground,
        alignment: Alignment.center,
        height: 300,
        constraints: getConstraints(
          context: context,
          height: 300,
          width: 660,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              AppTheme.of(context).primaryColor,
                              AppTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.35),
                              AppTheme.of(context).primaryColor.withOpacity(0),
                              AppTheme.of(context).primaryColor.withOpacity(0)
                            ])),
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¡Gracias por tu pedido!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: mobile(context) ? 20 : 28,
                            color: AppTheme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: Text(
                              "Tu solicitud ha sido recibida y estamos trabajando para procesarla lo antes posible.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                height: 1.5,
                                fontSize: 15,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        const SizedBox(height: 15),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor:
                                      AppTheme.of(context).primaryColor,
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () =>
                                  GoRouter.of(context).push('/comprar'),
                              child: Text("Volver",
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.5,
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.2))),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class Popup {
  BoxConstraints getConstraints({context, width, height}) {
    final size = MediaQuery.of(context).size;
    //550, 650
    if (size.height > height && size.width > width) {
      return BoxConstraints(minHeight: height * 0.9, minWidth: width * 0.9);
    } else {
      return const BoxConstraints();
    }
  }

  BoxDecoration buildBoxDecoration({
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
    );
  }
}
