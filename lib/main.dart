import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EaseReader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EaseReader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  final UniqueKey _formKey = UniqueKey();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Paste the text that you want to read easily',
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: null,
                  controller: controller,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      text = controller.text;
                    });
                  },
                  child: Text('Submit'),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: convertToBionicText(
                      text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<TextSpan> convertToBionicText(String text) {
  List<TextSpan> spans = [];
  for (String line in text.split('\n')) {
    for (String word in line.split(' ')) {
      spans.add(TextSpan(
          text: word.substring(0, (word.length / 2).ceil()),
          style: TextStyle(fontWeight: FontWeight.bold)));
      spans.add(
        TextSpan(text: word.substring((word.length / 2).ceil())),
      );
      spans.add(TextSpan(text: ' ')); // Add a space between words.
    }
    spans.add(TextSpan(text: '\n')); // Add a new line character.
  }
  return spans;
}
