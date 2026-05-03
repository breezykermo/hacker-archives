#import "site.typ": template, category-section
#import "data/tools.typ": tools
#import "data/digital-archives.typ": digital-archives
#import "data/hacker-archives.typ": hacker-archives
#import "data/artifacts.typ": artifacts
#import "data/documentaries.typ": documentaries
#import "data/magazines.typ": magazines
#import "data/books.typ": books
#import "data/practice.typ": practice

#show: template.with(current-page: "index")

#context if target() == "html" {
  html.elem("div", attrs: (class: "search-container"))[
    #html.elem("input", attrs: (
      type: "text",
      id: "search",
      placeholder: "Search archives...",
      "aria-label": "Search archives",
    ))[]
  ]
  html.elem("div", attrs: (class: "filter-pills", id: "filters"))[
    #html.elem("button", attrs: (class: "pill active", "data-filter": "all"))[All]
    #html.elem("button", attrs: (class: "pill", "data-filter": "tools"))[Tools & Projects]
    #html.elem("button", attrs: (class: "pill", "data-filter": "digital-archives"))[Digital Archives]
    #html.elem("button", attrs: (class: "pill", "data-filter": "hacker-archives"))[Hacker Archives]
    #html.elem("button", attrs: (class: "pill", "data-filter": "artifacts"))[Artifacts]
    #html.elem("button", attrs: (class: "pill", "data-filter": "documentaries"))[Documentaries & Shows]
    #html.elem("button", attrs: (class: "pill", "data-filter": "magazines"))[Magazines]
    #html.elem("button", attrs: (class: "pill", "data-filter": "books"))[Books]
    #html.elem("button", attrs: (class: "pill", "data-filter": "practice"))[Archival Practice]
  ]
  html.elem("div", attrs: (id: "results-count"))[]
}

= Hacker Archives

A catalog of hacker archive resources, compiled from the Hacker Archive Radcliffe Event --- Jan 16/17, 2025.

#context if target() == "html" {
  html.elem("div", attrs: (id: "archive-grid"))[
    #category-section("tools", "Tools & Projects", tools)
    #category-section("digital-archives", "Digital Archives", digital-archives)
    #category-section("hacker-archives", "Hacker-specific Archives", hacker-archives)
    #category-section("artifacts", "Preserving Particular Artifacts", artifacts)
    #category-section("documentaries", "Documentaries & Shows", documentaries)
    #category-section("magazines", "Magazines", magazines)
    #category-section("books", "Books", books)
    #category-section("practice", "Archival Practice Overviews", practice)
  ]
} else {
  [
    #category-section("tools", "Tools & Projects", tools)
    #category-section("digital-archives", "Digital Archives", digital-archives)
    #category-section("hacker-archives", "Hacker-specific Archives", hacker-archives)
    #category-section("artifacts", "Preserving Particular Artifacts", artifacts)
    #category-section("documentaries", "Documentaries & Shows", documentaries)
    #category-section("magazines", "Magazines", magazines)
    #category-section("books", "Books", books)
    #category-section("practice", "Archival Practice Overviews", practice)
  ]
}
