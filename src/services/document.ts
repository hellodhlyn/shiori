import { Service } from 'typedi';
import { InjectRepository } from 'typeorm-typedi-extensions';
import { Repository } from 'typeorm';

import Document from '../models/document';
import DocumentRevision from '../models/document-revision';

@Service()
export default class DocumentService {
  constructor(
    @InjectRepository(Document) private readonly documentRepository: Repository<Document>,
    @InjectRepository(DocumentRevision) private readonly revisionRepository: Repository<DocumentRevision>,
  ) {}

  async findByTitle(title: string): Promise<Document> {
    return this.documentRepository.findOne({ where: { title }, relations: ['revisions'] });
  }

  async findRandom(): Promise<Document> {
    const totalSize = await this.documentRepository.count();
    if (totalSize === 0) {
      return null;
    }

    const rows = await this.documentRepository.find({ skip: Math.floor(Math.random() * totalSize), take: 1 });
    return rows[0];
  }

  async create(title: string, body: string, description?: string, changelog?: string): Promise<Document> {
    if (await this.findByTitle(title)) {
      throw new Error('duplicated_title');
    }

    const doc = new Document();
    doc.title = title;
    await this.documentRepository.save(doc);

    const rev = new DocumentRevision();
    rev.document = doc;
    rev.revisionNumber = 1;
    rev.changelog = changelog;
    rev.description = description;
    rev.body = body;
    await this.revisionRepository.save(rev);

    return this.findByTitle(title);
  }
}
