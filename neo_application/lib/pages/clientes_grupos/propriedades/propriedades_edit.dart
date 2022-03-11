import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:neo_application/pages/utils/list_uf.dart';
import 'package:provider/provider.dart';

class PropriedadesEdit extends StatefulWidget {
  PropriedadesModel propModel;
  var tipoAcao;
  String uf;
  PropriedadesEdit(
      {Key? key, required this.propModel, this.tipoAcao, this.uf = ""})
      : super(key: key);


  @override
  State<PropriedadesEdit> createState() => _PropriedadesEditState();
}

class _PropriedadesEditState extends State<PropriedadesEdit> {
  Size get size => MediaQuery.of(context).size;
  late PropriedadesModel oProp;

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerCNPJ = TextEditingController();
  final TextEditingController _controllerXCoord = TextEditingController();
  final TextEditingController _controllerYCoord = TextEditingController();
  final TextEditingController _controllerAreaPropriedade =
      TextEditingController();
  final TextEditingController _controllerAreaTotal = TextEditingController();
  final TextEditingController _controllerAreaPlantada = TextEditingController();
  final TextEditingController _controllerAreaEstimaConser =
      TextEditingController();
  final TextEditingController _controllerAreaInfraestrutura =
      TextEditingController();
  final TextEditingController _controllerAreaOutro = TextEditingController();
  final TextEditingController _controllerLocalizacao = TextEditingController();

  late AppModel appRepository;
  double constWidth = 400;
  late PropriedadesModel oPropModel;
  String? listUfSelecionado;
  String? valueSelected;

  @override
  Widget build(BuildContext context) {
    oPropModel = widget.propModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text(widget.tipoAcao == "editar"
            ? "Editar Propriedade (${widget.propModel.idPropriedade})"
            : "Criar Nova Propriedade"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

    );
  }

  _setText() {
    oProp = widget.propModel;
    _controllerNome.text = oProp.Nome ?? "";
    _controllerCNPJ.text = oProp.CNPJ ?? "";
    _controllerXCoord.text = oProp.XCoord.toString();
    _controllerYCoord.text = oProp.yCoord.toString();
    _controllerAreaPropriedade.text = oProp.AreaPropriedade.toString();
    _controllerAreaTotal.text = oProp.AreaTotal.toString();
    _controllerAreaPlantada.text = oProp.AreaPlantada!.toString();
    _controllerAreaEstimaConser.text = oProp.AreaEstimaConservacao.toString();
    _controllerAreaInfraestrutura.text = oProp.AreaInfraestrutura.toString();
    _controllerAreaOutro.text = oProp.AreaOutrosUsos.toString();
    _controllerLocalizacao.text = oProp.Localizacao ?? "";
    listUfSelecionado = valueSelected != null ? valueSelected : oProp.UF;
  }

