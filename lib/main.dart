import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchHomePage(),
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  const StopwatchHomePage({super.key});

  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  String _formattedTime = '00:00:00';
  bool _isStopped = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 100), _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _formattedTime = _formatElapsedTime(_stopwatch.elapsed);
      });
    }
  }

  String _formatElapsedTime(Duration elapsed) {
    String hours = (elapsed.inHours).toString().padLeft(2, '0');
    String minutes = (elapsed.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void _startStopwatch() {
    if (_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _stopwatch.start();
      _isStopped = false;
    });
  }

  void _stopOrResetStopwatch() {
    if (_formattedTime == '00:00:00') {
      return;
    }
    if (_isStopped) {
      _stopwatch.reset();
      _formattedTime = '00:00:00';
    } else {
      _stopwatch.stop();
    }
    setState(() {
      _isStopped = !_isStopped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Hours
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        _formattedTime.split(':')[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                // Minutes
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        _formattedTime.split(':')[1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                // Seconds
                SizedBox(
                  width: 50,
                  child: Text(
                    _formattedTime.split(':')[2],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text('Start'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _stopOrResetStopwatch,
                  child: Text(_isStopped ? 'Reset' : 'Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
