class DetallePuntajeGanado {
  final String evento;
  String? descripcion;
  final int puntaje;
  final String nombreAdministrador;
  String? imagenurl;

  DetallePuntajeGanado({
    required this.evento,
    this.descripcion,
    required this.puntaje,
    required this.nombreAdministrador,
    this.imagenurl,
  });
}
