import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { isSupported, setup } from "@loomhq/loom-sdk";
// import { isSupported, setup } from "@loomhq/loom-sdk/dist/cjs/safe";
import { oembed } from "@loomhq/loom-embed";
import { AngularFirestore } from '@angular/fire/compat/firestore';

@Component({
  selector: 'app-record',
  templateUrl: './record.component.html',
  styleUrls: ['./record.component.css']
})
export class RecordComponent implements OnInit {

  constructor(private _router: ActivatedRoute, private _firestore: AngularFirestore) { }

  title = 'HMS-LOOM-App';
  API_KEY = "";
  BUTTON_ID = "loom-sdk-button";

  insertEmbedPlayer(html: string) {
    const target = document.getElementById("target");
    if (target) { target.innerHTML = html; }
  }
  async init() {
    const { supported, error } = await isSupported();
    if (!supported) { console.log(`Error setting up Loom: ${error}`); return; } else { console.log("browser has loom support.") }
  }

  async ngOnInit() {
    this.init();
    const root = document.getElementById("app");
    if (!root) { return; }
    root.innerHTML = `<button id="${this.BUTTON_ID}">Record</button>`;
    const button = document.getElementById(this.BUTTON_ID);
    if (!button) { return; } else { console.log("button found") }
    const { configureButton } = await setup({ apiKey: "" });
    const sdkButton = configureButton({ element: button });
    sdkButton.on("insert-click",
      async video => {
        const { html } = await oembed(video.sharedUrl, { width: 400 });
        this.setData(video.sharedUrl);
        this.insertEmbedPlayer(html);
      });
  }

  setData(url: string) {
    const id = "users/" + this._router.snapshot.paramMap.get('id');
    this._firestore.doc(id).update({ "messages": url });
    console.log(id);
  }

}