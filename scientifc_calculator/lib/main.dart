import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var input = '';
  var output = '';

  onButtonClick(value) {
    if(value == 'C'){
input = '';
output = '';
}else if(value == '<'){
  if(input.isNotEmpty){
  input = input.substring(0, input.length - 1);
  }
}else if(value == '='){
    if(input.isNotEmpty){
       try {
         
  var userInput = input;
  Parser p = Parser();
  Expression expression = p.parse(userInput);
  ContextModel cm = ContextModel();
  var fvalue = expression.evaluate(EvaluationType.REAL, cm);
  output = fvalue.toString();
  input = output;
       } catch (e) {
         output = "Error";
       }
  }
}else{
  input += value;
}
setState(() {
  
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Saaria Calculator", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      input,
                      style: const TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      output,
                      style: TextStyle(
                        fontSize: 34, color: Colors.white.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[800]),
          // Scientific Buttons Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SciBtn(text: 'sin('),
                SciBtn(text: 'cos('),
                SciBtn(text: 'tan('),
                SciBtn(text: 'log('),
                SciBtn(text: 'ln('),
                SciBtn(text: 'sqrt('),
                SciBtn(text: '^'),
                SciBtn(text: '('),
                SciBtn(text: ')'),
              ],
            ),
          ),
          // Calculator Buttons
          Row(
            children: [
              CalBtn(text: 'C', backColor: opperatorColor, tcolor: Colors.red),
              CalBtn(text: '00', backColor: opperatorColor),
              CalBtn(text: '%', backColor: opperatorColor),
              CalBtn(text: '/', backColor: opperatorColor),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalBtn(text: '7'),
              CalBtn(text: '8'),
              CalBtn(text: '9'),
              CalBtn(text: '*', backColor: opperatorColor),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalBtn(text: '4'),
              CalBtn(text: '5'),
              CalBtn(text: '6'),
              CalBtn(text: '-', backColor: opperatorColor),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalBtn(text: '1'),
              CalBtn(text: '2'),
              CalBtn(text: '3'),
              CalBtn(text: '+', backColor: opperatorColor),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalBtn(text: '.'),
              CalBtn(text: '0'),
              CalBtn(text: '<'),
              CalBtn(text: '=', backColor: opptextColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget CalBtn({text, tcolor = Colors.white, backColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22.0),
            backgroundColor: backColor,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            onButtonClick(text);
          },
          child: Text(
            "$text",
            style: TextStyle(color: tcolor, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget SciBtn({text, tcolor = Colors.white, backColor = buttonColor}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(18.0),
          backgroundColor: backColor,
          shape: const CircleBorder(),
        ),
        onPressed: () {
          onButtonClick(text);
        },
        child: Text(
          "$text",
          style: TextStyle(color: tcolor, fontSize: 24),
        ),
      ),
    );
  }
}

const buttonColor = Color(0xff191919);
const opperatorColor = Color(0xff262626);
const opptextColor = Colors.green;
