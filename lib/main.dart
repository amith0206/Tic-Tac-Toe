import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];

  var currentplayer = 'X';

  var counter= 0;

  void setX() {
    setState(() {
      currentplayer = 'X';
      counter=1;
    });
  }

  void setO() {
    setState(() {
      currentplayer = 'O';
      counter=1;
    });
  }

  void drawX(int i) {
    if (grid[i] == '-' && counter ==1) {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });

      findWinner(grid[i]);
    }
  }

  bool checkMove(int i1, int i2, int i3, String sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findWinner(String currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
        checkMove(3, 4, 5, currentsign) ||
        checkMove(6, 7, 8, currentsign) || // rows
        checkMove(0, 3, 6, currentsign) ||
        checkMove(1, 4, 7, currentsign) ||
        checkMove(2, 5, 8, currentsign) || // columns
        checkMove(0, 4, 8, currentsign) ||
        checkMove(2, 4, 6, currentsign)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtherPage()),
      );
    }
  }

  void reset() {
    setState(() {
      counter = 0;
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Title(color: Colors.blue, child: const Text('Choose your player',
              style: TextStyle(fontSize: 30),)),
            ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: setX,
                child: const Text('X'),
              ),
              const SizedBox(width: 30),
              ElevatedButton(onPressed: setO, child: const Text('O'))
            ],
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
            margin: const EdgeInsets.all(10),
            color: Colors.black,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: grid.length,
              itemBuilder: (context, index) => Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.black,
                  onTap: () => drawX(index),
                  child: Center(
                    child: Text(
                      grid[index],
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: reset,
            icon: const Icon(Icons.refresh),
            label: const Text("Play again"),
          ),
        ],
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Winner!',
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: const Text(
                'Go Back',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
