import constants from "./statCalculatorConstants.ts";

export default function calculateStat(level = 1, enchant = 0, stat: number) {
    // calculate level
    const res = stat + ((stat * constants.maxLevelEffect) - stat) * (level - 1) / (constants.maxLevel - 1);
    // calculate enchant
    return (res + ((res * constants.maxShadowEnchantEffect) - res) * enchant / constants.maxShadowEnchant);
}