import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/empty_widget.dart';
import 'package:manager/core/widgets/floating_button_add_widget.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/clients/clients_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:manager/features/clients_suppliers/presentation/pages/editor_client_supplier_page.dart';
import 'package:manager/features/clients_suppliers/presentation/widgets/item_client_widget.dart';
import '../widgets/search_bar_widget.dart';

class ClientsSuppliersPage extends StatelessWidget {
  final bool isClients;
  const ClientsSuppliersPage({super.key, required this.isClients});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClientsBloc()),
        BlocProvider(create: (context) => SuppliersBloc()),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
          child: CustomScrollView(
            slivers: [
              // AppBarWidget(isClients ? 'Clients' : 'Suppliers'),
              SliverList(
                  delegate: SliverChildListDelegate([
                if (isClients)
                  BlocBuilder<ClientsBloc, ClientsState>(
                      builder: (context, state) {
                    return SearchBarWidget(
                        bloc: Left(context.read<ClientsBloc>()));
                  })
                else
                  BlocBuilder<SuppliersBloc, SuppliersState>(
                      builder: (context, state) {
                    return SearchBarWidget(
                        bloc: Right(context.read<SuppliersBloc>()));
                  })
              ])),
              if (isClients)
                BlocBuilder<ClientsBloc, ClientsState>(
                  builder: (context, state) {
                    ClientsBloc bloc = context.read<ClientsBloc>();
                    bloc.add(ClientsGetAllEvent());
                    if (state is ClientsResultSearchState) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => ItemClientSupplierWidget(
                                  bloc: Left(bloc),
                                  client: bloc.resultSearch[index]),
                              childCount: bloc.resultSearch.length));
                    }
                    if (bloc.clients != null && bloc.clients!.isEmpty) {
                      return SliverToBoxAdapter(
                          child: EmptyWidget(
                              msg: 'msg_no_clients'.tr(),
                              nameLottieFile: 'clients'));
                    }
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => ItemClientSupplierWidget(
                                bloc: Left(bloc), client: bloc.clients![index]),
                            childCount: bloc.clients?.length ?? 0));
                  },
                )
              else
                BlocBuilder<SuppliersBloc, SuppliersState>(
                  builder: (context, state) {
                    SuppliersBloc bloc = context.read<SuppliersBloc>();
                    bloc.add(SuppliersGetAllEvent());
                    if (state is SuppliersResultSearchState) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => ItemClientSupplierWidget(
                                  bloc: Right(bloc),
                                  supplier: bloc.resultSearch[index]),
                              childCount: bloc.resultSearch.length));
                    }

                    if (bloc.suppliers != null && bloc.suppliers!.isEmpty) {
                      return SliverToBoxAdapter(
                          child: EmptyWidget(
                              msg: 'msg_no_suppliers'.tr(),
                              nameLottieFile: 'suppliers'));
                    }

                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => ItemClientSupplierWidget(
                                bloc: Right(bloc),
                                supplier: bloc.suppliers![index]),
                            childCount: bloc.suppliers?.length ?? 0));
                  },
                )
            ],
          ),
        ),
        floatingActionButton: isClients
            ? BlocBuilder<ClientsBloc, ClientsState>(
                builder: (context, state) {
                  ClientsBloc bloc = context.read<ClientsBloc>();
                  return _buttonAdd(isClients: isClients, bloc: Left(bloc));
                },
              )
            : BlocBuilder<SuppliersBloc, SuppliersState>(
                builder: (context, state) {
                  SuppliersBloc bloc = context.read<SuppliersBloc>();
                  return _buttonAdd(isClients: isClients, bloc: Right(bloc));
                },
              ),
      ),
    );
  }
}

// ignore: camel_case_types
class _buttonAdd extends StatelessWidget {
  const _buttonAdd({
    // ignore: unused_element
    super.key,
    required this.isClients,
    required this.bloc,
  });

  final bool isClients;
  final Either<ClientsBloc, SuppliersBloc> bloc;

  @override
  Widget build(BuildContext context) {
    return FloatingButtonAddWidget(
        onTap: () {
          bloc.fold((l) => l.resetDate, (r) => r.resetDate);
          Nav.to(EditorClientSupplierInfoPage(bloc: bloc));
        },
        title: bloc.fold(
            (l) => 'btn_add_client'.tr(), (r) => 'btn_add_supplier'.tr()));
  }
}
