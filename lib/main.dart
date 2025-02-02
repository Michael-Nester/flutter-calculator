// Added memory functionality to store and recall values
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator - Your Name',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';
  double? _memory; // Added memory variable

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final exp = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          _result = evaluator.eval(exp, {}).toString();
          _expression += ' = $_result';
        } catch (e) {
          _result = 'Error';
        }
      } else if (value == 'M+') {
        _memory = double.tryParse(_result);
      } else if (value == 'MR') {
        if (_memory != null) {
          _expression += _memory.toString();
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator - Your Name')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Text(
                _expression,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Text(
                _result,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(children: ['7', '8', '9', '/'].map(_buildButton).toList()),
              Row(children: ['4', '5', '6', '*'].map(_buildButton).toList()),
              Row(children: ['1', '2', '3', '-'].map(_buildButton).toList()),
              Row(children: ['0', 'C', '=', '+'].map(_buildButton).toList()),
              Row(children: ['M+', 'MR'].map(_buildButton).toList()), // Added memory buttons
            ],
          ),
        ],
      ),
    );
  }
}