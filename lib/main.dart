import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//period 시간 주기
class _MyAppState extends State<MyApp> {
  int times = 60;
  late Timer timer;
  String timeview = '0:00:00';
  bool isRunning = false;
  void timeStart() {
    //돌고 있는가? => 시간을 멈춤
    //안돌고 있음 => 돌아감
    if (isRunning) {
      timeStop();

      setState(() {
        isRunning = !isRunning;
      });
    } else {
      setState(() {
        isRunning = !isRunning;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          timeview = Duration(seconds: times).toString().split('.')[0];
          times--;
          if (times < 0) {
            timeStop();
            isRunning = !isRunning;
          }
        });
      });
    }

    // 1초마다 1씩 내려감 일정간격마다 수행
  }

  void timeReset() {
    //상태를 false로 변경
    setState(() {
      timeStop();
      times = 60;
      isRunning = false;
      timeview = Duration(seconds: times).toString().split('.').first;
    });
  }

  void addTime(int sec) {
    times = times + sec;
    times = times < 0 ? 0 : times;
    setState(() {
      timeview = Duration(seconds: times).toString().split('.').first;
    });
  }

  void timeStop() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'my timer',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    timeButton(sec: 60, color: Colors.black12),
                    timeButton(sec: 30, color: Color.fromARGB(31, 167, 24, 24)),
                    timeButton(
                        sec: -60, color: Color.fromARGB(31, 247, 17, 17)),
                    timeButton(
                        sec: -30, color: Color.fromARGB(31, 147, 173, 32)),
                  ],
                ),
              )),
          Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    timeview,
                    style: const TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRunning)
                        IconButton(
                            iconSize: 50,
                            onPressed: timeStart,
                            icon: Icon(Icons.pause_circle_rounded))
                      else
                        IconButton(
                            iconSize: 50,
                            onPressed: timeStart,
                            icon: const Icon(Icons.play_circle_rounded)),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          iconSize: 50,
                          onPressed: timeReset,
                          icon: Icon(Icons.stop_circle_rounded)),
                    ],
                  ))),
        ],
      )),
    );
  }

  GestureDetector timeButton({required int sec, required Color color}) {
    return GestureDetector(
      onTap: () => addTime(sec),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Center(child: Text('$sec')),
      ),
    );
  }
}
