import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoAgregar extends StatefulWidget {
  const EquipoAgregar({Key? key});

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
            Text("Nombre Equipo:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: nombreController,
            ),
            if (errNombre.isNotEmpty)
              Text(
                errNombre,
                style: TextStyle(color: Colors.red),
              ),
            Text("Descripción equipo:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Descripción"),
              controller: descripcionController,
            ),
            if (errDescripcion.isNotEmpty)
              Text(
                errDescripcion,
                style: TextStyle(color: Colors.red),
              ),
            if (errGeneral.isNotEmpty)
              Text(
                errGeneral,
                style: TextStyle(color: Colors.red),
              ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff134577),
                ),
                child: Text("Agregar equipo", style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                onPressed: () async {
                  // Validación de campos
                  if (nombreController.text.isEmpty) {
                    setState(() {
                      errNombre = 'El nombre del equipo es requerido';
                    });
                    return;
                  }
                  if (descripcionController.text.isEmpty) {
                    setState(() {
                      errDescripcion = 'La descripción del equipo es requerida';
                    });
                    return;
                  }

                  // Envío de solicitud al servicio HTTP
                  try {
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
                      Navigator.pop(context,true);
                    }
                  } catch (e) {
                    setState(() {
                      errGeneral = 'Error en el formato de entrada: ${e.toString()}';
                      print('Error durante la solicitud: $e');
                    });
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
