import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class EquipoAgregar extends StatefulWidget {
  const EquipoAgregar({super.key});

  @override
  State<EquipoAgregar> createState() => _EquipoAgregarState();
}

class _EquipoAgregarState extends State<EquipoAgregar> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  String errNombre = "";
  String errDescripcion = "";
  String errGeneral = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Nuevo Equipo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text("Agregar nombre:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: nombreController,
            ),
            Text(
              errNombre,
              style: TextStyle(color: Colors.red),
            ),
            Text("Agregar descripción:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Descripción"),
              controller: descripcionController,
            ),
            Text(
              errDescripcion,
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
                child: Text("Agregar equipo"),
                onPressed: () async {
                  var respuesta = await HttpService().equiposAgregar(
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
            )
          ],
        ),
      ),
    );
  }
}
