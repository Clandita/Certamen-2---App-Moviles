import 'package:flutter/material.dart';

class ResultadosPage extends StatelessWidget {
  const ResultadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Mostrar un Snackbar usando ScaffoldMessenger
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('¡Hola! Este es un Snackbar.'),
                action: SnackBarAction(
                  label: 'Deshacer',
                  onPressed: () {
                    // Algo que hacer cuando se presiona "Deshacer"
                    print('Acción de deshacer presionada.');
                  },
                ),
              ),
            );
          },
          child: Text('Mostrar Snackbar'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ResultadosPage(),
  ));
}
