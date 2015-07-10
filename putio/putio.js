if (!process.env.PUT_IO_TOKEN) {
  console.error('Missing PUT_IO_TOKEN.');
  process.exit(1);
}
if (!process.env.PWD) {
  console.error('Missing PWD.');
  process.exit(1);
}

// var _ = require('lodash');
var async = require('async');
var fs = require('fs');
var path = require('path');
var ProgressBar = require('progress');
var request = require('request');
var shellescape = require('shell-escape');
var shellexec = require('shelljs').exec;

var COLOURS = {
  FAIL: ' \033[0;31;49m[==]\033[0m ',
  GOOD: ' \033[0;32;49m[==]\033[0m ',
  WARN: ' \033[0;33;49m[==]\033[0m ',
  TASK: ' \033[0;34;49m[==]\033[0m ',
  USER: ' \033[1;1;49m[==]\033[0m '
};

var download = function download(file, next) {
  if (!file.id) {
    console.error('Unable to get file id from file: ' + JSON.stringify(file));
    return next();
  }

  if (!file.name) {
    console.error('Unable to get filename from file: ' + JSON.stringify(file));
    return next();
  }

  if (file.content_type.indexOf('video/') !== 0) {
    console.error('This file is not a video: ' + file.name);
    return next();
  }

  console.log(file.name);

  var progress = new ProgressBar('Downloading [:bar] :percent :etas', {
    complete: '=',
    incomplete: ' ',
    width: 20,
    total: parseInt(file.size, 10)
  });

  request({
    qs: {oauth_token: process.env.PUT_IO_TOKEN},
    url: 'https://api.put.io/v2/files/' + file.id + '/download'
  })
  .on('data', function (chunk) {
    progress.tick(chunk.length);
  })
  .on('error', next)
  .pipe(fs.createWriteStream(path.join(process.env.PWD, file.name)));
};

async.each(
  process.argv.slice(2),
  function (file_id, next) {
    console.log(file_id);

    if (isNaN(parseInt(file_id, 10))) {
      return next(COLOURS.FAIL + file_id + ' is not a valid number.');
    }

    request(
      {
        json: true,
        qs: {oauth_token: process.env.PUT_IO_TOKEN},
        url: 'https://api.put.io/v2/files/' + file_id
      },
      function (error, res, body) {
        if (error) {
          return next(error);
        }
        if (res.statusCode !== 200 || !body || !body.file) {
          return next(new Error('Failed to get file from Put.IO: ' + JSON.stringify(body)));
        }

        if (body.file.content_type !== 'application/x-directory') {
          return download(body.file, next);
        }

        request(
          {
            json: true,
            qs: {oauth_token: process.env.PUT_IO_TOKEN, parent_id: file_id},
            url: 'https://api.put.io/v2/files/list'
          },
          function (error, res, body) {
            if (error) {
              return next(error);
            }
            if (res.statusCode !== 200 || !body || !body.files) {
              return next(new Error('Failed to get files from Put.IO: ' + JSON.stringify(body)));
            }

            async.each(body.files, download, next);
          }
        );
      }
    );
  },
  function (error) {
    if (error) {
      console.error(error);
    }

    console.log('Finished!');
    process.exit(error ? 1 : 0);
  }
);
