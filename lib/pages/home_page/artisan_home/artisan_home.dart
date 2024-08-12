import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../state_managers/user_data_state.dart';
import 'dashboard_card.dart';

class ArtisanHome extends ConsumerStatefulWidget {
  const ArtisanHome({super.key});

  @override
  ConsumerState<ArtisanHome> createState() => _ArtisanHomeState();
}

class _ArtisanHomeState extends ConsumerState<ArtisanHome> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    return Column(children: [
      Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )),
        child: ListTile(
          title: Text(
            'Welcome!',
            style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          subtitle: Text(
            user.name,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor.withOpacity(.4),
        ),
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Artisan Category: ',
                    style: normalText(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                TextSpan(
                    text: user.artisanCategory ?? '',
                    style:
                        normalText(fontWeight: FontWeight.w700, fontSize: 16))
              ]),
            ),
            subtitle: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'You will pay a commission of 10% to the platform.',
                  style:
                      normalText(fontWeight: FontWeight.w500, fontSize: 16)),
            ]))),
      ),
      const Wrap(
        children: [
          DashBoardCard(
            title: 'Total Earnings',
            number: 'GHC 0.00',
            icon: Icons.monetization_on_outlined,
          ),
          DashBoardCard(
            title: 'Total Request',
            number: '47',
            icon: Icons.monetization_on_outlined,
          ),
          DashBoardCard(
            title: 'Pending Request',
            number: '5',
            icon: Icons.monetization_on_outlined,
          ),
          DashBoardCard(
            title: 'Complete Request',
            number: '42',
            icon: Icons.monetization_on_outlined,
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Expanded(
          child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales)
          ])),
    ]);
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
