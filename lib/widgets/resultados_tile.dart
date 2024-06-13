import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiUrl = 'http://10.0.2.2:8000/api';

class ResultadoTile extends StatefulWidget {
  final int equipo_id;
  final int puntos;
  final int ganador;

  const ResultadoTile({
    Key? key,
    this.equipo_id = 0,
    this.puntos = 0,
    this.ganador = 0,
  }) : super(key: key);

  @override
  State<ResultadoTile> createState() => _ResultadoTileState();
}

class _ResultadoTileState extends State<ResultadoTile> {
  late Future<String> _nombreEquipoFuture;

  @override
  void initState() {
    super.initState();
    _nombreEquipoFuture = obtenerNombreEquipoPorId(widget.equipo_id);
  }

  Future<String> obtenerNombreEquipoPorId(int equipo_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/equipos/$equipo_id'));
    if (respuesta.statusCode == 200) {
      var jsonData = json.decode(respuesta.body);
      return jsonData['nombre'] ?? 'Nombre no disponible';
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al obtener nombre del equipo: ${respuesta.statusCode}');
    }
  }

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
          title: Center(
            child: Text(
              'Equipo ${widget.equipo_id}',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          children: [
            _buildInfoRow(MdiIcons.soccer, 'Equipo ID', '${widget.equipo_id}'),
            Divider(color: Colors.black),
            _buildInfoRow(MdiIcons.star, 'Puntos', '${widget.puntos}'),
            Divider(color: Colors.black),
            FutureBuilder<String>(
              future: _nombreEquipoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error al cargar el nombre del equipo');
                }
                return _buildInfoRow(MdiIcons.trophy, 'Equipo', snapshot.data ?? 'Nombre no encontrado');
              },
            ),
            Divider(color: Colors.black),
            _buildInfoRow(MdiIcons.trophy, 'Resultado', widget.ganador == 1 ? 'Ganador' : 'Perdedor'),
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
        SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.oswald(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Text(
          value,
          style: GoogleFonts.oswald(
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ResultadoTile(
          equipo_id: 1,
          puntos: 10,
          ganador: 1,
        ),
      ),
    ),
  ));
}