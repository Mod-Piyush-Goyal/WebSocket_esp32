#include <WiFi.h>
#include <WebSocketsServer.h>

const char* ssid = "MY_ESP11";     // Replace with your Wi-Fi SSID
const char* password = "********"; // Replace with your Wi-Fi password

WebSocketsServer webSocket = WebSocketsServer(81);  // WebSocket on port 81

void onWebSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
    switch (type) {
        case WStype_CONNECTED:
            Serial.printf("[%u] Connected\n", num);
            webSocket.sendTXT(num, "Hello from ESP32!");
            break;

        case WStype_TEXT:
            Serial.printf("[%u] Received: %s\n", num, payload);
            webSocket.sendTXT(num, "Message received!");
            break;

        case WStype_DISCONNECTED:
            Serial.printf("[%u] Disconnected\n", num);
            break;
    }
}

void setup() {
    Serial.begin(115200);

    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to Wi-Fi...");
    }

    Serial.println("Connected to Wi-Fi");
    Serial.print("ESP32 IP Address: ");
    Serial.println(WiFi.localIP());  // Print ESP32 IP

    webSocket.begin();
    webSocket.onEvent(onWebSocketEvent);
}

void loop() {
    webSocket.loop();
}
