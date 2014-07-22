#!/usr/bin/env node

'use strict';

var argv = process.argv.slice(2);
var action = argv[0];
var arg = argv[1];
if (!action) {
  abort();
}

var request = require('request');
var semver = require('semver');
var CVM_MIRROR = process.env.CVM_MIRROR || 'http://registry.npmjs.org/cortex';


function abort () {
  process.exit(1);
}

function write (message) {
  process.stdout.write(message);
}


function versions (callback) {
  request(CVM_MIRROR, function (err, res, body) {
    if (err) {
      return callback(err);
    }

    if (res.statusCode !== 200) {
      return callback({
        code: 'ERROR_HTTP_STATUS'
      });
    }

    var json;
    try {
      json = JSON.parse(body);
    } catch(e) {
      return callback(e);
    }

    var versions = Object.keys(json.versions);
    callback(null, versions);
  });
}


function resolve (range, versions) {
  if (range === 'latest') {
    return versions.pop();
  }

  return semver.maxSatisfying(versions, range);
}


switch(action) {
  case "versions":
    versions(function (err, versions) {
      if (err) {
        abort();
      }

      write(versions.join(' '));
    });
    break;

  case "version":
    if (!arg) {
      abort();
    }

    versions(function (err, versions) {
      if (err) {
        abort();
      }

      var match = resolve(arg, versions);
      write(match || '');
    });

    break;
}
