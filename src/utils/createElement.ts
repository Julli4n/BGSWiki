import "https://deno.land/x/domtype/mod.ts";
export default function createElement(tagName: string, data?: Record<string, unknown>) {
    const element = document.createElement(tagName);
    if (!data) return element;
    for (const key in data) {
      if (data.hasOwnProperty(key) && data[key]) {
        // @ts-ignore: All arguments passed through should be valid arguments 
        element[key] = data[key];
      }
    }
    return element;
};