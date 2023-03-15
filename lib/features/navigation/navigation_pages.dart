import 'package:easy_localization/easy_localization.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';
import 'package:manager/features/clients_suppliers/presentation/pages/controller_clients_suppliers_page.dart';
import 'package:manager/features/expenses/presentation/pages/expenses_page.dart';
import 'package:manager/features/operations/presentation/pages/operations_page.dart';
import 'package:manager/features/store/presentation/pages/store_page.dart';

class NavigationPages extends StatefulWidget {
  final int? pageNumber;
  const NavigationPages({super.key, this.pageNumber});

  @override
  State<NavigationPages> createState() => _NavigationPagesState();
}

class _NavigationPagesState extends State<NavigationPages> {
  final List<Map<String, dynamic>> _pages = [
    // {'label': 'Home', 'icon': Icons.home, 'page': DashboardPage()},
    // {'label': 'Products', 'icon': Icons.work, 'page': ProductsPage()},
    {
      'label': 'title_operations'.tr(),
      'icon': Icons.transform_outlined,
      'page': const OperationsPage()
    },
    {
      'label': 'title_expenses'.tr(),
      'icon': Icons.money_off_rounded,
      'page': const ExpensesPage()
    },
    {
      'label': 'partners'.tr(),
      'icon': Icons.group,
      'page': const ControllerClientsSuppliersPage()
    },
    {
      'label': 'title_stock'.tr(),
      'icon': Icons.store,
      'page': const StorePage()
    },
  ];

  FlashyTabBarItem itemNavigation(Map<String, dynamic> pageData) {
    return FlashyTabBarItem(
      inactiveColor: colorScheme.secondary,
      activeColor: colorScheme.primary,
      icon: Icon(pageData['icon'], size: Sizes.size(12)),
      title:
          Text(pageData['label'], style: Fonts.t5(fontWeight: FontWeight.w600)),
    );
  }

  late int currentIndexPage;

  @override
  void initState() {
    currentIndexPage = widget.pageNumber ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndexPage]['page'],
      bottomNavigationBar: FlashyTabBar(
          backgroundColor: colorScheme.background,
          selectedIndex: currentIndexPage,
          showElevation: true,
          onItemSelected: (index) => setState(() {
                currentIndexPage = index;
              }),
          items: List.generate(
              _pages.length, (index) => itemNavigation(_pages[index]))),
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: currentIndexPage,
      //     backgroundColor: colorScheme.background,
      //     elevation: 10,
      //     items: List.generate(
      //         _pages.length, (index) => itemNavigation(_pages[index]))),
    );
  }
}
