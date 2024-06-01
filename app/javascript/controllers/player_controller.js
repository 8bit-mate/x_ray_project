import { Controller } from "@hotwired/stimulus"
import WaveSurfer from "wavesurfer"
import Hover from "hover"

export default class extends Controller {
  static targets = [ "title", "playButton", "waveForm" ];

  trackKey = null;
  audio = document.getElementById("audioElement");
  audioContext = new AudioContext();

  initialize() {
    //console.log("Player controller initialized.");

    document.addEventListener("turbo:load", (event) => {
      this.updateBtnState();
    });

    document.addEventListener("turbo:after-stream-render", (event) => {
      this.updateBtnState();
    });

    this.playButtonTarget.disabled = true;
  }

  connect() {
    //console.log("Player controller connected.");
  }

  updateBtnState() {
    if (this.audio.paused) {
      this.setBtnPause();
    } else {
      this.setBtnPlay();
    }
  }

  setBtnPause() {
    let btn = document.getElementById(this.trackKey);
    if (btn) { btn.className = "play-button" };

    if (this.trackKey) {
      this.playButtonTarget.className = "play-button"
    } else {
      this.playButtonTarget.className = "play-button-disabled";
    }
  }

  setBtnPlay() {
    let btn = document.getElementById(this.trackKey);
    if (btn) { btn.className = "pause-button" };
    this.playButtonTarget.className = "pause-button";
  } 

  activate(event) {
    let target = event.detail.target;
    let trackKey = target.dataset.trackKey;
    this.titleTarget.innerText = target.dataset.title;
    this.playButtonTarget.disabled = false;

    if (this.trackKey == trackKey) {
      this.handleSameTrack(event);
    } else {
      this.handleNewTrack(trackKey);
    }
  }

  handleSameTrack(event) {
    if (this.audio.paused) {
      this.audio.play();
    } else {
      this.audio.pause();
    }
  }

  handleNewTrack(trackKey) {
    this.setBtnPause();

    this.trackKey = trackKey;

    fetch("/player/fetch_audio?key=" + trackKey)
      .then(response => response.blob())
      .then(blob => {
          this.audio.src = URL.createObjectURL(blob);
          this.audio.load();
          this.audio.play();
          //this.audio.controls = "controls";
          this.audioContext.resume();
      })
      .catch(console.error);

    this.audio.addEventListener("ended", (event) => {
      this.setBtnPause();
      this.audio.currentTime = 0;
    });

    this.audio.addEventListener("play", (event) => {
      this.setBtnPlay();
    });

    this.audio.addEventListener("pause", (event) => {
      this.setBtnPause();
    });

    this.audio.addEventListener("canplay", (event) => {
      this.waveFormTarget.innerHTML = "";

      const wavesurfer = WaveSurfer.create({
        container: this.waveFormTarget,
        waveColor: "#cfe2ff",
        progressColor: "#0d6efd",
        height: 35,
        media: this.audio,
        plugins: [
          Hover.create({
            lineColor: "#cc008b",
            lineWidth: 2,
            labelBackground: "#555",
            labelColor: "#fff",
            labelSize: "11px",
          }),
        ],      
      })
  
    }, { once: true });
  }
}
