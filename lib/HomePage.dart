import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String hourString = '00';
  String minuteString = '00';
  String secondString = '00';
  String millisecString = '000';
  int hours = 0, minute = 0, second = 0, millisec = 0;
  late Timer _timer;
  bool isTimmerRunning = false;
  bool isResetButtonVisible = false;

  void pauseTimer() {
    setState(() {
      isTimmerRunning = false;
    });
    _timer.cancel();
    isResetButtonVisible=checkValue();
  }

  void startTimer() {
    setState(() {
      isTimmerRunning = true;
    });
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _startMilliSecond();
    });
  }

  void restartTimer() {
    _timer.cancel();
    setState(() {
      hourString = '00';
      minuteString = '00';
      secondString = '00';
      millisecString = '000';
      hours = 0;
      minute = 0;
      second = 0;
      millisec = 0;
      isResetButtonVisible=false;
    });
  }

  bool checkValue() {
    if (millisec != 0 || second != 0 || minute != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
  }

  void _startMilliSecond() {
    setState(() {
      millisec += 17;
      if (millisec >= 1000) {
        millisec = 0;
        _startSecond();
      }
      millisecString = millisec.toString().padLeft(3, '0');
    });
  }

  void _startSecond() {
    second++;
    if (second >= 60) {
      second = 0;
      _startMinute();
    }
    secondString = second.toString().padLeft(2, '0');
  }

  void _startMinute() {
    minute++;
    if (minute >= 60) {
      minute = 0;
      _startHour();
    }
    minuteString = minute.toString().padLeft(2, '0');
  }

  void _startHour() {
    hours++;
    hourString = hours.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Center(child: Text('S T O P W A T C H',textAlign: TextAlign.center,)),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hourString:$minuteString:$secondString.$millisecString",
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
                fontFamily: 'Courier', // Use a fixed-width font
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ElevatedButton(
                    onPressed: () {
                      if (isTimmerRunning) {
                        pauseTimer();
                      } else {
                        startTimer();
                      }
                    },
                    child: Text(isTimmerRunning ? "PAUSE" : "START")),
                SizedBox(width: 20),
                isResetButtonVisible? ElevatedButton(
                    onPressed: () {
                      restartTimer();
                    },
                    child: Text("RESET"),
                    ):SizedBox(),
              ] 
            )
          ],
        ),
      ),
    );
  }
}
