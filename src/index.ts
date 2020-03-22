import 'reflect-metadata';
import { Container } from 'typedi';
import { createConnection, useContainer } from 'typeorm';

import ApiApplication from './applications/api';
import ormconfig from './ormconfig';

async function initialize(): Promise<void> {
  useContainer(Container);
  await createConnection(ormconfig);
}

(async (): Promise<void> => {
  await initialize();

  const apiApp = Container.get(ApiApplication);
  apiApp.start();
})();
