const GIGASECOND_IN_MS = 1e12;

export const gigasecond = (date) => new Date(date.getTime() + GIGASECOND_IN_MS);
