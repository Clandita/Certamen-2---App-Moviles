import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class JugadorAgregar extends StatefulWidget {
  final int id_Equipo;

  const JugadorAgregar({Key? key, required this.id_Equipo}) : super(key: key);

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
            _buildTextField(
              label: "Nombre:",
              controller: nombreController,
              errorText: errNombre,
              onChanged: (value) {
                setState(() {
                  errNombre = value.isEmpty ? "Ingrese un nombre" : "";
                });
              },
            ),
            _buildTextField(
              label: "Apellido:",
              controller: apellidoController,
              errorText: errApellido,
              onChanged: (value) {
                setState(() {
                  errApellido = value.isEmpty ? "Ingrese un apellido" : "";
                });
              },
            ),
            _buildTextField(
              label: "RUT:",
              controller: rutController,
              errorText: errRut,
              onChanged: (value) {
                setState(() {
                  errRut = value.isEmpty ? "Ingrese un RUT" : "";
                });
              },
            ),
            _buildTextField(
              label: "Nickname:",
              controller: nicknameController,
              errorText: errNickname,
              onChanged: (value) {
                setState(() {
                  errNickname = value.isEmpty ? "Ingrese un nickname" : "";
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff134577),
                ),
                onPressed: () async {
                  setState(() {
                    errGeneral = "";
                  });

                  String nombre = nombreController.text.trim();
                  String apellido = apellidoController.text.trim();
                  String nickname = nicknameController.text.trim();
                  String rut = rutController.text.trim();

                  if (nombre.isEmpty || apellido.isEmpty || nickname.isEmpty || rut.isEmpty) {
                    setState(() {
                      errNombre = nombre.isEmpty ? "Ingrese un nombre" : "";
                      errApellido = apellido.isEmpty ? "Ingrese un apellido" : "";
                      errNickname = nickname.isEmpty ? "Ingrese un nickname" : "";
                      errRut = rut.isEmpty ? "Ingrese un RUT" : "";
                    });
                    return;
                  }

                  try {
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
                child: Text("Agregar Jugador"),
              ),
            ),
            if (errGeneral.isNotEmpty)
              Text(
                errGeneral,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String errorText,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: label,
            errorText: errorText.isNotEmpty ? errorText : null,
          ),
          controller: controller,
          onChanged: onChanged,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
