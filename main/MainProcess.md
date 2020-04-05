# Main Process
@title TEMP
@s TEMP

This file is the main entry point for the application. It creates the main window which loads `app.html`, configures the application menu, and tweaks its behavior on Mac.

This module executes inside of electron's main process. You can start electron renderer process from here and communicate with the other processes through IPC.

When running `yarn build` or `yarn build-main`, this file is compiled to `./app/main.prod.js` using webpack. This gives us some performance wins.


@file app/main.dev.ts
```js
/* eslint global-require: off, no-console: off */

import path from 'path';
import { app, BrowserWindow } from 'electron';
import { autoUpdater } from 'electron-updater';
import log from 'electron-log';
import MenuBuilder from './menu';

export default class AppUpdater {
  constructor() {
    log.transports.file.level = 'info';
    autoUpdater.logger = log;
    autoUpdater.checkForUpdatesAndNotify();
  }
}

let mainWindow: BrowserWindow | null = null;

if (process.env.NODE_ENV === 'production') {
  const sourceMapSupport = require('source-map-support');
  sourceMapSupport.install();
}

if (
  process.env.NODE_ENV === 'development' ||
  process.env.DEBUG_PROD === 'true'
) {
  require('electron-debug')();
}

const installExtensions = async () => {
  const installer = require('electron-devtools-installer');
  const forceDownload = !!process.env.UPGRADE_EXTENSIONS;
  const extensions = ['REACT_DEVELOPER_TOOLS', 'REDUX_DEVTOOLS'];

  return Promise.all(
    extensions.map(name => installer.default(installer[name], forceDownload))
  ).catch(console.log);
};

const createWindow = async () => {
  if (
    process.env.NODE_ENV === 'development' ||
    process.env.DEBUG_PROD === 'true'
  ) {
    await installExtensions();
  }

  mainWindow = new BrowserWindow({
    show: false,
    width: 1024,
    height: 728,
    webPreferences:
      process.env.NODE_ENV === 'development' || process.env.E2E_BUILD === 'true'
        ? {
            nodeIntegration: true
          }
        : {
            preload: path.join(__dirname, 'dist/renderer.prod.js')
          }
  });

  mainWindow.loadURL(`file://${__dirname}/app.html`);

  // @TODO: Use 'ready-to-show' event
  //        https://github.com/electron/electron/blob/master/docs/api/browser-window.md#using-ready-to-show-event
  mainWindow.webContents.on('did-finish-load', () => {
    if (!mainWindow) {
      throw new Error('"mainWindow" is not defined');
    }
    if (process.env.START_MINIMIZED) {
      mainWindow.minimize();
    } else {
      mainWindow.show();
      mainWindow.focus();
    }
  });

  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  const menuBuilder = new MenuBuilder(mainWindow);
  menuBuilder.buildMenu();

  // Remove this if your app does not use auto updates
  // eslint-disable-next-line
  new AppUpdater();
};

/**
 * Add event listeners...
 */

app.on('window-all-closed', () => {
  // Respect the OSX convention of having the application in memory even
  // after all windows have been closed
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('ready', createWindow);

app.on('activate', () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (mainWindow === null) createWindow();
});
```

Electron's main process creates a new BrowserWindow as the application is spawning and loads this following HTML file into it. 

@file app/app.html
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Hello Electron React!</title>
    <script>
      (() => {
        if (
          typeof process !== 'object' ||
          (typeof process === 'object' && !process.env.START_HOT)
        ) {
          const link = document.createElement('link');
          link.rel = 'stylesheet';
          link.href = './dist/style.css';
          // HACK: Writing the script path should be done with webpack
          document.getElementsByTagName('head')[0].appendChild(link);
        }
      })();
    </script>
  </head>
  <body>
    <div id="root"></div>
    <script>
      if (typeof process === 'object') {
        const scripts = [];

        if (process.env.NODE_ENV === 'development') {
          // Dynamically insert the DLL script in development env in the
          // renderer process
          scripts.push('../dll/renderer.dev.dll.js');
        }
        if (process.env.START_HOT) {
          // Dynamically insert the bundled app script in the renderer process
          const port = process.env.PORT || 1212;
          scripts.push(`http://localhost:${port}/dist/renderer.dev.js`);
        } else {
          scripts.push('./dist/renderer.prod.js');
        }

        if (scripts.length) {
          document.write(
            scripts
              .map(script => `<script defer src="${script}"><\/script>`)
              .join('')
          );
        }
      }
    </script>
  </body>
</html>
```
