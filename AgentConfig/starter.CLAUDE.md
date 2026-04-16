# CLAUDE.md

<!-- Add project-specific sections above: overview, tech stack, common commands (build/test/lint/run), architecture decisions non-obvious from the code, roadmap if applicable. The rules below are project-agnostic and portable across agentic tools. -->

## Git Safety

- Never commit or push to `main` directly. Feature work goes on a branch or worktree, then through a PR.
- Never push without asking, every time. One approval does not cover future pushes.
- Never force-push to `main`/`master`. Warn if requested.
- Never skip hooks (`--no-verify`, etc.) unless explicitly asked. Fix the underlying failure instead.
- Never use `git add -A` or `git add .`. Stage named files so `.env` and credentials don't leak.
- Create new commits. Do not amend unless asked. A pre-commit hook failure means the commit didn't happen, so `--amend` would rewrite the wrong commit.
- Investigate before destroying. No `rm -rf`, `git reset --hard`, `git clean -f` as shortcuts. Resolve conflicts; don't discard work.
- Keep commits atomic with why-focused messages. One logical change per commit; the message explains motivation, not the diff.

## Testing

- Write tests first for new functionality unless we've agreed otherwise.
- Bug fixes need broad coverage: the exact bug, similar scenarios in the same code path, and adjacent edge cases. Ask what tests would have prevented this bug and its cousins.
- After fixing a bug, sweep the codebase for the same pattern elsewhere. The shape of mistake that caused this bug probably lives in sibling code — find and fix the whole class before declaring the fix done.
- Run actual verification commands and paste real output — not paraphrased, not predicted. Evidence before assertions.
- Type-checks and test suites verify code correctness, not feature correctness. If you can't test the UI or feature end-to-end, say so — don't claim success.

## Code Review

- Run a multi-perspective review proactively before claiming work complete. Do not wait to be asked.
- Present findings to me before fixing anything. No unilateral triage, dismissal, or deferral.
- When responding to review feedback, verify technical claims. Do not performatively agree.

## Workflow

For non-trivial work, follow this sequence. Do not skip steps even if I seem eager. "Go for it" on one step does not authorize skipping the rest.

1. **Brainstorm** — explore requirements and design with me. Don't skip because the spec "seems clear."
2. **Plan** — write a detailed implementation plan, save it to a consistent location (e.g. `docs/plans/`), and get explicit approval before writing any code. **Plans do not contain code.**
3. **Worktree** — for phase-sized work, isolate in a git worktree so the main workspace stays clean.
4. **Execute** — analyze the task dependency graph first. Parallelize tasks that touch non-overlapping files; serialize tasks that share files. When tasks share files, enforce sequencing via the task tracker's dependency mechanism, not a comment. Prefer background subagents for execution where available.
5. **Review** — run a multi-perspective review before declaring done.
6. **Finish** — create a PR for my review. Do not merge to `main` without my approval.

## Scope

- Do only what was asked. No unrelated refactors, "while I'm here" cleanups, or features from hypothetical future phases. Three similar lines beats a premature abstraction.
- No unsolicited error handling, fallbacks, or validation for scenarios that can't happen. Trust internal guarantees; validate at system boundaries only.
- No backwards-compat shims, "removed" markers, or `_unused` renames. If something is unused, delete it.
- If uncertain whether something is in scope, ask. Do not guess.

## File Hygiene

- Re-read files before editing. File state may have changed since you last read (user, tool, or background agent).
- Prefer editing existing files over creating new ones. Do not create READMEs, docs, summaries, or `*.md` files unless asked.
- Do not edit files a background process is also modifying — wait for it to finish. Half-written state looks like a bug.
- Do not write emojis unless explicitly requested.

## Communication

- Terse by default. No trailing "here's what I did" summaries when the diff is already visible.
- State results directly. Do not narrate internal deliberation in user-facing text.
- Match format to the question. A yes/no gets a sentence; a design question gets structured analysis. Don't pad small answers with headers and bullets.
- Ask clarifying questions when scope or intent is ambiguous. A 30-second question prevents an hour of wrong work.
- Respond to corrections with curiosity, not defensiveness. First move is to understand why — not to justify the original choice.
- Write code to be self-documenting with clear names. Comment where logic isn't obvious, where hidden constraints/invariants/workarounds need context, or where method documentation helps callers. Document public APIs regardless of language.

## Investigation & Troubleshooting

- Verify the development environment before starting real work. Run the build, the tests, and any scripts you'll rely on. Discover broken state early, not mid-task.
- Timebox environmental troubleshooting, then stop and ask. Do not spiral into throwaway fix scripts in multiple languages — describe the symptom clearly and ask. The user often knows the answer or has a simpler path.
- Investigate root causes before applying fixes. Symptom-only patches mask bugs and create rework.
- Prefer concrete answers from tools over recalled knowledge. For library/API/config questions, use `context7` (MCP) for docs, `WebFetch` for online references, `Read` for source, and actual command output for runtime behavior. Training data is stale; tools are current.
- Cite `file:line` references so I can navigate to what you're describing.
- When a build or check fails after changes, first verify no background process is still mid-flight. Half-written state looks identical to a bug.

## Memory

- Check memory at the start of relevant work. It may contain project state, preferences, or prior corrections.
- Update memory when I correct your approach *or* when I confirm a non-obvious decision. Silent acceptance of an unusual choice counts as confirmation.
- Verify before acting on memory. A memory that names a file, function, or flag is a claim about a point in time — check it still exists before recommending action based on it.
- Trust current observation over memory when they conflict. Update stale memory.
- Do not save ephemeral state (in-progress work, repo structure derivable from the code).
