import 'package:dowload_page_apk/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart' as rive;
 */
class AnimacionSuccesWidget extends StatefulWidget {
  const AnimacionSuccesWidget({Key? key}) : super(key: key);

  @override
  _AnimacionSuccesWidgetState createState() => _AnimacionSuccesWidgetState();
}

class _AnimacionSuccesWidgetState extends State<AnimacionSuccesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
          color: AppTheme.of(context).secondaryBackground,
        ),
        child: Container()
        /* rive.RiveAnimation.asset(
          'assets/rive_animations/completado.riv',
          fit: BoxFit.contain,
        )

 */
        );
  }
}
