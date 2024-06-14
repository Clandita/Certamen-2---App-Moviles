import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/agregar_equipos_en_campeonato.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/equipo_tile.dart';

class EquiposCampeonato extends StatefulWidget {
  final int campeonato_Id;

  const EquiposCampeonato({required this.campeonato_Id});

  @override
  State<EquiposCampeonato> createState() => _EquiposCampeonatoState();
}

class _EquiposCampeonatoState extends State<EquiposCampeonato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos del Campeonato'),
      ),
      body: 
      Container(
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: FutureBuilder(
          future: HttpService().obtenerEquiposPorCampeonato(widget.campeonato_Id),
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color(0xff142157),
        onPressed: () async {
          final selectedEquipoId = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgregarEquiposEnCampeonato(campeonatoId: widget.campeonato_Id),
            ),
          );

          if (selectedEquipoId != null) {
            // Recargar los equipos del campeonato
            setState(() {});
          }
        },
      ),
    );
  }
}