  _body() {
    if (widget.propModel.Nome != "") {
      _setText();
    }

    List<String> listUfs = Uf().listUfs();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        width: size.width,
        height: 550,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerNome,
                        decoration: const InputDecoration(
                          labelText: "Nome",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerCNPJ,
                        decoration: const InputDecoration(
                          labelText: "CNPJ",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerXCoord,
                        decoration: const InputDecoration(
                          labelText: "XCoord",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerYCoord,
                        decoration: const InputDecoration(
                          labelText: "YCoord",

                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerAreaPropriedade,
                        decoration: const InputDecoration(
                          labelText: "Area Propriedade",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerAreaTotal,
                        decoration: const InputDecoration(
                          labelText: "Area Total",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerAreaPlantada,
                        decoration: const InputDecoration(
                          labelText: "Area Plantada",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerAreaEstimaConser,
                        decoration: const InputDecoration(
                          labelText: "Area Estima Conser",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerAreaInfraestrutura,
                        decoration: const InputDecoration(
                          labelText: "Area Infraestrutura",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerAreaOutro,
                        decoration: const InputDecoration(
                          labelText: "Area Outro",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: constWidth,
                      height: 30,
                      child: TextFormField(
                        controller: _controllerLocalizacao,
                        decoration: const InputDecoration(
                          labelText: "Localização",
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                    Container(
                        width: constWidth,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isDense: true,
                              isExpanded: true,
                              value: listUfSelecionado,
                              onChanged: (newValue) => {
                                setState(() {
                                  valueSelected = newValue;
                                  listUfSelecionado = valueSelected;
                                })
                              },
                              items: listUfs.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        )),

                    const SizedBox(
                      width: 30,
                      height: 20,
                    ),
                  ],
                ),

                Container(
                  alignment: Alignment.bottomRight,
                  child: ButtonBar(
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(246, 34, 37, 44)),
                        onPressed: () => widget.tipoAcao == "editar"
                            ? _onClickSalvar()
                            : _onClickAdd(),
                        child: widget.tipoAcao == "editar"
                            ? Text("Salvar Alterações")
                            : Text("Adicionar"),

                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(246, 34, 37, 44)),
                        onPressed: () =>
                            {appRepository.setPage(PropriedadesPage())},
                        child: Text("Cancelar"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onClickSalvar() async {
    int xCoord = int.parse(_controllerXCoord.text);
    int yCoord = int.parse(_controllerYCoord.text);
    int areaPropriedade = int.parse(_controllerAreaPropriedade.text);
    int areaTotal = int.parse(_controllerAreaTotal.text);
    int areaPlantada = int.parse(_controllerAreaPlantada.text);
    int areaEstimaConservacao = int.parse(_controllerAreaEstimaConser.text);
    int areaInfraestrutura = int.parse(_controllerAreaInfraestrutura.text);
    int areaOutrosUsos = int.parse(_controllerAreaOutro.text);

    PropriedadesApi propriedadesApi = PropriedadesApi();

    PropriedadesModel oProp = PropriedadesModel(
      idPropriedade: oPropModel.idPropriedade,
      Nome: _controllerNome.text,
      CNPJ: _controllerCNPJ.text,
      XCoord: xCoord,
      yCoord: yCoord,
      AreaPropriedade: areaPropriedade,
      AreaTotal: areaTotal,
      AreaPlantada: areaPlantada,
      AreaEstimaConservacao: areaEstimaConservacao,
      AreaInfraestrutura: areaInfraestrutura,
      AreaOutrosUsos: areaOutrosUsos,
      Localizacao: _controllerLocalizacao.text,
      UF: listUfSelecionado,
    );

    var messageReturn = await propriedadesApi.updatePropriedade(oProp);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(PropriedadesPage());
    }
  }

  _onClickAdd() async {
    if (_controllerXCoord.text == "" ||
        _controllerYCoord.text == "" ||
        _controllerAreaPropriedade.text == "" ||
        _controllerAreaTotal.text == "" ||
        _controllerAreaPlantada.text == "" ||
        _controllerAreaEstimaConser.text == "" ||
        _controllerAreaInfraestrutura.text == "" ||
        _controllerAreaOutro.text == "" ||
        _controllerNome.text == "" ||
        _controllerCNPJ.text == "" ||
        _controllerLocalizacao.text == "") {
      _onClickDialog();
      return;
    }
    int xCoord = int.parse(_controllerXCoord.text);
    int yCoord = int.parse(_controllerYCoord.text);
    int areaPropriedade = int.parse(_controllerAreaPropriedade.text);
    int areaTotal = int.parse(_controllerAreaTotal.text);
    int areaPlantada = int.parse(_controllerAreaPlantada.text);
    int areaEstimaConservacao = int.parse(_controllerAreaEstimaConser.text);
    int areaInfraestrutura = int.parse(_controllerAreaInfraestrutura.text);
    int areaOutrosUsos = int.parse(_controllerAreaOutro.text);


    PropriedadesApi propriedadesApi = PropriedadesApi();

    PropriedadesModel oProp = PropriedadesModel(
        idPropriedade: oPropModel.idPropriedade,
        Nome: _controllerNome.text,
        CNPJ: _controllerCNPJ.text,
        XCoord: xCoord,
        yCoord: yCoord,
        AreaPropriedade: areaPropriedade,
        AreaTotal: areaTotal,
        AreaPlantada: areaPlantada,
        AreaEstimaConservacao: areaEstimaConservacao,
        AreaInfraestrutura: areaInfraestrutura,
        AreaOutrosUsos: areaOutrosUsos,
        Localizacao: _controllerLocalizacao.text,
        UF: listUfSelecionado);

    var messageReturn = await propriedadesApi.createPropriedade(oProp);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(PropriedadesPage());
    }
  }

  _onClickDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 200,
            child: Center(
              child: Text("Preencher campos obrigatorios"),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(75, 171, 143, 30)),
              child: Text("Ok"),
            )
          ],
        ),
      );

  // String? _validateNome(String? value) {
  //    if (value!.isEmpty) {
  //     return "Nome não";
  //   }
  // }

  // String? _validateCnpj(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateXCoord(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateYCorrd(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaPropriedade(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaTotal(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaPlantada(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaEstimaConser(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaInfr(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaOutro(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateLocalizacao(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

}
