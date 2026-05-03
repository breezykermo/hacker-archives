#let template(current-page: none, doc) = {
  context if target() == "html" {
    html.elem("nav", attrs: (class: "site-nav"))[
      #html.elem("a", attrs: (href: "./index.html", class: "site-title"))[Hacker Archives]
      #html.elem("a", attrs: (href: "./about.html", class: "nav-link"))[About]
    ]
    html.elem("hr")
  }
  doc
  context if target() == "html" {
    html.elem("script", attrs: (src: "index.js"))[]
  }
}

#let resource-item(category, item) = {
  context if target() == "html" {
    html.elem("div", attrs: (
      class: "resource-item",
      "data-category": category,
    ))[
      #let title = if "url" in item and item.url != none {
        link(item.url)[#item.name]
      } else {
        item.name
      }
      #html.elem("strong", attrs: (class: "resource-name"))[#title]
      #let meta-parts = ()
      #if "authors" in item { meta-parts.push(item.authors) }
      #if "director" in item { meta-parts.push("Dir: " + item.director) }
      #if "year" in item { meta-parts.push(str(item.year)) }
      #if meta-parts.len() > 0 {
        html.elem("span", attrs: (class: "resource-meta"))[
          #meta-parts.join(" \u{00b7} ")
        ]
      }
      #if "description" in item {
        html.elem("p", attrs: (class: "resource-desc"))[#item.description]
      }
    ]
  } else {
    [
      #let title = if "url" in item and item.url != none {
        link(item.url)[#item.name]
      } else {
        item.name
      }
      *#title*
      #let meta-parts = ()
      #if "authors" in item { meta-parts.push(item.authors) }
      #if "director" in item { meta-parts.push("Dir: " + item.director) }
      #if "year" in item { meta-parts.push(str(item.year)) }
      #if meta-parts.len() > 0 { [\ #meta-parts.join(" · ")] }
      #if "description" in item { [\ #item.description] }
      #linebreak()
    ]
  }
}

#let category-section(slug, label, items) = {
  context if target() == "html" {
    html.elem("section", attrs: ("data-section": slug))[
      #html.elem("h2", attrs: (id: slug))[#label]
      #for item in items {
        resource-item(slug, item)
      }
    ]
  } else {
    [
      = #label
      #for item in items {
        resource-item(slug, item)
      }
    ]
  }
}
