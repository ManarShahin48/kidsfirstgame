import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player = AudioCache();
  Map<String, bool> score = {};
  Map<String, Color> choices = {
    '🍎' : Colors.red,
    '🧅' : Colors.yellow,
    '🍇' : Colors.purple,
    '🥒' : Colors.green,
    '🥚' : Colors.white,
    '🍊' : Colors.orange,
  };
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Scores'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choices.keys.map((e) {
              return Expanded(
                child: Draggable<String>(
                    data: e,
                    child: Movable(score[e] ==true ? '✔️' : e),
                    feedback: Movable(e),
                    childWhenDragging: Movable('🚀'),
                  ),
              );
            }).toList()
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys.map((e) {
                return buildTarget(e);
              }).toList()..shuffle(Random(index))
          ),
        ],
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            score.clear();
            index++;
          });
        },
      ),
    );
  }
  Widget buildTarget(e){
    return DragTarget<String>(
      builder: (context, incoming, rejected){
        if(score[e] == true){
          return Container(
            color: Colors.white,
            child: const Text(
              'Congratulations!✨✨'
            ),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }
        else{
          return Container(
            color: choices[e],
            height: 80,
            width: 200,
          );
        }
      },
      onAccept: (data) {
        setState(() {
          score[e] = true;
          player.play('clap.wav');
        });
      },
      onWillAccept: (data) => data == e,
      onLeave: (data){},
    );
  }
}

class Movable extends StatelessWidget {
  // const Movable({ Key? key }) : super(key: key);
  String emoji;
  Movable(this.emoji);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: const EdgeInsets.all(15),
        child: Text(
          emoji,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 60,
          ),
        ),
      ),
    );
  }
}