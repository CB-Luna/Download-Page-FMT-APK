// D I M E N S I O N S

// D e s k t o p
import 'package:flutter/material.dart';

const double minWidth = 950.0;
const double maxWidth = 1400.0;
const double maxRangeValue = maxWidth - minWidth;

const int maxTextLength = 225;
const double cartWidth = 350;
const double horBorderPadding = 20;

// F u n c i o n e s   p a r a   t a m a ñ o s   s e g ú n   e l   c o n t e x t o

////Identifica el tamaño actual de la pantalla
screenSize(context) {
  var screenSize = MediaQuery.of(context).size;
  return screenSize;
}

////Identifica si el tamaño de la pantalla es el considerado para un dispositivo móvil o no
mobile(context) {
  bool mobile = screenSize(context).width < minWidth ? true : false;

  return mobile;
}

equiv(context) {
  Size screen = screenSize(context);

  double equiv = mobile(context)
      ? 0.5
      : screen.width > maxWidth
          ? 1
          : ((screen.width - minWidth) / maxRangeValue);

  return equiv;
}
