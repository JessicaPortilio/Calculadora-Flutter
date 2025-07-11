// Importa pacote para cálculos matemáticos complexos
import 'package:math_expressions/math_expressions.dart';
// Importa pacote com ferramentas para construir a interface do app
import 'package:flutter/material.dart';

// Classe que contém toda a lógica da calculadora
class CalculatorLogic {
  // Armazena o número que está sendo digitado (valor atual)
  String _input = '0';
  // Armazena o que será mostrado no visor
  String _output = '0';
  // Armazena a operação atual (+, -, ×, ÷)
  String _operation = '';
  // Armazena o histórico do cálculo
  String _history = '';
  // Primeiro número digitado para o cálculo
  double _num1 = 0;
  // Segundo número digitado para o cálculo
  double _num2 = 0;
  // Controla se uma operação foi pressionada
  bool _isOperationPressed = false;

  // Lista com os botões da calculadora na ordem que aparecem
  final List<String> buttons = [
    'C', '⌫', '%', '÷', // Linha 1 - Limpar, Apagar, Porcentagem, Divisão
    '7', '8', '9', '×', // Linha 2 - Números 7-9 e Multiplicação
    '4', '5', '6', '-', // Linha 3 - Números 4-6 e Subtração
    '1', '2', '3', '+', // Linha 4 - Números 1-3 e Adição
    '0', '.', '=', // Linha 5 - Zero, Ponto decimal e Igual
  ];

  // Métodos para acessar valores privados de fora da classe
  String get output => _output;
  String get history => _history;

  // Método principal que é chamado quando qualquer botão é pressionado
  void onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clearAll(); // Se for 'C', limpa tudo
    } else if (buttonText == '⌫') {
      _backspace(); // Se for '⌫', apaga o último dígito
    } else if (buttonText == '%') {
      _handlePercentage(); // Se for '%', calcula porcentagem
    } else if (buttonText == '=') {
      _calculateResult(); // Se for '=', calcula o resultado
    } else if (['+', '-', '×', '÷'].contains(buttonText)) {
      _handleOperation(buttonText); // Se for operação matemática
    } else {
      _handleNumberInput(buttonText); // Se for número ou ponto decimal
    }
  }

  // Limpa TODOS os valores (reinicia a calculadora)
  void _clearAll() {
    _input = '0';
    _output = '0';
    _history = '';
    _num1 = 0;
    _num2 = 0;
    _operation = '';
    _isOperationPressed = false;
  }

  // Apaga o último dígito digitado
  void _backspace() {
    if (_input.length > 1) {
      _input = _input.substring(
        0,
        _input.length - 1,
      ); // Remove último caractere
    } else {
      _input = '0'; // Se só tiver 1 dígito, volta para zero
    }
    _output = _input;
  }

  // Converte o número atual para porcentagem (divide por 100)
  void _handlePercentage() {
    if (_input == '0') return; // Ignora se for zero
    double number = double.parse(_input);
    _input = (number / 100).toString();
    // Remove ".0" se for número inteiro (ex: 50.0 vira 50)
    if (_input.endsWith('.0')) {
      _input = _input.substring(0, _input.length - 2);
    }
    _output = _input;
  }

  // Lida com operações matemáticas (+, -, ×, ÷)
  void _handleOperation(String buttonText) {
    if (_input == '0' && _num1 == 0) return; // Ignora se não houver número

    // Se já houver uma operação pendente, calcula primeiro
    if (_operation.isNotEmpty && !_isOperationPressed) {
      _calculateResult();
    } else {
      // Senão, armazena o primeiro número
      _num1 = double.tryParse(_input) ?? 0;
    }

    _operation = buttonText; // Armazena a nova operação
    _isOperationPressed = true; // Marca que operação foi pressionada

    // Atualiza histórico (ex: "5 +")
    _history = '$_num1 $_operation';
    _output = '0';
  }

  // Lida com entrada de números (0-9) e ponto decimal
  void _handleNumberInput(String buttonText) {
    if (_isOperationPressed) {
      // Se uma operação foi pressionada antes, começa novo número
      _input = buttonText == '.' ? '0.' : buttonText;
      _isOperationPressed = false;
    } else {
      if (_input == '0' && buttonText != '.') {
        // Substitui zero se não for ponto decimal
        _input = buttonText;
      } else if (buttonText == '.' && _input.contains('.')) {
        // Não permite dois pontos decimais
        return;
      } else {
        // Adiciona o dígito ao número atual
        _input += buttonText;
      }
    }
    _output = _input;
  }

  // Calcula o resultado final
  void _calculateResult() {
    if (_operation.isEmpty) return; // Se não houver operação, sai

    _num2 = double.tryParse(_input) ?? 0; // Pega o segundo número

    try {
      // Converte símbolos (× → *, ÷ → /) para a biblioteca matemática
      String oper = _operation == '×'
          ? '*'
          : _operation == '÷'
          ? '/'
          : _operation;

      // Prepara e faz o cálculo usando a biblioteca math_expressions

      // Criação do Parser (Analisador)
      // É como criar uma nova calculadora científica vazia
      // p será nossa máquina que entende fórmulas matemáticas
      Parser p = Parser();

      // Transformação em Expressão Matemática
      // Pega os números e a operação (ex: "5 + 3")
      // Converte esse texto em uma estrutura matemática que o computador entende
      // Exemplo: Transforma "5 + 3" em um objeto que representa essa operação
      Expression exp = p.parse('$_num1 $oper $_num2');

      // Preparação do Ambiente de Cálculo
      // Cria um "espaço de trabalho limpo" para fazer os cálculos
      // Como pegar uma folha em branco para fazer contas
      ContextModel cm = ContextModel();

      // Execução do Cálculo
      // Pede para a expressão ser calculada (evaluate)
      // EvaluationType.REAL significa "quero o resultado com decimais" (números reais)
      // O resultado é armazenado na variável result (como 8.0 para "5 + 3")
      double result = exp.evaluate(EvaluationType.REAL, cm);

      // Formata o resultado (remove .0 se for inteiro)
      _input = result.toString();
      if (_input.endsWith('.0')) {
        _input = _input.substring(0, _input.length - 2);
      }

      // Atualiza histórico (ex: "5 + 3 = 8")
      _history = '$_num1 $_operation $_num2 = $_input';
      _output = _input;

      // Prepara para próximos cálculos (o resultado vira o novo _num1)
      _num1 = result;
      _operation = '';
      _isOperationPressed = true;
    } catch (e) {
      // Em caso de erro (como divisão por zero)
      _output = 'Erro';
      _input = '0';
      _operation = '';
      _history = '';
    }
  }

  // Define a cor de fundo de cada botão
  Color getButtonColor(String text) {
    if (text == '=') return const Color(0xFF1B3C53); // Botão '=' é azul escuro
    if (['÷', '×', '-', '+', '%', 'C', '⌫'].contains(text)) {
      return const Color(0xFFD3BEB0); // Botões de operação são bege
    }
    return Colors.white; // Números são brancos
  }

  // Define a cor do texto de cada botão
  Color getTextColor(String text) {
    if (text == '=') return Colors.white; // Texto do '=' é branco
    return Colors.black; // Demais textos são pretos
  }
}
