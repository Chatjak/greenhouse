import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class autocontrol extends StatefulWidget {
  const autocontrol({Key? key}) : super(key: key);

  @override
  _autocontrolState createState() => _autocontrolState();
}

class _autocontrolState extends State<autocontrol> {
  String _currentSliderValue = "150";
  String _currentSliderValue2 = "25";
  bool isSwitched = false;
  double pumpint = 0;
  double fanint = 0;
  int isStatus = 1;

  TextEditingController textpump = TextEditingController();
  TextEditingController textfan = TextEditingController();
  final db2 = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    //db2.child('switchcontrol').once().then((DataSnapshot snapshot) {
    //  isSwitched = snapshot.value;
    //});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 35,
                    ),
                    Text('     Automations',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    StreamBuilder(
                        stream: db2.child('switchcontrol').onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          isSwitched = snapshot.data.snapshot.value['status'];
                          print(isSwitched);
                          return Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  print("Click" + isSwitched.toString());
                                });
                                switchcontrol();
                              });
                        }),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/25010.jpg',
                    width: 300,
                    height: 200,
                  )
                ],
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                      stream: db2.child('Data').onValue,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Column(
                          children: [
                            Container(
                                child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/plant.jpg',
                                  width: 50,
                                  height: 50,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data.snapshot.value["Soil"]
                                                .toString() +
                                            " mv",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '  Soil moisture',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/temperature.jpg',
                                  width: 50,
                                  height: 50,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data.snapshot
                                                .value["Temperature"]
                                                .toString() +
                                            " °C",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '  Temperature',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                          ],
                        );
                      }),
                ],
              )),
              SizedBox(
                height: 25,
              ),
              StreamBuilder(
                  stream: db2.child('switchcontrol').onValue,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    isSwitched = snapshot.data.snapshot.value['status'];
                    return isSwitched ? enablewidget() : diswidget();
                  })
            ],
          ),
        ),
      )),
    );
  }

  Column enablewidget() {
    return Column(
      children: [
        Semantics(
          child: SizedBox(
            width: 250,
            child: TextField(
              enabled: true,
              controller: textpump,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Input Soil moisture',
                  labelStyle: TextStyle(fontSize: 20)),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Semantics(
          child: SizedBox(
            width: 250,
            child: TextField(
              enabled: true,
              controller: textfan,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Input Temperature',
                  labelStyle: TextStyle(fontSize: 20)),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentSliderValue = textpump.text;
                _currentSliderValue2 = textfan.text;
                if (_currentSliderValue == "") {
                  if (_currentSliderValue2 == "") {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'TextField is empty',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text('Please input number in TextField'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              'OK',
                            ),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  control();
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Data saved ',
                        style: TextStyle(color: Colors.green),
                      ),
                      content: const Text('Data saved on firebase'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(
                            context,
                            'OK',
                          ),
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'เงื่อนไข',
                    style: TextStyle(color: Colors.green),
                  ),
                  content: const Text(
                      'If Soil moisture < input = Water pump on !! \nIf Tempurature > input = Fan on !!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                        'OK',
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              '?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Column diswidget() {
    return Column(
      children: [
        Semantics(
          child: SizedBox(
            width: 250,
            child: TextField(
              enabled: false,
              controller: textpump,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'กรอกค่าความชื้นในดิน',
                  labelStyle: TextStyle(fontSize: 20)),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Semantics(
          child: SizedBox(
            width: 250,
            child: TextField(
              enabled: false,
              controller: textfan,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'กรอกค่าอุณหภูมิ',
                  labelStyle: TextStyle(fontSize: 20)),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: null,
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'เงื่อนไข',
                    style: TextStyle(color: Colors.green),
                  ),
                  content: const Text(
                      '1. ความชื้นในดิน < input = ปั้มน้ำทำงาน !! \n2. อุณหภูมิ > input = พัดลมทำงาน !!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                        'OK',
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              '?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Future<void> control() async {
    db2.child("Auto").set({
      'pumpint': _currentSliderValue.toString(),
      'fanint': _currentSliderValue2.toString()
    });
  }

  Future<void> switchcontrol() async {
    db2.child("switchcontrol").set({'status': isSwitched});
  }
}
