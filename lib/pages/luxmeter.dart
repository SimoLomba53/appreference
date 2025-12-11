import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:light/light.dart';
import 'package:my_light_sensor/my_light_sensor.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class LuxmeterPage extends StatefulWidget {
  const LuxmeterPage({super.key});

  @override
  State<LuxmeterPage> createState() => _LuxmeterPageState();
}

class _LuxmeterPageState extends State<LuxmeterPage> {
  Light? _light;
  Timer? timerIOS;
  final _myLightSensor = MyLightSensor();
  StreamSubscription? _subscription;
  int lux = 0;
  int min = 999999, max = 0, avg = 0;

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
    if (!mounted) return;
    setState(() {
      lux = luxValue;
      if (lux < min) min = lux;
      if (lux > max) max = lux;
      avg = (min + max) ~/ 2;
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

  getLuxPercentage() {
    return lux > 1000 ? 1.0 : lux / 1000;
  }

  _refreshDatas() {
    setState(() {
      lux = 0;
      min = 999999;
      max = 0;
      avg = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Expanded(child: progressIndicator(context)),
          progressIndicator(context),
          const SizedBox(height: 15),
          values(),
          //const SizedBox(height: 15),
          //Expanded(child: chart()),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x881D1617),
              blurRadius: 40,
              spreadRadius: 0.0,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Color(0xff2B874B),
              Color(0xff0EAE56),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            _refreshDatas();
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const SvgIcon(
            icon: 'rotate-right',
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  CircularPercentIndicator progressIndicator(BuildContext context) {
    return CircularPercentIndicator(
      radius: MediaQuery.sizeOf(context).width / 3,
      lineWidth: 20.0,
      percent: getLuxPercentage(),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$lux",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Text(
            "lx",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      linearGradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            const Color(0xff2B874B),
            const Color(0xff0EAE56),
            if (lux > 800) const Color(0xff2B874B)
          ]),
      backgroundColor: const Color.fromARGB(68, 55, 51, 52),
      rotateLinearGradient: true,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  LineChart chart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color(0xff2B874B),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Color(0xff2B874B),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 3.1),
              FlSpot(8, 4),
              FlSpot(9.5, 3),
              FlSpot(11, 4),
            ],
            isCurved: true,
            gradient: const LinearGradient(
              colors: [
                Color(0xff2B874B),
                Color(0xff0EAE56),
              ],
            ),
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xff2B874B),
                  const Color(0xff0EAE56),
                ].map((color) => color.withValues(alpha:0.3)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget values() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                (min > 9999 ? 0 : min).toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'minimo',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                avg.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'media',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                max.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'massimo',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Luxometro',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
