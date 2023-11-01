import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DataTable & Chart Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TableRow> _dataRows = [];
  List<String> _itemList = [];
  List<int> _valueList = [];

  TextEditingController _itemController = TextEditingController();
  TextEditingController _valueController = TextEditingController();


  List<Series<ChartData, String>> _chartData = [];
  List<ChartData> _mydata = [];

  @override
  void initState() {
    super.initState();
    _initializeChartData(); // Call the initializer function
  }

  void _initializeChartData() {
    // Initialize chart data with any initial data
    _chartData = [
      Series(
        id: 'chartData',
        data: _generateInitialChartData(), // Function to generate initial data
        domainFn: (ChartData data, _) => data.item,
        measureFn: (ChartData data, _) => data.value,
      ),
    ];
  }

  //HW: REFACTOR
  List<ChartData> _generateInitialChartData() {
    return _mydata;
  }

  void _addDataRow() {
    setState(() {
      String newItem = _itemController.text;
      int newValue = int.tryParse(_valueController.text) ?? 0;

      if (newItem.isNotEmpty) {
        _itemList.add(newItem);
        _valueList.add(newValue);

        _dataRows.add(
          TableRow(children: [
            TableCell(
              child: Center(child: Text(newItem)),
            ),
            TableCell(
              child: Center(child: Text(newValue.toString())),
            ),
          ]),
        );

        _mydata.add(ChartData(newItem, newValue));
        _initializeChartData();
      }

      _itemController.clear();
      _valueController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter DataTable & Chart Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Table(
              children: _dataRows,
              border: TableBorder.all(),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
            TextFormField(
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Value'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _addDataRow,
              child: Text('Add Data Row'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: PieChart(
                _chartData,
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String item;
  final int value;

  ChartData(this.item, this.value);
}
