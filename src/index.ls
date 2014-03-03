require! fs
require! pgrest

export function bootstrap(plx, done)
  <- plx.query pgrest.util.define-schema \pgrest "pgrest schema"
  <- plx.query """
  CREATE TABLE IF NOT EXISTS organizations (
    id integer PRIMARY KEY,
    name text,
    other_names json,
    identifiers json,
    classification json,
    parent_id integer,
    founding_date date,
    dissolutions_date date,
    image text,
    contact_details json,
    links json
);
  """
  <- pgrest.bootstrap plx, \who require.resolve \../package.json
  done!