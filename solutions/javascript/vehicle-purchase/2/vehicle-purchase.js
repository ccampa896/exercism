// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Determines whether or not you need a license to operate a certain kind of vehicle.
 *
 * @param {string} kind
 * @returns {boolean} whether a license is required
 */
export function needsLicense(kind) {
    return kind === 'car' || kind === 'truck';
}

/**
 * Helps choosing between two options by recommending the one that
 * comes first in dictionary order.
 *
 * @param {string} option1
 * @param {string} option2
 * @returns {string} a sentence of advice which option to choose
 */
export function chooseVehicle(option1, option2) {
    const better = option1 < option2 ? option1 : option2;
    return `${better} is clearly the better choice.`;
}

/**
 * Calculates an estimate for the price of a used vehicle in the dealership
 * based on the original price and the age of the vehicle.
 *
 * @param {number} originalPrice
 * @param {number} age
 * @returns {number} expected resell price in the dealership
 */
export function calculateResellPrice(originalPrice, age) {
    const rules = [
        { max: 3, factor: 0.8 }, // Age < 3 -> 80%
        { max: 11, factor: 0.7 }, // Age < 11 (ou seja, 3 até 10) -> 70%
        { max: Infinity, factor: 0.5 },
    ];

    const { factor } = rules.find(r => age < r.max);

    return originalPrice * factor;
}
