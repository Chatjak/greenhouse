#include <ESP8266WiFi.h>
#include <DHT.h>
#include <FirebaseESP8266.h>
#include <TridentTD_LineNotify.h>
#define LINE_TOKEN ""
#define WIFI_SSID "NRRU"
#define WIFI_PASSWORD "12345678"
#define FIREBASE_HOST "greenhouse-24394-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "zUhlM17SQFAHE2kqfLUbbRkpj2XpFeuL34CL3rx9"
#define DHTPIN    D1
#define DHTTYPE   DHT22
FirebaseData fbdo;
DHT dht(DHTPIN, DHTTYPE);
int i = 0;
int j = 0;
float humid = 0;
float temp  = 0;
int analogPin = A0; //ประกาศตัวแปร ให้ analogPin แทนขา analog ขาที่5
int soil = 0;
bool ledstatus;
bool fanstatus;
bool fertilizerstatus;
bool pumpstatus;
String vpump;
String vtemp;
bool switchcontrol;
void setup() {
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  dht.begin();
  LINE.setToken(LINE_TOKEN);
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  pinMode(D2, OUTPUT); // หลอดไฟ
  pinMode(D3, OUTPUT); // ปั้มน้ำ
  pinMode(D4, OUTPUT); // พัดลม
  pinMode(D5, OUTPUT); // ปุ๋ย
}

void loop() {
  humid = dht.readHumidity();
  delay(500);
  temp  = dht.readTemperature();
  soil = analogRead(analogPin);
  if (isnan(humid) || isnan(temp)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }
  delay(500);
  Firebase.setFloat(fbdo, "/Data/Temperature", temp); //sent temp to firebase
  Firebase.setFloat(fbdo, "/Data/Humidity", humid); // set humid to firebase
  Firebase.setFloat(fbdo, "/Data/Soil", soil); // set soil to firebase
  if (Firebase.getBool(fbdo, "/switchcontrol/status")) {
    switchcontrol = fbdo.boolData();
  }
  if (switchcontrol == true) {
    switchtrue();
  }
  else {
    switchoff();
  }
}
void switchtrue() {
  Serial.println("Auto กำลังทำงาน");
  if (Firebase.getString(fbdo, "/Auto/fanint")) { // temp for on cooling fan
    vtemp = fbdo.stringData();
    Serial.print("ส่งอุณหภูมิมา : ");
    Serial.println(vtemp.toInt());
    if (temp > vtemp.toInt()) {
      Serial.print("----------- fan auto -----------");
      digitalWrite(D4, false);
      if (i < 1) {
        LINE.notify("อุณหภูมิ : "+ String(temp) +"องศา ร้อนกว่ากำหนด : "+ vtemp);
        i=1;
      }
    } else {
      digitalWrite(D4, true);
      i = 0;
    }
  }
  if (Firebase.getString(fbdo, "/Auto/pumpint")) {
    vpump = fbdo.stringData();
    Serial.print("ส่งความชื้นในดินมา : ");
    Serial.println(vpump.toInt());
    if (soil < vpump.toInt()) {
      Serial.print("----------- Pump auto -----------");
      digitalWrite(D3, false);
      if (j < 1) {
        LINE.notify("ความชื้นในดิน : "+ String(soil) +"ต่ำกว่ากำหนด : "+ vpump);
        j=1;
      }else {
      digitalWrite(D3, true);
      j = 0;
    }
  }
}
}

void switchoff() {
  if (Firebase.getBool(fbdo, "/Light State/switch")) { // หลอดไฟ
    ledstatus = fbdo.boolData();
    digitalWrite(D2, ledstatus);
  }
  if (Firebase.getBool(fbdo, "/Pump State/switch")) { // ปั้มน้ำ
    pumpstatus = fbdo.boolData();
    digitalWrite(D3, pumpstatus);
  }
  if (Firebase.getBool(fbdo, "/Fan State/switch")) { // พัดลม
    fanstatus = fbdo.boolData();
    digitalWrite(D4, fanstatus);
  }
  if (Firebase.getBool(fbdo, "/Fertilizer State/switch")) { // ปุ๋ย
    fertilizerstatus = fbdo.boolData();
    digitalWrite(D5, fertilizerstatus);
  }
}
