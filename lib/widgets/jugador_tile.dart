import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/editar_jugador.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class JugadorTile extends StatefulWidget {

  final String rut;
  final String nombre;
  final String apellido;
  final String nickname; 
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const JugadorTile({this.nombre='sin nombre',this.rut='sin rut',this.apellido='sin apellido', this.nickname='sin nickname',required this.onEdit, required this.onDelete});

  @override
  State<JugadorTile> createState() => _JugadorTileState();
}

class _JugadorTileState extends State<JugadorTile> {
  late TextEditingController rutController;
  late String nombre;
  late String apellido;
  late String nickname;


  void funcionVacia(){

  }

  @override
  void initState() {
    super.initState();
    rutController=TextEditingController(text: widget.rut);
    nombre = widget.nombre;
    apellido = widget.apellido;
    nickname = widget.nickname;
  }

  void editarJugador() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarJugadorPage(
          rut: widget.rut,
          nombre: nombre,
          apellido: apellido,
          nickname: nickname,
          onEdit: funcionVacia
        ),
      ),
    ).then((value) {
                      if (value ==true){
                        widget.onEdit();
                      }
                    });

    if (updatedData != null) {
      setState(() {
        nombre = updatedData['nombre'];
        apellido = updatedData['apellido'];
        nickname = updatedData['nickname'];
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),    
          decoration: BoxDecoration(
            color: Color.fromRGBO(158, 158, 158, 0.8),
            border:Border.all(color: Colors.black),
            borderRadius: BorderRadius.all( Radius.circular(10))
          ),
      child: Column(children: [

        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(158, 158, 158, 0.8),
            borderRadius: BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          child: Row(
        
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.png'),
              )
            ],
          )),

        Container(
          color:Color.fromRGBO(158, 158, 158, 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(MdiIcons.instagram),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(MdiIcons.facebook),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(MdiIcons.youtube),
              )
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nombre} '+'${this.widget.apellido}', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          )),
          Container(
            child: Text('Nickname:',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ),
          Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nickname}',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            ],
          )),
          Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: editarJugador,
                icon: Icon(MdiIcons.humanEdit)),
              IconButton(onPressed: () async{
                var respuesta= await HttpService().deleteJugador(
                    rutController.text
                );
                if(respuesta=='Error'){
                  print("nooo");
                }else{
                  print('${rutController}');
                  widget.onDelete();
                  setState(() {});
                }
              }, icon: Icon(MdiIcons.delete))
            ],
          ),
        ),
      ],),
    );
  
  
  }
  
}