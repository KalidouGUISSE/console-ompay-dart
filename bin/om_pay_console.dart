import 'dart:io';
import 'package:om_pay_console/interfaces/i_api_client.dart';
import 'package:om_pay_console/interfaces/i_auth_service.dart';
import 'package:om_pay_console/interfaces/i_auth_repository.dart';
import 'package:om_pay_console/interfaces/i_transaction_repository.dart';
import 'package:om_pay_console/interfaces/i_transaction_service.dart';


import 'package:om_pay_console/core/api_client.dart';
import 'package:om_pay_console/core/constants.dart';

import 'package:om_pay_console/services/auth_service.dart';
import 'package:om_pay_console/services/transaction_service.dart';

import 'package:om_pay_console/repositories/auth_repository.dart';
import 'package:om_pay_console/repositories/transaction_repository.dart';

import 'package:om_pay_console/controllers/menu_controller.dart';
import 'package:om_pay_console/utils/menu_display.dart';

import 'package:om_pay_console/commands/login_command.dart';
import 'package:om_pay_console/commands/transaction_command.dart';
import 'package:om_pay_console/commands/quit_command.dart';
import 'package:om_pay_console/commands/list_accounts_transactions.dart';

void main() async {
  // Injection de dépendances (Dependency Inversion Principle)
  final IApiClient apiClient = ApiClient(baseUrl: 'http://127.0.0.1:8000');
  final IAuthService authService = AuthService(apiClient);
  final IAuthRepository authRepository = AuthRepository(authService);
  final ITransactionService transactionService = TransactionService(apiClient);
  final ITransactionRepository transactionRepository = TransactionRepository(transactionService);

  final menuController = MenuController(
    MenuDisplay(),
    {
      1: LoginCommand(authRepository, apiClient),
      // 2: ListAccountsTransactions(transactionRepository, apiClient),
      2: TransactionCommand(transactionRepository, apiClient),
      0: QuitCommand(),
    },
  );

  bool quitter = false;

  while (!quitter) {
    menuController.displayMenu();

    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input ?? '');

    if (choice == null) {
      print(ErrorMessages.invalidChoice);
      continue;
    }

    // Utilisation du pattern Command pour OCP (Open-Closed Principle)
    quitter = await menuController.handleChoice(choice);
  }
}
