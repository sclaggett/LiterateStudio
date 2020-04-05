# Index
@title TEMP
@s TEMP

@file app/render/reducers/Index.ts
```js
import { combineReducers } from 'redux';
import { connectRouter } from 'connected-react-router';
import { History } from 'history';
import counter from './Counter';

export default function createRootReducer(history: History) {
  return combineReducers({
    router: connectRouter(history),
    counter
  });
}
```
