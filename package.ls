#!/usr/bin/env lsc -cj
author:
  name: ['Chen Hsin-Yi']
  email: 'ossug.hychen@gmail.com'
name: 'api.addressbook'
description: 'who is who?'
version: '0.0.1'
main: \lib/index.js
repository:
  type: 'git'
  url: 'git://github.com/g0v/api.addressbook.git'
scripts:
  test: """
    mocha
  """
  prepublish: """
    lsc -cj package.ls &&
    lsc -bc -o lib src
  """
  # this is probably installing from git directly, no lib.  assuming dev
  postinstall: """
    if [ ! -e ./lib ]; then npm i LiveScript; lsc -bc -o lib src; fi
  """
engines: {node: '*'}
Dependencies:
  fscache: \0.0.1
  async: \0.2.x
  optimist: \0.4.x
  pgrest: 'git://github.com/pgrest/pgrest.git'
devDependencies:
  mocha: \1.14.x
  supertest: \0.7.x
  chai: \1.8.x
  LiveScript: \1.2.x
