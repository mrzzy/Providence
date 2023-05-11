/*
 * Providence
 * YNAB Sink
 * Database
 */

import pg from "pg";
import { SaveTransaction } from "ynab";

/// Expected schema of the table providing transactions to import.
export interface TableRow {
  import_id: string;
  account_id: string;
  date: Date;
  // amount should be an integer as expected by the YNAB API
  amount: number;
  payee_id: string;
  category_id: string;
  memo: string | null;
  cleared: SaveTransaction.ClearedEnum;
  approved: boolean;
  flag_color: SaveTransaction.FlagColorEnum | null;
  split_id: string | null;
  split_payee_id: string | null;
  split_memo: string | null;
}

/**
 * Query the database table for table rows.
 *
 * @param dbHost <HOSTNAME>:<PORT> the database server is listenin on.
 * @param tableId DATABASE>.<SCHEMA>.<TABLE> specifying the database table to query from.
 * @param user Username credential used to authenticate with the database.
 * @param password Password credential used to authenticate with the database.
 * @returns queried data as table rows.
 */
export async function queryDBTable(
  dbHost: string,
  tableId: string,
  user: string,
  password: string
): Promise<TableRow[]> {
  // connect to the database with db client
  const [host, portStr] = (dbHost as string).split(":");
  const [database, schema, table] = (tableId as string).split(".");
  const db = new pg.Client({
    host,
    port: Number.parseInt(portStr),
    database,
    user,
    password,
  });
  // a connection has to be made first before querying, otherwise queries will
  // end up stuck in the query queue and never evaluate.
  await db.connect();
  // query the database table for transactions
  return (await db.query(`SELECT * FROM ${schema}.${table};`)).rows;
}
