import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  handleCommand(Map<String, dynamic> command){
    switch(command["command"]){
      default:
        print("Done");
        break;
    }
  }

  /// Handling events
  void _handleEvent(Map<String, dynamic> event) {
    switch (event["name"]) {
      case "recognized":
        debugPrint("Interim results: ${event["text"]}");
        break;
      case "parsed":
        debugPrint("Final result: ${event["text"]}");
        break;
      case "text":
        debugPrint("Alan response: ${event["text"]}");
        break;
      default:
        debugPrint("Unknown event");
    }
  }
}
