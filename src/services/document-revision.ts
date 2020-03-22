import { Service } from 'typedi';
import { Repository } from 'typeorm';
import { InjectRepository } from 'typeorm-typedi-extensions';

import Document from '../models/document';
import DocumentRevision from '../models/document-revision';

@Service()
export default class DocumentRevisionService {
  constructor(
    @InjectRepository(Document) private readonly documentRepository: Repository<Document>,
    @InjectRepository(DocumentRevision) private readonly revisionRepository: Repository<DocumentRevision>,
  ) {}

  async create(title: string, body: string, description?: string, changelog?: string): Promise<DocumentRevision> {
    const doc = await this.documentRepository.findOne({ where: { title }, relations: ['revisions'] });
    if (!doc) {
      throw new Error('no_such_document');
    }

    const rev = new DocumentRevision();
    rev.document = doc;
    rev.revisionNumber = doc.lastRevision().revisionNumber + 1;
    rev.changelog = changelog;
    rev.description = description;
    rev.body = body;

    return this.revisionRepository.save(rev);
  }
}
