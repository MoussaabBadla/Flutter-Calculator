import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.height * 0.2 * buttonHeight,
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        padding: EdgeInsets.all(8),
        child: NeumorphicButton(
            style: NeumorphicStyle(
                color: buttonColor,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                shape: NeumorphicShape.flat),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff728AB7)),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17181A),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              children: [
                buildButton("C", 1, Color(0xffD4D4D2)),
                buildButton("⌫", 1, Color(0xffD4D4D2)),
                buildButton("%", 1, Color(0xffD4D4D2)),
                buildButton("7", 1, Color(0xff505050)),
                buildButton("8", 1, Color(0xff505050)),
                buildButton("9", 1, Color(0xff505050)),
                buildButton("4", 1, Color(0xff505050)),
                buildButton("5", 1, Color(0xff505050)),
                buildButton("6", 1, Color(0xff505050)),
                buildButton("1", 1, Color(0xff505050)),
                buildButton("2", 1, Color(0xffF505050)),
                buildButton("3", 1, Color(0xff505050)),
                buildButton(".", 1, Color(0xff505050)),
                buildButton("0", 1, Color(0xff505050)),
                buildButton("00", 1, Color(0xff505050)),
                buildButton("÷", 1, Color(0xffFF9500)),
                buildButton("×", 1, Color(0xffFF9500)),
                buildButton("-", 1, Color(0xffFF9500)),
                buildButton("+", 1, Color(0xffFF9500)),
                buildButton("=", 1, Color(0xffFF9500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
