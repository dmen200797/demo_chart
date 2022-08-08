import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChart extends StatefulWidget {
  final Function touchCallBack;

  const _LineChart(this.enableBuildOnTouch, this.touchCallBack);

  final bool enableBuildOnTouch;

  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  bool enableBuildOnTouch = false;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 24,
        maxY: 121,
        minY: 0,
        showingTooltipIndicators: [
          ShowingTooltipIndicators([
            LineBarSpot(
                lineChartBarData1_1,
                lineBarsData.indexOf(lineChartBarData1_1),
                lineChartBarData1_1.spots[allSpots1.length - 1]),
          ]),
        ],
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: enableBuildOnTouch,
        touchCallback: (data, response) {
          if (data is FlPanEndEvent) {
            enableBuildOnTouch = false;
            setState(() {});
          }
          if (data is FlPanDownEvent) {
            enableBuildOnTouch = true;
            setState(() {});
          }
        },
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.orange,
            getTooltipItems: (touchedSpots) {
              List<LineTooltipItem> listItem = [];
              int count = 0;
              for (var touchedSpot in touchedSpots) {
                const textStyle1 = TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                const textStyle2 = TextStyle(
                  fontSize: 0,
                );
                listItem.add(
                  LineTooltipItem(
                    '🕓${touchedSpot.x.toStringAsFixed(0)}時   🚹${touchedSpot.y.toStringAsFixed(0)}%',
                    count == 0 ? textStyle1 : textStyle2,
                    children: [],
                  ),
                );
                count++;
              }
              return listItem;
            }),
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map(
            (index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.grey,
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 8,
                    color: Colors.orange,
                    strokeWidth: 2,
                    strokeColor: Colors.transparent,
                  ),
                ),
              );
            },
          ).toList();
        },
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      case 120:
        text = '120';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0時', style: style);
        break;
      case 3:
        text = const Text('3時', style: style);
        break;
      case 6:
        text = const Text('6時', style: style);
        break;
      case 9:
        text = const Text('9時', style: style);
        break;
      case 12:
        text = const Text('12時', style: style);
        break;
      case 15:
        text = const Text('15時', style: style);
        break;
      case 18:
        text = const Text('18時', style: style);
        break;
      case 21:
        text = const Text('21時', style: style);
        break;
      case 24:
        text = const Text('24時', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 20,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  int currentSpot1Index(int data) =>
      allSpots1.indexWhere((element) => element.x == data);

  final List<FlSpot> allSpots1 = const [
    FlSpot(0, 40),
    FlSpot(3, 25),
    FlSpot(6, 30),
    FlSpot(9, 55),
    FlSpot(11, 80),
    FlSpot(12, 90),
  ];

  final List<FlSpot> allSpots2 = const [
    FlSpot(0, 40),
    FlSpot(3, 30),
    FlSpot(6, 35),
    FlSpot(9, 55),
    FlSpot(12, 80),
    FlSpot(15, 60),
    FlSpot(18, 40),
    FlSpot(21, 60),
    FlSpot(24, 30),
  ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.grey,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        showingIndicators: [allSpots1.length - 1],
        spots: allSpots1,
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.grey.withOpacity(0.5),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        spots: allSpots2,
      );
}

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  bool enableBuildOnTouch = false;
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 2),
              right: BorderSide(color: Colors.grey, width: 2),
              left: BorderSide(color: Colors.grey, width: 2),
              top: BorderSide(color: Colors.grey, width: 2),
            ),
            color: Colors.white),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.grey,
                    ),
                    const Text(
                      '前日',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Text(
                          '2023/07/06',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '翌日',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: _LineChart(enableBuildOnTouch,
                        (FlTouchEvent? data, LineTouchResponse? response) {
                      x = data?.localPosition?.dx ?? 100;
                      y = data?.localPosition?.dy ?? 100;
                      setState(() {});
                    }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            // Positioned(
            //   top: y,
            //   left: x,
            //   child: Container(
            //     height: 40,
            //     width: 40,
            //     color: Colors.red,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
