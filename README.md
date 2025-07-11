# Calculadora em Flutter

Uma calculadora moderna desenvolvida com **Flutter** e a biblioteca **math_expressions**, com foco em usabilidade, design elegante e arquitetura limpa. O projeto foi refatorado para seguir boas práticas de organização de código, utilizando separação de responsabilidades entre UI, lógica e widgets personalizados.

---

## Demonstração

<div align="center">
  <img width="250" alt="tela1" src="https://github.com/user-attachments/assets/87ce3fb4-1308-47ab-a6d4-7f688911a0a3" />
</div>

<p align="center"><em>Exemplo da interface da calculadora.</em></p>

---

## Funcionalidades

- Operações básicas: soma, subtração, multiplicação e divisão
- Cálculo de porcentagem
- Limpar (C) e apagar último dígito (⌫)
- Histórico de operação
- Botões animados com efeito de clique
- Layout responsivo em Grid
- Lógica de cálculo separada da interface

---

## Dependências

- flutter
- math_expressions

Adicionadas no pubspec.yaml:

```bash
dependencies:
  flutter:
    sdk: flutter
  math_expressions: ^2.2.0

```


---

## 🛠️ Como Rodar o Projeto

### Pré-requisitos
- [Flutter](https://flutter.dev/docs/get-started/install) instalado na máquina
- Um dispositivo físico/emulador

### Passos

```bash
# Clone o repositório
git clone https://github.com/JessicaPortilio/Calculadora-Flutter.git
cd calculadora-flutter

# Instale as dependências
flutter pub get

# Execute no emulador ou dispositivo
flutter run

