# tui — styled terminal output for Zap.
#
# Scaffold only. The public surface (Console, Style, Text, Table, Panel, and
# console markup) is pinned docs-first in the Tier-1 epic before any rendering
# code lands here: https://github.com/zaplang-io/tui/issues/1

# The package version. This placeholder keeps the module importable and the
# `zap test` harness exercised until the console-rendering surface is filed.
def version() -> str:
    return "0.1.0"
