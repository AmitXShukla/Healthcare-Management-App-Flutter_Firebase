import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RecordComponent } from './shared/record/record.component';
import { MessagesComponent } from './shared/messages/messages.component';

const routes: Routes = [

  { path: '', redirectTo: '/record', pathMatch: 'full' },
  { path: 'record/:id', component: RecordComponent },
  { path: 'messages/:id', component: MessagesComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
