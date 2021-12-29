import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { isSupported, setup } from "@loomhq/loom-sdk";
// import { isSupported, setup } from "@loomhq/loom-sdk/dist/cjs/safe";
import { oembed } from "@loomhq/loom-embed";

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.css']
})
export class MessagesComponent implements OnInit {

  constructor(private _router: ActivatedRoute) { }

  title = 'HMS-LOOM-App';
  API_KEY = "";
  BUTTON_ID = "loom-sdk-button";

  insertEmbedPlayer(html: string) {
    const target = document.getElementById("target");
    if (target) { target.innerHTML = html; }
  }
  async init() {
    const { supported, error } = await isSupported();
    if (!supported) { console.log(`Error setting up Loom: ${error}`); return; } else { console.log("all good") }
  }

  async ngOnInit() {
    const id = "https://www.loom.com/share/" + this._router.snapshot.paramMap.get('id');
    this.init();
    const root = document.getElementById("app");
    if (!root) { return; }
    root.innerHTML = `<button id="${this.BUTTON_ID}">Show Video</button>`;
    const button = document.getElementById(this.BUTTON_ID);
    if (!button) { return; }
    const { html } = await oembed(id, { width: 400 });
    this.insertEmbedPlayer(html);
    // const { configureButton } = await setup({ apiKey: "" });
    // const sdkButton = configureButton({ element: button });
    // sdkButton.on("insert-click",
    //   async video => {
    //     // const { html } = await oembed(video.sharedUrl, { width: 400 });
    //     const { html } = await oembed(id, { width: 400 });
    //     this.insertEmbedPlayer(html);
    //   });
  }

  setData(url: string) {
    console.log(url);
  }

}