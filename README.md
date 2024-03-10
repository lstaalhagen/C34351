# C34351

Scripts and miscellaneous files for course **34351 Access networks and home networks**. To install relevant packages/SW and prepare the VM for the course, run the ```<nn>-<software>-install.sh``` scripts, *starting with the **01-General-install.sh** script*.

1. 01-General-install.sh : Installs additional common software, disables some irrelevant system services, etc.
2. 02-MininetWiFi-install.sh : Downloads and installs the latest version of Mininet-WiFi (see https://mininet-wifi.github.io/)
3. 03-OMNeTpp-install.sh : Downloads and installs OMNeT++ network simulator. The version is specified using an environment variable at the start of the script.
4. 04-MQTTCoAP-install.sh : Downloads and installs the Mosquitto Broker and clients, and the libcoap CoAP software for the exercises
5. 99-Misc-install.sh : Sets some personal preferences - can be skipped.
