document.addEventListener("turbo:load", function() {
    createAddButton();
});

//   document.onreadystatechange = () => {
//     if (document.readyState === "complete") {
//         createButton();
//     }
//   };

var createAddButton = function(){
    var button = document.createElement("button");
    button.className = "add_artist_name_field";
    button.innerHTML = "Add another artist";

    button.onclick = function(){
        createTextBox();
    };

    document.body.appendChild(button);
};

var createTextBox = function(){
    var e = document.createElement("input");
    e.type = "text"
    e.setAttribute("list", "artists-list");
    e.name = "tags[artists_slugs][]";

    document.querySelector(".artist-selection").appendChild(e);
};