import '../interfaces/i_auth_service.dart';
import '../interfaces/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
    final IAuthService service;
    AuthRepository(this.service);

    @override
    Future<Map<String, dynamic>> initiateLogin(String numero) async {
        final result = await service.initiateLogin(numero);
        return result;
    }

    @override
    Future<Map<String, dynamic>> loginWithOtp(String tokenTemp, String otp) async {
        final result = await service.verifyOtp(tokenTemp, otp);
        return result;
    }

    @override
    Future<Map<String, dynamic>> me() async {
        final result = await service.me();
        return result;
    }
}
