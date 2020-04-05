# Home
@title TEMP
@s TEMP

@file app/render/components/Home.tsx
```js
import React from 'react';
import { Link } from 'react-router-dom';
import routes from '../Routes.json';
import styles from './Home.css';

export default function Home() {
  return (
    <div className={styles.container} data-tid="container">
      <h2>Home</h2>
      <Link to={routes.COUNTER}>to counter</Link>
    </div>
  );
}
```

@file app/render/components/Home.css
```css
.container {
  position: absolute;
  top: 30%;
  left: 10px;
  text-align: center;
}

.container h2 {
  font-size: 5rem;
}

.container a {
  font-size: 1.4rem;
}
```
