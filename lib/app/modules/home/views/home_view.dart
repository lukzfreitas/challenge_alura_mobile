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
      backgroundColor: const Color(0xff373737),
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
                          logout: () => AppPages.logout(),
                        )
                      : Header(
                          amount: 'Carregando...',
                          logout: () => AppPages.logout(),
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
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionCard(
                          title: 'Depositar',
                          width: constraints.maxWidth / 3.5,
                          icon: IconsSvg.wallet,
                        ),
                        ActionCard(
                          title: 'Transferir',
                          width: constraints.maxWidth / 3.5,
                          icon: IconsSvg.cached,
                        ),
                        ActionCard(
                          title: 'Ler',
                          width: constraints.maxWidth / 3.5,
                          icon: IconsSvg.centerFoco,
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
