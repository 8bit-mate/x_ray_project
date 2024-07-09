import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    this.tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
  }

  disconnect() {
    // Destroy all tooltips when user leaves/refreshes the page with tooltips.
    this.tooltipList.forEach((tooltip) => {
      tooltip.dispose();
    });
  }
}
