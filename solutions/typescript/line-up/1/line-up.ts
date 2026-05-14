function getOrdinal(number: number): string {
  const s = String(number)
  const lastTwo = s.slice(-2)
  const last = s.slice(-1)

  if (['11', '12', '13'].includes(lastTwo)) return 'th'

  const suffixes: Record<string, string> = { '1': 'st', '2': 'nd', '3': 'rd' }

  return suffixes[last] || 'th'
}

export function format(name: string, number: number): string {
  const suffix = getOrdinal(number)
  return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`
}
