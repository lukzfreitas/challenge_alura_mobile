import 'package:alura_challenge_mobile/app/core/utils/currency_format.dart';
import 'package:alura_challenge_mobile/app/core/utils/icon_svg.dart';
import 'package:alura_challenge_mobile/app/data/models/extract_model.dart';
import 'package:alura_challenge_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:alura_challenge_mobile/app/modules/home/widgets/actions_card.dart';
import 'package:alura_challenge_mobile/app/modules/home/widgets/activies_card.dart';
import 'package:alura_challenge_mobile/app/modules/home/widgets/header.dart';
import 'package:alura_challenge_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => FutureBuilder<ExtractModel>(
            future: controller.extractController(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot.hasData
                      ? Header(
                          amount: CurrencyFormat.currencyFormat(
                            amount: snapshot.data!.balance,
                            locale: 'en_US',
                            symbol: '\$',
                          ),
                          logout: () => controller.logoutController(),
                        )
                      : Header(
                          amount: 'Carregando...',
                          logout: () => controller.logoutController(),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: snapshot.hasData
                        ? ActiviesCard(
                            amount: CurrencyFormat.currencyFormat(
                              amount: snapshot.data!.totalExpense,
                              locale: 'en_US',
                              symbol: '\$',
                            ),
                          )
                        : const ActiviesCard(amount: 'Carregando...'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Ações da conta',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontSize: 23.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: ListView(
                      shrinkWrap: true,                      
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ActionCard(
                              title: 'Receitas',
                              width: constraints.maxWidth / 3.5,
                              icon: IconsSvg.wallet,
                              onClick: () => Get.toNamed(Routes.revenue),
                            ),
                            ActionCard(
                              title: 'Despesas',
                              width: constraints.maxWidth / 3.5,
                              icon: IconsSvg.cached,
                              onClick: () => Get.toNamed(Routes.expense),
                            ),
                            ActionCard(
                              title: 'Cadastrar Tipos de Despesas e Receitas',
                              width: constraints.maxWidth / 3.5,
                              icon: IconsSvg.centerFoco,
                              onClick: () => Get.toNamed(Routes.typeIncome),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ActionCard(
                              title: 'Últimas Receitas',
                              width: constraints.maxWidth / 3.5,
                              icon: IconsSvg.wallet,
                              onClick: () => Get.toNamed(Routes.revenueList),
                            ),
                            ActionCard(
                              title: 'Últimas Despesas',
                              width: constraints.maxWidth / 3.5,
                              icon: IconsSvg.cached,
                              onClick: () => Get.toNamed(Routes.expenseList),
                            ),
                            ActionCard(
                              title: 'Tipos de Despesas e Receitas',
                              width: constraints.maxWidth / 3.5,
                              icon: IconsSvg.centerFoco,
                              onClick: () => Get.toNamed(Routes.typeIncomeList),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
