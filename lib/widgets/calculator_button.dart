// Importa o pacote do Flutter que contém os componentes básicos de interface
import 'package:flutter/material.dart';

// Define um botão personalizado para a calculadora (é um widget imutável)
class CalculatorButton extends StatelessWidget {
  // Texto que aparecerá no botão (ex: '1', '+', '=')
  final String text;

  // Controla se o botão está pressionado (para animação)
  final bool isPressed;

  // Cor de fundo do botão
  final Color color;

  // Cor do texto do botão
  final Color textColor;

  // Construtor do botão - recebe todas as configurações necessárias
  const CalculatorButton({
    super.key, // Chave identificadora (uso interno do Flutter)
    required this.text, // Texto é obrigatório
    required this.isPressed, // Estado é obrigatório
    required this.color, // Cor é obrigatória
    required this.textColor, // Cor do texto é obrigatória
  });

  // Método que constrói a aparência do botão
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      // Widget que anima o tamanho do botão
      scale: isPressed ? 0.9 : 1.0, // Reduz 10% quando pressionado
      duration: const Duration(milliseconds: 100), // Duração da animação
      curve: Curves.easeOut, // Tipo de animação (suaviza no final)
      child: Container(
        // Container que forma o botão
        decoration: BoxDecoration(
          // Personalização visual
          color: color, // Cor de fundo definida
          shape: BoxShape.circle, // Formato circular
          boxShadow: [
            // Sombra para efeito 3D
            BoxShadow(
              color: Color.fromRGBO(
                0,
                0,
                0,
                0.1,
              ), // Preto com 10% de opacidade // Cor com transparência
              spreadRadius: 1, // Quanto a sombra se espalha
              blurRadius: 5, // Desfoque da sombra
              offset: const Offset(0, 2), // Posição da sombra (baixo)
            ),
          ],
        ),
        child: Center(
          // Centraliza o conteúdo
          child: Text(
            // Texto do botão
            text,
            style: TextStyle(
              // Estilo do texto
              fontSize: 28, // Tamanho grande
              fontWeight: FontWeight.bold, // Texto em negrito
              color: textColor, // Cor definida
            ),
          ),
        ),
      ),
    );
  }
}
