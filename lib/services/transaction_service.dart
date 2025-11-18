import '../core/i_api_client.dart';
import './i_transaction_service.dart';
import '../utils/validators.dart';
import '../core/exceptions.dart';
import '../utils/cache.dart';
import '../core/config.dart';

class TransactionService implements ITransactionService{
    final IApiClient apiClient;
    TransactionService(this.apiClient);

    @override
    Future<Map<String, dynamic>> getAllTransactions() async {
        final encodedNumero = Uri.encodeComponent(apiClient.numero!);
        return await apiClient.get('/api/v1/compte/$encodedNumero/transactions') as Map<String, dynamic>;
    }

    @override
    Future<Map<String, dynamic>> getSolde() async {
        final cacheKey = 'solde_${apiClient.numero}';
        final cached = SimpleCache.get<Map<String, dynamic>>(cacheKey);
        if (cached != null) {
            return cached;
        }
        final result = await apiClient.get('/api/v1/compte/${apiClient.numero}/solde') as Map<String, dynamic>;
        SimpleCache.set(cacheKey, result, Duration(minutes: Config.cacheTtlMinutes));
        return result;
    }

    @override
    Future<Map<String, dynamic>> creerTransaction(String numero, String montant, String type_transaction) async {
        if (!Validator.isValidPhoneNumber(numero)) {
            throw ValidationException('Numéro de téléphone invalide');
        }
        if (!Validator.isValidAmount(montant)) {
            throw ValidationException('Montant invalide');
        }
        if (!Validator.isValidTransactionType(type_transaction)) {
            throw ValidationException('Type de transaction invalide');
        }
        return await apiClient.post('/api/v1/compte/${apiClient.numero}/transactions',
        {
            'numero du destinataire': numero,
            'montant': double.parse(montant),
            'type_transaction': type_transaction,
            'date':''
        });
    }

    @override
    Future<Map<String, dynamic>> getByIdTransactions(String id) async {
        if (!Validator.isValidId(id)) {
            throw ValidationException('ID invalide');
        }
        return await apiClient.get('/api/v1/transactions/$id') as Map<String, dynamic>;
    }

    @override
    Future<Map<String, dynamic>> getTransactionsAndSolde() async {
        final results = await Future.wait([
            getAllTransactions(),
            getSolde(),
        ]);
        return {
            'transactions': results[0],
            'solde': results[1],
        };
    }

}