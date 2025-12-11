import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:light/light.dart';
import 'package:my_light_sensor/my_light_sensor.dart';

class LuxmeterTerrariumPage extends StatefulWidget {
  final TerrariumEntity terrarium;
  const LuxmeterTerrariumPage({super.key, required this.terrarium});

  @override
  State<LuxmeterTerrariumPage> createState() => _LuxmeterTerrariumPage();
}

enum LuxMeterStatus { low, good, perfect, high, extreme }

class _LuxmeterTerrariumPage extends State<LuxmeterTerrariumPage> {
  Light? _light;
  Timer? timerIOS;
  final _myLightSensor = MyLightSensor();
  StreamSubscription? _subscription;
  int lux = 0;

  LuxMeterStatus status = LuxMeterStatus.low;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) startListening();
    if (Platform.isIOS) initIOSLuxmeter();
  }

  @override
  void dispose() {
    if (Platform.isAndroid) stopListening();
    if (Platform.isIOS) timerIOS?.cancel();
    super.dispose();
  }

  void initIOSLuxmeter() async {
    timerIOS ??=
        Timer.periodic(const Duration(milliseconds: 10), (Timer t) async {
      double luxValue = await _myLightSensor.getLuxValue() ?? 0;
      onData(luxValue.toInt().abs());
    });
  }

  void onData(int luxValue) async {
    bool haveSaxifraga =
        (widget.terrarium.actualPlants ?? widget.terrarium.plants)!
            .contains('saxifraga stolonifera');
    if (!mounted) return;
    setState(() {
      if (haveSaxifraga) {
        status = luxValue < 1500
            ? LuxMeterStatus.low
            : luxValue < 5000
                ? LuxMeterStatus.good
                : luxValue < 40000
                    ? LuxMeterStatus.perfect
                    : luxValue < 40000
                        ? LuxMeterStatus.high
                        : LuxMeterStatus.extreme;
      } else {
        status = luxValue < widget.terrarium.minLux!
            ? LuxMeterStatus.low
            : luxValue < widget.terrarium.minPerfectLux!
                ? LuxMeterStatus.good
                : luxValue < widget.terrarium.maxPerfectLux!
                    ? LuxMeterStatus.perfect
                    : luxValue < widget.terrarium.maxLux!
                        ? LuxMeterStatus.high
                        : LuxMeterStatus.extreme;
      }
      lux = luxValue;
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light?.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  List<Color> _getColors() {
    switch (status) {
      case LuxMeterStatus.low:
      case LuxMeterStatus.extreme:
        return [const Color(0xffF27B6D), const Color(0xffEF6F79)];
      case LuxMeterStatus.good:
      case LuxMeterStatus.high:
        return [const Color(0xfff7ad64), const Color(0xfff99c39)];
      case LuxMeterStatus.perfect:
        return [const Color(0xff0eae56), const Color(0xff2b874b)];
    }
  }

  String _getIcon() {
    switch (status) {
      case LuxMeterStatus.low:
      case LuxMeterStatus.extreme:
        return 'dislike_thin';
      case LuxMeterStatus.good:
      case LuxMeterStatus.high:
        return 'warning_thin';
      case LuxMeterStatus.perfect:
        return 'like_thin';
    }
  }

  String _getText() {
    switch (status) {
      case LuxMeterStatus.low:
        return 'Troppo basso';
      case LuxMeterStatus.good:
        return 'Bene';
      case LuxMeterStatus.perfect:
        return 'Perfetto';
      case LuxMeterStatus.high:
        return 'Alto';
      case LuxMeterStatus.extreme:
        return 'Troppo alto';
    }
  }

  String _getDescription() {
    switch (status) {
      case LuxMeterStatus.low:
        return 'Al tuo terrario serve più luce';
      case LuxMeterStatus.good:
        return 'Ok, ma più luce sarebbe meglio';
      case LuxMeterStatus.perfect:
        return 'Qui il tuo terrario starà benissimo';
      case LuxMeterStatus.high:
        return 'Ok, ma meno luce sarebbe meglio';
      case LuxMeterStatus.extreme:
        return 'Non esporre direttamente al sole';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getColors(),
        ),
      ),
      child: Scaffold(
        appBar: appbar(),
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$lux",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "lx",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SvgIcon(
              icon: _getIcon(),
              size: MediaQuery.of(context).size.width - 60,
              color: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              _getText(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              _getDescription(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Controlla il livello di lux',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _getColors()[0],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff7B6F72).withValues(alpha: 0.16),
                  blurRadius: 40,
                  spreadRadius: 0.0,
                  blurStyle: BlurStyle.outer,
                ),
              ]),
          child: const SvgIcon(
            icon: "arrow-left",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
