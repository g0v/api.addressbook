require fs

export bootstrap(plx, done)
  require! pgrest
  <- plx.query pgrest.util.define-schema \pgrest "pgrest schema"

  sql <- fs.readFile \../sql
  <- plx.query sql
  
	<- pgrest.bootstrap plx, \who require.resolve \../package.json
	done!