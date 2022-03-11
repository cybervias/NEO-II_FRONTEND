import 'package:flutter/material.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_page.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_page.dart';
import 'package:neo_application/pages/default_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:neo_application/pages/utils/nav.dart';
import 'package:provider/provider.dart';

class SubListTile extends StatefulWidget {
  const SubListTile({Key? key}) : super(key: key);

  @override
  State<SubListTile> createState() => _SubListTileState();
}

class _SubListTileState extends State<SubListTile> {
  var selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _paindelAtividade(context, "Default Page", DefaultPage()),
        _expansionTileLider(),
        _expansionTileAuditorLider(),
        _expansionTileAuditor(),
        _expansionTileGrupos(),
        _expansionTileConfig()
      ],
    );
  }

  _paindelAtividade(context, String title, Widget page) {
    return ListTile(
      leading: const Icon(
        Icons.analytics_outlined,
        color: Colors.white,
        size: 15,
      ),
      title: const Text(
        "Painel de Atividades",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      onTap: () {
        AppModel app = Provider.of<AppModel>(context, listen: false);
        app.setPage(page);
      },
    );
  }

  _expansionTileLider() {
    return const ExpansionTile(
      leading: Icon(
        Icons.gavel_outlined,
        color: Colors.white,
        size: 15,
      ),
      title: Text(
        "Lider de Experiência",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      children: [
        ListTile(
          title: Text(
            "Transferidos do Bitrix",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Atribuir Lider",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  _expansionTileAuditorLider() {
    return const ExpansionTile(
      leading: Icon(
        Icons.article_outlined,
        color: Colors.white,
        size: 15,
      ),
      title: Text(
        "Auditoria Líder",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      children: [
        ListTile(
          title: Text(
            "Painel de Acompanhamento",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Distribuir Equipe",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Revisar Itens",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Gerar Relatório Final",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  _expansionTileAuditor() {
    return const ExpansionTile(
      leading: Icon(
        Icons.visibility_outlined,
        color: Colors.white,
        size: 15,
      ),
      title: Text(
        "Auditor",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      children: [
        ListTile(
          title: Text(
            "Painel de Acompanhamento",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Preencher itens",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Detalhes de Conformidades",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  _expansionTileGrupos() {
    return ExpansionTile(
      leading: Icon(
        Icons.group,
        color: Colors.white,
        size: 15,
      ),
      title: Text(
        "Clientes/Grupos",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      children: [
        ListTile(
          title: Text(
            "Lista de Clientes",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Entidades Gestoras",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          onTap: () {
            AppModel app = Provider.of<AppModel>(context, listen: false);
            app.setPage(EntidadesPage());
          },
        ),
        ListTile(
          title: Text(
            "Propriedades",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          onTap: () {
            AppModel app = Provider.of<AppModel>(context, listen: false);
            app.setPage(PropriedadesPage());
          },
        ),
        ListTile(
          title: Text(
            "Administração de Grupos",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "Controle de Escopo",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  _expansionTileConfig() {
    return const ExpansionTile(
      leading: Icon(
        Icons.settings,
        color: Colors.white,
        size: 15,
      ),
      title: Text(
        "Configurações",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      children: [
        ListTile(
          title: Text(
            "00 - Sistemas de Certificação",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "01-Tipos de Auditoria",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "02 - Modelos de Relatório",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "03 - Itens dos Modelos de",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "04 - Normas",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "10 - Tipos de Manejo",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "11 - Tipos de Floresta",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "12 - Produtos",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "20 - Qualificações",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        ListTile(
          title: Text(
            "21 - Funções",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
