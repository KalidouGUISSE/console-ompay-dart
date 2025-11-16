import 'dart:io';
import '../lib/core/api_client.dart';
import '../lib/services/auth_service.dart';
import '../lib/repositories/auth_repository.dart';
import '../lib/utils/helpers.dart';

void main() async {
  // 1️⃣ Initialisation de l'API client
  final apiClient = ApiClient(baseUrl: 'http://127.0.0.1:8000');

  // 2️⃣ Initialisation des services
  final authService = AuthService(apiClient);

  // 3️⃣ Initialisation des repositories
  final authRepository = AuthRepository(authService);

  bool quitter = false;

  while (!quitter) {
    afficherMenuAuth();

    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input ?? '');

    if (choice == null) {
      print("❌ Veuillez entrer un chiffre.");
      continue;
    }

    switch (choice) {
      case 1:
        // Exemple : Login OTP
        stdout.write("Numéro de téléphone (+221...): ");
        String? numero = stdin.readLineSync();
        if (numero == null || numero.isEmpty) break;

        try {
          final result = await authRepository.initiateLogin(numero); // OTP fictif
          // apiClient.token = result['token']; // Sauvegarde du token
          print("✅ Numero valide : $result");

          stdout.write("Saisir le code OTP envoyé : ");
          String? otp = stdin.readLineSync();

          if (otp == null || otp.isEmpty) {
            print("❌ OTP invalide");
            break;
          }

          // Comparaison OTP envoyé ↔ OTP saisi
          final otpServeur = result['data']['otp'].toString();

          if (otp != otpServeur) {
            print("❌ OTP incorrect");
            break;
          }

          print("🔑 OTP correct, connexion en cours...");

          // Temp token
          final tempToken = result['data']['temp_token'];

          // Appel du login OTP
          final resulFinal = await authRepository.loginWithOtp(tempToken, otp);
          print("🎉 Connexion réussie !  $resulFinal");

          apiClient.token = resulFinal['data']['access_token'];
          // Ici tu peux sauvegarder le token dans ApiClient
          // apiClient.token = result['token']; // Sauvegarde du token

          final infoCommpte = await authRepository.me();
          print(infoCommpte);
        } catch (e) {
          print("❌ Erreur : $e");
        }
        break;

      case 2:
        print("👉 Liste des comptes (à implémenter)");
        break;

      case 3:
        print("👉 Effectuer une transaction (à implémenter)");
        break;

      case 0:
        print("👋 Au revoir !");
        quitter = true;
        break;

      default:
        print("❌ Choix invalide.");
    }
  }
}
