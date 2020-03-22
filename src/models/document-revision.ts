import {
  Column, CreateDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn,
} from 'typeorm';

import Document from './document';

@Entity('document_revisions')
export default class DocumentRevision {
  @PrimaryGeneratedColumn()
  public id: number;

  @Column()
  public revisionNumber: number;

  @ManyToOne(() => Document, (doc) => doc.revisions)
  public document: Document;

  @Column()
  public changelog: string;

  @Column()
  public description: string;

  @Column()
  public body: string;

  @CreateDateColumn()
  public createdAt: Date;

  @UpdateDateColumn()
  public updatedAt: Date;
}
