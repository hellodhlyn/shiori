import { Service } from 'typedi';

import Document from '../models/document';
import DocumentService from '../services/document';
import DocumentRevisionService from '../services/document-revision';
import DocumentRevision from '../models/document-revision';

export interface CreateDocumentInput {
  title: string;
  changelog: string;
  description: string;
  body: string;
}

export interface CreateRevisionInput {
  title: string;
  changelog: string;
  description: string;
  body: string;
}

@Service()
export default class Mutations {
  constructor(
    private readonly documentService: DocumentService,
    private readonly revisionService: DocumentRevisionService,
  ) {}

  async createDocument(args: { input: CreateDocumentInput }): Promise<Document> {
    const { input } = args;
    return this.documentService.create(input.title, input.body, input.description, input.changelog);
  }

  async createRevision(args: { input: CreateRevisionInput }): Promise<DocumentRevision> {
    const { input } = args;
    return this.revisionService.create(input.title, input.body, input.description, input.changelog);
  }
}
