import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/resultados.dart';
import 'package:flutter_application_1/service/http_service.dart';

class PartidoTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Partido $id"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$hora'),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (jugado == 1)
                Text('Partido Finalizado'),
                if (jugado == 0)
                Text('Partido Por Jugar'),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$lugar'),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<String>(
                  future: HttpService().obtenerNombreCampeonatoPorId(campeonato_id), // Obtener el nombre del campeonato por su ID
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    final nombreCampeonato = snapshot.data ?? 'Sin nombre de campeonato';
                    return Text('Campeonato: $nombreCampeonato');
                  },
                ),
              ],
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: HttpService().obtenerResultadosDePartidos(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<List<String>>(
                      future: _obtenerNombresEquipos(snapshot.data ?? []),
                      builder: (context, nombresSnapshot) {
                        if (!nombresSnapshot.hasData || nombresSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        final nombres = nombresSnapshot.data ?? [];
                        final nombresFormateados = nombres.isNotEmpty ? nombres.join(", ") : 'Sin nombres de equipos';
                        return Text('Nombres de Equipos: $nombresFormateados');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          
          if (jugado == 1) // Agrega el botón solo si jugado es igual a 1
            Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResultadosPage()), // Navega a la página de resultados
                      );
                    },
                    child: Text('Ver Resultados'),
                  ),
                ],
              ),
            ),
        ],
      ),
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
