#include<WiFi.h>
#include<Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>

#define DATABASE_URL "https://smart-baby-monitoring-sy-ce203-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define API_KEY "vQLmtkPDc2brPVATQSuMRZ9yJMvExKUqVE8LN2B9"

#define ssid "Galaxy S10e"
#define password "12345678"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis =0;
unsigned long sendclock =0;
unsigned long soundtime =0;
// unsigned long motorTime =0;
bool signupOk =false;

/************************[humi]************************************/
#include "DHT.h"
#define DHT11PIN 25
DHT dht(DHT11PIN, DHT11);
/*********************Servo********************************/
//pin16
#include <ESP32Servo.h>
Servo myservo;  
int servoState;
bool servoStatus = false; 
int pos;
/*****************Toys************************************/
//pin17
Servo mytoys;  
int toysState;
bool toysStatus = false;
/*********************[babyCrying]*********************************/
bool soundsens;
const int soundpin=34;
const int threshold=100;
int soundNoti=0;
// /********************[fan]****************************************/
const int fanPin=32;
int fanState;
bool fanStatus = false;
int fanNoti=0;
/*****************************************************************************************************************************/

void setup() {

 
   /************WiFi Connecting*****************/
  Serial.begin (115200);
  WiFi.begin(ssid,password);
  Serial.print("Connenting to WiFi");

  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(500);
  }
Serial.println("\nConnected to WiFi network");
Serial.print("IP address: ");
Serial.println(WiFi.localIP());

config.api_key=API_KEY;
config.database_url= DATABASE_URL;
if(Firebase.signUp(&config,&auth,"",""))
  {
    Serial.println("SignUp Ok");
    signupOk=true;
  }else {
    Serial.printf("%s\n",config.signer.signupError.message.c_str());
  }
  config.token_status_callback=tokenStatusCallback;
  Firebase.begin(&config,&auth);
  Firebase.reconnectWiFi(true);
  /*************************************************************************************************************************/
  
  pinMode (fanPin,OUTPUT);
  pinMode (DHT11PIN,INPUT);
  mytoys.attach(17); 
  myservo.attach(16); 
  mytoys.write(90);
  dht.begin();
}

void loop() {
  
  controlFan();
  // sendTime();
  controlServo();
  controlToys();
 if ((millis()-soundtime)>120000){
     soundtime=millis();
     sendSound();
     Firebase.RTDB.setInt(&fbdo,"/notification/status",soundNoti); 
     sendfanNoti();
     Firebase.RTDB.setInt(&fbdo,"/notification/fanstatus",fanNoti);
  }
  if (Firebase.ready()&&signupOk && (millis()-sendDataPrevMillis>60000 || sendDataPrevMillis==0)){
    sendDataPrevMillis=millis();
     setTempData();
     setHumiData();

  }
  

}


void sendTime(){

  if((millis()-sendclock)>=60000){
    sendclock=millis();
                      Serial.print("clock is ");
                      Firebase.RTDB.getString(&fbdo,"/Sensor/clock");
                      int clock =fbdo.stringData().toInt();
                      clock++;
                      Serial.println(clock);
                      Firebase.RTDB.setString(&fbdo,"/Sensor/clock",(String)clock);

  }else {
    Serial.println("clock");
    delay(1000);
  }
}

void setHumiData(){

  float humi = dht.readHumidity();
  delay(1000);

  if (Firebase.RTDB.setFloat(&fbdo,"Sensor/Humidity_data",humi)){
      Serial.println();Serial.print(humi);
      Serial.print("- successfully saved to: "+fbdo.dataPath());
      
      Serial.println("(" + fbdo.dataType() + ")");
  }else {
      Serial.println("FAILED: "+ fbdo.errorReason());
    }
}
void setTempData(){

  float temp = dht.readTemperature();
  delay(1000);

   if (Firebase.RTDB.setFloat(&fbdo,"Sensor/Temperature_data",temp)){
      Serial.println();Serial.print(temp);
      Serial.print("- successfully saved to: "+fbdo.dataPath());
      Serial.println("(" + fbdo.dataType() + ")");
  }else {
      Serial.println("FAILED: "+ fbdo.errorReason());
    }
}
void controlToys(){

  if (Firebase.RTDB.getBool(&fbdo,"/Sensor/Toys")){
        if(fbdo.dataType()=="int"){
          toysState=fbdo.intData();
          toysStatus=toysState? true:false;
          
         Serial.println("successfully Read from : " +fbdo.dataPath()+": "+toysStatus + "(" +fbdo.dataType()+")");
          if(toysStatus==true){

            mytoys.write(45); // rotate the motor counterclockwise
            // delay(5000); // keep rotating for 5 seconds (5000 milliseconds)
            // mytoys.write(90); // stop the motor
            // delay(5000); // stay stopped
            // mytoys.write(135); // rotate the motor clockwise
            // delay(5000); // keep rotating :D
          }
          else {mytoys.write(90);}
           
        }

    }else {
      Serial.println("FAILED: "+ fbdo.errorReason());
     
    }
   
  
}

void controlServo(){

  if (Firebase.RTDB.getBool(&fbdo,"/Sensor/Cradle")){
        if(fbdo.dataType()=="int"){
          servoState=fbdo.intData();
          servoStatus=servoState? true:false;
          
         Serial.println("successfully Read from : " +fbdo.dataPath()+": "+servoStatus + "(" +fbdo.dataType()+")");
          if(servoStatus==true){
            for (pos = 0; pos <= 180; pos += 1) { 
                myservo.write(pos); 
                // Serial.println(pos);             
                delay(5);                      
                  }
             pos = 0;

            for (pos = 180; pos >= 0; pos -= 1) {
               myservo.write(pos);
              //  Serial.println(pos);               
               delay(5);                      
  }
          }
           
        }

    }else {
      Serial.println("FAILED: "+ fbdo.errorReason());
     
    }
   
  
}
void sendSound(){

   Serial.println("start");
   bool soundsensor = (analogRead(soundpin)>threshold? true:false);
   int soundlevel= analogRead(soundpin);
    Serial.println(soundlevel);
   if(soundsensor==true){
     soundNoti=1;
  }else{
    soundNoti=0;
  }

}
void controlFan()

  {
  if (Firebase.RTDB.getBool(&fbdo,"/Sensor/Fan")){
        if(fbdo.dataType()=="int"){
          fanState=fbdo.intData();
          fanStatus=fanState? true:false;
          // Serial.println("successfully Read from : " +fbdo.dataPath()+": "+fanStatus + "(" +fbdo.dataType()+")");
           digitalWrite(fanPin,fanStatus);
        }

    }else {
      Serial.println("FAILED: "+ fbdo.errorReason());
     
    }
}
void sendfanNoti(){
  float humiNoti = dht.readHumidity();
  if(humiNoti<40&&humiNoti>60){
  fanNoti=1;
  }else{
    fanNoti=0;
    }
}