import './i_command.dart';

class QuitCommand implements ICommand {
    @override
    Future<void> execute() async {
        print("Au revoir !");
    }
}