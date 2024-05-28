import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = [ "navbarSwitch" ];

  connect() {
    this.handleTheme();
  }

  handleTheme() {
    const element = document.documentElement;

    const currentTheme = localStorage.getItem("bsTheme") || "light";
    element.setAttribute("data-bs-theme", currentTheme);
    this.navbarSwitchTarget.checked = currentTheme === "dark";
  }

  toggleTheme() {
    const element = document.documentElement;

    if (this.navbarSwitchTarget.checked) {
      element.setAttribute("data-bs-theme", "dark");
      localStorage.setItem("bsTheme", "dark");
    } else {
      element.setAttribute("data-bs-theme", "light");
      localStorage.setItem("bsTheme", "light");
    }
  }
}
