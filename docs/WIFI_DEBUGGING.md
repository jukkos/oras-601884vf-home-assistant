# ESP32 Wi-Fi debugging checklist

Use this when a real offline event occurs.

## Capture first, change later

Record the smallest serial-log window that starts before the disconnect and ends after recovery. Do not immediately change firmware or access-point settings after every event.

## Event classes

### A. Authentication / association failure

Look for messages indicating authentication failure, association rejection, disconnect reason codes or repeated connection attempts before an IP address is obtained.

### B. AP reassociation / roaming

Look for BSSID/AP changes or a disconnect followed immediately by association to another access point.

### C. ESPHome API-only interruption

Wi-Fi and IP remain healthy, but Home Assistant API disconnects/reconnects. This points away from RF association as the primary cause.

### D. Device reboot/reset

Look for the ESPHome boot banner, reset reason, watchdog, brownout, heap initialization or other unmistakable startup output.

## Record for each event

- approximate timestamp
- outage duration
- whether Home Assistant showed the entity unavailable
- whether the serial log continued during the outage
- whether BSSID/AP changed
- whether the device obtained a new DHCP lease/IP
- whether a reset reason appeared

## Current known observation

One captured event has shown an authentication failure followed by recovery to the same access point within a few seconds. Treat this as one data point, not yet the root cause of longer outages.
