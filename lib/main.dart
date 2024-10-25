import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
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
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  String _formattedTime = '00:00:00';
  bool _isStopped = true;

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
    setState(() {
      _stopwatch.start();
      _isStopped = false;
    });
  }

  void _stopOrResetStopwatch() {
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
            Text(
              'Stopwatch',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 0.0),
            Text(
              _formattedTime,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
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
