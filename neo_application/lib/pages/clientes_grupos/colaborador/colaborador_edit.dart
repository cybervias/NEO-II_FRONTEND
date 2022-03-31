import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/colaborador/colaborador_api.dart';
import 'package:neo_application/pages/clientes_grupos/colaborador/colaborador_model.dart';
import 'package:neo_application/pages/clientes_grupos/colaborador/colaborador_page.dart';
import 'package:neo_application/pages/login_page/login_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';


class ColaboradorEdit extends StatefulWidget {
  ColaboradorModel colaboradorModel;
  var tipoAcao;

  ColaboradorEdit({
    Key? key,
    required this.colaboradorModel,
    this.tipoAcao,
  }) : super(key: key);

  @override
  State<ColaboradorEdit> createState() => _ColaboradorEditState();
}

class _ColaboradorEditState extends State<ColaboradorEdit> {
  Size get size => MediaQuery.of(context).size;
  late ColaboradorModel oColaborador;
  late String _valueEntrada;

  final TextEditingController _controlleridAuditor = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerDataInicio = TextEditingController();
  final TextEditingController _controllerEspecialidade =
      TextEditingController();
  final TextEditingController _controllerqAuditor = TextEditingController();
  final TextEditingController _controllerqAuditorLider =
      TextEditingController();
  final TextEditingController _controllerqLiderExperiencia =
      TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

  late AppModel appRepository;
  late ColaboradorModel oColaboradorModel;

  List<ColaboradorModel> listColaborador = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _setText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oColaboradorModel = widget.colaboradorModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text("Usuário"),
        backgroundColor: Color.fromRGBO(78, 204, 196, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() {
    oColaborador = widget.colaboradorModel;
    _controlleridAuditor.text = oColaborador.idAuditor.toString();
    _controllerNome.text = oColaborador.Nome.toString();
    _controllerDataInicio.text = oColaborador.DataInicio.toString();
    _controllerEspecialidade.text = oColaborador.Especialidade.toString();
    _controllerqAuditor.text = oColaborador.qAuditor.toString();
    _controllerqAuditorLider.text = oColaborador.qAuditorLider.toString();
    _controllerqLiderExperiencia.text =
        oColaborador.qLiderExperiencia.toString();
    _controllerUsuario.text = oColaborador.Usuario.toString();
  }

  _body() {
    return FutureBuilder(
      future: ColaboradorApi().getListColaborador(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          listColaborador = snapshot.data;
          if (listColaborador.isNotEmpty) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Card(
                  child: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Column(
                        children: [
                          Container(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 40,
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
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _controllerUsuario,
                                        decoration: const InputDecoration(
                                          labelText: "Usuário",
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
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _controllerEspecialidade,
                                        decoration: const InputDecoration(
                                          labelText: "Especialidade",
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
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _controllerqAuditor,
                                        decoration: const InputDecoration(
                                          labelText: "Auditor",
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
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _controllerqAuditorLider,
                                        decoration: const InputDecoration(
                                          labelText: "Auditor Líder",
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
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        controller:
                                            _controllerqLiderExperiencia,
                                        decoration: const InputDecoration(
                                          labelText: "Lider de Experiência",
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
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        controller: _controllerDataInicio,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          labelText: "Data de Início",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.date_range,
                                              color: Color.fromARGB(
                                                  96, 88, 87, 87),
                                              size: 20,
                                            ),
                                            onPressed: () async {
                                              final data = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                              );
                                              if (data != null)
                                                setState(() => _valueEntrada =
                                                    data.toString());

                                              _controllerDataInicio
                                                  .text = _valueEntrada
                                                      .substring(8, 10) +
                                                  '/' +
                                                  _valueEntrada.substring(
                                                      5, 7) +
                                                  '/' +
                                                  _valueEntrada.substring(0, 4);

                                              print(_controllerDataInicio.text);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _Buttons()
                        ],
                      );
                    }),
                  ),
                ),
              ),
            );
          } else {
            Fluttertoast.showToast(
                msg: "Usuario não autorizado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 10,
                fontSize: 16.0);

            SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _Buttons() {
    return Container(
      alignment: Alignment.bottomRight,
      child: ButtonBar(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 34, 37, 44)),
            onPressed: () => _onClickSalvar(),
            child: Text("Salvar Alterações"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 34, 37, 44)),
            onPressed: () => {appRepository.setPage(ColaboradorPage())},
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  _onClickSalvar() async {
    if (_controllerNome.text == "" || _controllerEspecialidade.text == "") {
      _onClickDialog();
      return;
    }
    
    var DataInicio = _controllerDataInicio.text.substring(3, 5) +
        '/' +
        _controllerDataInicio.text.substring(0, 2) +
        '/' +
        _controllerDataInicio.text.substring(6, 10);

    ColaboradorApi colaboradorApi = ColaboradorApi();

    ColaboradorModel oColaborador = ColaboradorModel(
      idAuditor: widget.colaboradorModel.idAuditor,
      Nome: _controllerNome.text,
      DataInicio: DataInicio.toString(),
      Especialidade: _controllerEspecialidade.text,
      qAuditor: _controllerqAuditor.text,
      qAuditorLider: _controllerqAuditorLider.text,
      qLiderExperiencia: _controllerqLiderExperiencia.text,
      Usuario: _controllerUsuario.text,
    );

    var messageReturn = await colaboradorApi.updateColaborador(oColaborador);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(ColaboradorPage());
    } else if (messageReturn["type"] == "U") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          fontSize: 16.0);

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          fontSize: 16.0);
    }
  }

  _onClickDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 60,
            child: Center(
              child: ListTile(
              leading: Icon(Icons.warning,
              color: Colors.orange,
              size: 30,),
              title: Text('Preencha os campos obrigatórios.',
             style: TextStyle(fontSize: 20),
             ),
              subtitle: Text('Nome, Especialidade.',
              style: TextStyle(fontSize: 18),
              ),
            ),
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
}
