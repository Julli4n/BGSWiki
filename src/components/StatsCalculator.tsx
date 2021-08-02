/// <reference path="https://deno.land/x/domtype@v1.0.4/mod.ts" />

import createElement from "../utils/createElement.ts";
import commafy from "../utils/commafy.ts";
import constants from "../utils/statCalculatorConstants.ts";
import calculateStat from "../utils/calculateStat.ts";

// TODO: add amplifiers for potions, also redo it entirely to be on the left side of the Infobox
export default function StatsCalculator(element: Element): DocumentFragment {
    return (<>
      <label className="level-label">Level</label>
      <br />
      <input className="level-input" />
      <br />
      <button className="max-level" onclick={() => {
        const level = element.getElementsByClassName("level-input")[0] as HTMLInputElement;
        const calculate = element.getElementsByClassName("calculate")[0] as HTMLButtonElement;

        level.value = String(constants.maxLevel);
        calculate.click();
      }}>🔮 Max Level</button>
      <br />
      <br />
      <label className="enchant-label">Enchant</label>
      <br />
      <input className="enchant-input" />
      <br />
      <button className="max-enchant" onclick={() => {
        const enchant = element.getElementsByClassName("enchant-input")[0] as HTMLInputElement;
        const calculate = element.getElementsByClassName("calculate")[0] as HTMLButtonElement;

        enchant.value = String(constants.maxEnchant);
        calculate.click();
      }}>🧪 Max Normal Enchant</button>
      <br />
      <br />
      <button className="max-shadow-enchant" onclick={() => {
        const enchant = element.getElementsByClassName("enchant-input")[0] as HTMLInputElement;
        const calculate = element.getElementsByClassName("calculate")[0] as HTMLButtonElement;

        enchant.value = String(constants.maxShadowEnchant);
        calculate.click();
      }} >👽 Max Shadow Enchant</button>
      <br />
      <br />
      <button className="calculate" onclick={() => {
        const level = element.getElementsByClassName("level-input")[0] as HTMLInputElement;
        const enchant = element.getElementsByClassName("enchant-input")[0] as HTMLInputElement;

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
          const enchantValue = parseInt(enchant.value !== "" ? enchant.value: "0");
          const levelValue = parseInt(level.value !== "" ? level.value : "1");
          if (!isNaN(original) && !isNaN(enchantValue) && !isNaN(levelValue)) {
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
              commafy(calculateStat(levelValue, enchantValue, original));
          }
        }
      
      }}>Calculate</button>
    </>) as unknown as DocumentFragment;
}