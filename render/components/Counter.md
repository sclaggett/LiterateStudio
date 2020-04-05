# Counter
@title TEMP
@s TEMP

@file app/render/components/Counter.tsx
```js
import React from 'react';
import { Link } from 'react-router-dom';
import styles from './Counter.css';
import routes from '../Routes.json';

type Props = {
  increment: () => void;
  incrementIfOdd: () => void;
  incrementAsync: () => void;
  decrement: () => void;
  counter: number;
};

export default function Counter(props: Props) {
  const {
    increment,
    incrementIfOdd,
    incrementAsync,
    decrement,
    counter
  } = props;

  return (
    <div>
      <div className={styles.backButton} data-tid="backButton">
        <Link to={routes.HOME}>
          <i className="fa fa-arrow-left fa-3x" />
        </Link>
      </div>
      <div className={`counter ${styles.counter}`} data-tid="counter">
        {counter}
      </div>
      <div className={styles.btnGroup}>
        <button
          className={styles.btn}
          onClick={increment}
          data-tclass="btn"
          type="button"
        >
          <i className="fa fa-plus" />
        </button>
        <button
          className={styles.btn}
          onClick={decrement}
          data-tclass="btn"
          type="button"
        >
          <i className="fa fa-minus" />
        </button>
        <button
          className={styles.btn}
          onClick={incrementIfOdd}
          data-tclass="btn"
          type="button"
        >
          odd
        </button>
        <button
          className={styles.btn}
          onClick={() => incrementAsync()}
          data-tclass="btn"
          type="button"
        >
          async
        </button>
      </div>
    </div>
  );
}
```

@file app/render/components/Counter.css
```css
.backButton {
  position: absolute;
}

.counter {
  position: absolute;
  top: 30%;
  left: 45%;
  font-size: 10rem;
  font-weight: bold;
  letter-spacing: -0.025em;
}

.btnGroup {
  position: relative;
  top: 500px;
  width: 480px;
  margin: 0 auto;
}

.btn {
  font-size: 1.6rem;
  font-weight: bold;
  background-color: #fff;
  border-radius: 50%;
  margin: 10px;
  width: 100px;
  height: 100px;
  opacity: 0.7;
  cursor: pointer;
  font-family: Arial, Helvetica, Helvetica Neue, sans-serif;
}

.btn:hover {
  color: white;
  background-color: rgba(0, 0, 0, 0.5);
}
```
