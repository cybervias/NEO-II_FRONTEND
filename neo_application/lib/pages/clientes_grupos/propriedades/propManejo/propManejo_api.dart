import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:javascript/javascript.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propManejo/propManejo_model.dart';

import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoManejo/tipoManejoModel.dart';

class PropManejoApi {
  //Busca Lista de TiposManejo
  Future<List<TipoManejoModel>> getListTipoManejo() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/tiposManejo");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((tipoManejo) => TipoManejoModel.fromMap(tipoManejo))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }
  //Busca Lista de PropManejo
  Future<List<PropManejoModel>> getListPropManejo() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/propManejo");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((propManejo) => PropManejoModel.fromMap(propManejo))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  Future createPropManejo(PropManejoModel oPropManejo) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propManejo/create");

      var body = {
        "IDPropriedade": oPropManejo.IDPropriedade,
        "IDTipoManejo": oPropManejo.IDTipoManejo,
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

  Future deletePropManejo(int idManejo) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propManejo/delete/$idManejo");

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
