import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/campeonato_agregar.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/campeonato_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatosTab extends StatefulWidget {
  const CampeonatosTab({super.key});

  @override
  State<CampeonatosTab> createState() => _CampeonatosTabState();
}

class _CampeonatosTabState extends State<CampeonatosTab> {
  List<dynamic> campeonatos = [];

  @override
  void initState() {
    super.initState();
    _fetchCampeonatos();
  }

  Future<void> _fetchCampeonatos() async {
    var campeonatosData = await HttpService().campeonatos();
    setState(() {
      campeonatos = campeonatosData;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/iconito.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "CAMPEONATOS",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: campeonatos.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: campeonatos.length,
                      itemBuilder: (context, index) {
                        var campeonato = campeonatos[index];
                        return CampeonatoTile(
                          id: campeonato["id"],
                          nombre: campeonato["nombre"],
                          juego: campeonato['juego'],
                          reglas: campeonato['reglas'],
                          premios: campeonato['premios'],
                          onEdit: _fetchCampeonatos,
                          onDelete: _fetchCampeonatos,
                          
                        );
                      },
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color:Colors.white
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color(0xff142157),
        onPressed: () async {
          MaterialPageRoute ruta = MaterialPageRoute(
            builder: (context) => CampeonatoAgregar(),
          );
          await Navigator.push(context, ruta);
          _fetchCampeonatos(); 
        },
      ),
    );
  }
}
