import { loadRemoteModule } from '@angular-architects/module-federation';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const MFE_APP_URL = "http://localhost:4300/remoteEntry.js";

const routes: Routes = [
  {
    path: '',
    redirectTo: 'countermap',
    pathMatch: "full"
  },
  {
    path: 'countermap',
    loadChildren: () => {
      return loadRemoteModule({
        remoteEntry: "http://localhost:4300/remoteEntry.js",
        type: 'module',
        //remoteName: 'mfeApp',
        exposedModule: "./CounterModule",
      }).then(m => m.CounterModule).catch(err => console.log(err));
    }
  }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
