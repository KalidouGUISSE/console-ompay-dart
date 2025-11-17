abstract class IAuthRepository {
  Future<Map<String, dynamic>> initiateLogin(String numero);
  Future<Map<String, dynamic>> loginWithOtp(String token, String otp);
  Future<Map<String, dynamic>> me();
}