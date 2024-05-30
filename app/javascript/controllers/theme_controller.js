import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = [ "navbarSwitch" ];
  static values = {
    mode: String
  }

  connect() {
    let darkThemeMq = window.matchMedia("(prefers-color-scheme: dark)");

    darkThemeMq.addEventListener('change', event => {
      this.handleTheme(darkThemeMq);
    });

    this.handleTheme(darkThemeMq);
  }

  handleTheme(darkThemeMq) {
    const element = document.documentElement;
    const preferedTheme = (darkThemeMq.matches) ? "dark" : "light"
    const currentTheme = localStorage.getItem("bsTheme") || preferedTheme;

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
