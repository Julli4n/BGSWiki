/* import JQuery types when?


const baseUrl = "https://bgswiki.glitch.me/api";
export default function apiRequest(
    callback: (arg0: boolean, arg1: unknown) => void,
    path: string,
    method: string,
    headers: JQuery.PlainObject<string | null | undefined> | undefined,
    data: string | JQuery.PlainObject<unknown> | undefined
  ) {
    $.ajax({
      async: true,
      type: method || "GET",
      url: baseUrl + path,
      data: method !== "GET" ? undefined : data,
      cache: false,
      headers: headers ?? {},
      crossDomain: true
    }).done(function (data) {
      callback(false, data);
    }).fail(function (data) {
      callback(true, data);
    });
}
*/