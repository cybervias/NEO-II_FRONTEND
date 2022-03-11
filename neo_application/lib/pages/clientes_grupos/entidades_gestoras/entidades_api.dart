import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:javascript/javascript.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';

class EntidadesApi {
  List<EntidadesModel> list = [];
  Future<List<EntidadesModel>> getListEntidades() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/entidades");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((entidades) => EntidadesModel.fromMap(entidades))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  Future updateEntidade(EntidadesModel oEnti) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/entidades/update");

      var body = {
        "Id": oEnti.Id,
        "Nome": oEnti.Nome,
        "Contato": oEnti.Contato,
        "Telefone": oEnti.Telefone,
        "Email": oEnti.Email,
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
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future createEntidade(EntidadesModel oEnti) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/entidades/create");

      var body = {
        "Nome": oEnti.Nome,
        "Contato": oEnti.Contato,
        "Telefone": oEnti.Telefone,
        "Email": oEnti.Email,
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

  Future deleteEntidade(int idProp) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/entidades/delete/$idProp");

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
