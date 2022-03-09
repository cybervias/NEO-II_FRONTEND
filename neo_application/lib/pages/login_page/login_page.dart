import 'package:flutter/material.dart';
import 'package:neo_application/pages/home_page/home_page.dart';
import 'package:neo_application/pages/utils/nav.dart';
import 'package:neo_application/pages/widgets/app_button.dart';
import 'package:neo_application/pages/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_bg_agro.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            height: 350,
            width: 400,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(75, 171, 143, 30),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 76,
                  child: const Center(
                    child: Text(
                      "NEO ANALYTICS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppText(
                  "Usuário",
                  Icon(Icons.person),
                  "Digite seu usuário",
                  controller: _tLogin,
                  validator: _validateLogin,
                  textInputAction: TextInputAction.next,
                  nextFocus: _focusSenha,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Senha",
                  Icon(Icons.lock),
                  "Digite sua senha",
                  password: true,
                  controller: _tSenha,
                  validator: _validateSenha,
                  keyboardType: TextInputType.number,
                  focusNode: _focusSenha,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                  "Acessar",
                  onPressed: _onClickLogin,
                  showProgress: _showProgress,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _onClickLogin() async {
    bool formOk = _formKey.currentState!.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Login: $login, Senha: $senha");
    push(context, const HomePage());
  }

  String? _validateLogin(String? text) {
    if (text!.isEmpty) {
      return "Digite o login";
    }
  }

  String? _validateSenha(String? text) {
    if (text!.isEmpty) {
      return "Digite a senha";
    }
  }
}
