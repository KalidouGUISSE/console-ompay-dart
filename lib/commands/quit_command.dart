import './i_command.dart';
import '../core/constants.dart';

class QuitCommand implements ICommand {
    @override
    Future<void> execute() async {
        print(Messages.goodbye);
    }
}