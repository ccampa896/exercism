export function decodedValue(colors: [Color, Color]): number {
  const [first, second] = colors
  return COLORS.indexOf(first) * 10 + COLORS.indexOf(second)
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
] as const

export type Color = (typeof COLORS)[number]
