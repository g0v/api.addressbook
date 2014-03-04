#!/usr/bin/env lsc
require! <[optimist async fscache]>
require! \./lib/cli

{input, db} = optimist.argv

orglist = require require.resolve input
plx <- cli.plx {+client}

update-orgs = (next) ->
  funcs = for let entry in orglist 
    (done) ->
      console.log "inserting"
      res <- plx.query "select pgrest_insert($1)", [collection: \organizations, $: entry]
      done!
  err, res <- async.series funcs
  next!

<- update-orgs
console.log "inserted organizations entries from orglist to postgresql."

# populiate parent id.
console.log "updated parent id of all organizations."

plx.end!