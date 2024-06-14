import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class AgregarEquiposEnCampeonato extends StatefulWidget {
  final int campeonatoId;

  const AgregarEquiposEnCampeonato({required this.campeonatoId});

  @override
  _AgregarEquiposEnCampeonatoState createState() =>
      _AgregarEquiposEnCampeonatoState();
}

class _AgregarEquiposEnCampeonatoState
    extends State<AgregarEquiposEnCampeonato> {
  List<dynamic> equipos = [];
  String? selectedEquipoId;

  String errEquipoId = "";
  String errGeneral = "";

  @override
  void initState() {
    super.initState();
    cargarEquipos();
  }

  Future<void> cargarEquipos() async {
    try {
      var equiposList = await HttpService().equipos();
      setState(() {
        equipos = equiposList;
      });
    } catch (e) {
      print('Error al cargar equipos: $e');
      setState(() {
        errGeneral = 'Error al cargar equipos: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Nuevo Equipo al Campeonato"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text("Equipo:"),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Equipo"),
              items: equipos.map((equipo) {
                return DropdownMenuItem<String>(
                  value: equipo['id'].toString(),
                  child: Text(equipo['nombre']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedEquipoId = value;
                });
              },
              value: selectedEquipoId,
            ),
            Text(
              errEquipoId,
              style: TextStyle(color: Colors.red),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff134577),
                ),
                child: Text("Agregar Equipo"),
                onPressed: () async {
                  try {
                    String? equipoId = selectedEquipoId;

                    if (equipoId == null) {
                      setState(() {
                        errEquipoId = 'Debe seleccionar un equipo';
                      });
                      return ;
                    }

                    var respuesta = await HttpService().agregarEquipoACampeonato(
                      int.parse(equipoId),
                      widget.campeonatoId,
                    );

                    if (respuesta['message'] == 'Error') {
                      var errores = respuesta['errors'];
                      setState(() {
                        errEquipoId = errores['equipo_id'] != null ? errores['equipo_id'][0] : "";
                        errGeneral = errores['general'] != null ? errores['general'][0] : "";
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    setState(() {
                      errGeneral = 'Error en el formato de entrada: ${e.toString()}';
                    });
                  }
                },
              ),
            ),
            Text(
              errGeneral,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
