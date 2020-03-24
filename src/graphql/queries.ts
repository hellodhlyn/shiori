import { Service } from 'typedi';

import Document from '../models/document';
import DocumentService from '../services/document';

@Service()
export default class Queries {
  constructor(
    private readonly documentService: DocumentService,
  ) {}

  async document(args: {title: string}): Promise<Document> {
    return this.documentService.findByTitle(args.title);
  }

  async randomDocument(): Promise<Document> {
    return this.documentService.findRandom();
  }
}
