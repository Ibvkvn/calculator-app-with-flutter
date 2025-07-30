import 'package:calculator_app/button_value.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1  = "";
  String number2 = "";
  String operand = "";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false, 
        child: Column(
          children: [Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight, 
                padding: const EdgeInsets.all(16),
                child: Text(
                  "$number1$operand$number2".isEmpty? "0":"$number1$operand$number2", style: const TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                   textAlign: TextAlign.end,)
                   )
                  )
                ),
                Wrap(
                  children: Button_values.btnArrangement.map((value) => SizedBox(
                    width: value != Button_values.n0?(screenSize.width / 4): screenSize.width / 2,
                    height: screenSize.width / 5,
                    child: buildbtn(value))).toList(),
                )
              ]
            )
          ),
    );
  }

  Widget buildbtn(v){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(v),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24), 
            borderRadius: BorderRadius.circular(100)), 
            child: InkWell(
              onTap: () => btnOnTap(v), 
              child: Center(
                child: Text(v, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),))),)
    );
  }

  void btnOnTap(String value){
    if(value == Button_values.del){
      delete();
      return;
    }else if(value == Button_values.clr){
      clear();
      return;
    }else if(value == Button_values.per){
      returnPercentage();
      return;
    }else if(value == Button_values.equals){
      calculate();
      return;
    }

    appendValue(value);
  }

  void calculate(){
    if(number1.isEmpty) return;
    if(operand.isEmpty) return;
    if(number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);
    var result = 0.0;

    switch(operand){
      case Button_values.add:
        result = num1 + num2;
        break;
      case(Button_values.minus):
        result = num1 - num2;
        break;
      case(Button_values.divide):
        result = num1 / num2;
        break;
      case(Button_values.multiply):
        result = num1 * num2;
        break;
      default:
    }

    setState(() {
      number1 = "${result}";
      operand = "";
      number2 = "";

      if(number1.endsWith(".0")){
        number1 = number1.substring(0, number1.length - 2);
      }
    });
  }

  void returnPercentage(){
    if(number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty){

    }
    if(operand.isNotEmpty){
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  void clear(){
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  void delete(){
    if(number2.isNotEmpty){
      number2 = number2.substring(0, number2.length-1);
    }else if(operand.isNotEmpty){
      operand = "";
    }else if(number1.isNotEmpty){
      number1 = number1.substring(0, number1.length-1);
    }

    setState(() {});
  }

  void appendValue(String value){
    if (value != Button_values.dot && int.tryParse(value) == null){
      if(operand.isNotEmpty && number2.isNotEmpty){

      }
      operand = value;
    }else if(number1.isEmpty || operand.isEmpty){
      if(value == Button_values.dot || number1.contains(Button_values.dot)) return;
      if(value == Button_values.dot && (number1.isEmpty || number1 == Button_values.n0)){
        value = "0.";
      }
      number1 += value;
    }else if(number2.isEmpty || operand.isNotEmpty){
      if(value == Button_values.dot || number2.contains(Button_values.dot)) return;
      if(value == Button_values.dot && (number2.isEmpty || number2 == Button_values.n0)){
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }

  Color getBtnColor(v){
    return [
      Button_values.del, 
      Button_values.clr].contains(v)
        ?Colors.blueGrey:[Button_values.add, 
                            Button_values.minus, 
                            Button_values.multiply,
                            Button_values.divide, 
                            Button_values.per, 
                            Button_values.equals].contains(v)
        ?Colors.orange:
        Colors.black87;
  }
}
