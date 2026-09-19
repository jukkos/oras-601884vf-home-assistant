# Cost-aware development workflow

The goal is that the project owner should **not** need to choose an AI model or reasoning level for every question.

## Default workflow

### 1. ChatGPT = coordinator

Start the technical question in the normal ChatGPT conversation. Use it to:

- define the problem
- decide what evidence is needed
- review logs, screenshots and GitHub state
- design the next controlled test
- decide whether local execution is actually required

This avoids consuming coding-agent credits for planning, discussion and simple analysis.

### 2. GitHub = durable source of truth

Keep tested configuration, documentation, history and issue state in GitHub. AI conversations are not the only project memory.

When GitHub write access is available to ChatGPT, routine documentation and small repository changes can be made directly without opening a separate coding-agent session.

### 3. Local Ollama = cheap bulk analysis

Use the locally installed `qwen3-coder:30b` for tasks such as:

- reducing large ESPHome serial logs to the relevant event window
- finding repeated error patterns
- producing a first-pass hypothesis list
- checking large diffs or repetitive configuration text

A helper script is included in `scripts/ollama_log_triage.sh`.

### 4. Codex / Work = execution specialist

Use a coding agent when the task genuinely needs access to the local repository, terminal, compiler, device flashing or multi-file edits.

Do not use the most expensive/highest-reasoning mode merely because it is available. First define a bounded task and provide the existing evidence so the agent does not spend credits rediscovering project context.

## Good task hand-off

Instead of:

> Figure out why the Oras project is unreliable.

Prefer:

> Here is a 90-second serial log covering one offline event. Classify whether this is Wi-Fi authentication/association, ESPHome API disconnect, or an ESP32 reset. Do not modify firmware yet. Return the evidence lines and one next test.

That keeps the task small, measurable and cheap.

## Escalation rule

Only escalate to a heavier model/reasoning setting when at least one of these is true:

- evidence from multiple subsystems conflicts
- the same bounded test has produced contradictory results
- a firmware change has safety/reliability consequences across multiple components
- the smaller/local model cannot produce a coherent hypothesis supported by the logs

The user should not be expected to make this routing decision manually; the coordinator should recommend it when needed.

## Repository-local OpenCode default

This bootstrap includes `opencode.json` with:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "ollama/qwen3-coder:30b"
}
```

OpenCode currently supports local Ollama models and project-level `AGENTS.md` instructions. This means routine coding sessions in this repository can start on the local Qwen model without the project owner choosing a paid model for each prompt.

A read-only `.opencode/agents/triage.md` subagent is also included for first-pass log analysis.
