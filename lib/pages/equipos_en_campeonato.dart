import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/equipo_tile.dart';

class EquiposCampeonato extends StatelessWidget {
  final int campeonato_Id;

  const EquiposCampeonato({required this.campeonato_Id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos del Campeonato'),
      ),
      body: FutureBuilder(
        future: HttpService().obtenerEquiposPorCampeonato(campeonato_Id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var equipo = snapshot.data[index];
              return EquipoTile(
                id: equipo["id"],
                nombre: equipo["nombre"],
                descripcion: equipo['descripcion'],
              );
            },
          );
        },
      ),
    );
  }
}
