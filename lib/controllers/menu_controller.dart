import '../interfaces/i_command.dart';
import '../utils/menu_display.dart';

class MenuController {
    final MenuDisplay menuDisplay;
    final Map<int, ICommand> actions;

    MenuController(this.menuDisplay, this.actions);

    Future<bool> handleChoice(int choice) async {
        final action = actions[choice];
        if (action != null) {
            await action.execute();
            return choice == 0; // Quitter
        } else {
            print("Choix invalide");
            return false;
        }
    }

    void displayMenu() {
        menuDisplay.display();
    }
}