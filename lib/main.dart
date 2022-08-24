import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlChart Demo',
      showPerformanceOverlay: false,
      theme: ThemeData(
        primaryColor: const Color(0xff262545),
        primaryColorDark: const Color(0xff201f39),
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'fl_chart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var baselineX = 0.0;
  var baselineY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: SizedBox(
                    child: Chart(baselineX, (20 - (baselineY + 10)) - 10),
                    width: 400,
                  ),
                ),
                SizedBox(
                  child: Slider(
                    value: baselineX,
                    onChanged: (newValue) {
                      setState(() {
                        baselineX = newValue;
                      });
                    },
                    min: -10,
                    max: 10,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final double baselineX;
  final double baselineY;

  const Chart(this.baselineX, this.baselineY) : super();

  TextStyle getHorizontalTextStyle(context, value) {
    if ((value - baselineX).abs() <= 0.1) {
      return const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    } else {
      return const TextStyle(color: Colors.white60, fontSize: 14);
    }
  }

  TextStyle getVerticalTextStyle(context, value) {
    if ((value - baselineY).abs() <= 0.1) {
      return const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    } else {
      return const TextStyle(color: Colors.white60, fontSize: 14);
    }
  }

  FlLine getHorizontalVerticalLine(double value) {
    if ((value - baselineY).abs() <= 0.1) {
      return FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  FlLine getVerticalVerticalLine(double value) {
    if ((value - baselineX).abs() <= 0.1) {
      return FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [],
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: getHorizontalVerticalLine,
          getDrawingVerticalLine: getVerticalVerticalLine,
        ),
        minY: -10,
        maxY: 10,
        baselineY: baselineY,
        minX: -10,
        maxX: 10,
        baselineX: baselineX,
      ),
      swapAnimationDuration: Duration.zero,
    );
  }
}

// import 'package:demo_chart/line_chart.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Demo Chart'),
//       ),
//       body: const Center(
//         child: SizedBox(
//           height: 500,
//           width: 410,
//           child: LineChartWidget(),
//         )
//       ),
//     );
//   }
// }
