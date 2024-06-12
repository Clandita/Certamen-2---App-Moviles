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
        title: Text("Agregar Nuevo partido"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text("Nombre Equipo:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: horaController,
            ),
            Text(
              errHora,
              style: TextStyle(color: Colors.red),
            ),
            Text(
              errGeneral,
              style: TextStyle(color: Colors.red),
            ),
            /*Container(
              margin: EdgeInsets.only(top: 20),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xff134577),
                ),
                child: Text("Agregar equipo"),
                onPressed: () async {
                  var respuesta = await HttpService().(
                    nombreController.text,
                    descripcionController.text,
                  );
                  if (respuesta['message'] == 'Error') {
                    var errores = respuesta['errors'];
                    setState(() {
                      errNombre = errores['nombre'] != null ? errores['nombre'][0] : "";
                      errDescripcion = errores['descripcion'] != null ? errores['descripcion'][0] : "";
                      errGeneral = errores['general'] != null ? errores['general'][0] : "";
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
