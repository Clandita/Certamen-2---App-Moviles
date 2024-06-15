import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/editar_campeonato.dart';
import 'package:flutter_application_1/pages/equipos_en_campeonato.dart';
import 'package:flutter_application_1/pages/partidos.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CampeonatoTile extends StatefulWidget {
  final String nombre;
  final String juego;
  final String reglas;
  final String premios;
  final int id;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CampeonatoTile({this.nombre='sin nombre', this.juego='sin juego', this.reglas='sin reglas', this.premios='sin premios', required this.id,required this.onEdit, required this.onDelete});

  @override
  State<CampeonatoTile> createState() => _CampeonatoTileState();
}

class _CampeonatoTileState extends State<CampeonatoTile> {
  final HttpService httpService = HttpService();
  late TextEditingController idController;


 @override
  void initState() {
    super.initState();
    idController=TextEditingController(text: widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(158, 158, 158, 0.8),
          border: Border.all(color: Colors.black),
        ),
        child: ExpansionTile(
          backgroundColor: const Color.fromRGBO(158, 158, 158, 0.8),
          title: Center(child: Text(widget.nombre, style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.nintendoGameBoy, size: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Juego', style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(' ${widget.juego}', textAlign: TextAlign.justify, style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16)))
            ),
            Divider(color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.ruler, size: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Reglas', style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(' ${widget.reglas}', textAlign: TextAlign.justify,style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
            ),
            Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.trophy, size: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Premios', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(' ${widget.premios}', textAlign: TextAlign.justify, style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EquiposCampeonato(campeonato_Id: widget.id)
                        ),
                      );
                    },
                    child: Text('Equipos Participantes', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartidosCampeonato(campeonato_Id: widget.id),
                        ),
                      );
                    },
                    child: Text('Partidos', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarCampeonatoPage(
                            id: widget.id,
                            nombre: widget.nombre,
                            juego: widget.juego,
                            reglas: widget.reglas,
                            premios: widget.premios)
                        ),
                      ).then((value){
                        if(value==true){
                          widget.onEdit();
                        }
                      });
                    },
                    icon: Icon(MdiIcons.bookEdit),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () async {
                      var respuesta= await HttpService().deleteCampeonato(
                    int.parse(idController.text)
               
                );
                if(respuesta=='Error'){
                  print("nooo");
                }else{
                  widget.onDelete();
                }
                    },
                    icon: Icon(MdiIcons.delete),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

