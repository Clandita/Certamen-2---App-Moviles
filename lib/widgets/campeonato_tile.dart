import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/equipo_tile.dart';

class CampeonatoTile extends StatefulWidget {
  final String nombre;
  final String reglas;
  final String premios;
  final int id;

  const CampeonatoTile({this.nombre='sin nombre',this.reglas='sin reglas', this.premios='sin premios', required this.id});

  @override
  State<CampeonatoTile> createState() => _CampeonatoTileState();
}

class _CampeonatoTileState extends State<CampeonatoTile> {
  List<dynamic> equipos = []; // Lista para almacenar los equipos
  bool isLoading = false; // Variable para controlar el estado de carga

  // Método para obtener los equipos
  Future<void> _obtenerEquipos() async {
    setState(() {
      isLoading = true; // Mostrar indicador de carga
    });
    try {
      final equiposObtenidos = await HttpService().obtenerEquiposPorCampeonato(widget.id);
      setState(() {
        equipos = equiposObtenidos;
      });
    } catch (e) {
      // Manejar errores aquí
    } finally {
      setState(() {
        isLoading = false; // Ocultar indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
        color: Color(0xDDFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(' ${widget.nombre}', style: TextStyle(fontSize: 20)),
                ),
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('Reglas: ')
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(' ${widget.reglas}', textAlign: TextAlign.justify)
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('Premios: ')
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(' ${widget.premios}', textAlign: TextAlign.justify)
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: _obtenerEquipos, // Llamar al método para obtener equipos
              child: Text('Ver participantes'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            ),
          ),
          if (isLoading)
            CircularProgressIndicator(), // Indicador de carga
          for (var equipo in equipos)
            EquipoTile(id:equipo["id"],
                  nombre:equipo["nombre"],
                  descripcion: equipo['descripcion'],), // Mostrar cada equipo usando el widget EquipoTile
        ],
      ),
    );
  }
}
