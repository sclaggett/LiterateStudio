# Routing
@title TEMP
@s TEMP

@file app/render/Routes.json
```json
{
  "HOME": "/",
  "COUNTER": "/counter"
}
```

@file app/render/Router.tsx
```js
import React from 'react';
import { Switch, Route } from 'react-router-dom';
import routes from './Routes.json';
import App from './App';
import HomePage from './containers/HomePage';
import CounterPage from './containers/CounterPage';

export default function Router() {
  return (
    <App>
      <Switch>
        <Route path={routes.COUNTER} component={CounterPage} />
        <Route path={routes.HOME} component={HomePage} />
      </Switch>
    </App>
  );
}
```

