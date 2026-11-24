import tui

@test
def _reports_the_scaffold_version():
    assert tui.version() == "0.1.0"
