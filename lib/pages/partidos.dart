import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/partido_tile.dart';

class PartidosCampeonato extends StatefulWidget {
  final int campeonato_Id;
  const PartidosCampeonato({required this.campeonato_Id});

  @override
  State<PartidosCampeonato> createState() => _PartidosCampeonatoState();
}

class _PartidosCampeonatoState extends State<PartidosCampeonato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partidos del campeonato'),
      ),
      body: Center(
        child: FutureBuilder(
          future: HttpService().partidos(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return Center(child: Text('No hay partidos disponibles'));
            } else {
              var filteredPartidos = snapshot.data.where((partido) => partido['campeonato_id'] == widget.campeonato_Id).toList();
              
              if (filteredPartidos.isEmpty) {
                return Center(child: Text('No hay partidos para este campeonato'));
              }

              return ListView.builder(
                itemCount: filteredPartidos.length,
                itemBuilder: (context, index) {
                  var partido = filteredPartidos[index];
                  return PartidoTile(
                    id: partido['id'],
                    jugado: partido['jugado'],
                    lugar: partido['lugar'],
                    campeonato_id: partido['campeonato_id'],
                    hora: partido['hora'],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
