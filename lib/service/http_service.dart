import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> campeonatos() async {
    return listarDatos('campeonatos');
  }

  Future<List<dynamic>> equipos() async {
    return listarDatos('equipos');
  }

  Future<List<dynamic>> partidos() async {
    return listarDatos('partidos');
  }

  Future<List<dynamic>> listarDatos(String coleccion) async {
    var respuesta = await http.get(Uri.parse(apiUrl + '/' + coleccion));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al listar datos: ${respuesta.statusCode}');
    }
  }

  Future<List<dynamic>> obtenerEquiposPorCampeonato(int campeonato_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/campeonatos/$campeonato_id/equipos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al obtener equipos por campeonato: ${respuesta.statusCode}');
    }
  }

  Future<List<dynamic>> jugadoresPorEquipo(int equipo_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/jugadores/?equipo_id=$equipo_id'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al obtener jugadores por equipo: ${respuesta.statusCode}');
    }
  }
<<<<<<< HEAD

  Future<String> obtenerNombreCampeonatoPorId(int campeonato_id) async {
=======
  
   Future<String> obtenerNombreCampeonatoPorId(int campeonato_id) async {
>>>>>>> 9ad3e7a3fdc82dcf161dadd39760d70e14f84f24
    var respuesta = await http.get(Uri.parse('$apiUrl/campeonatos/$campeonato_id'));
    if (respuesta.statusCode == 200) {
      var jsonData = json.decode(respuesta.body);
      return jsonData['nombre'] ?? 'Nombre no disponible';
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al obtener nombre del campeonato: ${respuesta.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerResultadosDePartidos(int partido_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/resultados/?partido_id=$partido_id'));
    if (respuesta.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(respuesta.body));
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al obtener resultados de partidos: ${respuesta.statusCode}');
    }
  }

  Future<String> obtenerNombreEquipoPorId(int equipo_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/equipos/$equipo_id'));
    if (respuesta.statusCode == 200) {
      var jsonData = json.decode(respuesta.body);
      return jsonData['nombre'] ?? 'Nombre no disponible';
    } else {
      print('Error: ${respuesta.statusCode}');
      throw Exception('Error al obtener nombre del equipo: ${respuesta.statusCode}');
    }
  }

  Future<Map<String, dynamic>> equiposAgregar(String nombre, String descripcion) async {
  if (nombre.isEmpty || descripcion.isEmpty) {
    return {'error': 'Los campos nombre y descripción no pueden estar vacíos'};
  }

  final url = Uri.parse('$apiUrl/equipos');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'nombre': nombre,
      'descripcion': descripcion,
    }),
  );

  return _procesarRespuesta(response);
}


  Future<Map<String, dynamic>> campeonatosAgregar(String nombre, String juego, String reglas, String premios) async {
    final url = Uri.parse('$apiUrl/campeonatos');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'juego': juego,
        'reglas': reglas,
        'premios': premios,
      }),
    );

    return _procesarRespuesta(response);
  }

  Future<Map<String, dynamic>> obtenerEquipo(int equipoId) async {
    final response = await http.get(Uri.parse('$apiUrl/equipos/$equipoId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Error al obtener equipo: ${response.statusCode}');
    }
  }

  Map<String, dynamic> _procesarRespuesta(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        return {'message': 'Success', 'data': response.body};
      }
    } else {
      try {
        return {
          'message': 'Error',
          'errors': jsonDecode(response.body)['errors']
        };
      } catch (e) {
        return {
          'message': 'Error',
          'errors': {'general': ['Respuesta no válida del servidor']}
        };
      }
    }
  }
<<<<<<< HEAD
  Future<Map<String, dynamic>> editarEquipo(int id, String nombre, String descripcion) async {
    final String url = '$apiUrl/equipos/$id';
  
    final Map<String, String> body = {
      'nombre': nombre,
      'descripcion': descripcion,
    };

    final http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
=======
>>>>>>> 9ad3e7a3fdc82dcf161dadd39760d70e14f84f24

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al editar el equipo: ${response.statusCode}');
    }
  }

  Future<bool> updateJugador(String rut,String nombre, String apellido, String nickname) async {
    final response = await http.put(
      Uri.parse('$apiUrl/jugadores/$rut'), 
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'nombre': nombre,
        'apellido': apellido,
        'nickname': nickname

  }),    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('');
    }
  }
  


}
