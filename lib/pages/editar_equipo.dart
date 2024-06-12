import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class EquipoEditar extends StatefulWidget {
  final int id;
  final String nombre;
  final String descripcion;

  EquipoEditar({required this.id, required this.nombre, required this.descripcion});

  @override
  State<EquipoEditar> createState() => _EquipoEditarState();
}

class _EquipoEditarState extends State<EquipoEditar> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombre);
    _descripcionController = TextEditingController(text: widget.descripcion);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
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
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre del Equipo',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Equipo',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () async {
    String nombreEditado = _nombreController.text;
    String descripcionEditada = _descripcionController.text;
    
    try {
      // Llamar al método editarEquipo del servicio HttpService
      var response = await HttpService().editarEquipo(widget.id, nombreEditado, descripcionEditada);
      
      // Verificar la respuesta y mostrar un mensaje adecuado
      if (response.containsKey('message') && response['message'] == 'Success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Equipo editado correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al editar el equipo')),
        );
      }
    } catch (error) {
      print('Error al editar el equipo: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al editar el equipo')),
      );
    }
  },
  child: Text('Guardar Cambios'),
),

          ],
        ),
      ),
    );
  }
}
