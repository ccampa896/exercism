export function decodedValue(colors: [Color, Color]): number {
    return COLORS.indexOf(colors[0]) * 10 + COLORS.indexOf(colors[1]);
}

export const COLORS = [
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
