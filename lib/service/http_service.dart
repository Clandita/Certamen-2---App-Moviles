import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;



class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> campeonatos() async {
    return listarDatos('campeonatos');
  }

  Future<List<dynamic>> partidos() async {
    return listarDatos('partidos');
  }
  Future<List<dynamic>> resultados() async {
    return listarDatos('resultados');
  }
    Future<List<dynamic>> jugadores() async {
    return listarDatos('jugadores');
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

  Future<String> obtenerNombreCampeonatoPorId(int campeonato_id) async {
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
  print(nombre);
  print(descripcion); 
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

Future<Map<String, dynamic>> campeonatosAgregar(
      String nombre, String juego, String reglas, String premios) async {
    final response = await http.post(
      Uri.parse('$apiUrl/campeonatos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'juego': juego,
        'reglas': reglas,
        'premios': premios,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
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

  Future<Map<String, dynamic>> updateEquipos(int id, String nombre, String descripcion) async {

    var url = Uri.parse('$apiUrl/equipos/$id');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(<String, dynamic>{
        'nombre': nombre,
        'descripcion': descripcion,
      }),
    );

    return json.decode(response.body);
  }


  Future<String> deleteEquipo(int id) async {
    var url=Uri.parse('$apiUrl/equipos/$id');
    var response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      
      );
      return response.body;
      }


  Future<LinkedHashMap<String, dynamic>> updateJugador(String rut,String nombre, String apellido, String nickname) async {
    var url=Uri.parse('$apiUrl/jugadores/?rut=$rut');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(<String, dynamic>{
        'nombre': nombre,
        'apellido': apellido,
        'nickname': nickname

  }),
      );
      return json.decode(response.body);}

    Future<String> deleteJugador(String rut) async {
    var url=Uri.parse('$apiUrl/jugadores/?rut=$rut');
    var response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      
      );
      return response.body;
      }


  Future<Map<String, dynamic>> updateCampeonato(int id, String nombre, String juego, String reglas, String premios) async {

    var url = Uri.parse('$apiUrl/campeonatos/$id');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(<String, dynamic>{
        'nombre': nombre,
        'juego': juego,
        'reglas': reglas,
        'premios': premios
      }),
    );

    return json.decode(response.body);
    }

    Future<String> deleteCampeonato(int id) async {
    var url=Uri.parse('$apiUrl/campeonatos/$id');
    var response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      
      );
      return response.body;
      }




  Map<String, dynamic> _procesarRespuesta(http.Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    try {
      return {
        'message': 'Error',
        'errors': jsonDecode(response.body)['errors']
      };
    } catch (e) {
      print('Error al procesar la respuesta de error: $e');
      return {
        'message': 'Error',
        'errors': {'general': ['Respuesta no válida del servidor']}
      };
    }
  }
}




  
  Future<Map<String, dynamic>> partidosAgregar(String hora, bool jugado, String lugar, int campeonatoId) async {
    final url = Uri.parse('$apiUrl/partidos');
    print(hora);
    print (jugado);
    print(lugar);
    print(campeonatoId);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'hora': hora,
        'jugado': false,
        'lugar': lugar,
        'campeonato_id': campeonatoId,
      }),
    );

    return _procesarRespuesta(response);
  }




    Future<Map<String, dynamic>> updatePartidos(int id, String lugar) async {

    var url = Uri.parse('$apiUrl/partidos/$id');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(<String, dynamic>{
        'id': id,
        'lugar': lugar,


      }),
    );
    print(lugar);
    return json.decode(response.body);
  }

    Future<String> deletePartido(int id) async {
      var url=Uri.parse('$apiUrl/partidos/$id');
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      
      );
    return response.body;
      }




  Future<Map<String, dynamic>> jugadorAgregar(String nombre, String apellido, String rut, String nickname, int equipo_id) async {
    final url = Uri.parse('$apiUrl/jugadores');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'apellido': apellido,
        'rut': rut,
        'nickname': nickname,
        'equipo_id': equipo_id,
      }),
    );

    return _procesarRespuesta(response);
  }
  Future<Map<String, dynamic>> AgregarEquiposEnCampeonato(int equipo_id, int campeonato_id) async {
    final url = Uri.parse('$apiUrl/campeonatoequipo');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'equipo_id': equipo_id,
        'campeonato_id': campeonato_id,
      }),
    );

    return _procesarRespuesta(response);
  }
  Future<List<dynamic>> equiposNoEnCampeonato(int campeonatoId) async {
    final response = await http.get(Uri.parse('$apiUrl/campeonatos/$campeonatoId/equipos/no'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los equipos');
    }
  }

  Future<Map<String, dynamic>> agregarEquipoACampeonato(int equipoId, int campeonatoId) async {
  final url = Uri.parse('$apiUrl/campeonatoequipo');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'equipo_id': equipoId,
      'campeonato_id': campeonatoId,
    }),
  );

  return _procesarRespuesta(response);
}
  Future<List<dynamic>> equipos() async {
    final response = await http.get(Uri.parse('$apiUrl/equipos'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los equipos');
    }
  }

  Future<dynamic> agregarResultado(int equipoId, int partidoId, int puntos, bool ganador) async {
    final response = await http.post(
      Uri.parse('$apiUrl/resultados'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'equipo_id': equipoId,
        'partido_id': partidoId,
        'puntos': puntos,
        'ganador': ganador,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add resultado');
    }
  }
}


