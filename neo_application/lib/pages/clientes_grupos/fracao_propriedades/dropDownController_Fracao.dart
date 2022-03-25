import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_api.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_model.dart';

class DropDownControllerFracao extends ChangeNotifier {
  
  List<FracaoPropModel> listFracao = [];
  FracaoPropModel? selecionadoFracao;

  Future buscarFracao() async {
    listFracao = await FracaoPropApi().getListFracaoProp();

    notifyListeners();
  }

  void setSelecionadoFracao(selTipo){
    selecionadoFracao = selTipo;
    notifyListeners();
  }


}