import 'package:dowload_page_apk/pages/cotizador/cotizador_page.dart';
import 'package:dowload_page_apk/providers/cotizador_provider.dart';
//import 'package:dowload_page_apk/providers/seguimiento_facturas_provider.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class CargaFacturaPopUp extends StatelessWidget {
  const CargaFacturaPopUp({super.key, required this.provider});

  final CotizadorProvider provider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: const Color(0xff262626),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        child: PdfView(
          pageSnapping: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          renderer: (PdfPage page) {
            if (page.width >= page.height) {
              return page.render(
                width: page.width * 7,
                height: page.height * 4,
                format: PdfPageImageFormat.jpeg,
                backgroundColor: '#15FF0D',
              );
            } else if (page.width == page.height) {
              return page.render(
                width: page.width * 4,
                height: page.height * 4,
                format: PdfPageImageFormat.jpeg,
                backgroundColor: '#15FF0D',
              );
            } else {
              return page.render(
                width: page.width * 4,
                height: page.height * 7,
                format: PdfPageImageFormat.jpeg,
                backgroundColor: '#15FF0D',
              );
            }
          },
          controller: provider.pdfController!,
          onDocumentLoaded: (document) {},
          onPageChanged: (page) {},
        ),
      ),
    );
  }
}
