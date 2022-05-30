import 'package:flutter/material.dart';
import 'package:ynovify/music.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ynovify',
      theme: ThemeData(
        fontFamily: 'FuzzyBubbles',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration? duration = const Duration(seconds: 0);

  int _counter = 0;
  bool play = false;

  void _incrementCounter() {
    setState(() {
      (_counter == musicList.length - 1) ? _counter = 0 : _counter++;
    });
    _initSong(_counter);
  }

  void _decrementCounter() {
    setState(() {
      (_counter == 0) ? _counter = musicList.length - 1 : _counter--;
    });
    _initSong(_counter);
  }

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initSong(_counter);
  }

  Future<void> _initSong(int _counter) async {
    try {
      await _player
          .setAudioSource(
              AudioSource.uri(Uri.parse(musicList[_counter].urlSOng)))
          .then((value) => duration = value);
    } catch (e) {
      print("erreur");
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Center(
        child: Text('Ynovify'),
      )),
      body: Column(
        children: [
          //Appel de la pochette de l'album
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Container(
              width: 280.0,
              height: 280.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image: AssetImage(musicList[_counter].imagePath),
                  )),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      musicList[_counter].Singer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      musicList[_counter].Title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FuzzyBubbles'),
                    ),
                  ),
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: IconButton(
                iconSize: 45.0,
                color: Colors.blue,
                icon: const Icon(Icons.skip_previous_outlined),
                onPressed: () {
                  _decrementCounter();
                },
              )),
              Container(
                  child: IconButton(
                iconSize: 45.0,
                color: Colors.blue,
                icon: Icon(
                    play ? Icons.play_arrow_outlined : Icons.pause_outlined),
                onPressed: () {
                  setState(() {
                    play ? _player.play() : _player.pause();
                    play = !play;
                  });
                },
              )),
              Container(
                  child: IconButton(
                iconSize: 45.0,
                color: Colors.blue,
                icon: const Icon(Icons.skip_next_outlined),
                onPressed: () {
                  _incrementCounter();
                },
              )),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    "Durée : ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Container(
                    child: Text(
                      _player.duration != null
                          ? "${_player.duration!.inMinutes}:${_player.duration!.inSeconds % 60}"
                          : "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
  }
}

List<Music> musicList = [
  Music('Go withe the Flow ', 'Queen Of the Stone Age ', 'assets/Queens.jpg',
      'https://codiceo.fr/mp3/armin.mp3'),
  Music('Like That', 'Fox Stevenson ', 'assets/Fox.jpg',
      'https://codiceo.fr/mp3/civilisation.mp3'),
  Music('bad karma', 'axel thesleff', 'assets/BAD.jpg',
      'https://codiceo.fr/mp3/armin.mp3'),
];
