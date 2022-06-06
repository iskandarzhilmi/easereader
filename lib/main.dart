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
                // SubmitButton(),
                SizedBox(
                  height: 10,
                ),
                SelectableText.rich(
                  TextSpan(
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

class SubmitButton extends StatefulWidget {
  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLoading = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        width: _isLoading ? 50.0 : 200.0,
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isLoading ? Colors.green : Colors.transparent,
          border: Border.all(
            color: Colors.green,
            width: _isLoading ? 0.0 : 2.0,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: _isLoading
            ? Icon(Icons.check, color: Colors.white)
            : Text(
                'Submit',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
      ),
    );
  }
}

class SubmitButton2 extends StatefulWidget {
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButton2State extends State<SubmitButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = true;
        });
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isTapped = false;
          });
        });
      },
      child: AnimatedContainer(
        width: _isTapped ? 80 : 200,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: _isTapped ? Colors.green : Colors.transparent,
            width: _isTapped ? 5 : 2,
          ),
          color: _isTapped ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        duration: Duration(milliseconds: 300),
        child: _isTapped
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
