# tui workspace conventions (zaplang-io/tui)

This is an official non-core Zap module. Target: parity with the popular Python
equivalent (`rich`) for styled console output. The application/widget framework
(`textual`) is deferred to a later phase and is out of scope for the first slice.

## Language-first (non-negotiable)
- All language or stdlib bugs discovered while building this module MUST be reported in `zaplang-io/zap` FIRST, and no workaround is permitted. Keep the dependent work blocked or draft and report the dependency; never build the library around a core defect.
- Terminal-capability detection (is stdout a TTY, terminal width, `NO_COLOR`) is a likely core-stdlib dependency. If a needed primitive is missing, report it in `zaplang-io/zap` and keep the dependent work blocked rather than reimplementing it here. The console must still render with an explicit width and an explicit color toggle so docs and tests never depend on a live terminal.

## Python parity & signatures
- Match the equivalent `rich` API surface and naming as closely as the language allows (e.g. `Console.print`, `Style`, `Text`, `Table`, `Panel`, console markup `[bold red]...[/]`).
- Where a function/method signature is ambiguous or there is any confusion about argument shape, defaults, or keyword-vs-positional, do NOT just pick one: present the options to the maintainer with concrete examples of what Python (`rich`) does, and let the maintainer decide. Record the chosen design in `DECISIONS.md`.
- Forced divergences from rich (static typing, no `Any`, the color/renderable type model) are design decisions: record each in `DECISIONS.md`, keyed to the issue that introduces it.

## Accessibility
- Styling is decorative: output MUST remain legible and correctly ordered when color/style is stripped. Keep a plain-text render path, honor a color-off toggle, and never encode meaning in color alone.

## Tests
- All test cases live in the `tests/` folder and use the `zap test` methodology (`zap test tests/`).
- Prefer the plain-text capture path so rendering is asserted deterministically without a live terminal.
- Every PR MUST include extensive positive AND negative test cases — treat tests as a walled garden and as intent documentation, not a minimal smoke check. Cover edge cases, error paths, malformed markup, and width/overflow boundaries.
- When fixing a bug, write the failing test first, then fix.

## CI
- CI runs against `ghcr.io/zaplang-io/zap:latest` and MUST continue to pin `zap:latest` until this module reaches a proper major (1.0) version release; only then pin a released toolchain version.

## Issues & PRs
- Keep issues concrete and testable with detailed bodies (repro or intended syntax, `rich` equivalent, references).
- Multi-issue features get an Epic with trackable sub-issues. Individual issues are 'M' sized.
- One issue, one PR. Rebase onto the latest default branch before raising or updating a PR.
- Documentation (README, DECISIONS.md, CHANGELOG) stays current with every PR.
