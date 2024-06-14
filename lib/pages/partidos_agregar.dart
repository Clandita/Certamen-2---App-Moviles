import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class PartidosAgregar extends StatefulWidget {
  const PartidosAgregar({super.key});

  @override
  State<PartidosAgregar> createState() => _PartidosAgregarState();
}

class _PartidosAgregarState extends State<PartidosAgregar> {
  TextEditingController horaController = TextEditingController();
  TextEditingController jugadoController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController idcampeonatoController = TextEditingController();
  String errHora = "";
  String errJugado = "";
  String errLugar = "";
  String errIdCampeonato = "";
  String errGeneral = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Nuevo Partido"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text("Hora:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Hora (YYYY-MM-DD HH:MM:SS)"),
              controller: horaController,
            ),
            Text(
              errHora,
              style: TextStyle(color: Colors.red),
            ),
            Text("Jugado:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Jugado (true/false)"),
              controller: jugadoController,
            ),
            Text(
              errJugado,
              style: TextStyle(color: Colors.red),
            ),
            Text("Lugar:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Lugar"),
              controller: lugarController,
            ),
            Text(
              errLugar,
              style: TextStyle(color: Colors.red),
            ),
            Text("ID Campeonato:"),
            TextFormField(
              decoration: InputDecoration(labelText: "ID Campeonato"),
              controller: idcampeonatoController,
            ),
            Text(
              errIdCampeonato,
              style: TextStyle(color: Colors.red),
            ),
            Text(
              errGeneral,
              style: TextStyle(color: Colors.red),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xff134577),
                ),
                child: Text("Agregar Partido"),
                onPressed: () async {
                  if (_validateFields()) {
                    try {
                      DateTime hora = DateTime.parse(horaController.text);
                      bool jugado = jugadoController.text.toLowerCase() == 'true';
                      int campeonatoId = int.parse(idcampeonatoController.text);
                      var respuesta = await HttpService().partidosAgregar(
                        hora.toIso8601String(),
                        jugado,
                        lugarController.text,
                        campeonatoId,
                      );
                      if (respuesta['message'] == 'Error') {
                        var errores = respuesta['errors'];
                        setState(() {
                          errHora = errores['hora'] != null ? errores['hora'][0] : "";
                          errJugado = errores['jugado'] != null ? errores['jugado'][0] : "";
                          errLugar = errores['lugar'] != null ? errores['lugar'][0] : "";
                          errIdCampeonato = errores['campeonato_id'] != null ? errores['campeonato_id'][0] : "";
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateFields() {
    bool isValid = true;
    if (horaController.text.isEmpty) {
      setState(() {
        errHora = 'Campo requerido';
      });
      isValid = false;
    } else {
      setState(() {
        errHora = '';
      });
    }

    if (jugadoController.text.isEmpty) {
      setState(() {
        errJugado = 'Campo requerido';
      });
      isValid = false;
    } else {
      setState(() {
        errJugado = '';
      });
    }

    if (lugarController.text.isEmpty) {
      setState(() {
        errLugar = 'Campo requerido';
      });
      isValid = false;
    } else {
      setState(() {
        errLugar = '';
      });
    }

    if (idcampeonatoController.text.isEmpty) {
      setState(() {
        errIdCampeonato = 'Campo requerido';
      });
      isValid = false;
    } else {
      setState(() {
        errIdCampeonato = '';
      });
    }

    return isValid;
  }
}
