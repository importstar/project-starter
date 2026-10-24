# pstack model configuration. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` or `auto` as a value: the role runs on the parent chat model (omit Task `model`). Alias entries in a panel list still count toward its fan-out.
# Team policy: main session runs Opus medium; implementation and judgment subagents run Sonnet high; explore, tooling, and verify roles run Haiku.
# budget: custom (per-role effort; re-running /pstack:setup-pstack with a budget sets every role to one effort)
feature, refactoring: sonnet high
bug-fix: sonnet high
perf-issue: sonnet high
hillclimb: sonnet high
judgment and prose: sonnet high
hardest tasks: opus medium
how explorer: haiku medium
how explainer: sonnet high
why investigators: haiku medium
why synthesizer: sonnet high
reflect tooling: haiku medium
reflect judgment, divergent, synthesizer: sonnet high
arena runners: sonnet high, opus medium
arena cross-judge pool: sonnet high, opus medium
swarm workers: sonnet high
architect runners: opus medium, sonnet high
interrogate reviewers: sonnet high, haiku medium
