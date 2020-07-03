import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';


void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _toDoList = [];






  @override
  Widget build(BuildContext context) {
    return ListView(

    );
  }




  Future<File> _getFile() async{//função para obter o arquivo

    final directory = await getApplicationDocumentsDirectory();//peguei o local onde posso salvar os documentos
    return File("${directory.path}/data.json");//pegando o caminho do diretório e junto com o nome do arquivo e abro o arquivo através do file

  }


  Future<File> _saveData() async{ //função para salvar o arquivo

   String data = json.encode(_toDoList);//pegando a lista e transformando em um Json e colocando em uma string
   final file = await _getFile();
   return file.writeAsString(data);

  }

  Future<String> _readData() async{ // função para ler o dados no arquivo

    try{
      final file = await _getFile();
      return file.readAsString();
    } catch (e){
      return null;
    }
  }



}


