import 'package:automated_report/FinalReportScreen.dart';
import 'package:automated_report/shared/components/components.dart';
import 'package:automated_report/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var headline = TextEditingController();

  var paragraph = TextEditingController();

  List lData = [];

  List excelData = [];

  var excelColNum = 0, excelRowNum = 0, excelSheetNum = 0;
  late String excelSheetName;
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Grey BOX
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[500],
                ),
              ],
            ),
            SizedBox(
              height: 140,
            ),
            //TextField and Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //Headline and Paragraph and add button
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text('Headline',
                                      style: TextStyle(
                                        color: secondaryColorApp,
                                        fontSize: 20,
                                      )),
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: myTextFormField(
                                      controller: headline,
                                      label: 'Headline',
                                      textInputType:
                                          TextInputType.text),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text('Paragraph',
                                      style: TextStyle(
                                        color: secondaryColorApp,
                                        fontSize: 20,
                                      )),
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: myTextFormField(
                                      controller: paragraph,
                                      label: 'Paragraph',
                                      textInputType:
                                          TextInputType.text),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            //Add Button
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  if (headline.text != '' &&
                                      paragraph.text != '') {
                                    lData.add(headline.text);
                                    lData.add(paragraph.text);
                                    headline.clear();
                                    paragraph.clear();
                                    setState(() {});
                                  }
                                  else {
                                    //print('Must write headline and paragraph');
                                  }
                                },
                                child: Text(
                                  'Add'.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColorApp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  // Browse Button
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {
                        var name, age;
                        //Browse Windows
                        FilePickerResult? pickedFile =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['xlsx'],
                        );
                        // If browse is done
                        if (pickedFile != null) {
                          List<String> rowdetail = [];
                          //pickedFile.paths.single = get path of Excel when browse
                          var filePath = pickedFile.paths.single;
                          var bytes = File(filePath!).readAsBytesSync();
                          var excel = Excel.decodeBytes(bytes);
                          if (excel.sheets.length > 1) {
                            //Check Num. Of Sheets in Excel File
                            print(
                                'Your Excel File has more than one Sheet');
                            /*Fluttertoast.showToast(
                                msg:
                                    'Your Excel File has more than one Sheet',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);*/
                          } else {
                            excelSheetName= excel.sheets.keys.toString(); //get sheet Name
                            //table = sheet name,this for it's loop in all Sheets in Excel
                            for (var table in excel.tables.keys) {
                              excelSheetNum++;
                              //this for it's loop in all Rows in Sheet
                              //excel.tables[table]!.rows, it's return number of rows
                              for (var row
                                  in excel.tables[table]!.rows) {
                                excelRowNum++;
                                rowdetail.add(row.toString());
                                /*Sheet sheetObject = excel['Sheet1'];
                              name = sheetObject.cell(
                                  CellIndex.indexByColumnRow(
                                      columnIndex: 1, rowIndex: 1));*/
                                //excel.tables[table]!.maxCols, it's return number of columns
                                for (var index = 0;
                                    index <
                                        excel.tables[table]!.maxCols;
                                    index++) {
                                  excelColNum++;
                                  //print(row[index]!.value);
                                  excelData.add(row[index]!.value);
                                }

                                //print(row[0]!.value);
                                //print(row[1]!.value);
                                //print(excel.tables[table]!.maxCols);
                              }
                            }
                            //print(excelSheetNum);
                            //print(excelColNum /(excelRowNum / excelSheetNum));
                            //print(excelRowNum);
                            //print(excelData);
                            //print(excelSheetName);
                            //print(rowdetail[5]);
                            //print(rowdetail.length);
                            /*chartData = getChartData();
                            print(chartData);
                            print('wwwwwwwwwwwwwwwwwwwwwwwwww');*/
                          }
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Text(
                        'Browse'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColorApp,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Create Button
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {
                        excelColNum = (excelColNum /
                                (excelRowNum / excelSheetNum))
                            .toInt();
                        await getChartData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinalReportScreen(
                              data: lData,
                              excelData: excelData,
                              excelColNum: excelColNum,
                              excelRowNum: excelRowNum,
                              excelSheetNum: excelSheetNum,
                              excelSheetName: excelSheetName,
                              chartData: chartData,
                            ),
                          ),
                        );
                        /*var file =
                            'E:\New Microsoft Excel Worksheet.xlsx';
                        var bytes = File(file).readAsBytesSync();
                        var excel = Excel.decodeBytes(bytes);

                        for (var table in excel.tables.keys) {
                          print(table); //sheet Name
                          print(excel.tables[table]?.maxCols);
                          print(excel.tables[table]?.maxRows);
                          for (var row in excel.tables[table]!.rows) {
                            print('$row');
                          }
                        }*/
                      },
                      child: Text(
                        'Create'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColorApp,
                    ),
                  ),
                ],
              ),
            ),
            //Statsbomb Image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/statsbomb.png',
                      scale: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
  List<ChartData> getChartData() {
    for (int i = 0; i < excelData.length; i++) {
      if (i % 2 == 0) {
        chartData.add(ChartData(excelData[i].toString(),excelData[i+1]));
      }
    }
    return chartData;
  }
}

class ChartData {
  ChartData(this.xAxis, this.yAxis);
  final String xAxis;
  final int yAxis;
}