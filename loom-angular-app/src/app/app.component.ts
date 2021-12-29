import { Component, OnInit } from '@angular/core';
// import { isSupported, setup } from "@loomhq/loom-sdk";
// import { oembed } from "@loomhq/loom-embed";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'HMS-LOOM-App';
  // API_KEY = "454de8ec-4232-415a-9199-cd95cfbdfb85";
  // BUTTON_ID = "loom-sdk-button";

  // insertEmbedPlayer(html: string) {
  //   const target = document.getElementById("target");
  //   if (target) { target.innerHTML = html; }
  // }
  // async init() {
  //   const { supported, error } = await isSupported();
  //   if (!supported) { console.log(`Error setting up Loom: ${error}`); return; } else { console.log("all good") }
  // }

  async ngOnInit() {
    // this.init();
    // const root = document.getElementById("app");
    // if (!root) { return; }
    // root.innerHTML = `<button id="${this.BUTTON_ID}">Record</button>`;
    // const button = document.getElementById(this.BUTTON_ID);
    // if (!button) { return; }
    // const { configureButton } = await setup({ apiKey: "454de8ec-4232-415a-9199-cd95cfbdfb85" });
    // const sdkButton = configureButton({ element: button });
    // sdkButton.on("insert-click",
    //   async video => {
    //     const { html } = await oembed(video.sharedUrl, { width: 400 });
    //     this.setData(video.sharedUrl);
    //     this.insertEmbedPlayer(html);
    //   });
  }

  setData(url: string) {
    console.log(url);
  }

}