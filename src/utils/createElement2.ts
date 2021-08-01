/// <reference path="https://deno.land/x/domtype@v1.0.4/mod.ts" />

declare global {
  namespace JSX {
    type Element = string;
    interface IntrinsicElements {
      [elementName: string]: unknown;
    }
  }
}
export default function createElement(tagName: string | ((props: Record<string, string | (() => unknown)>, children: (HTMLElement | string)[]) => HTMLElement), props: Record<string, string | (() => unknown)> = {},  ...children: (HTMLElement | string)[]): HTMLElement {
  const element = typeof tagName === "string" ? document.createElement(tagName) : tagName(props, children);
  
  if (props) Object.entries(props).forEach(([index, value]) => {
    if (index.startsWith("on") && (index.toLowerCase() in window)) {
      // In most cases, the value should be a function. If it isn't, that's a problem.
      element.addEventListener(index.toLowerCase().substr(2), value as (() => void));
      // In most cases, the value should be able to convert to a string. If it can't, that's a problem.
    } else element.setAttribute(index, value.toString());
  });

  children.forEach(child => {
    if (Array.isArray(child)) element.append(...child);
    else element.append(child);
  });

  return element;
}
