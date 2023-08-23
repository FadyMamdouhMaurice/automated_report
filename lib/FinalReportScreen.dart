import 'package:automated_report/shared/components/components.dart';
import 'package:automated_report/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'ReportScreen.dart';

class FinalReportScreen extends StatelessWidget {
  List data;
  List excelData = [];
  var excelColNum = 0, excelRowNum = 0, excelSheetNum = 0;
  String excelSheetName;
  List<ChartData> chartData = [];

  FinalReportScreen({
    required this.data,
    required this.excelData,
    required this.excelSheetNum,
    required this.excelRowNum,
    required this.excelColNum,
    required this.excelSheetName,
    required this.chartData,
  });

  var tableRows = <TableRow>[];

  @override
  Widget build(BuildContext context) {
    int x = 0;
    int cells = excelRowNum * excelColNum;

    for (int i = 0; i < excelRowNum; i++) {
      var cell = <Widget>[];
      for (int i = 0; i < excelColNum; i++) {
        cell.add(myCell(excelData[x].toString()));
        x++;
      }
      tableRows.add(TableRow(children: cell));
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/radar.png'), opacity: 900)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Table(
                              defaultColumnWidth: FixedColumnWidth(200.0),
                              border: TableBorder.all(color: primaryColorApp),
                              children: tableRows),
                        ),
                      ],
                    ),
                  ),
                  if (excelColNum == 2)
                    SfCartesianChart(
                      series: <ChartSeries>[
                        ColumnSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData c, _) => c.xAxis,
                            yValueMapper: (ChartData c, _) => c.yAxis)
                      ],
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift),
                      title: ChartTitle(text: excelSheetName),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getParagraph(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getParagraph() {
    List<Widget> childs = [];
    for (int i = 0; i < data.length; i++) {
      if (i % 2 == 0) {
        childs.add(myParagraph(
            data: data,
            i: i,
            leftPadding: 0,
            fontSize: 25,
            color: primaryColorApp,
            fontWeight: FontWeight.bold));
      } else {
        childs.add(myParagraph(
            data: data,
            i: i,
            leftPadding: 20,
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal));
      }
      childs.add(SizedBox(
        height: 10,
      ));
    }
    return childs;
  }

}
