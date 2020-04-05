# App
@title TEMP
@s TEMP

@file app/containers/App.tsx
```js
import React, { ReactNode } from 'react';

type Props = {
  children: ReactNode;
};

export default function App(props: Props) {
  const { children } = props;
  return <>{children}</>;
}
```
