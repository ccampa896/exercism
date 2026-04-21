export function format(name: string, number: number): string {
  const lastDigit = number % 10
  const secondLast = Math.floor(number / 10) % 10

  const suffixes: Record<number, string> = { 1: 'st', 2: 'nd', 3: 'rd' }

  const suffix = (secondLast !== 1 && suffixes[lastDigit]) || 'th'

  return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`
}
