import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propProduto/propProduto_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoProduto/tipoProdutoModel.dart';

class DropDownControllerProduto extends ChangeNotifier {
  
  List<TipoProdutoModel> listTipoProduto = [];
  TipoProdutoModel? selecionadoTipoProduto;

  Future buscarTipoProduto() async {
    listTipoProduto = await PropProdutoApi().getListProduto();

    notifyListeners();
  }

  void setSelecionadoTipoProduto(selTipo){
    selecionadoTipoProduto = selTipo;
    notifyListeners();
  }


}