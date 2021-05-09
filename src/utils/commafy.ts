export default function commafy(input: string | number) {
    return input.toString().replace(/(^|[^\w.])(\d{4,})/g, function (_, $1, $2) {
      return $1 + $2.replace(/\d(?=(?:\d\d\d)+(?!\d))/g, "$&,")
    });
}