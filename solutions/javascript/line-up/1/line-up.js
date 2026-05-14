export const format = (name, number) => {
    let ord = 'th';

    const lastTwo = number % 100;
    const last = number % 10;

    if (last === 1 && lastTwo !== 11) {
        ord = 'st';
    } else if (last === 2 && lastTwo !== 12) {
        ord = 'nd';
    } else if (last === 3 && lastTwo !== 13) {
        ord = 'rd';
    }

    return `${name}, you are the ${number}${ord} customer we serve today. Thank you!`;
};
