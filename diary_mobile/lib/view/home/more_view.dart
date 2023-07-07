/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  static Future<Route> route() async {
    return Utils.pageRouteBuilder(const MoreView(), false);
  }

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  final bool _isDeveloping = true;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ReportBloc>(
              create: (context) =>
                  ReportBloc(context, repository: context.read<Repository>())),
        ],
        child: Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: BkavAppBar(
              context,
              showDefaultBackButton: false,
              title: Text(S.of(context).more_label),
              backgroundColor: AppColor.main,
            ),
            body: GridView(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 6 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: <Widget>[
                  InkWell(
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          ListBillPage.route(false),
                        );
                      },
                      child: ItemMoreView(text: S.of(context).sell_label)),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push<void>(ListItemsPage.route());
                      },
                      child: ItemMoreView(text: S.of(context).items)),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PaymentMoneyListPage.route(0),
                        );
                      },
                      child: ItemMoreView(text: S.of(context).collect_money)),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PaymentMoneyListPage.route(1),
                        );
                      },
                      child: ItemMoreView(
                        text: S.of(context).pay,
                      )),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context)
                            .push<void>(await PaySlipReturnPage.route(true));
                      },
                      child: ItemMoreView(text: S.of(context).item_returned)),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context)
                            .push<void>(await PaySlipReturnPage.route(false));
                      },
                      child: ItemMoreView(
                        text: S.of(context).return_purchase,
                      )),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true).push<void>(
                            await InventoryPage.route(),
                        );
                      },
                      child: ItemMoreView(
                        text: S.of(context).inventory_check,
                      )),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true).push<void>(
                            await WarehousePage.route(),
                        );
                      },
                      child: ItemMoreView(text: S.of(context).ware_house)),
                  InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          CustomersListPage.route(),
                        );
                      },
                      child: ItemMoreView(
                        text: S.of(context).customer,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          SuppliersListPage.route(),
                        );
                      },
                      child: ItemMoreView(
                        text: S.of(context).supplier,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          StaffsListPage.route(),
                        );
                      },
                      child: ItemMoreView(
                        text: S.of(context).Staff,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          PayrollsListPage.route(),
                        );
                      },
                      child: ItemMoreView(
                        text: S.of(context).payroll,
                      )),
                  InkWell(
                      onTap: () {
                        if(_isDeveloping){
                          DiaLogManager.showDialogDevelopingFeature();
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DebtClearingPage(
                                    currentIndex: 0,
                                  )));
                        }

                      },
                      child: ItemMoreView(
                        text: S.of(context).Debt_deduction,
                      )),
                  BlocBuilder<ReportBloc, ReportState>(
                      builder: (context, state) {
                        return InkWell(
                            onTap: () async {
                              // fake du lieu
                              Map<String, List<Report>> groupReport =
                              Report.groupByGroupName(state.listReport??[]);
                              Navigator.of(context, rootNavigator: true).push<void>(
                                await ReportPage.route(groupReport),
                              );
                            },
                            child: ItemMoreView(
                              text: S.of(context).report,
                            ));
                      }),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          await InfoPage.route(),
                        );
                      },
                      child: ItemMoreView(text: S.of(context).account)),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          await SettingPage.route(),
                        );
                      },
                      child: ItemMoreView(text: S.of(context).setting)),
                  */
/*InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push<void>(AccountantConfigPage.route());
                      },
                      child: ItemMoreView(text: S.of(context).text_accountant)),*//*

                ])));
  }
}
*/
