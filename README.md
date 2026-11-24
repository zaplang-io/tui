# tui

Styled terminal output for [Zap](https://github.com/zaplang-io/zap) — an official **non-core** package.

- Tracking issue: [zaplang-io/zap#315](https://github.com/zaplang-io/zap/issues/315)
- Contributor & agent conventions: [AGENTS.md](AGENTS.md)
- Design decisions: [DECISIONS.md](DECISIONS.md)

This repository is scaffolding. The public surface and phased plan are tracked in the [Tier-1 epic](https://github.com/zaplang-io/tui/issues/2); no rendering code ships yet.

## Goals

A typed Zap library for styled terminal output whose public API mirrors Python's [**rich**](https://rich.readthedocs.io/) as closely as Zap's static typing allows. API-parity with rich is a project rule — see [AGENTS.md](AGENTS.md).

The first slice targets rich's *console rendering* surface: a `Console`, a color/style model with console markup, and the core renderables (`Text`, `Table`, `Panel`). The full **application / widget framework** — rich's companion library [**textual**](https://textual.textualize.io/) (event loop, reactive widgets, screens, CSS) — is explicitly **deferred to a later phase** and is out of scope for the first slice.

Planned scope (first cut — rich console rendering):

- **Console** — the render target: width resolution, writing styled output, a plain-text capture mode for tests.
- **Color + Style model** — named/8-bit/truecolor colors and a composable `Style` (bold, italic, underline, dim, reverse, fg/bg).
- **Console markup** — rich's inline tag syntax, e.g. `[bold red]...[/]`, parsed into styled spans.
- **Text** — a styled string: spans, concatenation, measurement, truncation/overflow.
- **Table** — columns, rows, headers, borders, per-cell/column styles.
- **Panel** — a titled, bordered box around any renderable.

Deferred to later issues (named in the epic, not yet filed):

- The **textual** app/event-loop/reactive-widget framework (screens, layouts, CSS, input handling).
- Progress bars and spinners, status/live regions.
- Syntax highlighting and Markdown rendering.
- Interactive prompts (rich's `Prompt`/`Confirm`; Python `prompt-toolkit`).
- Trees, columns, and other secondary renderables.

## Planned usage

The surface below is **illustrative** and not final — exact signatures (keyword vs positional, defaults, return shapes) are pinned docs-first in [#3](https://github.com/zaplang-io/tui/issues/3) and recorded in [DECISIONS.md](DECISIONS.md).

```zap
import tui

# Console + console markup
console = tui.Console()
console.print("[bold red]error[/]: file [cyan]config.toml[/] not found")

# A styled Text built explicitly
text = tui.Text("hello", style=tui.Style(bold=True, color="green"))
text.append(" world", style=tui.Style(dim=True))
console.print(text)

# A Table renderable
table = tui.Table(title="Packages")
table.add_column("Name", style=tui.Style(color="cyan"))
table.add_column("Status")
table.add_row("tui", "[yellow]scaffold[/]")
console.print(table)

# A Panel around any renderable
console.print(tui.Panel(text, title="greeting"))
```

## Build and test

Run the native `zap test` suite against a temporary consumer that installs this
checkout as a package:

```
sh tools/test.sh
```

GitHub Actions runs the suite on pull requests and pushes inside the
`ghcr.io/zaplang-io/zap:latest` container. CI stays pinned to `zap:latest`
until this module reaches a 1.0 release.

## Development

Read **[AGENTS.md](AGENTS.md)** before contributing — it covers the rich-parity rule
(with textual deferred), the one-issue-one-PR flow, how design decisions are
recorded in **[DECISIONS.md](DECISIONS.md)**, accessibility expectations, and the rule
for reporting core Zap language/stdlib defects upstream in `zaplang-io/zap`
(rather than working around them here).
