# Styling
@title TEMP
@s TEMP

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
