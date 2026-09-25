"""Render the Formulae page cards from formulae.yml and Formula/*.rb tags."""

from __future__ import annotations

import html
import re
from pathlib import Path
from typing import Any

import yaml

REPO_ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = REPO_ROOT / "data" / "formulae.yml"
ORG_PATH = REPO_ROOT / "data" / "organisations.yml"
FORMULA_DIR = REPO_ROOT / "Formula"
MARKER = "<!-- formulae -->"
TAG_RE = re.compile(
    r'url\s+"https://github\.com/[^/]+/[^/]+/archive/refs/tags/(v[^"]+)\.tar\.gz"'
)
REQUIRED = (
    "name",
    "title",
    "organisation",
    "logo",
    "description",
    "categories",
    "repository",
    "publish_date",
    "released_date",
)


def formula_version(name: str) -> str:
    """Return the vX.Y.Z tag from Formula/<name>.rb."""
    path = FORMULA_DIR / f"{name}.rb"
    if not path.is_file():
        raise SystemExit(f"formulae.yml names {name}, but {path.relative_to(REPO_ROOT)} is missing")
    match = TAG_RE.search(path.read_text(encoding="utf-8"))
    if not match:
        raise SystemExit(f"{path.relative_to(REPO_ROOT)} has no tagged archive url")
    return match.group(1)


def load_formulae() -> list[dict[str, Any]]:
    """Load card records and require one formula file per record."""
    raw = yaml.safe_load(DATA_PATH.read_text(encoding="utf-8"))
    if not isinstance(raw, list) or not raw:
        raise SystemExit("data/formulae.yml must be a non-empty list")
    names: list[str] = []
    records: list[dict[str, Any]] = []
    for item in raw:
        if not isinstance(item, dict):
            raise SystemExit("each formulae.yml entry must be a mapping")
        missing = [key for key in REQUIRED if not item.get(key)]
        if missing:
            raise SystemExit(f"formulae.yml entry is missing {', '.join(missing)}")
        name = str(item["name"])
        if name in names:
            raise SystemExit(f"formulae.yml lists {name} more than once")
        names.append(name)
        item["version"] = formula_version(name)
        records.append(item)
    on_disk = sorted(path.stem for path in FORMULA_DIR.glob("*.rb"))
    listed = sorted(names)
    if on_disk != listed:
        raise SystemExit(
            "Formula/*.rb and data/formulae.yml disagree: "
            f"files={on_disk} data={listed}"
        )
    return sorted(records, key=lambda item: str(item["name"]))


def _wrap(text: str, width: int = 76) -> str:
    words = " ".join(text.split()).split(" ")
    lines: list[str] = []
    current = ""
    for word in words:
        trial = word if not current else f"{current} {word}"
        if current and len(trial) > width:
            lines.append(current)
            current = word
        else:
            current = trial
    if current:
        lines.append(current)
    return "\n".join(f"    {line}" for line in lines)


def catalogue_value(value: str) -> str:
    """Match the filter script's comparison form."""
    return " ".join(value.casefold().split())


def organisation_names() -> list[str]:
    """Return every published organisation, including those with no formulae."""
    if not ORG_PATH.is_file():
        raise SystemExit(f"missing {ORG_PATH.relative_to(REPO_ROOT)}")
    raw = yaml.safe_load(ORG_PATH.read_text(encoding="utf-8")) or []
    names = [
        str(item["name"])
        for item in raw
        if isinstance(item, dict) and item.get("published", True) and item.get("name")
    ]
    return sorted(names, key=str.casefold)


def render_filter_panel() -> str:
    """Return the Formulae filter pane. Organisation options are the full catalogue."""
    options = "\n".join(
        f'            <option value="{html.escape(catalogue_value(name), quote=True)}">'
        f"{html.escape(name)}</option>"
        for name in organisation_names()
    )
    return f"""
<div class="filter-panel filter-panel--with-sort" data-formula-filters markdown="0">
    <div class="filter-panel-toolbar">
        <button
            type="button"
            class="md-button lupaxa-button filter-panel-expand"
            data-filter-expand
            aria-expanded="false"
        >
            <span class="filter-panel-expand__icon filter-panel-expand__icon--show" aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" focusable="false">
                    <path d="M6 13h12v-2H6m-3-5v2h18V6M10 18h4v-2h-4v2Z"/>
                </svg>
            </span>
            <span class="filter-panel-expand__icon filter-panel-expand__icon--hide" aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" focusable="false">
                    <path d="M14.76 20.83 17.6 18l-2.84-2.83 1.41-1.41L19 16.57l2.83-2.81 1.41 1.41L20.41 18l2.83 2.83-1.41 1.41L19 19.41l-2.83 2.83-1.41-1.41M6 13h7.07c.14-.71.4-1.38.76-2H6m-3-5v2h18V6H3Z"/>
                </svg>
            </span>
            <span class="filter-panel-expand__label">Show Filters</span>
        </button>
        <div class="filter-panel-summary" aria-live="polite" data-formula-summary>
            Showing…
        </div>
    </div>
    <div class="filter-panel-search">
        <label for="formula-search">Search formulae</label>
        <input
            id="formula-search"
            type="search"
            placeholder="Search by formula name, description, or category..."
            autocomplete="off"
            data-formula-search
        />
    </div>
    <div class="filter-panel-select">
        <label for="formula-organisation">Organisation</label>
        <select id="formula-organisation" data-formula-organisation>
            <option value="">All Organisations</option>
{options}
        </select>
    </div>
    <div class="filter-panel-select">
        <label for="formula-category">Category</label>
        <select id="formula-category" data-formula-category>
            <option value="">All Categories</option>
        </select>
    </div>
    <div class="filter-panel-toggle" role="group" aria-labelledby="formula-sort-label">
        <label id="formula-sort-label">Sort</label>
        <div class="filter-panel-toggle__options">
            <button type="button" class="filter-panel-toggle__option" data-formula-sort="alpha" aria-pressed="true">
                A–Z
            </button>
            <button type="button" class="filter-panel-toggle__option" data-formula-sort="newest" aria-pressed="false">
                Newest
            </button>
        </div>
    </div>
    <div class="filter-panel-actions">
        <button type="button" class="md-button lupaxa-button filter-panel-clear" data-formula-clear>
            Clear filters
        </button>
    </div>
</div>
""".strip()


