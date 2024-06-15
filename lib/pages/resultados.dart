import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/resultados_tile.dart';

class ResultadosPartido extends StatefulWidget {
  final int partido_id;
  const ResultadosPartido({super.key, this.partido_id = 0});

  @override
  State<ResultadosPartido> createState() => _ResultadosPartidoState();
}

class _ResultadosPartidoState extends State<ResultadosPartido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/iconito.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FutureBuilder(
            future: HttpService().resultados(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Center(child: Text('No hay partidos disponibles'));
              } else {
                var filteredPartidos = snapshot.data.where((resultado) => resultado['partido_id'] == widget.partido_id).toList();
        
                if (filteredPartidos.isEmpty) {
                  return Center(child: Text('No hay partidos para este campeonato'));
                }
        
                return ListView.builder(
                  itemCount: filteredPartidos.length,
                  itemBuilder: (context, index) {
                    var resultado = filteredPartidos[index];
                    return ResultadoTile(
                      equipo_id: resultado["equipo_id"],
                      puntos: resultado["puntos"],
                      ganador: resultado["ganador"],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
