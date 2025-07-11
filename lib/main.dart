// Importa o pacote do Flutter, que contém todos os widgets e ferramentas básicas
import 'package:flutter/material.dart';
// Importa o arquivo que contém a tela da calculadora (outro arquivo do projeto)
import 'screens/calculator_screen.dart';

// Função principal que é executada quando o app inicia
void main() {
  // Inicia o aplicativo Flutter, usando a classe CalculatorApp como raiz
  runApp(const CalculatorApp());
}

// Define a classe CalculatorApp, que é um widget sem estado (não muda durante a execução)
class CalculatorApp extends StatelessWidget {
  // Construtor da classe (super.key é usado para identificação interna do Flutter)
  const CalculatorApp({super.key});

  // Método obrigatório que constrói a interface do aplicativo
  @override
  Widget build(BuildContext context) {
    // Retorna um MaterialApp, que é o widget raiz para apps com design Material
    return const MaterialApp(
      // Título do aplicativo (aparece em alguns lugares como gerenciador de apps)
      title: 'Calculadora Profissional',
      // Remove o banner "DEBUG" que aparece no canto superior direito
      debugShowCheckedModeBanner: false,
      // Define a tela inicial do app como sendo a CalculatorScreen
      home: CalculatorScreen(),
    );
  }
}
