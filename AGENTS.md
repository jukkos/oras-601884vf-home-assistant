# AGENTS.md

These instructions apply to AI coding agents working in this repository.

## Primary objective

Maintain and improve a reliable Home Assistant / ESPHome integration for the Oras 601884V-F valve without wasting paid model usage or risking the working installation.

## Cost-aware working rules

1. **Do not default to maximum reasoning.** Start with the smallest bounded investigation that can answer the current question.
2. Use ordinary local tools first: `grep`, `rg`, `git diff`, file inspection, log filtering, syntax checks and compile validation.
3. If local Ollama is available, use it for first-pass log summarization or large-text triage before escalating to a paid remote model.
4. Escalate model/reasoning effort only when the current evidence is genuinely ambiguous or a change spans multiple interacting subsystems.
5. Avoid repeatedly rereading the whole repository. Read only the files and log ranges needed for the current hypothesis.
6. Keep responses and generated diagnostics concise. Report observations, hypothesis, test and result.
7. Never start repeated flash/reboot loops merely to gather more data. One controlled test at a time.

## Hardware safety

- Do not actuate the physical valve merely as a diagnostic step unless the user explicitly asks for it or confirms that actuation is safe.
- Do not change actuator voltage, pulse polarity or pulse duration without first documenting the current tested values and the reason for the change.
- Prefer non-invasive observation (serial log, Wi-Fi/API state) before firmware or wiring changes.
- Preserve the physical push-button fallback.

## Source-of-truth rules

- `PROJECT_STATE.md` is the hand-off summary of the currently verified installation.
- Exact production behavior comes from the checked-in ESPHome configuration, once it has been imported from the running device.
- If documentation conflicts with the production configuration, call out the conflict instead of guessing.
- Never invent GPIO assignments, entity IDs, pulse timings, voltages or wiring details.

## Privacy / secrets

Never commit or print:

- Wi-Fi SSIDs or passwords
- ESPHome API keys
- OTA passwords
- local addresses, personal names or unrelated private infrastructure details
- tokens, secrets or credentials of any kind

Use `secrets.yaml` or environment variables for site-specific values and keep them ignored by Git.

## Debugging method

For reliability issues, use this sequence:

1. State the exact symptom and timestamp.
2. Capture the smallest useful serial-log window.
3. Determine whether the event was:
   - Wi-Fi auth/association failure
   - AP reassociation/roaming
   - ESPHome API disconnect only
   - reboot/reset/brownout/watchdog
4. Correlate with Home Assistant availability only after classifying the device-side event.
5. Change one variable at a time.
6. Record the outcome in `PROJECT_STATE.md` if it materially changes what is known.

## Git workflow

- Keep commits small and descriptive.
- Do not mix documentation cleanup with firmware-behavior changes in the same commit when avoidable.
- Before changing working production logic, show the intended diff and the expected behavior change.
- Prefer a branch/PR for meaningful firmware changes once the repository is fully populated.
