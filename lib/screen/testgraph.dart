import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';




class BarChartWithSecondaryAxis extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  DashboardController dashboardController = Get.put(DashboardController());



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    _createSampleData();
    return Container(
      width:width,
      height: height,
      color: Colors.white,

      child:

     Center(
       child: SingleChildScrollView(
         scrollDirection: Axis.horizontal,
         child:
         Container(
           color: Colors.white70,
           width: width,
           height: height*0.5,
           child:  charts.BarChart(
             _createSampleData(),
             animate: true,
             //domainAxis: new charts.OrdinalAxisSpec(),
             domainAxis: charts.OrdinalAxisSpec(
               renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
             ),
             animationDuration: Duration(seconds: 2),
             flipVerticalAxis: false,
             barGroupingType: charts.BarGroupingType.grouped,
             // It is important when using both primary and secondary axes to choose
             // the same number of ticks for both sides to get the gridlines to line
             // up.
             primaryMeasureAxis: const charts.NumericAxisSpec(
                 tickProviderSpec:
                 charts.BasicNumericTickProviderSpec(desiredTickCount:5)),
             secondaryMeasureAxis: const charts.NumericAxisSpec(
                 tickProviderSpec:
                 charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
           ),
         ),
       ),
     ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      OrdinalSales('JAIN', 6000),
      OrdinalSales('FMEB', 3560),
      OrdinalSales('MUAR', 1000),
      OrdinalSales('SDHF', 1400),
      OrdinalSales('JAGN', 1000),
      OrdinalSales('FQEB', 9500),
      OrdinalSales('MAR', 6000),
      OrdinalSales('SEDF', 2500),
      OrdinalSales('JFAN', 2800),
      OrdinalSales('FDEB', 1000),
      OrdinalSales('MSAR', 6000),
      OrdinalSales('SDSF', 1800),
    ];

    final losAngelesSalesData = [
      OrdinalSales('JAIN', 1000),
      OrdinalSales('FMEB', 500),
      OrdinalSales('MUAR', 1000),
      OrdinalSales('SDHF', 1400),
      OrdinalSales('JAGN', 1000),
      OrdinalSales('FQEB', 5500),
      OrdinalSales('MAR', 4000),
      OrdinalSales('SEDF', 3000),
      OrdinalSales('JFAN', 1800),
      OrdinalSales('FDEB', 1500),
      OrdinalSales('MSAR', 9000),
      OrdinalSales('SDSF', 1400),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,

      ),
      charts.Series<OrdinalSales, String>(
        id: 'Los Angeles Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: losAngelesSalesData,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
      // Set the 'Los Angeles Revenue' series to use the secondary measure axis.
      // All series that have this set will use the secondary measure axis.
      // All other series will use the primary measure axis.
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
