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

    print("\n=== MENU TRANSACTION ===");
    print("1. Lister les transactions");
    print("2. Faire une transaction");
    print("3. Récupérer une transaction");
    print("4. Voir solde");
    print("0. Quitter");
    stdout.write("Votre choix : ");

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
            print("👋 Retour au menu principal...");
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
            final result = await service.getAllTransactions();
            print("📄 Transactions : $result");
        } catch (e) 
        {
            print("❌ Erreur API : $e");
        }
    }

    Future<void> _soldeCompte() async 
    {
        try 
        {
            final result = await service.getSolde();
            print("📄 Transactions : $result");
        } catch (e) 
        {
            print("❌ Erreur API : $e");
        }
    }

    Future<void> _effectuerTransaction() async 
    {

        print("\n📌 Effectuer une transactions");

        stdout.write("Saisir le numéro du destinataire : ");
        String? numero = stdin.readLineSync();

        stdout.write("Saisir le montant : ");
        String? montant = stdin.readLineSync();

        stdout.write("Type de transaction ?: transfert, Transfert d'argent, dépôt ou retrait : \n");
        String? type_transaction = stdin.readLineSync();

        if (numero == null || numero.isEmpty || montant == null || montant.isEmpty || type_transaction == null || type_transaction.isEmpty ) {
            print("❌ Tous les champs sont requis");
            return;
        }

        try
        {
            final result = await service.creerTransaction(numero,montant,type_transaction);
            print("📄 Transaction créée : $result");
        } catch (e)
        {
            print("❌ Erreur : $e");
        }
    }

    Future<void> _transactionById() async 
    {
        print("\n📌 Recuperer une Transaction par id");

        stdout.write("Saisir l'id : ");
        String? id = stdin.readLineSync();

        if (id == null || id.isEmpty) {
            print("❌ ID requis");
            return;
        }

        try
        {
            final result = await service.getByIdTransactions(id);
            print(result);
        }catch (e)
        {
            print("❌ Erreur : $e");
        }
    }
}
