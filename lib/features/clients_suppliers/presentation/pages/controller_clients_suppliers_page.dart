import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/widgets/space_widget.dart';
import 'package:manager/core/widgets/tab_widget.dart';
import 'package:manager/features/clients_suppliers/presentation/pages/clients_suppliers_page.dart';

class ControllerClientsSuppliersPage extends StatelessWidget {
  const ControllerClientsSuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Column(children: [
              TabBar(tabs: [
                TabWidget(title: 'title_clients'.tr()),
                TabWidget(title: 'title_suppliers'.tr()),
              ]),
              const Space(isH: true, count: 4),
              const Expanded(
                child: TabBarView(children: [
                  ClientsSuppliersPage(isClients: true),
                  ClientsSuppliersPage(isClients: false),
                ]),
              )
            ])),
      ),
    );
  }
}
