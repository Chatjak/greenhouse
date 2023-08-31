import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContainer(),
    );
  }
}

// ignore: camel_case_types
class _buildContainer extends StatefulWidget {
  const _buildContainer({Key? key}) : super(key: key);

  @override
  __buildContainerState createState() => __buildContainerState();
}

class __buildContainerState extends State<_buildContainer> {
  final dbRef = FirebaseDatabase.instance.reference();
  bool ledstatus = false;
  bool pumpstatus = true;
  bool fertilizerstatus = true;
  bool fanstatus = true;
  int ledint = 1;
  //bool checkswitch = false;

  @override
  void initState() {
    super.initState();
    //checkled();
    //checkpump();
    //checkfan();
    //checkfertilizer();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbRef.child("Data").onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "GREENHOUSE",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                        //temphumid
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              'Temperature ',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/humidity.jpg',
                                            width: 50,
                                            height: 50,
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data.snapshot
                                                          .value["Humidity"]
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Humidity  ',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ],
                    )
                        //SizedBox
                        ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        )),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      child: Row(
                        //textsmart
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Smart System',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    StreamBuilder(
                        stream: dbRef.child('switchcontrol').onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          bool checkswitch =
                              snapshot.data.snapshot.value['status'];
                          if (checkswitch == true) {
                            return Column(
                              //smartsystemfunction
                              children: [
                                Container(
                                  //smartsystem
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                                width: 140,
                                                height: 140,
                                                child: FloatingActionButton(
                                                  backgroundColor:
                                                      Colors.orange[50],
                                                  onPressed: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                          'The automation is on',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        content: const Text(
                                                            'Turn off Automation System for use function'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                              context,
                                                              'OK',
                                                            ),
                                                            child: const Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Image.asset(
                                                        'assets/images/light.jpg',
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            'OFF',
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          Text(
                                                            'Light LED',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black),
                                                            textAlign:
                                                                TextAlign.right,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0))),
                                                )),
                                            Container(
                                              child: SizedBox(
                                                width: 15,
                                                height: 100,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 140,
                                              height: 140,
                                              child: FloatingActionButton(
                                                backgroundColor: Colors.red[50],
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                        'The automation is on',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      content: const Text(
                                                          'Turn off Automation System for use function'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                            context,
                                                            'OK',
                                                          ),
                                                          child: const Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/waterpump.jpg',
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          'OFF',
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        Text(
                                                          'Water Pump',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                          textAlign:
                                                              TextAlign.right,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0))),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Container(
                                  //smartsystem2
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 140,
                                              height: 140,
                                              child: FloatingActionButton(
                                                backgroundColor:
                                                    Colors.deepPurple[50],
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                        'The automation is on',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      content: const Text(
                                                          'Turn off Automation System for use function'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                            context,
                                                            'OK',
                                                          ),
                                                          child: const Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/fertilizer.jpg',
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          'OFF',
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        Text(
                                                          'Fertilizer ',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0))),
                                              ),
                                            ),
                                            Container(
                                              child: SizedBox(
                                                width: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 140,
                                              height: 140,
                                              child: FloatingActionButton(
                                                backgroundColor:
                                                    Colors.cyan[50],
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                        'The automation is on',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      content: const Text(
                                                          'Turn off Automation System for use function'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                            context,
                                                            'OK',
                                                          ),
                                                          child: const Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/fan.jpg',
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Text(
                                                          'OFF',
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        Text(
                                                          'Fan',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                          textAlign:
                                                              TextAlign.right,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0))),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              //smartsystemfunction
                              children: [
                                Container(
                                  //smartsystem
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                                width: 140,
                                                height: 140,
                                                child: StreamBuilder(
                                                    stream: dbRef
                                                        .child('Light State')
                                                        .onValue,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      ledstatus = snapshot
                                                          .data
                                                          .snapshot
                                                          .value['switch'];
                                                      return FloatingActionButton(
                                                        backgroundColor:
                                                            Colors.orange[50],
                                                        onPressed: () {
                                                          onled();
                                                          led();
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Image.asset(
                                                              'assets/images/light.jpg',
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                            Column(
                                                              children: [
                                                                ledstatus
                                                                    ? Text(
                                                                        'ON',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.green),
                                                                      )
                                                                    : Text(
                                                                        'OFF',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                Text(
                                                                  'Light LED',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.0))),
                                                      );
                                                    })),
                                            Container(
                                              child: SizedBox(
                                                width: 15,
                                                height: 100,
                                              ),
                                            ),
                                            SizedBox(
                                                width: 140,
                                                height: 140,
                                                child: StreamBuilder(
                                                    stream: dbRef
                                                        .child('Pump State')
                                                        .onValue,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      pumpstatus = snapshot
                                                          .data
                                                          .snapshot
                                                          .value['switch'];
                                                      return FloatingActionButton(
                                                        backgroundColor:
                                                            Colors.red[50],
                                                        onPressed: () {
                                                          onpump();
                                                          pump();
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Image.asset(
                                                              'assets/images/waterpump.jpg',
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                pumpstatus
                                                                    ? Text(
                                                                        'OFF',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.red),
                                                                      )
                                                                    : Text(
                                                                        'ON',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.green),
                                                                      ),
                                                                Text(
                                                                  'Water Pump',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.0))),
                                                      );
                                                    }))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Container(
                                  //smartsystem2
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                                width: 140,
                                                height: 140,
                                                child: StreamBuilder(
                                                    stream: dbRef
                                                        .child(
                                                            'Fertilizer State')
                                                        .onValue,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      fertilizerstatus =
                                                          snapshot.data.snapshot
                                                              .value['switch'];
                                                      return FloatingActionButton(
                                                        backgroundColor: Colors
                                                            .deepPurple[50],
                                                        onPressed: () {
                                                          onfertilizer();
                                                          fertilizer();
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Image.asset(
                                                              'assets/images/fertilizer.jpg',
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                fertilizerstatus
                                                                    ? Text(
                                                                        'OFF',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.red),
                                                                      )
                                                                    : Text(
                                                                        'ON',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.green),
                                                                      ),
                                                                Text(
                                                                  'Fertilizer ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.0))),
                                                      );
                                                    })),
                                            Container(
                                              child: SizedBox(
                                                width: 15,
                                              ),
                                            ),
                                            SizedBox(
                                                width: 140,
                                                height: 140,
                                                child: StreamBuilder(
                                                    stream: dbRef
                                                        .child('Fan State')
                                                        .onValue,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                      fanstatus = snapshot
                                                          .data
                                                          .snapshot
                                                          .value['switch'];
                                                      return FloatingActionButton(
                                                        backgroundColor:
                                                            Colors.cyan[50],
                                                        onPressed: () {
                                                          onfan();
                                                          fan();
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Image.asset(
                                                              'assets/images/fan.jpg',
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                fanstatus
                                                                    ? Text(
                                                                        'OFF',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.red),
                                                                      )
                                                                    : Text(
                                                                        'ON',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.green),
                                                                      ),
                                                                Text(
                                                                  'Fan',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.0))),
                                                      );
                                                    }))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),
            ));
          }
        });
  }

  Future<void> led() async {
    dbRef.child("Light State").set({"switch": ledstatus});
  }

  Future<void> pump() async {
    dbRef.child("Pump State").set({"switch": pumpstatus});
  }

  Future<void> fertilizer() async {
    dbRef.child("Fertilizer State").set({"switch": fertilizerstatus});
  }

  Future<void> fan() async {
    dbRef.child("Fan State").set({"switch": fanstatus});
  }

  onled() {
    setState(() {
      ledstatus = !ledstatus;
    });
  }

  onpump() {
    setState(() {
      pumpstatus = !pumpstatus;
    });
  }

  onfertilizer() {
    setState(() {
      fertilizerstatus = !fertilizerstatus;
    });
  }

  onfan() {
    setState(() {
      fanstatus = !fanstatus;
    });
  }
}
