import cors from '@koa/cors';
import Koa from 'koa';
import mount from 'koa-mount';
import graphql from 'koa-graphql';
import { Service } from 'typedi';

import schema from '../graphql/schema';
import Queries from '../graphql/queries';
import Mutations, { CreateDocumentInput, CreateRevisionInput } from '../graphql/mutations';
import Document from '../models/document';
import DocumentRevision from '../models/document-revision';

@Service()
export default class ApiApplication {
  private app: Koa;

  constructor(
    private readonly queries: Queries,
    private readonly mutations: Mutations,
  ) {
    this.initialize();
  }

  initialize(): void {
    const app = new Koa();

    app.use(cors());
    app.use(mount('/graphql', graphql({
      schema,
      rootValue: {
        // Queries
        document: (args: {title: string}): Promise<Document> => this.queries.document(args),
        randomDocument: (): Promise<Document> => this.queries.randomDocument(),

        // Mutations
        createDocument:
          (args: { input: CreateDocumentInput }): Promise<Document> => this.mutations.createDocument(args),
        createRevision:
          (args: { input: CreateRevisionInput }): Promise<DocumentRevision> => this.mutations.createRevision(args),
      },
      graphiql: true,
    })));
    this.app = app;
  }

  start(): void {
    this.app.listen(process.env.PORT || 8080);
  }
}
