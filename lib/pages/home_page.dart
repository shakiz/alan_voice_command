import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List greetingsText = ['hi', 'hello', 'thanks', 'welcome'];
  List cancelText = ['cancel', 'close', 'remove', 'delete'];

  @override
  void initState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "502ebcc9f884646444d4ab00d0618b172e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      handleCommand(command.data["data"]);
      print("got new command ${command.toString()}");
    });
    /// Registering the event listener
    AlanVoice.onEvent.add((event) => _handleEvent(event.data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Alan AI"),
          leading: InkWell(
            child: const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(
                  Icons.menu,
                )),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
      ),
    );
  }

  /// Responsible for handling commands sent from the Alan voice script.
  /// To accompany user’s utterances with activities in the app UI, you can send commands
  /// from the voice scripts to the client app. For example, once the user gives a voice command, another view or
  /// page can be opened in the app, a UI element can be selected on the screen and so on.
  handleCommand(Map<String, dynamic> command){
    switch(command["command"]){
      default:
        debugPrint("Done");
        break;
    }
  }

  /// Handling events
  /// Responsible for handling events received from Alan.
  /// While Alan interacts with the user and interpretes the user’s input, it emits a series of events.
  /// For each event, Alan generates JSON output with the event description. You can intercept the event information and
  /// use it in your app logic if needed.
  /// https://alan.app/docs/client-api/methods/event-handler/
  void _handleEvent(Map<String, dynamic> event) {
    switch (event["name"]) {
      case "recognized":
        debugPrint("Interim results: ${event["text"]}");
        break;
      case "parsed":
        debugPrint("Final result: ${event["text"]}");
        if(greetingsText.contains(event["text"])){
          _showMyDialog();
        }
        else if(cancelText.contains(event["text"])){
          Navigator.pop(context);
        }
        break;
      case "text":
        debugPrint("Alan response: ${event["text"]}");
        break;
      default:
        debugPrint("Unknown event");
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
