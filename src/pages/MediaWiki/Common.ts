var baseUrl = "https://bgswikiapi.glitch.me";
function createElement(tagName, data?) {
  var element = document.createElement(tagName);
  if (!data) return element;
  for (var key in data) {
    if (data.hasOwnProperty(key) && data[key]) {
      element[key] = data[key];
    }
  }
  return element;
}
function apiRequest(
  callback: (boolean, unknown) => void,
  path: string,
  method: string,
  headers,
  data: string | Record<any, any>,
) {
  $.ajax({
    "async": true,
    "type": method || "GET",
    "url": baseUrl + path,
    "data": method !== "GET" ? null : data,
    "cache": false,
    "headers": headers || {},
  }).done(function (data) {
    callback(false, data);
  }).fail(function (data) {
    callback(true, data);
  });
}
function calculateStat(level: number, enchant: number, stat: number) {
  var l = level || 1;
  var e = enchant || 0;
  var res = stat + ((stat * 2) - stat) * (l - 1) / (25 - 1);
  return (res + ((res * 1.625) - res) * e / 50);
}

// stats calculator

// used on pet pages for the infoboxes, max enchant and max level values may change
// because of the game updating to have a higher value
function createStatsCalculator(element) {
  var level = createElement("input");
  var levelLabel = createElement("label", { innerHTML: "Level" });
  var enchant = createElement("input");
  var enchantLabel = createElement("label", { innerHTML: "Enchant" });
  var calculate = createElement("button", {
    innerHTML: "Calculate",
    onclick: function () {
      var infobox = document.getElementsByClassName("portable-infobox")[0];
      var spans = infobox.getElementsByTagName("span");
      for (var i = 0; i < spans.length; i++) {
        if (!spans[i].getAttribute("data-original")) {
          var stat = spans[i].innerHTML;
          spans[i].setAttribute(
            "data-original",
            (stat.substring(1, stat.length).replace(/,/g, "")),
          );
          spans[i].setAttribute("data-sep", stat.charAt(0));
        }
        var original = parseInt(spans[i].getAttribute("data-original"));
        var sep = spans[i].getAttribute("data-sep");
        if (!isNaN(original) && !isNaN(enchant.value) && !isNaN(level.value)) {
          var headers = infobox.getElementsByClassName("pi-header");
          if (calculateStat(level.value, enchant.value, original) == original) {
            for (var a = 0; a < headers.length; a++) {
              if (headers[a].innerHTML.includes("Calculated")) {
                var inner = headers[a].innerHTML;
                headers[a].innerHTML = inner.replace("Calculated ", "").replace(
                  "Stats",
                  "Base Stats",
                );
              }
            }
          } else {
            for (var a = 0; a < headers.length; a++) {
              if (headers[a].innerHTML.includes("Base")) {
                var inner = headers[a].innerHTML;
                headers[a].innerHTML = "Calculated " +
                  inner.replace("Base ", "");
              }
            }
          }
          spans[i].innerHTML = sep +
            commafy(calculateStat(level.value, enchant.value, original));
        }
      }
    },
  });
  var maxLevel = createElement("button", {
    innerHTML: "🔮 Max Level",
    onclick: function () {
      level.value = 25;
      calculate.click();
    },
  });
  var maxEnchant = createElement("button", {
    innerHTML: "🧪 Max Enchant",
    onclick: function () {
      enchant.value = 40;
      calculate.click();
    },
  });
  var maxShadowEnchant = createElement("button", {
    innerHTML: "👽 Max Shadow Enchant",
    onclick: function () {
      enchant.value = 50;
      calculate.click();
    },
  });
  element.append(
    levelLabel,
    createElement("br"),
    level,
    createElement("br"),
    maxLevel,
    createElement("br"),
    createElement("br"),
    enchantLabel,
    createElement("br"),
    enchant,
    createElement("br"),
    maxEnchant,
    createElement("br"),
    createElement("br"),
    maxShadowEnchant,
    createElement("br"),
    createElement("br"),
    calculate,
  );
}
if (document.getElementsByClassName("calculator")[0]) {
  var calculators = document.getElementsByClassName("calculator");
  for (var i = 0; i < calculators.length; i++) {
    createStatsCalculator(calculators[i]);
  }
}

function commafy(input: string | number) {
  return input.toString().replace(/(^|[^\w.])(\d{4,})/g, function ($0, $1, $2) {
    return $1 + $2.replace(/\d(?=(?:\d\d\d)+(?!\d))/g, "$&,");
  });
}
