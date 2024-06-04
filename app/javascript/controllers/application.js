import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// https://discuss.hotwired.dev/t/event-to-know-a-turbo-stream-has-been-rendered/1554/25
const afterRenderEvent = new Event("turbo:after-stream-render");
addEventListener("turbo:before-stream-render", (event) => {
  const originalRender = event.detail.render

  event.detail.render = function (streamElement) {
    originalRender(streamElement)
    document.dispatchEvent(afterRenderEvent);
  }
})