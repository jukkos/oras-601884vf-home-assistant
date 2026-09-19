# Oras 601884V-F + Home Assistant

Open-source documentation and ESPHome integration work for controlling an **Oras 601884V-F washing-machine water valve** from Home Assistant.

> **Status:** working prototype in daily use. This repository bootstrap intentionally does not contain the exact production ESPHome YAML yet; the running configuration should be copied and sanitized before publication.

## Project goal

The original Oras valve is operated through an ESP32 and a DRV8833 H-bridge so that Home Assistant can issue open/close commands while a physical illuminated push button remains available locally.

This is an independent community project and is **not affiliated with or endorsed by Oras**.

## Confirmed hardware

- ESP32
- ESPHome
- DRV8833 H-bridge
- Oras 601884V-F washing-machine water valve
- DFRobot DFR0379 adjustable buck converter
- Physical illuminated push button
- Ethernet/CAT cable used for the low-voltage push-button wiring

The ESP32 is powered separately. The DFRobot converter provides approximately **3.0–3.1 V** for the valve actuator circuit.

## Valve actuator

The actuator uses two wires and is controlled by **reversing polarity**. The DRV8833 H-bridge performs the polarity reversal.

Measured coil resistance during development was approximately **3.8–3.9 Ω**. The actuator is driven with short pulses rather than continuous power.

## Physical button

The local illuminated push button is installed and working.

Current ESP32 assignments used by the installed prototype:

- **GPIO32 / D32** — push-button input
- **GPIO33 / D33** — indicator LED output

The exact production ESPHome configuration should be added only after it has been copied from the running installation and reviewed so the public repository does not accidentally contain credentials or site-specific data.

## Home Assistant

The working installation currently exposes at least these entities:

- `button.oras_venttiili_avaa`
- `button.oras_venttiili_sulje`
- `sensor.oras_venttiili_tila_arvio`

The entities have also been exposed to Apple Home through Home Assistant.

## Current investigation

The valve control itself is working. The active reliability investigation concerns intermittent ESP32 Wi-Fi connectivity.

A recent serial-log capture showed a single Wi-Fi **authentication failure**, after which the ESP32 reconnected to the same access point within a few seconds. That observation is useful but not enough to establish the root cause.

The next step is to gather targeted serial logs around future disconnects and distinguish between:

- Wi-Fi authentication/association failures
- access-point roaming or reassociation
- ESPHome/API reconnects
- actual ESP32 resets or power-related events

See [PROJECT_STATE.md](PROJECT_STATE.md) for the current hand-off state and [docs/WORKFLOW.md](docs/WORKFLOW.md) for the cost-aware AI workflow.

## Repository principles

- Do not commit Wi-Fi credentials, API keys, passwords, local SSIDs or other secrets.
- Prefer exact measurements and observed behavior over assumptions.
- Keep the production configuration reproducible.
- Separate site-specific values from reusable logic.
- Make one controlled change at a time when debugging reliability.

## Safety

This project modifies the control of a water valve. Verify the wiring, voltages and valve behavior independently before relying on it to prevent water damage. Retain a practical local/manual way to operate or isolate the water supply.

## License

A license has not yet been selected. Until one is added, normal copyright rules apply.
