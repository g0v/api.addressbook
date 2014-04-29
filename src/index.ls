require! fs
require! path
require! pgrest

export function bootstrap(plx, done)
  root = path.dirname require.main.filename
  <- plx.query pgrest.util.define-schema \pgrest "pgrest schema"
  tpl_sql = fs.readFileSync (path.join root, \addressbook-tpl.sql), "utf-8"
  <- plx.query tpl_sql
  <- pgrest.bootstrap plx, \who require.resolve \../package.json
  done!