# ConfigureStore
@title TEMP
@s TEMP

The file *ConfigureStore* exports a function that creates store 

@file app/render/store/ConfigureStore.ts
```js
import configureStoreDev from './ConfigureStore.dev';
import configureStoreProd from './ConfigureStore.prod';

const selectedConfigureStore =
  process.env.NODE_ENV === 'production'
    ? configureStoreProd
    : configureStoreDev;

export const { configureStore } = selectedConfigureStore;

export const { history } = selectedConfigureStore;
```


Middleare provides a third-party extension point between dispatching an action, and the moment it reaches the reducer.

@file app/render/store/ConfigureStore.prod.ts
```js
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { createHashHistory } from 'history';
import { routerMiddleware } from 'connected-react-router';
import createRootReducer from '../reducers';
import { Store, counterStateType } from '../reducers/Types';

const history = createHashHistory();
const rootReducer = createRootReducer(history);
const router = routerMiddleware(history);
const enhancer = applyMiddleware(thunk, router);

function configureStore(initialState?: counterStateType): Store {
  return createStore(rootReducer, initialState, enhancer);
}

export default { configureStore, history };
```



@file app/render/store/ConfigureStore.dev.ts
```js
import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import { createHashHistory } from 'history';
import { routerMiddleware, routerActions } from 'connected-react-router';
import { createLogger } from 'redux-logger';
import createRootReducer from '../reducers';
import * as counterActions from '../actions/Counter';
import { counterStateType } from './reducers/Types';

declare global {
  interface Window {
    __REDUX_DEVTOOLS_EXTENSION_COMPOSE__: (
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      obj: Record<string, any>
    ) => Function;
  }
  interface NodeModule {
    hot?: {
      accept: (path: string, cb: () => void) => void;
    };
  }
}

const history = createHashHistory();

const rootReducer = createRootReducer(history);

const configureStore = (initialState?: counterStateType) => {
  // Redux Configuration
  const middleware = [];
  const enhancers = [];

  // Thunk Middleware
  middleware.push(thunk);

  // Logging Middleware
  const logger = createLogger({
    level: 'info',
    collapsed: true
  });

  // Skip redux logs in console during the tests
  if (process.env.NODE_ENV !== 'test') {
    middleware.push(logger);
  }

  // Router Middleware
  const router = routerMiddleware(history);
  middleware.push(router);

  // Redux DevTools Configuration
  const actionCreators = {
    ...counterActions,
    ...routerActions
  };
  // If Redux DevTools Extension is installed use it, otherwise use Redux compose
  /* eslint-disable no-underscore-dangle */
  const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__
    ? window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
        // Options: http://extension.remotedev.io/docs/API/Arguments.html
        actionCreators
      })
    : compose;
  /* eslint-enable no-underscore-dangle */

  // Apply Middleware & Compose Enhancers
  enhancers.push(applyMiddleware(...middleware));
  const enhancer = composeEnhancers(...enhancers);

  // Create Store
  const store = createStore(rootReducer, initialState, enhancer);

  if (module.hot) {
    module.hot.accept(
      '../Reducers',
      // eslint-disable-next-line global-require
      () => store.replaceReducer(require('../Reducers').default)
    );
  }

  return store;
};

export default { configureStore, history };
```

