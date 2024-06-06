import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/jugador_tile.dart';
class EquipoPerfil extends StatelessWidget {
  final int equipo_id;
  const EquipoPerfil({required this.equipo_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jugadores del equipo'),
      ),
      body: FutureBuilder(
        future: HttpService().jugadoresPorEquipo(equipo_id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var jugador = snapshot.data[index];
              return JugadorTile(
                nombre:jugador["nombre"],
                rut:jugador["rut"],
                apellido:jugador["apellido"],
                nickname:jugador["nickname"],

              );
            },
          );
        },
      ),
    );
  }
}