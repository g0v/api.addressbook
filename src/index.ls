require! fs
require! pgrest

export function bootstrap(plx, done)
  <- plx.query pgrest.util.define-schema \pgrest "pgrest schema"
  <- plx.query """
  CREATE TABLE IF NOT EXISTS organizations (
    id serial PRIMARY KEY,
    name text,
    other_names json,
    identifiers json,
    classification text,
    parent_id integer,
    founding_date text,
    dissolutions_date text,
    image text,
    contact_details json,
    links json
);
  """
  <- pgrest.bootstrap plx, \who require.resolve \../package.json
  done!