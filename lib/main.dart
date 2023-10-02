import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(),
      home: const Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // final List extraButtons = ['AC', 'DE', 'LO', 'RA'];
  final List primaryButtons = ['AC', '+/-', '%', '/'];
  final List secundaryButtons = ['7', '8', '9', 'x'];
  final List thirdsButtons = ['4', '5', '6', '-'];
  final List fourthButtons = ['1', '2', '3', '+'];
  final List finalButtons = ['.', '='];

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: 90,
      height: 90,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
        ),
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        onPressed: () {
          calculation(btntxt);
        },
      ),
    );
  }

  Widget constructRow(list, dynamic opccionalColor1, dynamic opccionalColor2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < list.length; i++)
          list.length == 4
              ? calcbutton(
                  list[i],
                  opccionalColor1 != Colors.grey
                      ? i == 3
                          ? Colors.blue
                          : opccionalColor1
                      : opccionalColor1,
                  opccionalColor2 != Colors.grey
                      ? i == 3
                          ? Colors.black
                          : opccionalColor2
                      : opccionalColor2,
                )
              : calcbutton(
                  list[i],
                  opccionalColor1 != Colors.grey
                      ? i == 1
                          ? Colors.blue
                          : opccionalColor1
                      : opccionalColor1,
                  opccionalColor2 != Colors.grey
                      ? i == 1
                          ? Colors.white
                          : opccionalColor2
                      : opccionalColor2,
                ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List listsButtons = [
      // extraButtons,
      primaryButtons,
      secundaryButtons,
      thirdsButtons,
      fourthButtons,
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('CalculATO(r)'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: ListView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(5),
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        text,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: double.parse(text) == 0
                              ? Colors.white
                              : double.parse(text) > 0
                                  ? Colors.green
                                  : Colors.red,
                          fontSize: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            for (int i = 0; i < listsButtons.length; i++)
              i == 0
                  ? constructRow(listsButtons[i], Colors.grey, Colors.black)
                  : constructRow(
                      listsButtons[i], Colors.grey[850], Colors.white),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 10, right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, right: 105, left: 20),
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      calculation('0');
                    },
                  ),
                ),
                constructRow(finalButtons, Colors.grey[850], Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }

  String text = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        result == '' ? null : numOne = double.parse(result);
      } else {
        result == '' ? null : numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      } else if (opr == '+/-') {
        finalResult = result;
      }

      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      result.toString().contains('.') ? null : result = '${result.toString()}.';
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-${result.toString()}';
      finalResult = result;
    } else if (btnText == 'DE') {
    } else if (btnText == 'LO') {
    } else if (btnText == 'RA') {
    } else if (btnText == '^2') {
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if ((double.parse(splitDecimal[1]) < 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
