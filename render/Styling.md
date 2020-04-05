# Styling
@title TEMP
@s TEMP

@file app/app.global.css
```css
/*
 * @NOTE: Prepend a `~` to css file paths that are in your node_modules
 *        See https://github.com/webpack-contrib/sass-loader#imports
 */
@import '~@fortawesome/fontawesome-free/css/all.css';

body {
  position: relative;
  color: white;
  height: 100vh;
  background-color: #232c39;
  background-image: linear-gradient(
    45deg,
    rgba(0, 216, 255, 0.5) 10%,
    rgba(0, 1, 127, 0.7)
  );
  font-family: Arial, Helvetica, Helvetica Neue, serif;
  overflow-y: hidden;
}

h2 {
  margin: 0;
  font-size: 2.25rem;
  font-weight: bold;
  letter-spacing: -0.025em;
  color: #fff;
}

p {
  font-size: 24px;
}

li {
  list-style: none;
}

a {
  color: white;
  opacity: 0.75;
  text-decoration: none;
}

a:hover {
  opacity: 1;
  text-decoration: none;
  cursor: pointer;
}
```


using both CSS Modules and TypeScript with webpack

The easiest way is to not integrate the two together at all by using require instead of import. The styles object will be typed as `any` offering no type-safety.

define a module definition that applies to all style imports. It won’t catch invalid class names or provide the type-ahead in supported editors but it is an improvement on `any`.

@file app/components/css.d.ts
```css
declare module '*.scss' {
  const content: { [className: string]: string };
  export default content;
}

declare module '*.css' {
  const content: { [className: string]: string };
  export default content;
}
```
