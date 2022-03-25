import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_api.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_model.dart';

class DropDownControllerGrupos extends ChangeNotifier {
  
  List<GruposModel> listGrupos = [];
  GruposModel? selecionadoGrupos;

  Future buscarGrupos() async {
    listGrupos = await GruposApi().getListGrupos();

    notifyListeners();
  }

  void setSelecionadoGrupos(selTipo){
    selecionadoGrupos = selTipo;
    notifyListeners();
  }


}