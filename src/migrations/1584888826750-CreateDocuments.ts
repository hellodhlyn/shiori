import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateDocuments1584888826750 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.createTable(new Table({
      name: 'documents',
      columns: [
        { name: 'id', type: 'integer', isPrimary: true, isGenerated: true },
        { name: 'title', type: 'varchar', length: '200', isUnique: true },
        { name: 'created_at', type: 'timestamp with time zone', default: 'now()' },
        { name: 'updated_at', type: 'timestamp with time zone', default: 'now()' },
      ],
      indices: [
        { columnNames: ['title'] },
      ],
    }));

    await queryRunner.createTable(new Table({
      name: 'document_revisions',
      columns: [
        { name: 'id', type: 'integer', isPrimary: true, isGenerated: true },
        { name: 'revision', type: 'integer' },
        { name: 'document_id', type: 'integer' },
        { name: 'changelog', type: 'text', isNullable: true },
        { name: 'description', type: 'text', isNullable: true },
        { name: 'body', type: 'text' },
        { name: 'created_at', type: 'timestamp with time zone', default: 'now()' },
        { name: 'updated_at', type: 'timestamp with time zone', default: 'now()' },
      ],
      indices: [
        { columnNames: ['document_id', 'revision'] },
      ],
    }));
  }

  public async down(queryRunner: QueryRunner): Promise<any> {
    await queryRunner.dropTable('document_revisions');
    await queryRunner.dropTable('documents');
  }
}
