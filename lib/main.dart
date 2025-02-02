import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Name - Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final exp = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final evalResult = evaluator.eval(exp, {});
          _result = evalResult.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Name - Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                '$_expression\n$_result',
                style: const TextStyle(fontSize: 32),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Column(
            children: [
              ['7', '8', '9', '/'],
              ['4', '5', '6', '*'],
              ['1', '2', '3', '-'],
              ['C', '0', '=', '+'],
            ].map((row) {
              return Row(
                children: row.map((text) => _buildButton(text)).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
