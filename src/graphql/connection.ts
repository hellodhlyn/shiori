import { QueryResult } from '../services';

type ConnectionPageInfo = {
  startCursor: string;
  endCursor: string;
  hasPreviousPage: boolean;
  hasNextPage: boolean;
}

type ConnectionEdge<T> = {
  node: T;
  cursor: string;
}

export type Connection<T> = {
  edges: ConnectionEdge<T>[];
  pageInfo: ConnectionPageInfo;
}

interface Idable {
  id: number;
}

function cursorOf(idable: Idable): string {
  return Buffer.from(`cursor:${idable.id}`).toString('base64');
}

export function queryResultToConnection<T extends Idable>(result: QueryResult<T>): Connection<T> {
  const { items } = result;
  return {
    edges: items.map((item) => ({ node: item, cursor: cursorOf(item) })),
    pageInfo: {
      startCursor: items.length === 0 ? null : cursorOf(items[0]),
      endCursor: items.length === 0 ? null : cursorOf(items[items.length - 1]),
      hasNextPage: result.pageInfo.hasNext,
      hasPreviousPage: result.pageInfo.hasPrevious,
    },
  };
}
