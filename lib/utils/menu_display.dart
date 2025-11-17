import 'dart:io';

class MenuDisplay {
  void display() {
    print('\n=== MENU PRINCIPAL ===');
    print('1. Initier la connexion avec OTP');
    print('2. TRANSACTION');
    print('0. Quitter');
    stdout.write('Votre choix : ');
  }
}