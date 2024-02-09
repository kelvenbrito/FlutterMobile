import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  // Exemplo 1: Variáveis e Impressão
  //Declarando e inicialiazando variaveis
  String nome = "joao";
  int idade = 25;
  double altura = 1.75;
  bool estudante = true;

  //Imprimindo variaveis
  print("Nome:  $nome");
  print("idade: $idade anos");
  print("Altura: $altura metros");
  print("Estudante: $estudante");

  // Exemplo 2: Operações Aritméticas e Variáveis

  // Operações aritméticas com variáveis
  int numero1 = 10;
  int numero2 = 5;

  int soma = numero1 + numero2;
  int subtracao = numero1 - numero2;
  int multiplicacao = numero1 * numero2;

  double divisao = numero1 / numero2;

// Imprimindo resultados
  print("\nSoma: $soma");
  print("Subtração: $subtracao");
  print("Multiplicação: $multiplicacao");
  print("Divisão: $divisao");

  // Exemplo 3: Concatenação de Strings e Variáveis

  // Concatenação de strings com variáveis
  nome = "Maria";
   idade = 30;

  // Utilizando concatenação
  String mensagem = "\nOlá, meu nome é $nome e tenho $idade anos.";

  // Imprimindo a mensagem
  print(mensagem);



  // Exemplo 4: Alteração Dinâmica de Variáveis (Mutabilidade)

  // Variáveis mutáveis
  var numero = 42;
  print("\nNúmero inicial: $numero");

  // Alterando o valor da variável
  numero = 100;
  print("Número alterado: $numero");

    // Variável de tipo dinâmico
  dynamic variavelDinamica = "Texto";
  print("Variável dinâmica: $variavelDinamica");

  // Alterando dinamicamente o tipo e valor
  variavelDinamica = 42;
  print("Variável dinâmica alterada: $variavelDinamica");

}
