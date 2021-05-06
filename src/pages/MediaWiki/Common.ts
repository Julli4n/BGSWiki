import 'https://deno.land/x/domtype/mod.ts';
import "https://esm.sh/types-mediawiki";
import "https://esm.sh/@types/jquery";

import StatsCalculator from "../../components/StatsCalculator.ts";

// stats calculator

// used on pet pages for the infoboxes, max enchant and max level values may change
// because of the game updating to have a higher value
if (document.getElementsByClassName("calculator")[0]) {
  const calculators = document.getElementsByClassName("calculator");
  for (let i = 0; i < calculators.length; i++) {
    StatsCalculator(calculators[i]);
  }
};