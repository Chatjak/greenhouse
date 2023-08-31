//             StreamBuilder(
//                        stream: dbRef.child('Auto').onValue,
//                        builder:
//                            (BuildContext context, AsyncSnapshot snapshot) {
//                          if (!snapshot.hasData) {
//                            return Container();
//                          } else {
//                            TextEditingController textpump =
//                                TextEditingController();
//                            TextEditingController textfan =
//                                TextEditingController();
//                            return Container(
//                              child: Column(
//                                children: [
//                                  Text(
//                                    "Automations",
//                                    style: TextStyle(fontSize: 25),
//                                  ),
//                                  Container(
//                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceAround,
//                                      children: [
//                                        SizedBox(
//                                          width: 350,
//                                          child: ElevatedButton(
//                                              style: ElevatedButton.styleFrom(
//                                                primary: Colors
//                                                    .green[50], // background
//                                                onPrimary: Colors.black,
//                                              ),
//                                              onPressed: () {
//                                                showDialog(
//                                                  context: context,
//                                                  builder:
//                                                      (BuildContext context) =>
//                                                          AlertDialog(
//                                                    title: const Text(
//                                                      'Automations',
//                                                      style: TextStyle(
//                                                          color: Colors.black),
//                                                    ),
//                                                    insetPadding:
//                                                        EdgeInsets.symmetric(
//                                                      vertical: 150,
//                                                    ),
//                                                    content: Column(
//                                                      children: [
//                                                        SizedBox(
//                                                          width: 200,
//                                                          child: TextField(
//                                                            controller:
//                                                                textpump,
//                                                            decoration: InputDecoration(
//                                                                border:
//                                                                    UnderlineInputBorder(),
//                                                                labelText:
//                                                                    'Input Soil moisture'),
//                                                            textAlign: TextAlign
//                                                                .center,
//                                                            style: TextStyle(
//                                                                fontWeight:
//                                                                    FontWeight
//                                                                        .bold,
//                                                                fontSize: 18),
//                                                            keyboardType:
//                                                                TextInputType
//                                                                    .number,
//                                                          ),
//                                                        ),
//                                                        SizedBox(
//                                                          width: 200,
//                                                          child: TextField(
//                                                            controller: textfan,
//                                                            decoration: InputDecoration(
//                                                                border:
//                                                                    UnderlineInputBorder(),
//                                                                labelText:
//                                                                    'Input Temperature'),
//                                                            textAlign: TextAlign
//                                                                .center,
//                                                            style: TextStyle(
//                                                                fontWeight:
//                                                                    FontWeight
//                                                                        .bold,
//                                                                fontSize: 18),
//                                                            keyboardType:
//                                                                TextInputType
//                                                                    .number,
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    actions: <Widget>[
//                                                      TextButton(
//                                                        onPressed: () =>
//                                                            Navigator.pop(
//                                                          context,
//                                                          'OK',
//                                                        ),
//                                                        child: const Text(
//                                                          'OK',
//                                                          style: TextStyle(
//                                                              color:
//                                                                  Colors.red),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                );
//                                              },
//                                              child: Column(
//                                                children: [
//                                                  Column(
//                                                    children: [
//                                                      SizedBox(
//                                                        child: Container(
//                                                          child: Text(
//                                                              "Soil Moisture : " +
//                                                                  snapshot
//                                                                      .data
//                                                                      .snapshot
//                                                                      .value[
//                                                                          "pumpint"]
//                                                                      .toString() +
//                                                                  " mv",
//                                                              style: TextStyle(
//                                                                  fontSize:
//                                                                      20)),
//                                                        ),
//                                                      ),
//                                                      SizedBox(
//                                                        child: Container(
//                                                          child: Text(
//                                                            "Temperature : " +
//                                                                snapshot
//                                                                    .data
//                                                                    .snapshot
//                                                                    .value[
//                                                                        "fanint"]
//                                                                    .toString() +
//                                                                " °C",
//                                                            style: TextStyle(
//                                                                fontSize: 20),
//                                                          ),
//                                                        ),
//                                                      )
//                                                    ],
//                                                  ),
//                                                ],
//                                              )),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            );
//                          }
//                        }),