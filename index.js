(function () {
  var input = document.getElementById("search");
  var pills = document.querySelectorAll(".pill");
  var sections = document.querySelectorAll("[data-section]");
  var countEl = document.getElementById("results-count");
  var activeFilter = "all";

  function normalize(str) {
    return str.toLowerCase().replace(/[^\w\s]/g, "");
  }

  function matchesSearch(el, query) {
    if (!query) return true;
    var text = normalize(el.textContent);
    var words = normalize(query).split(/\s+/).filter(Boolean);
    var idx = 0;
    for (var i = 0; i < words.length; i++) {
      var found = text.indexOf(words[i], idx);
      if (found === -1) return false;
      idx = found + words[i].length;
    }
    return true;
  }

  function matchesFilter(el) {
    if (activeFilter === "all") return true;
    return el.getAttribute("data-category") === activeFilter;
  }

  function update() {
    var query = input.value.trim();
    var visible = 0;
    var total = 0;

    var items = document.querySelectorAll(".resource-item");
    for (var i = 0; i < items.length; i++) {
      total++;
      var show = matchesSearch(items[i], query) && matchesFilter(items[i]);
      items[i].style.display = show ? "" : "none";
      if (show) visible++;
    }

    for (var j = 0; j < sections.length; j++) {
      var sectionItems = sections[j].querySelectorAll(".resource-item");
      var anyVisible = false;
      for (var k = 0; k < sectionItems.length; k++) {
        if (sectionItems[k].style.display !== "none") {
          anyVisible = true;
          break;
        }
      }
      sections[j].style.display = anyVisible ? "" : "none";
    }

    if (countEl) {
      if (query || activeFilter !== "all") {
        countEl.textContent = "Showing " + visible + " of " + total + " resources";
      } else {
        countEl.textContent = total + " resources";
      }
    }
  }

  input.addEventListener("input", update);

  for (var p = 0; p < pills.length; p++) {
    pills[p].addEventListener("click", function () {
      for (var q = 0; q < pills.length; q++) {
        pills[q].classList.remove("active");
      }
      this.classList.add("active");
      activeFilter = this.getAttribute("data-filter");
      update();
    });
  }
})();
