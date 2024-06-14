import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class JugadorAgregar extends StatefulWidget {
  final int id_Equipo;
  const JugadorAgregar({super.key, required this.id_Equipo});

  @override
  State<JugadorAgregar> createState() => _JugadorAgregarState();
}

class _JugadorAgregarState extends State<JugadorAgregar> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController rutController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  String errNombre = "";
  String errApellido = "";
  String errNickname = "";
  String errRut = "";
  String errGeneral = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Nuevo jugador"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text("Nombre:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: nombreController,
            ),
            Text(
              errNombre,
              style: TextStyle(color: Colors.red),
            ),
            Text("Apellido:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Apellido"),
              controller: apellidoController,
            ),
            Text(
              errApellido,
              style: TextStyle(color: Colors.red),
            ),
            Text("RUT:"),
            TextFormField(
              decoration: InputDecoration(labelText: "RUT"),
              controller: rutController,
            ),
            Text(
              errRut,
              style: TextStyle(color: Colors.red),
            ),
            Text("Nickname:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Nickname"),
              controller: nicknameController,
            ),
            Text(
              errNickname,
              style: TextStyle(color: Colors.red),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xff134577),
                ),
                child: Text("Agregar Jugador"),
                onPressed: () async {
                  try {
                    String nombre = nombreController.text;
                    String apellido = apellidoController.text;
                    String nickname = nicknameController.text;
                    String rut = rutController.text;

                    var respuesta = await HttpService().jugadorAgregar(
                      nombre,
                      apellido,
                      rut,
                      nickname,
                      widget.id_Equipo,
                    );

                    if (respuesta['message'] == 'Error') {
                      var errores = respuesta['errors'];
                      setState(() {
                        errNombre = errores['nombre'] != null ? errores['nombre'][0] : "";
                        errApellido = errores['apellido'] != null ? errores['apellido'][0] : "";
                        errNickname = errores['nickname'] != null ? errores['nickname'][0] : "";
                        errRut = errores['rut'] != null ? errores['rut'][0] : "";
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
          ],
        ),
      ),
    );
  }
}