def render_empty() -> str:
    """Return the empty state shown when every card is filtered out."""
    return """
<div class="catalogue-empty-state" data-formula-empty hidden markdown>

:material-filter-off:{ .lg }

**No matching formulae**

Try changing the search text or selecting different filters.

</div>
""".strip()


def asset_href(page: object, path: str) -> str:
    """Resolve a docs-relative asset from the page that embeds it."""
    if path.startswith(("http://", "https://", "/")):
        return path
    url = getattr(page, "url", "") or ""
    depth = len([part for part in url.split("/") if part])
    return ("../" * depth) + path


def render_card(item: dict[str, Any], page: object) -> str:
    """Return one Material card list item. HTML lines stay at four spaces."""
    organisation = html.escape(str(item["organisation"]), quote=True)
    logo = html.escape(asset_href(page, str(item["logo"])), quote=True)
    version = html.escape(str(item["version"]), quote=True)
    repository = html.escape(str(item["repository"]), quote=True)
    categories = [
        f'    <button type="button" class="catalogue-category">{html.escape(str(category), quote=True)}</button>'
        for category in item["categories"]
    ]
    docs = ""
    if item.get("documentation"):
        documentation = html.escape(str(item["documentation"]), quote=True)
        docs = (
            "\n"
            f'    <a class="catalogue-action catalogue-action--documentation" href="{documentation}" target="_blank" rel="noopener noreferrer">\n'
            '    <span class="md-icon">:material-book-open-page-variant:</span> Documentation\n'
            "    </a>"
        )
    released = html.escape(str(item["released_date"]), quote=True)
    published = html.escape(str(item["publish_date"]), quote=True)
    return "\n".join(
        [
            f"-   ### :material-source-repository: {item['title']} {{ #{item['name']} .no_toc translate=no }}",
            "",
            "    ---",
            "",
            f'    <span class="catalogue-banner catalogue-banner--version catalogue-banner--short" aria-label="{version}">',
            '    <span class="catalogue-banner__band" aria-hidden="true">',
            f'    <span class="catalogue-banner__text" translate="no">{version}</span>',
            "    </span></span>",
            "",
            '    <span class="catalogue-logo-wrap">',
            f'    <img class="catalogue-logo" translate="no" title="{organisation}" alt="{organisation}" data-name="{html.escape(str(item["title"]), quote=True)}" data-organisation="{organisation}" data-publish-date="{published}" data-released-date="{released}" src="{logo}" />',
            "    </span>",
            "",
            _wrap(str(item["description"])),
            "",
            *categories,
            "",
            "    ---",
            "",
            f'    <a class="catalogue-action catalogue-action--repository" href="{repository}" target="_blank" rel="noopener noreferrer">',
            '    <span class="md-icon">:material-github:</span> View on GitHub',
            "    </a>" + docs,
            "",
        ]
    )


def render_grid(page: object) -> str:
    """Return the filter pane, catalogue grid, and empty state."""
    items = load_formulae()
    cards = "\n".join(render_card(item, page) for item in items)
    grid = f'<div class="grid cards catalogue-grid" data-formula-catalogue markdown>\n\n{cards}</div>'
    return f"{render_filter_panel()}\n\n{grid}\n\n{render_empty()}"


def on_page_markdown(markdown: str, page: object, config: object, files: object) -> str:
    """Replace the Formulae page marker with the rendered formula cards."""
    del config, files
    src = getattr(getattr(page, "file", None), "src_uri", "")
    if src != "formulae.md" or MARKER not in markdown:
        return markdown
    return markdown.replace(MARKER, render_grid(page).rstrip("\n"))
