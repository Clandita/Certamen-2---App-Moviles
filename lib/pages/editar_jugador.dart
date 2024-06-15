import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarJugadorPage extends StatefulWidget {
  final String rut;
  final String nombre;
  final String apellido;
  final String nickname;
  final VoidCallback onEdit;

  const EditarJugadorPage({
    required this.rut,
    required this.nombre,
    required this.apellido,
    required this.nickname,
    required this.onEdit
  });

  @override
  State<EditarJugadorPage> createState() => _EditarJugadorPageState();
}

class _EditarJugadorPageState extends State<EditarJugadorPage> {
  late TextEditingController rutController;
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController nicknameController;

  String nombreError = '';
  String apellidoError = '';
  String nicknameError = '';
  String errorMessage = '';
  String successMessage = '';

  @override
  void initState() {
    super.initState();
    rutController = TextEditingController(text: widget.rut);
    nombreController = TextEditingController(text: widget.nombre);
    apellidoController = TextEditingController(text: widget.apellido);
    nicknameController = TextEditingController(text: widget.nickname);
  }

  @override
  void dispose() {
    rutController.dispose();
    nombreController.dispose();
    apellidoController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Jugador',
          style: GoogleFonts.oswald(
            textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: nombreController,
              label: 'Nombre',
              errorText: nombreError,
            ),
            _buildTextField(
              controller: apellidoController,
              label: 'Apellido',
              errorText: apellidoError,
            ),
            _buildTextField(
              controller: nicknameController,
              label: 'Nickname',
              errorText: nicknameError,
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (successMessage.isNotEmpty)
              Text(
                successMessage,
                style: const TextStyle(color: Colors.green, fontSize: 16),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: () async {
                setState(() {
                  errorMessage = '';
                  successMessage = '';
                  nombreError = '';
                  apellidoError = '';
                  nicknameError = '';
                });

                if (nombreController.text.isEmpty) {
                  setState(() {
                    nombreError = 'Ingrese un nombre';
                  });
                  return;
                }
                if (apellidoController.text.isEmpty) {
                  setState(() {
                    apellidoError = 'Ingrese un apellido';
                  });
                  return;
                }
                if (nicknameController.text.isEmpty) {
                  setState(() {
                    nicknameError = 'Ingrese un nickname';
                  });
                  return;
                }

                var respuesta = await HttpService().updateJugador(
                  rutController.text,
                  nombreController.text,
                  apellidoController.text,
                  nicknameController.text,
                );

                if (respuesta == 'Error') {
                  setState(() {
                    errorMessage = 'Error al actualizar el jugador. Inténtelo de nuevo.';
                  });
                } else {
                  Navigator.pop(context, true);
                  setState(() {
                    
                    successMessage = 'Jugador actualizado exitosamente.';
                  });
                }
              },
              child: Text(
                'Guardar',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            errorText: errorText.isNotEmpty ? errorText : null,
            labelStyle: GoogleFonts.oswald(
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
