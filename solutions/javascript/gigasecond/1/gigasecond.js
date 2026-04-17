const GIGASECOND = 1_000_000_000 * 1000;

export const gigasecond = (date) => {
  return new Date(date.getTime() + GIGASECOND);
};
