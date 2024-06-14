import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class EquipoEditar extends StatefulWidget {
  final int id;
  String nombre;
  String descripcion;

  EquipoEditar({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  @override
  State<EquipoEditar> createState() => _EquipoEditarState();
}

class _EquipoEditarState extends State<EquipoEditar> {
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  String errNombre = "";
  String errDescripcion = "";

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    descripcionController = TextEditingController(text: widget.descripcion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTextField(
              label: 'Nombre del Equipo',
              controller: nombreController,
              errorText: errNombre,
              onChanged: (value) {
                setState(() {
                  errNombre = value.isEmpty ? 'Ingrese un nombre' : '';
                });
              },
            ),
            SizedBox(height: 20),
            _buildTextField(
              label: 'Descripción del Equipo',
              controller: descripcionController,
              errorText: errDescripcion,
              onChanged: (value) {
                setState(() {
                  errDescripcion = value.isEmpty ? 'Ingrese una descripción' : '';
                });
              },
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  errNombre = nombreController.text.isEmpty ? 'Ingrese un nombre' : '';
                  errDescripcion = descripcionController.text.isEmpty ? 'Ingrese una descripción' : '';
                });

                if (errNombre.isEmpty && errDescripcion.isEmpty) {
                  try {
                    var respuesta = await HttpService().updateEquipos(
                      widget.id,
                      nombreController.text,
                      descripcionController.text,
                    );

                    if (respuesta == 'Error') {
                      print("Hubo un error al actualizar el equipo.");
                    } else {
                      setState(() {
                        widget.nombre = nombreController.text;
                        widget.descripcion = descripcionController.text;
                      });

                      Navigator.pop(context); // Volver a la pantalla anterior
                    }
                  } catch (e) {
                    print('Error en la solicitud: $e');
                  }
                }
              },
              child: Text('Guardar'),
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
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            errorText: errorText.isNotEmpty ? errorText : null,
          ),
          onChanged: onChanged,
          maxLines: maxLines,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
