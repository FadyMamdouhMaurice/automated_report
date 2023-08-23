import 'package:automated_report/FinalReportScreen.dart';
import 'package:automated_report/ReportScreen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: FinalReportScreen(data: ['Headline','Your words matter, and our paraphrasing tool is designed to ensure you use the right ones. With unlimited Custom modes and 7 predefined modes, Paraphraser lets you rephrase text countless ways. Our product will improve your fluency while also ensuring you have the appropriate vocabulary, tone, and style for any occasion. Simply enter your text into the input box, and our AI will work with you to create the best paraphrase.','Headline2','Your words matter, and our paraphrasing tool is designed to ensure you use the right ones. With unlimited Custom modes and 7 predefined modes, Paraphraser lets you rephrase text countless ways. Our product will improve your fluency while also ensuring you have the appropriate vocabulary, tone, and style for any occasion. Simply enter your text into the input box, and our AI will work with you to create the best paraphrase.'], excelData: ['fady','fady','fady','fady','fady','fady',], excelSheetNum: 1, excelRowNum: 2, excelColNum: 3,),
      home: ReportScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
