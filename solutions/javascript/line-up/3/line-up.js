function getOrdinal(number) {
    const s = String(number);
    const lastTwo = s.slice(-2);
    const lastOne = s.slice(-1);

    const suffixes = {
        1: 'st',
        2: 'nd',
        3: 'rd',
        11: 'th',
        12: 'th',
        13: 'th',
    };

    return suffixes[lastTwo] || suffixes[lastOne] || 'th';
}

export function format(name, number) {
    return `${name}, you are the ${number}${getOrdinal(number)} customer we serve today. Thank you!`;
}
