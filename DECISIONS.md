# tui package decisions

Design decisions for the Zap `tui` library, keyed to issues. Each records a
choice that could not be read straight off Python's [rich](https://rich.readthedocs.io/),
with the reference it follows or departs from. Signature ambiguities are resolved
with the maintainer (with Python examples) before being recorded here.

## Parity target: rich (textual deferred)

The package tracks [**rich**](https://rich.readthedocs.io/) as its primary API
reference for styled console output. Its companion application framework
[**textual**](https://textual.textualize.io/) (event loop, reactive widgets,
screens, CSS) is deferred to a later phase and is not a first-slice reference.
Deviations from rich are recorded below, keyed to the issue that introduces them.

## Open decisions (first slice)

These are flagged for the maintainer and resolved docs-first in
[#2](https://github.com/zaplang-io/tui/issues/2) before implementation; the
resolution is recorded here.

- **Color model type.** rich accepts a loosely-typed `str | Style` almost
  everywhere. Zap has no `Any`; the proposal is a `Color` built from a name,
  an 8-bit index, or a truecolor triple, with `Style` holding an optional
  foreground/background plus attribute flags. To confirm in #2.
- **Renderable abstraction.** rich dispatches on a `__rich_console__` protocol.
  The Zap equivalent is an interface implemented by `Text`/`Table`/`Panel`;
  whether `Console.print` takes that interface or overloaded concrete types is
  to confirm in #2.
- **Markup error policy.** On malformed console markup (`[bold` with no close),
  rich is lenient. Whether Zap raises a typed error or renders the literal text
  is to confirm in #2.

## Relied-upon core contracts

- Standard-stream writes use `sys.write` / `io.writer` (present on `origin/main`),
  which cover the console's output path for the first slice.
- **Terminal-capability detection is an open dependency, not yet confirmed as a
  core gap.** `origin/main` exposes no `isatty` / terminal-size primitive. The
  first slice avoids depending on one by resolving width from an explicit
  argument (default 80) and gating color on an explicit toggle. If auto-detection
  is required later and the primitive is still missing, it is reported in
  `zaplang-io/zap` and the dependent work is kept blocked — never worked around
  here (see [AGENTS.md](AGENTS.md)).
