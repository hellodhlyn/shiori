import { Service } from 'typedi';

import { Connection, queryResultToConnection } from './connection';
import Document from '../models/document';
import DocumentRevision from '../models/document-revision';
import DocumentService from '../services/document';
import DocumentRevisionService from '../services/document-revision';

@Service()
export default class Queries {
  constructor(
    private readonly documentService: DocumentService,
    private readonly revisionService: DocumentRevisionService,
  ) {}

  async document(args: {title: string}): Promise<Document> {
    return this.documentService.findByTitle(args.title);
  }

  async randomDocument(): Promise<Document> {
    return this.documentService.findRandom();
  }

  async revisions(args: {last: number}): Promise<Connection<DocumentRevision>> {
    return queryResultToConnection<DocumentRevision>(await this.revisionService.query(args.last));
  }
}
