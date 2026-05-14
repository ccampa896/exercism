function getOrdinal(number) {
    const s = String(number);
    const lastTwo = s.slice(-2);
    const last = s.slice(-1);

    if (['11', '12', '13'].includes(lastTwo)) return 'th';

    const suffixes = { 1: 'st', 2: 'nd', 3: 'rd' };

    return suffixes[last] || 'th';
}

export function format(name, number) {
    const suffix = getOrdinal(number);
    return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`;
}
