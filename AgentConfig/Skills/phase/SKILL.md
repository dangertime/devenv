---
name: phase
description: Kick off a new PolishTracker development phase - design, plan, worktree, and implement
disable-model-invocation: true
argument-hint: "[phase-number]"
---

Kick off the next development phase for PolishTracker. This orchestrates the full workflow from design through implementation.

## Steps

### 1. Identify the phase

- If `$ARGUMENTS` is provided, use that as the phase number
- Otherwise, read `docs/plans/2026-02-07-polishtracker-design.md` and find the next phase without a checkmark

### 2. Design and brainstorm

- Read the phase description from the design doc
- Use the `superpowers:brainstorming` skill to explore requirements with the user
- Clarify scope, UI behavior, data model changes, and API surface
- Do NOT proceed until the user is satisfied with the design

### 3. Write the implementation plan

- Use the `superpowers:writing-plans` skill to produce a detailed implementation plan
- Save to `docs/plans/` with naming convention `2026-MM-DD-<phase-name>-plan.md`
- Get user approval before proceeding

### 4. Create a worktree

- Use the `superpowers:using-git-worktrees` skill
- Name it after the phase (e.g., `phase4-user-auth`)

### 5. Execute the plan

- **Before dispatching subagents, analyze the task dependency tree:**
  1. List every task and the files it reads/creates/modifies
  2. Build a dependency graph — Task B depends on Task A if B reads a file A creates or modifies
  3. Group independent tasks into parallel batches (tasks that touch non-overlapping files)
  4. Execute batches: dispatch all tasks in a batch as background subagents simultaneously, wait for completion, then start the next batch
- Use the `superpowers:subagent-driven-development` skill
- Implementation subagents should use Sonnet
- After each task: spec review (reviews can also run in parallel since they're read-only)
- Run `/verify` after each batch of tasks
- **Example:** If tasks 2 (backend), 3 (frontend routing), 4 (frontend auth) touch non-overlapping files, dispatch all 3 in parallel rather than sequentially

### 6. Final review

- Use `review-hats:review` for a multi-perspective code review
- Fix all Critical and Important findings before proceeding

### 7. Finish the branch

- Use `superpowers:finishing-a-development-branch` to merge or create a PR
- Update MEMORY.md with the new phase status

## Hard Rules

- **NEVER commit or push directly to main.** All phase work happens on a feature branch or worktree.
- **NEVER skip a step.** Each step requires user interaction and approval before proceeding to the next. "Go for it" on one step does not authorize skipping subsequent steps.
- **NEVER push without explicit user confirmation.** Even on a feature branch, ask before pushing.
- **The review-hats step is mandatory, not optional.** Run the review before claiming the phase is complete, not after the user asks for it.
- **Create a PR for the user to review.** Do not merge to main without user approval.

## Notes

- Do not skip the brainstorming step even if the design doc seems detailed enough
- Scope work to the current phase only - do not add features from later phases
- If the user says "go for it" after seeing the dependency graph or plan summary, that means "execute the plan" — it does NOT mean "skip worktree creation, skip reviews, push directly to main"
