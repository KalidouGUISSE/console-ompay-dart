// Constantes pour les choix de menu
class MenuConstants {
  static const int initiateLogin = 1;
  static const int listAccounts = 2;
  static const int makeTransaction = 3;
  static const int quit = 0;
}

// Messages d'erreur
class ErrorMessages {
  static const String invalidChoice = "❌ Veuillez entrer un chiffre.";
  static const String invalidOtp = "❌ OTP invalide";
  static const String incorrectOtp = "❌ OTP incorrect";
  static const String apiError = "❌ Erreur : ";
  static const String invalidChoiceDefault = "❌ Choix invalide.";
}

// Messages de succès
class SuccessMessages {
  static const String validNumber = "✅ Numero valide : ";
  static const String otpCorrect = "🔑 OTP correct, connexion en cours...";
  static const String loginSuccess = "🎉 Connexion réussie ! ";
  static const String goodbye = "👋 Au revoir !";
}

// Messages d'information
class InfoMessages {
  static const String accountsNotImplemented = "👉 Liste des comptes (à implémenter)";
  static const String transactionsNotImplemented = "👉 Effectuer une transaction (à implémenter)";
}