import 'dart:convert';
import 'package:flutter/material.dart';
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
    }
    print(respuesta.statusCode);
    return [];
  }

  Future<List<dynamic>> obtenerEquiposPorCampeonato(int campeonato_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/campeonatos/$campeonato_id/equipos'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    

    print(respuesta.statusCode);
    return [];
  }

  Future<List<dynamic>> jugadoresPorEquipo(int equipo_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/jugadores/?equipo_id=$equipo_id'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    

    print(respuesta.statusCode);
    return [];
  }
  Future<List<dynamic>> campeonatoPorId(int campeonato_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/campeonatos/$campeonato_id'));
    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    

    print(respuesta.statusCode);
    return [];
  }

  Future<List<dynamic>> obtenerResultadosDePartidos(int partido_id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/resultados/?partido_id=$partido_id'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    

    print(respuesta.statusCode);
    return [];
  }
  Future<String> obtenerNombreEquipoPorId(int equipo_Id) async {
    final response = await http.get(Uri.parse('$apiUrl/equipos/$equipo_Id'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['nombre'];
    } else {
      throw Exception('Error al obtener el nombre del equipo');
    }
  }
}