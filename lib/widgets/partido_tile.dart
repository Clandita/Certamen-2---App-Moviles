import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/resultados.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PartidoTile extends StatefulWidget {
  final int id;
  final String hora;
  final int jugado;
  final String lugar;
  final int campeonato_id;

  const PartidoTile({
    this.id = 0,
    this.jugado = 0,
    this.lugar = 'sin lugar',
    this.campeonato_id = 0,
    required this.hora,
  });

  @override
  _PartidoTileState createState() => _PartidoTileState();
}

class _PartidoTileState extends State<PartidoTile> {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(158, 158, 158, 0.8),
          border: Border.all(color: Colors.black),
        ),
        child: ExpansionTile(
          backgroundColor: const Color.fromRGBO(158, 158, 158, 0.8),
          title: Center(child: Text("Partido ${widget.id}", style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
          children: [
            _buildInfoRow(MdiIcons.clock, 'Hora', widget.hora),
            Divider(color: Colors.black),
            _buildInfoRow(MdiIcons.mapMarker, 'Lugar', widget.lugar),
            Divider(color: Colors.black),
            _buildInfoRow(MdiIcons.check, 'Estado', widget.jugado == 1 ? 'Partido Finalizado' : 'Partido Por Jugar'),
            Divider(color: Colors.black),
            FutureBuilder<String>(
              future: HttpService().obtenerNombreCampeonatoPorId(widget.campeonato_id),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final nombreCampeonato = snapshot.data ?? 'Sin nombre de campeonato';
                return _buildInfoRow(MdiIcons.trophy, 'Campeonato', nombreCampeonato);
              },
            ),
            Divider(color: Colors.black),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: HttpService().obtenerResultadosDePartidos(widget.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return FutureBuilder<List<String>>(
                  future: _obtenerNombresEquipos(snapshot.data ?? []),
                  builder: (context, nombresSnapshot) {
                    if (!nombresSnapshot.hasData || nombresSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final nombres = nombresSnapshot.data ?? [];
                    final nombresFormateados = nombres.isNotEmpty ? nombres.join(", ") : 'Sin nombres de equipos';
                    return _buildInfoRow(MdiIcons.accountGroup, 'Nombres de Equipos', nombresFormateados);
                  },
                );
              },
            ),
            if (widget.jugado == 1)
              Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultadosPartido(partido_id: widget.id)),
                    );
                  },
                  child: Text('Ver Resultados', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(title, style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(value, style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
        ),
      ],
    );
  }

  Future<List<String>> _obtenerNombresEquipos(List<Map<String, dynamic>> resultados) async {
    final List<String> nombres = [];
    for (var resultado in resultados) {
      final nombre = await HttpService().obtenerNombreEquipoPorId(resultado["equipo_id"]);
      nombres.add(nombre);
    }
    return nombres;
  }
}
