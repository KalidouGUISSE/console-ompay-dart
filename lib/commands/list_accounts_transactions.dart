import './i_command.dart';
import '../core/i_api_client.dart';
import '../services/i_transaction_service.dart';

class ListAccountsTransactions implements ICommand {
    final ITransactionService transactionService;
    final IApiClient apiClient;

    ListAccountsTransactions(this.transactionService, this.apiClient);

    @override
    Future<void> execute() async {
        print("Fonctionnalité 'Lister les transactions' non implémentée.");

    }
}