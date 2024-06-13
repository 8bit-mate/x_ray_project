import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var a = document.createElement("a");
    a.className = "btn btn-primary";
    a.innerHTML = "Add artist";

    a.onclick = this.create_inputs;

    this.element.appendChild(a);
  };

  create_inputs() {
    let e = document.createElement("input");
    e.type = "text"
    e.name = "tags[artists_slugs][]";
    e.setAttribute("list", "artists-list");
    e.placeholder = "Artist";
    document.querySelector(".artist-selection").appendChild(e);

    e = document.createElement("input");
    e.type = "text"
    e.name = "tags[roles_names][]";
    e.placeholder = "Role";
    e.setAttribute("list", "roles-list");
    document.querySelector(".artist-selection").appendChild(e);
  };
}