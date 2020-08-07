import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFF0F3857),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                color: Color(0xFF0B5B78),
                padding: EdgeInsets.only(top: 35.0, right: 20.0),
                height: 80.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "w",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF0B5B78),
                height: 80.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "=",
                        style: TextStyle(color: Colors.white, fontSize: 40.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "W",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10.0,
                color: Color(0xFF0A768E),
                thickness: 3.0,
              ),
              Wrap(
                children: <Widget>[
                  CalcButton(
                    value: "C",
                    buttonColor: Colors.lightBlueAccent,
                  ),
                  CalcButton(value: "%", buttonColor: Colors.lightBlueAccent),
                  CalcButton(value: "÷", buttonColor: Colors.lightBlueAccent),
                  CalcButton(value: "X", buttonColor: Colors.lightBlueAccent),
                ],
              ),
              Wrap(
                children: <Widget>[
                  CalcButton(
                    value: "7",
                    buttonColor: Colors.white,
                  ),
                  CalcButton(value: "8", buttonColor: Colors.white),
                  CalcButton(value: "9", buttonColor: Colors.white),
                  CalcButton(value: "-", buttonColor: Colors.lightBlueAccent),
                ],
              ),
              Wrap(
                children: <Widget>[
                  CalcButton(value: "4", buttonColor: Colors.white),
                  CalcButton(value: "5", buttonColor: Colors.white),
                  CalcButton(value: "6", buttonColor: Colors.white),
                  CalcButton(value: "+", buttonColor: Colors.lightBlueAccent),
                ],
              ),
              Wrap(
                children: <Widget>[
                  CalcButton(value: "1", buttonColor: Colors.white),
                  CalcButton(value: "2", buttonColor: Colors.white),
                  CalcButton(value: "3", buttonColor: Colors.white),
                  CalcButton(value: "()", buttonColor: Colors.lightBlueAccent),
                ],
              ),
              Wrap(
                children: <Widget>[
                  CalcButton(value: "0", buttonColor: Colors.white),
                  CalcButton(value: ".", buttonColor: Colors.white),
                  CalcButton(value: "←", buttonColor: Colors.white),
                  CalcButton(value: "=", buttonColor: Colors.lightBlueAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalcButton extends StatefulWidget {
  final String value;
  final Color buttonColor;
  final Function calculate;

  CalcButton({this.value, this.buttonColor, this.calculate});

  @override
  _CalcButtonState createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  @override
  Widget build(BuildContext context) {
    String value = widget.value;

    return Container(
      width: 102.0,
      height: 100.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: Color(0xFF123962),
        width: 2.0,
      )),
      child: RaisedButton(
        elevation: 0,
        color: Color(0xFF0F3857),
        onPressed: () => widget.calculate,
        child: Text(
          value,
          style: TextStyle(color: widget.buttonColor, fontSize: 35.0),
        ),
      ),
    );
  }
}

class CoolCalculator extends StatefulWidget {
  @override
  _CoolCalculatorState createState() => _CoolCalculatorState();
}

class _CoolCalculatorState extends State<CoolCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "←") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "X") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
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
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Container(
      height: 100.0,
      width: 102.0,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Color(0xFF123962),
                  width: 2,
                  style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            color: Color(0xFF0B5B78),
            padding: EdgeInsets.only(top: 30.0, right: 35.0),
            height: 90.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    equation,
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFF0B5B78),
            height: 91.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  child: Text(
                    "=",
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 50.0, color: Colors.white),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2.0,
            thickness: 1.0,
            color: Color(0xFF0A768E),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 309.0,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", Color(0xFF0F3858)),
                      buildButton("%", Color(0xFF0F3858)),
                      buildButton("÷", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("7", Color(0xFF0F3858)),
                      buildButton("8", Color(0xFF0F3858)),
                      buildButton("9", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("4", Color(0xFF0F3858)),
                      buildButton("5", Color(0xFF0F3858)),
                      buildButton("6", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("1", Color(0xFF0F3858)),
                      buildButton("2", Color(0xFF0F3858)),
                      buildButton("3", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("0", Color(0xFF0F3858)),
                      buildButton(".", Color(0xFF0F3858)),
                      buildButton("←", Color(0xFF0F3858)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: 102.0,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("-", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("+", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("()", Color(0xFF0F3858)),
                    ]),
                    TableRow(children: [
                      buildButton("=", Color(0xFF0F3858)),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
