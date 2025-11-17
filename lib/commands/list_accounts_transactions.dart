import '../interfaces/i_command.dart';
import '../interfaces/i_transaction_repository.dart';
import '../interfaces/i_api_client.dart';

class ListAccountsTransactions implements ICommand {
    final ITransactionRepository transactionRepository;
    final IApiClient apiClient;

    ListAccountsTransactions(this.transactionRepository, this.apiClient);

    @override
    Future<void> execute() async {
        print("Fonctionnalité 'Lister les transactions' non implémentée.");

    }
}