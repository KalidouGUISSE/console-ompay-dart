import '../services/auth_service.dart';

class AuthRepository {
    final AuthService service;
    AuthRepository(this.service);

    Future<Map<String, dynamic>> initiateLogin(String numero) async {
        final result = await service.initiateLogin(numero);
        return result;
    }

    Future<Map> loginWithOtp(String tokenTemp, String otp) async {
        final result = await service.verifyOtp(tokenTemp,otp);
        return result;
    }

    Future<Map> me() async {
        final result = await service.me();
        return result;
    }
}
