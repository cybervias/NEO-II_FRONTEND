import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neo_application/pages/clientes_grupos/propriedades/propProduto/propProduto_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoProduto/tipoProdutoModel.dart';


class PropProdutoApi {
  //Busca Lista de PropProduto
  Future<List<PropProdutoModel>> getListPropProduto() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/propProdutos");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((PropProduto) => PropProdutoModel.fromMap(PropProduto))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }
  
  //Create Lista de PropProduto
  Future createPropProduto(PropProdutoModel oPropProduto) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propProdutos/create");

      var body = {
        "IDPropriedade": oPropProduto.IDPropriedade,
        "IDTipoManejo": oPropProduto.IDTipoManejo,
      };

      var response = await http.post(url,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        Map<String, dynamic> map = {
          "type": res["type"],
          "message": res["message"]
        };
        return map;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  //Busca Lista de Produto
  Future<List<TipoProdutoModel>> getListProduto() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/produtos");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((tipoProduto) => TipoProdutoModel.fromMap(tipoProduto))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  //Deletar PropProduto
  Future deletePropProduto(int idPropProduto) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propProdutos/delete/$idPropProduto");

      var response = await http.delete(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        Map<String, dynamic> map = {
          "type": res["type"],
          "message": res["message"]
        };
        return map;

      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}