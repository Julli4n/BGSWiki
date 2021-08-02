/// <reference path="https://deno.land/x/domtype@v1.0.4/mod.ts" />

declare global {
  namespace JSX {
    type Element = string;
    interface IntrinsicElements {
      [elementName: string]: unknown;
    }
  }
}
export default function createElement(tagName: string | ((props: Record<string, string | (() => unknown)>, children: (HTMLElement | string)[]) => HTMLElement | DocumentFragment), props: Record<string, string | (() => unknown)> = {},  ...children: (HTMLElement | string)[]): HTMLElement | DocumentFragment {
  const element = typeof tagName === "string" ? (tagName === "fragment" ? new DocumentFragment()  : document.createElement(tagName)) : tagName(props, children);
  
  if (props) Object.entries(props).forEach(([index, value]) => {
    if (index === "className" && (element instanceof HTMLElement)) element.className = value.toString();

    if (index.startsWith("on") && (index.toLowerCase() in window)) {
      element.addEventListener(index.toLowerCase().substr(2), value as (() => void));
      // @ts-ignore: "Props" will only **ever** exist if it isn't a fragment
    } else element.setAttribute(index, value.toString());
  });

  children.forEach(child => {
    if (Array.isArray(child)) element.append(...child);
    else element.append(child);
  });

  return element;
}
