import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:javascript/javascript.dart';

import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';

class PropriedadesApi {
  List<PropriedadesModel> list = [];
  Future<List<PropriedadesModel>> getListPropriedades() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/propriedades");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((propriedades) => PropriedadesModel.fromMap(propriedades))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  Future updatePropriedade(PropriedadesModel oProp) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propriedades/update");

      var body = {
        "idPropriedade": oProp.idPropriedade,
        "Nome": oProp.Nome,
        "CNPJ": oProp.CNPJ,
        "XCoord": oProp.XCoord,
        "yCoord": oProp.yCoord,
        "AreaPropriedade": oProp.AreaPropriedade,
        "AreaTotal": oProp.AreaTotal,
        "AreaPlantada": oProp.AreaPlantada,
        "AreaEstimaConservacao": oProp.AreaEstimaConservacao,
        "AreaInfraestrutura": oProp.AreaInfraestrutura,
        "AreaOutrosUsos": oProp.AreaOutrosUsos,
        "Localizacao": oProp.Localizacao,
        "UF": oProp.UF

      };

      var response = await http.put(url,
          headers: <String, String>{"Content-type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        Map<String, dynamic> map = {
          "type": res["type"],
          "message": res["message"]
        };
        return map;
      } else {
        
        Map<String, dynamic> map = {
          "type": "E",
          "message": "Erro ao gravar dados"
        };
        return map;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future createPropriedade(PropriedadesModel oProp) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propriedades/create");

      var body = {
        "Nome": oProp.Nome,
        "CNPJ": oProp.CNPJ,
        "XCoord": oProp.XCoord,
        "yCoord": oProp.yCoord,
        "AreaPropriedade": oProp.AreaPropriedade,
        "AreaTotal": oProp.AreaTotal,
        "AreaPlantada": oProp.AreaPlantada,
        "AreaEstimaConservacao": oProp.AreaEstimaConservacao,
        "AreaInfraestrutura": oProp.AreaInfraestrutura,
        "AreaOutrosUsos": oProp.AreaOutrosUsos,
        "Localizacao": oProp.Localizacao,
        "UF": oProp.UF,
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

  Future deletePropriedade(int idProp) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propriedades/delete/$idProp");

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
