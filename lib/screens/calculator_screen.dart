// Importa os pacotes necessários para construir a calculadora
import 'package:flutter/material.dart';
import '../widgets/calculator_button.dart'; // Nosso botão personalizado
import '../utils/calculator_logic.dart'; // A lógica matemática da calculadora

// Define a tela principal da calculadora (que pode mudar de estado)
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

// Classe que controla o estado da calculadora
class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic logic =
      CalculatorLogic(); // Instância da lógica da calculadora
  int? _pressedIndex; // Guarda qual botão está sendo pressionado (ou nenhum)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold é a estrutura básica da tela
      backgroundColor: const Color(0xFF466A86), // Cor de fundo azul escuro
      body: SafeArea(
        // Garante que o conteúdo não fique sob áreas inseguras (notch, etc)
        child: Column(
          // Organiza os elementos verticalmente
          children: [
            // Espaço vazio no topo
            const SizedBox(height: 60),

            // Container do visor da calculadora
            Container(
              height: 160, // Altura do visor
              width: double.infinity, // Largura total da tela
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ), // Espaçamento interno
              alignment: Alignment.bottomRight, // Alinha o conteúdo à direita
              color: const Color(0xFF1B3C53), // Cor do visor (azul mais escuro)
              child: Column(
                // Organiza o histórico e o resultado verticalmente
                crossAxisAlignment: CrossAxisAlignment.end, // Alinha à direita
                mainAxisAlignment:
                    MainAxisAlignment.end, // Alinha na parte de baixo
                children: [
                  // Texto do histórico (cálculos anteriores)
                  Text(
                    logic.history, // Pega o histórico da lógica
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ), // Estilo cinza claro
                  ),
                  const SizedBox(
                    height: 8,
                  ), // Espaço entre histórico e resultado
                  // Texto do resultado atual
                  Text(
                    logic.output, // Pega o resultado da lógica
                    style: const TextStyle(
                      fontSize: 48, // Tamanho grande
                      fontWeight: FontWeight.bold, // Negrito
                      color: Colors.white, // Cor branca
                    ),
                  ),
                ],
              ),
            ),

            // Área dos botões (ocupa todo espaço restante)
            Expanded(
              child: GridView.builder(
                // Cria uma grade de botões
                padding: const EdgeInsets.only(
                  // Espaçamento ao redor dos botões
                  top: 60,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                itemCount: logic.buttons.length, // Quantidade total de botões
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 botões por linha
                  mainAxisSpacing: 16, // Espaço vertical entre botões
                  crossAxisSpacing: 16, // Espaço horizontal entre botões
                ),
                itemBuilder: (context, index) {
                  // Pega o texto do botão atual
                  String buttonText = logic.buttons[index];
                  // Verifica se este botão está pressionado
                  bool isPressed = _pressedIndex == index;

                  // GestureDetector detecta toques no botão
                  return GestureDetector(
                    // Quando o botão é pressionado
                    onTapDown: (_) {
                      setState(() {
                        _pressedIndex =
                            index; // Marca este botão como pressionado
                      });
                    },
                    // Quando o botão é solto
                    onTapUp: (_) {
                      // Espera 100ms para animação de soltar
                      Future.delayed(const Duration(milliseconds: 100), () {
                        setState(() {
                          _pressedIndex =
                              null; // Remove o estado de pressionado
                        });
                      });
                      // Executa a ação do botão
                      setState(() {
                        logic.onButtonPressed(
                          buttonText,
                        ); // Chama a lógica da calculadora
                      });
                    },
                    // Se o toque for cancelado (arrastar para fora do botão)
                    onTapCancel: () {
                      setState(() {
                        _pressedIndex = null; // Remove o estado de pressionado
                      });
                    },
                    // Nosso botão personalizado
                    child: CalculatorButton(
                      text: buttonText, // Texto do botão
                      isPressed: isPressed, // Se está pressionado
                      color: logic.getButtonColor(buttonText), // Cor do botão
                      textColor: logic.getTextColor(buttonText), // Cor do texto
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
