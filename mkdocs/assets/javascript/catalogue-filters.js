/**
 * Formulae catalogue search and filters.
 */

(() => {
  "use strict";

  const { onPageRender } = window.LupaxaPageLifecycle;
  const LOCALE = "en-GB";

  /**
   * @param {string} value
   * @returns {string}
   */
  function normalise(value) {
    return String(value ?? "")
      .toLocaleLowerCase(LOCALE)
      .replace(/\s+/g, " ")
      .trim();
  }

  /**
   * @param {HTMLElement} panel
   * @param {boolean} expanded
   */
  function setExpanded(panel, expanded) {
    const button = panel.querySelector("[data-filter-expand]");

    panel.classList.toggle("filter-panel--expanded", expanded);

    if (!(button instanceof HTMLButtonElement)) {
      return;
    }

    button.setAttribute("aria-expanded", expanded ? "true" : "false");
    const label = button.querySelector(".filter-panel-expand__label");

    if (label) {
      label.textContent = expanded ? "Hide Filters" : "Show Filters";
    }
  }

  /**
   * @param {HTMLSelectElement} select
   * @param {Map<string, string>} options
   */
  function addOptions(select, options) {
    Array.from(options.entries())
      .sort((left, right) => left[1].localeCompare(right[1], LOCALE))
      .forEach(([value, label]) => {
        const option = document.createElement("option");

        option.value = value;
        option.textContent = label;
        select.append(option);
      });
  }

  /**
   * @param {HTMLSelectElement} select
   * @param {string} value
   */
  function applySelect(select, value) {
    const normalised = normalise(value);
    const exists = Array.from(select.options).some(
      (option) => option.value === normalised,
    );

    if (!exists) {
      const option = document.createElement("option");

      option.value = normalised;
      option.textContent = value.trim();
      option.dataset.urlFilterOption = "";
      select.append(option);
    }

    select.value = normalised;
  }

  function init() {
    const panel = document.querySelector("[data-formula-filters]");
    const catalogue = document.querySelector("[data-formula-catalogue]");

    if (!panel || !catalogue || panel.dataset.initialised === "true") {
      return;
    }

    const searchInput = panel.querySelector("[data-formula-search]");
    const categorySelect = panel.querySelector("[data-formula-category]");
    const organisationSelect = panel.querySelector("[data-formula-organisation]");
    const clearButton = panel.querySelector("[data-formula-clear]");
    const summary = panel.querySelector("[data-formula-summary]");
    const emptyState = document.querySelector("[data-formula-empty]");

    if (
      !(searchInput instanceof HTMLInputElement) ||
      !(categorySelect instanceof HTMLSelectElement) ||
      !(organisationSelect instanceof HTMLSelectElement) ||
      !(clearButton instanceof HTMLButtonElement) ||
      !summary
    ) {
      return;
    }

    panel.dataset.initialised = "true";

    const cards = Array.from(catalogue.querySelectorAll(":scope > ul > li"));
    const categories = new Map();
    const cardData = cards.map((card) => {
      const labels = Array.from(card.querySelectorAll(".catalogue-category"))
        .map((node) => node.textContent?.trim() || "")
        .filter(Boolean);
      const values = labels.map(normalise);

      labels.forEach((label, index) => {
        categories.set(values[index], label);
      });

      const logo = card.querySelector(".catalogue-logo");
      const organisationLabel = logo?.dataset.organisation?.trim() || "";
      const title = logo?.dataset.name?.trim() ||
        card.querySelector("h3")?.textContent?.trim() ||
        "";

      return {
        element: card,
        categories: values,
        organisation: normalise(organisationLabel),
        title,
        releasedDate: logo?.dataset.releasedDate?.trim() ||
          logo?.dataset.publishDate?.trim() ||
          "",
        searchableText: normalise(
          [card.textContent || "", organisationLabel, ...labels].join(" "),
        ),
      };
    });

    addOptions(categorySelect, categories);

    const params = new URLSearchParams(window.location.search);

    if (params.has("search")) {
      searchInput.value = params.get("search") || "";
    }

    if (params.has("category")) {
      applySelect(categorySelect, params.get("category") || "");
    }

    if (params.has("org")) {
      applySelect(organisationSelect, params.get("org") || "");
    }

    const sortButtons = Array.from(
      panel.querySelectorAll("[data-formula-sort]"),
    );
    let activeSort = params.get("sort") === "newest" ? "newest" : "alpha";

    const setSortPressed = (sort) => {
      sortButtons.forEach((button) => {
        button.setAttribute(
          "aria-pressed",
          button.dataset.formulaSort === sort ? "true" : "false",
        );
      });
    };

    setSortPressed(activeSort);

    const applyOrder = () => {
      const list = catalogue.querySelector(":scope > ul");

      if (!list) {
        return;
      }

      const ordered = [...cardData].sort((left, right) => {
        if (activeSort === "newest" && left.releasedDate !== right.releasedDate) {
          if (!left.releasedDate) {
            return 1;
          }

          if (!right.releasedDate) {
            return -1;
          }

          return right.releasedDate.localeCompare(left.releasedDate);
        }

        return left.title.localeCompare(right.title, LOCALE, {
          sensitivity: "base",
        });
      });

      ordered.forEach((card) => {
        list.append(card.element);
      });
      cardData.length = 0;
      cardData.push(...ordered);
    };

    const expandButton = panel.querySelector("[data-filter-expand]");

    if (expandButton instanceof HTMLButtonElement) {
      expandButton.addEventListener("click", () => {
        setExpanded(panel, !panel.classList.contains("filter-panel--expanded"));
      });
    }

    setExpanded(
      panel,
      params.has("search") ||
        params.has("category") ||
        params.has("org") ||
        params.get("sort") === "newest",
    );

    /**
     * @returns {{ searchTerm: string, category: string, organisation: string }}
     */
    const readFilters = () => ({
      searchTerm: normalise(searchInput.value),
      category: normalise(categorySelect.value),
      organisation: normalise(organisationSelect.value),
    });

    const syncUrl = (filters) => {
      const url = new URL(window.location.href);

      url.searchParams.delete("search");
      url.searchParams.delete("category");
      url.searchParams.delete("org");
      url.searchParams.delete("sort");

      if (filters.searchTerm) {
        url.searchParams.set("search", searchInput.value.trim());
      }

      if (filters.category) {
        url.searchParams.set("category", categorySelect.value);
      }

      if (filters.organisation) {
        url.searchParams.set("org", organisationSelect.value);
      }

      if (activeSort === "newest") {
        url.searchParams.set("sort", "newest");
      }

      window.history.replaceState(
        window.history.state,
        "",
        `${url.pathname}${url.search}${url.hash}`,
      );
    };

    const update = () => {
      const filters = readFilters();
      let visible = 0;

      cardData.forEach((card) => {
        const matches =
          (filters.searchTerm === "" ||
            card.searchableText.includes(filters.searchTerm)) &&
          (filters.category === "" ||
            card.categories.includes(filters.category)) &&
          (filters.organisation === "" ||
            card.organisation === filters.organisation);

        card.element.hidden = !matches;

        if (matches) {
          visible += 1;
        }
      });

      summary.textContent = `Showing ${visible} of ${cardData.length}`;

      if (emptyState) {
        emptyState.hidden = visible !== 0;
      }

      syncUrl(filters);
    };

    searchInput.addEventListener("input", update);
    categorySelect.addEventListener("change", update);
    organisationSelect.addEventListener("change", update);
    sortButtons.forEach((button) => {
      button.addEventListener("click", () => {
        const sort = button.dataset.formulaSort === "newest" ? "newest" : "alpha";

        if (sort === activeSort) {
          return;
        }

        activeSort = sort;
        setSortPressed(activeSort);
        applyOrder();
        update();
      });
    });
    clearButton.addEventListener("click", () => {
      searchInput.value = "";
      categorySelect.value = "";
      organisationSelect.value = "";
      activeSort = "alpha";
      setSortPressed(activeSort);
      applyOrder();
      panel.querySelectorAll("option[data-url-filter-option]").forEach((option) => {
        option.remove();
      });
      update();
    });

    catalogue.querySelectorAll(".catalogue-category").forEach((pill) => {
      pill.setAttribute(
        "aria-label",
        `Filter by ${pill.textContent?.trim() || "category"}`,
      );
      pill.addEventListener("click", (event) => {
        event.preventDefault();
        event.stopPropagation();
        applySelect(categorySelect, pill.textContent?.trim() || "");
        setExpanded(panel, true);
        update();
        categorySelect.focus({ preventScroll: true });
      });
    });

    catalogue.querySelectorAll("img.catalogue-logo[data-organisation]").forEach((logo) => {
      const organisation = logo.dataset.organisation?.trim() || "";

      if (!organisation) {
        return;
      }

      const control = document.createElement("button");

      control.type = "button";
      control.dataset.organisationFilterControl = "";
      control.setAttribute("aria-label", `Filter by ${organisation}`);
      logo.replaceWith(control);
      control.append(logo);
      control.addEventListener("click", (event) => {
        event.preventDefault();
        event.stopPropagation();
        applySelect(organisationSelect, organisation);
        setExpanded(panel, true);
        update();
        organisationSelect.focus({ preventScroll: true });
      });
    });

    applyOrder();
    update();
  }

  onPageRender(init);
})();
