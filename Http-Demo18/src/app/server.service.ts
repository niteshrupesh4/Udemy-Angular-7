import { Injectable } from '@angular/core';
import { Headers, Http, Response } from '@angular/http';
import { Observable } from 'rxjs';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';
import 'rxjs/add/observable/throw';

@Injectable()
export class ServerService {
  constructor(private http: Http) {}
  storeServers(servers: any[]) {
    const headers = new Headers({ 'Content-Type': 'application/json' });
    //    return this.http.post('https://http-demo-f22b3.firebaseio.com/data.json', servers);

    return this.http.put('https://http-demo-f22b3.firebaseio.com/data.json',
      servers,
      {
        headers: headers
      }
    );
  }
  getServers() {
    return this.http
      .get('https://http-demo-f22b3.firebaseio.com/data.json')
      .map((responce: Response) => {
        const data = responce.json();
        for (const server of data) {
          server.name = 'FETCHED_' + server.name;
        }
        return data;
      })
      .catch((error: Response) => {
        return Observable.throw('Somthing went wrong!');
      });
  }
  getAppName() {
    return this.http
      .get('https://http-demo-f22b3.firebaseio.com/appName.json')
      .map((responce: Response) => {
        return responce.json();
      });
  }
}
