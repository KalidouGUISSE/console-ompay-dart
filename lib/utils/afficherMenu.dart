import 'dart:io';
void afficherMenu() {
    print('\n=== MENU PRINCIPAL ===');
    print('1. Ajouter un utilisateur');
    print('2. Lister les utilisateurs');
    print('3. Supprimer un utilisateur');
    print('4. Quitter');
    stdout.write('Votre choix : ');
}


bool switchCase(String? choice, [bool quitter = false] ){
    switch (choice) {
        case '1':
            print('👉 Fonction : Ajouter un utilisateur');
            // Appelle ici ta fonction addUser()
            break;

        case '2':
            print('👉 Fonction : Lister les utilisateurs');
            // Appelle ici ta fonction listUsers()
            break;

        case '3':
            print('👉 Fonction : Supprimer un utilisateur');
            // Appelle ici ta fonction deleteUser()
            break;

        case '4':
            print('👋 Au revoir !');
            return true;

        default:
            print('❌ Choix invalide, réessayez.');
    }
    return false;
}