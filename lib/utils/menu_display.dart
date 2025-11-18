import 'dart:io';
import 'package:dart_console/dart_console.dart';

class MenuDisplay {
  final Console console = Console();

  void display() {
    console.clearScreen();
    console.writeLine('\n=== MENU PRINCIPAL ===', TextAlignment.center);
    console.writeLine('1. Initier la connexion avec OTP');
    console.writeLine('2. TRANSACTION');
    console.writeLine('0. Quitter');
    console.write('Votre choix : ');
  }

  void showSuccess(String message) {
    console.setForegroundColor(ConsoleColor.green);
    console.writeLine('✓ $message');
    console.resetColorAttributes();
  }

  void showError(String message) {
    console.setForegroundColor(ConsoleColor.red);
    console.writeLine('✗ $message');
    console.resetColorAttributes();
  }
}