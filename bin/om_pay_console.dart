import 'dart:io';
import 'package:om_pay_console/core/i_api_client.dart';
import 'package:om_pay_console/services/i_auth_service.dart';
import 'package:om_pay_console/services/i_transaction_service.dart';

import 'package:om_pay_console/core/api_client.dart';
import 'package:om_pay_console/core/constants.dart';

import 'package:om_pay_console/services/auth_service.dart';
import 'package:om_pay_console/services/transaction_service.dart';

import 'package:om_pay_console/controllers/menu_controller.dart';
import 'package:om_pay_console/utils/menu_display.dart';
import 'package:om_pay_console/utils/logger.dart';
import 'package:om_pay_console/core/config.dart';

import 'package:om_pay_console/commands/login_command.dart';
import 'package:om_pay_console/commands/transaction_command.dart';
import 'package:om_pay_console/commands/quit_command.dart';
import 'package:om_pay_console/commands/list_accounts_transactions.dart';

void main() async {
  // Chargement de la configuration
  Config.load();

  // Configuration du logger
  AppLogger.setup();

  // Injection de dépendances (Dependency Inversion Principle)
  final IApiClient apiClient = ApiClient(baseUrl: Config.baseUrl);
  final IAuthService authService = AuthService(apiClient);
  final ITransactionService transactionService = TransactionService(apiClient);

  final menuController = MenuController(
    MenuDisplay(),
    {
      1: LoginCommand(authService, apiClient),
      // 2: ListAccountsTransactions(transactionRepository, apiClient),
      2: TransactionCommand(transactionService, apiClient),
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
