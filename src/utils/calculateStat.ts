import constants from "./statCalculatorConstants.ts";
import calculateStatInternal from "./calculateStatInternal.ts";

export default function calculateStat(level = 1, enchant = 0, stat: number, isAmplified?: boolean): number {
    // calculate level
    let calculation = calculateStatInternal(constants.minLevel, constants.maxLevel, constants.maxLevelEffect, level, stat);
    // calculate enchant
    calculation = calculateStatInternal(constants.minEnchant, constants.maxShadowEnchant, constants.maxShadowEnchantEffect, enchant, calculation);

    return Math.ceil(calculation * (isAmplified ? 1.15 : 1));
}