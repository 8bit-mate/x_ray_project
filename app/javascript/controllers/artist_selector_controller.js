import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var a = document.createElement("a");
    a.className = "btn btn-primary";
    a.innerHTML = "Add artist";

    a.onclick = function(){
      var e = document.createElement("input");
      e.type = "text"
      e.name = "tags[artists_slugs][]";
      e.setAttribute("list", "artists-list");
      e.id = document.querySelectorAll(".artist-input").length;
    
      document.querySelector(".artist-selection").appendChild(e);
    };

    this.element.appendChild(a);
  };
}