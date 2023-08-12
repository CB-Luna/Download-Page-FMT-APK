import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/widgets/custom_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ImageSelectionPanel extends StatefulWidget {
  const ImageSelectionPanel({Key? key}) : super(key: key);

  @override
  State<ImageSelectionPanel> createState() => _ImageSelectionPanelState();
}

class _ImageSelectionPanelState extends State<ImageSelectionPanel> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    fToast.init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectImageWidget(
                      title: 'Logo',
                      assetName: 'logoColor',
                      imageUrl: assets.logoColor,
                    ),
                    SelectImageWidget(
                      title: 'Logo Blanco',
                      assetName: 'logoBlanco',
                      imageUrl: assets.logoBlanco,
                      bgColor: Colors.black,
                    ),
                    SelectImageWidget(
                      title: 'Fondo',
                      assetName: 'bg1',
                      imageUrl: assets.bg1,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: CustomButton(
              onPressed: () async {
                final res = await visualState.actualizarImagenes();
                if (!res) {
                  Fluttertoast.showToast(
                    msg: 'Error al actualizar las imágenes',
                    toastLength: Toast.LENGTH_SHORT,
                    webBgColor: "#e74c3c",
                    textColor: Colors.black,
                    timeInSecForIosWeb: 5,
                    webPosition: 'center',
                  );
                } else {
                  fToast.showToast(
                    child: const SuccessToast(
                      message: 'Cambio exitoso! Por favor actualiza la página',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );
                }
                if (!mounted) return;
              },
              text: 'Actualizar imágenes',
              options: ButtonOptions(
                width: 250,
                height: 50,
                color: AppTheme.of(context).primaryColor,
                textStyle: AppTheme.of(context).subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectImageWidget extends StatefulWidget {
  const SelectImageWidget({
    Key? key,
    required this.title,
    required this.assetName,
    required this.imageUrl,
    this.bgColor = Colors.white,
  }) : super(key: key);

  final String title;
  final String assetName;
  final String imageUrl;

  final Color bgColor;

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  bool isHover = false;

  Future<void> openDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: PhotoView(
              tightMode: true,
              imageProvider: NetworkImage(widget.imageUrl),
              backgroundDecoration: BoxDecoration(color: widget.bgColor),
              filterQuality: FilterQuality.high,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);

    const double containerWidth = 400;
    const double containerHeight = 100;

    final imageData = visualState.getImageData(widget.assetName);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.title,
              style: AppTheme.of(context).title2,
            ),
          ),
          Container(
            width: containerWidth,
            height: containerHeight,
            color: widget.bgColor,
            child: MouseRegion(
              onHover: (_) => setState(() => isHover = true),
              onExit: (_) => setState(() => isHover = false),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await openDialog(context);
                    },
                    child: imageData != null
                        ? Image.memory(
                            imageData,
                            height: containerHeight,
                            width: containerWidth,
                          )
                        : Image(
                            width: containerWidth,
                            height: containerHeight,
                            image: NetworkImage(widget.imageUrl),
                          ),
                  ),
                  Visibility(
                    visible: isHover,
                    child: Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            visualState.selectImage(widget.assetName);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          splashRadius: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
