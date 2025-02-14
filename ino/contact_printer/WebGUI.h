#ifndef WEBGUI
#define WEBGUI

#include <Arduino.h>
#include <WiFi.h>
#include <WiFiClient.h>
#include <WiFiAP.h>
#include <WebServer.h>
#include <ESPmDNS.h>
#include <ArduinoJson.h>

class WebGUI {
	private:
	const char *AP_SSID = "contact_printer";
	const char *DEFAULT_PASSWORD = "contact_printer";
	const char *MDNS_NAME = "contact_printer";
	//IPAddress wifiIP;
	//String IP;
	//DynamicJsonDocument postJSON(1024);
	WebServer server(80);

	protected:
	static void HandleNotFound();

	public:
	WebGUI();
	void Setup();
	void Loop();

};

#endif