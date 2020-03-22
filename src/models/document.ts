import {
  AfterLoad, Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn,
} from 'typeorm';

import DocumentRevision from './document-revision';

@Entity('documents')
export default class Document {
  @PrimaryGeneratedColumn()
  public id: number;

  @Column()
  public title: string;

  @OneToMany(() => DocumentRevision, (rev) => rev.document)
  public revisions: DocumentRevision[];

  @CreateDateColumn()
  public createdAt: Date;

  @UpdateDateColumn()
  public updatedAt: Date;

  @AfterLoad()
  afterLoad(): void {
    if (this.revisions) {
      this.revisions = this.revisions.sort((a, b) => b.id - a.id);
    }
  }

  lastRevision(): DocumentRevision {
    return (this.revisions?.length > 0) ? this.revisions[0] : null;
  }
}
