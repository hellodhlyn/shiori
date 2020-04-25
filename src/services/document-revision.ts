import { Service } from 'typedi';
import { Repository } from 'typeorm';
import { InjectRepository } from 'typeorm-typedi-extensions';

import { QueryResult } from './index';
import Document from '../models/document';
import DocumentRevision from '../models/document-revision';

@Service()
export default class DocumentRevisionService {
  constructor(
    @InjectRepository(Document) private readonly documentRepository: Repository<Document>,
    @InjectRepository(DocumentRevision) private readonly revisionRepository: Repository<DocumentRevision>,
  ) {}

  async query(last: number): Promise<QueryResult<DocumentRevision>> {
    const results = await this.revisionRepository.find({
      order: { id: 'DESC' }, take: last + 1, relations: ['document'],
    });
    return {
      items: results.slice(0, last).sort((a, b) => (a.id - b.id)),
      pageInfo: { hasPrevious: false, hasNext: results.length > last },
    };
  }

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
