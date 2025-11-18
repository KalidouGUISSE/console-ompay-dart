import '../commands/i_command.dart';
import '../utils/menu_display.dart';
import '../core/constants.dart';

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
            Messages.showError(Messages.invalidChoiceDefault);
            return false;
        }
    }

    void displayMenu() {
        menuDisplay.display();
    }
}