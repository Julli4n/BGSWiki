import 'https://deno.land/x/domtype/mod.ts';

import createElement from "../utils/createElement.ts";
import commafy from "../utils/commafy.ts";
import constants from "../utils/statCalculatorConstants.ts";
import calculateStat from "../utils/calculateStat.ts";

// This really isn't a component *yet*, but this will nr vibing here
export default function StatsCalculator(element: Element) {
    const level = createElement("input") as HTMLInputElement;
    const levelLabel = createElement("label", { innerHTML: "Level" });
    const enchant = createElement("input") as HTMLInputElement;
    const enchantLabel = createElement("label", { innerHTML: "Enchant" });
    const calculate = createElement("button", {
      innerHTML: "Calculate",
      onclick: function () {
        const infobox = document.getElementsByClassName("portable-infobox")[0];
        const spans = infobox.getElementsByTagName("span");
        for (let i = 0; i < spans.length; i++) {
          if (!spans[i].getAttribute("data-original")) {
            const stat = spans[i].innerHTML;
            spans[i].setAttribute(
              "data-original",
              (stat.substring(1, stat.length).replace(/,/g, "")),
            );
            spans[i].setAttribute("data-sep", stat.charAt(0));
          }
          const original = parseInt(spans[i].getAttribute("data-original") ?? "0");
          const sep = spans[i].getAttribute("data-sep");
          if (!isNaN(original) && !isNaN(parseInt(enchant.value ?? "0")) && !isNaN(parseInt(level.value ?? "1"))) {
            const headers = infobox.getElementsByClassName("pi-header");
            if (calculateStat(parseInt(level.value), parseInt(enchant.value), original) == original) {
              for (let a = 0; a < headers.length; a++) {
                if (headers[a].innerHTML.includes("Calculated")) {
                  const inner = headers[a].innerHTML;
                  headers[a].innerHTML = inner.replace("Calculated ", "").replace(
                    "Stats",
                    "Base Stats",
                  );
                }
              }
            } else {
              for (let a = 0; a < headers.length; a++) {
                if (headers[a].innerHTML.includes("Base")) {
                  const inner = headers[a].innerHTML;
                  headers[a].innerHTML = "Calculated " +
                    inner.replace("Base ", "");
                }
              }
            }
            spans[i].innerHTML = sep +
              commafy(calculateStat(parseInt(level.value), parseInt(enchant.value), original));
          }
        }
      },
    });
    const maxLevel = createElement("button", {
      innerHTML: "🔮 Max Level",
      onclick: function () {
        level.value = String(constants.maxLevel);
        calculate.click();
      },
    });
    const maxEnchant = createElement("button", {
      innerHTML: "🧪 Max Enchant",
      onclick: function () {
        enchant.value = String(constants.maxEnchant);
        calculate.click();
      },
    });
    const maxShadowEnchant = createElement("button", {
      innerHTML: "👽 Max Shadow Enchant",
      onclick: function () {
        enchant.value = String(constants.maxShadowEnchant);
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