export type QueryResult<T> = {
  items: T[];
  pageInfo: {
    hasPrevious: boolean;
    hasNext: boolean;
  };
}
