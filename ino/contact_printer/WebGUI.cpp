#include "WebGUI.h"

void WebGUI::Setup () {
	
}

void WebGUI::Loop () {
	
}

void WebGUI::HandleNotFound() {
	String res = "404 Not Found\n\n";
	res += "URI: ";
	res += server.uri();
	res += "\nMethod: ";
	res += (server.method() == HTTP_GET) ? "GET" : "POST";
	res += "\nArguments: ";
	res += server.args();
	res += "\n";

	for (uint8_t i = 0; i < server.args(); i++) {
		res += " " + server.argName(i) + ": " + server.arg(i) + "\n";
	}

	server.send(404, "text/plain", res);
}