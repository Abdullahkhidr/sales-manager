import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/core/services/navigation.dart';
import 'package:manager/core/theme_app/sizes_app.dart';
import 'package:manager/core/widgets/app_bar_widget.dart';
import 'package:manager/core/widgets/empty_widget.dart';
import 'package:manager/core/widgets/floating_button_add_widget.dart';
import 'package:manager/core/widgets/operation_widget.dart';
import 'package:manager/features/operations/presentation/bloc/operations/operations_bloc.dart';
import 'package:manager/features/operations/presentation/pages/editor_operation_page.dart';
import 'package:manager/features/operations/presentation/widgets/search_bar_widget.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OperationsBloc(),
        child: BlocBuilder<OperationsBloc, OperationsState>(
          builder: (context, state) {
            OperationsBloc bloc = context.read<OperationsBloc>();
            if (state is OperationsInitial) bloc.add(OperationsGetAllEvent());

            return Scaffold(
              body: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Sizes.paddingScreen.left),
                child: CustomScrollView(
                  slivers: [
                    AppBarWidget('title_operations'.tr()),
                    SliverList(
                        delegate: SliverChildListDelegate(
                            [OperationsSearchBarWidget(bloc: bloc)])),
                    if (bloc.operations != null && bloc.operations!.isEmpty)
                      SliverToBoxAdapter(
                          child: EmptyWidget(
                              msg: 'msg_not_found_operations'.tr(),
                              nameLottieFile: 'office_accountant')),
                    if (state is OperationsResultSearchState)
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => ItemOperationWidget(
                                  operation: state.operations[index]),
                              childCount: state.operations.length))
                    else
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => ItemOperationWidget(
                                  operation: bloc.operations![index]),
                              childCount: bloc.operations?.length ?? 0))
                  ],
                ),
              ),
              floatingActionButton: FloatingButtonAddWidget(
                onTap: () {
                  Nav.to(const EditorOperationPage());
                },
                title: 'btn_add_operation'.tr(),
              ),
            );
          },
        ));
  }
}
