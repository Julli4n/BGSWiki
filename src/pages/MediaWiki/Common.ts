import StatsCalculator from "../../components/StatsCalculator.tsx";
// stats calculator
// used on pet pages for the infoboxes, max enchant and max level values may change
// because of the experience updating to have a higher value
if (document.getElementsByClassName("calculator")[0]) {
  const calculators = document.getElementsByClassName("calculator");
  for (let i = 0; i < calculators.length; i++) {
    calculators[i].append(StatsCalculator(calculators[i]));
  }
}