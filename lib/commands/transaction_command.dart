import 'dart:io';
import './i_command.dart';
import '../core/i_api_client.dart';
import '../core/constants.dart';
import '../services/i_transaction_service.dart';


class TransactionCommand implements ICommand {

final ITransactionService service;
final IApiClient apiClient;

TransactionCommand(this.service, this.apiClient);

@override
Future<void> execute() async {
    // 🔥 Ici on applique le Single Responsibility : Cette classe ne s’occupe QUE d’une action

    print(Messages.transactionMenuTitle);
    print(Messages.transactionMenuOption1);
    print(Messages.transactionMenuOption2);
    print(Messages.transactionMenuOption3);
    print(Messages.transactionMenuOption4);
    print(Messages.transactionMenuOption0);
    stdout.write(Messages.mainMenuPrompt);

    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input ?? '');

    if (choice == null) {
        print(ErrorMessages.invalidChoice);
        return;
    }

    switch (choice) {
        case 1:
            await _listTransactions();
            break;

        case 2:
            await _effectuerTransaction();
            break;

        case 3:
            await _transactionById();
            break;

        case 4:
            await _soldeCompte();
            break;

        case 0:
            print(Messages.backToMainMenu);
            break;

        default:
            print(ErrorMessages.invalidChoice);
        }
    }

    // 🔥 Méthode privée - applique le principe SRP + OCP
    Future<void> _listTransactions() async
    {
        try
        {
            final transactions = await service.getAllTransactions();
            if (transactions.isEmpty) {
                Messages.showInfo(Messages.transactionNotFound);
                return;
            }

            print(Messages.transactionCount(transactions.length));
            print("-" * 80);
            for (final transaction in transactions) {
                print("${Messages.labelId}${transaction.id}");
                print("${Messages.labelType}${transaction.typeTransaction}");
                print("${Messages.labelPhone}${transaction.expediteur}");
                print("${Messages.labelAmount}${transaction.montant}${Messages.currency}");
                print("${Messages.labelDate}${transaction.date.toLocal()}");
                print("${Messages.labelReference}${transaction.reference}");
                if (transaction.metadata != null && transaction.metadata!.isNotEmpty) {
                    print("${Messages.labelMetadata}${transaction.metadata}");
                }
                print("-" * 80);
            }
        } catch (e)
        {
            print("${Messages.apiErrorGeneric}$e");
        }
    }

    Future<void> _soldeCompte() async 
    {
        try 
        {
            final result = await service.getSolde();
            print("${Messages.transactionBalance}$result");
        } catch (e)
        {
            Messages.showError("Erreur lors de la récupération du solde : $e");
        }
    }

    Future<void> _effectuerTransaction() async 
    {

        print(Messages.transactionCreatePrompt);

        stdout.write(Messages.transactionCreateRecipientPrompt);
        String? numero = stdin.readLineSync();

        stdout.write(Messages.transactionCreateAmountPrompt);
        String? montant = stdin.readLineSync();

        stdout.write(Messages.transactionCreateTypePrompt);
        String? type_transaction = stdin.readLineSync();

        if (numero == null || numero.isEmpty || montant == null || montant.isEmpty || type_transaction == null || type_transaction.isEmpty ) {
            Messages.showError(Messages.requiredField);
            return;
        }

        try
        {
            final montantDouble = double.tryParse(montant);
            if (montantDouble == null) {
                Messages.showError(Messages.invalidAmount);
                return;
            }
            final transaction = await service.creerTransaction(numero, montantDouble, type_transaction);
            Messages.showSuccess("Transaction créée avec succès");
            print("-" * 80);
            print("-" * 80);
            print("${Messages.labelId}${transaction.id}");
            print("${Messages.labelType}${transaction.typeTransaction}");
            print("${Messages.labelSender}${transaction.expediteur}");
            print("${Messages.labelRecipient}${transaction.destinataire}");
            print("${Messages.labelAmount}${transaction.montant}${Messages.currency}");
            print("${Messages.labelDate}${transaction.date.toLocal()}");
            print("${Messages.labelReference}${transaction.reference}");
            if (transaction.metadata != null && transaction.metadata!.isNotEmpty) {
                print("${Messages.labelMetadata}${transaction.metadata}");
            }
            print("-" * 80);
        } catch (e)
        {
            Messages.showError("Erreur lors de la création : $e");
        }
    }

    Future<void> _transactionById() async
    {
        print(Messages.transactionByIdPrompt);

        stdout.write(Messages.transactionByIdIdPrompt);
        String? id = stdin.readLineSync();

        if (id == null || id.isEmpty) {
            Messages.showError(Messages.requiredId);
            return;
        }

        try
        {
            final transaction = await service.getByIdTransactions(id);
            print(Messages.transactionFound);
            print("-" * 80);
            print("${Messages.labelId}${transaction.id}");
            print("${Messages.labelType}${transaction.typeTransaction}");
            print("${Messages.labelSender}${transaction.expediteur}");
            print("${Messages.labelRecipient}${transaction.destinataire}");
            print("${Messages.labelAmount}${transaction.montant}${Messages.currency}");
            print("${Messages.labelDate}${transaction.date.toLocal()}");
            print("${Messages.labelReference}${transaction.reference}");
            if (transaction.metadata != null && transaction.metadata!.isNotEmpty) {
                print("${Messages.labelMetadata}${transaction.metadata}");
            }
            print("-" * 80);
        }catch (e)
        {
            Messages.showError("Erreur lors de la récupération : $e");
        }
    }
}
