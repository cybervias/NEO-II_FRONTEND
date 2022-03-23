import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neo_application/pages/clientes_grupos/propriedades/propFloresta/propFloresta_Model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoFloresta/tipoFlorestaModel.dart';


class PropFlorestaAPI {
  //Create Lista de TiposFloresta
  Future createPropManejo(PropFlorestaModel oPropFloresta) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propFloresta/create");

      var body = {
        "IDPropriedade": oPropFloresta.IDPropriedade,
        "IDTipoManejo": oPropFloresta.IDTipoManejo,
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

  //Busca Lista de TiposFloresta
  Future<List<TipoFlorestaModel>> getListTipoFloresta() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/tiposFloresta");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((tipoFloresta) => TipoFlorestaModel.fromMap(tipoFloresta))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  //Deletar tipo floresta
  Future deletePropManejo(int idFloresta) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propFloresta/delete/$idFloresta");

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