# Project state

Last bootstrap update: 2026-09-19

## Overall status

The Oras valve integration is **functionally working** in Home Assistant. The current engineering focus is reliability of the ESP32 network connection, not basic valve control.

## Confirmed architecture

- ESP32 running ESPHome
- DRV8833 H-bridge drives the two-wire Oras actuator by polarity reversal
- DFRobot DFR0379 provides approximately 3.0–3.1 V to the actuator circuit
- ESP32 has separate power
- physical illuminated push button remains in use

## Confirmed measurements / wiring

- actuator/coil resistance measured approximately 3.8–3.9 Ω
- GPIO32 / D32: physical push-button input
- GPIO33 / D33: push-button LED output
- push-button wiring is carried over CAT/Ethernet cable
- four conductors remained available in the button cable after the button/LED wiring was completed

## Home Assistant state

Known working entities include:

- `button.oras_venttiili_avaa`
- `button.oras_venttiili_sulje`
- `sensor.oras_venttiili_tila_arvio`

The entities have been exposed to Apple Home through Home Assistant.

The state sensor is an **estimated/logical state**, not a direct physical position sensor. Any future design must preserve the distinction between commanded/estimated state and independently measured valve position.

## Current Wi-Fi reliability investigation

Observed behavior prior to this bootstrap:

- ESP32 Wi-Fi has intermittently gone offline even though other nearby client devices have remained usable.
- Device-side location and enclosure may attenuate the ESP32 PCB antenna.
- Access-point auto-selection was tried for multiple days and did not clearly resolve the issue.
- A serial-log capture with the current firmware showed one `Authentication Failed` event.
- After that event, the ESP32 reconnected to the same access point within roughly a few seconds.
- A single successful recovery is not enough to explain the longer offline incidents.

### Important correction to earlier assumptions

Do **not** assume the device automatically reboots after approximately five minutes offline unless a future log proves it. The currently known configuration includes Wi-Fi AP fallback/rescue behavior, but the exact reboot behavior must be verified from the production YAML rather than inferred.

## Next investigation

1. Import the exact production ESPHome YAML from the running project.
2. Sanitize credentials/site-specific data into `secrets.yaml` references.
3. Confirm Wi-Fi settings, fallback AP behavior, reboot timeout and logger level from the actual YAML.
4. Capture a bounded serial log during the next real disconnect.
5. Look specifically for:
   - `Authentication Failed`
   - association/disassociation reason codes
   - AP/BSSID change
   - DHCP loss/reacquisition
   - ESPHome API disconnect/reconnect
   - boot banner / reset reason
   - brownout/watchdog indicators
6. Only after classification decide whether the next change should be antenna placement, Wi-Fi configuration, hardware, or firmware.

## Do not change yet

Until the production YAML is imported and reviewed, do not casually change:

- actuator pulse timing
- DRV8833 polarity logic
- physical push-button behavior
- valve state-estimation logic
- GPIO assignments

These parts are currently working.

## Missing from repository

The repository still needs the exact current production ESPHome configuration. Do not reconstruct it from memory if the original is available locally.
