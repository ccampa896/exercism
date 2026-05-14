const PREFIXES = ['', 'kilo', 'mega', 'giga'];

const COLORS = [
    'black',
    'brown',
    'red',
    'orange',
    'yellow',
    'green',
    'blue',
    'violet',
    'grey',
    'white',
] as const;

export type Color = (typeof COLORS)[number];

export function decodedResistorValue(
    colors: [Color, Color, Color, ...Color[]],
): string {
    const [tens, ones, multiplier] = colors
        .slice(0, 3)
        .map(color => COLORS.indexOf(color));

    let base = tens * 10 + ones;
    let zeros = multiplier;

    if (base > 0 && base % 10 === 0) {
        base /= 10;
        zeros += 1;
    }

    const prefix_index = (zeros / 3) | 0;
    const remaining_zeros = zeros % 3;

    const final_value = base * 10 ** remaining_zeros;
    const prefix = PREFIXES[prefix_index];

    return `${final_value} ${prefix}ohms`;
}
