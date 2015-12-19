(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
module.exports={
  "title": "scratoon",
  "descriptor": {
    "en": {
      "blocks": [
        [" ", "send %s's score ( %n point )", "sendScore", "anonymous", 0]
      ]
    },
    "ja": {
      "blocks": [
        [" ", "%s の スコア ( %n ポイント ) を送る", "sendScore", "anonymous", 0]
      ]
    }
  }
}

},{}],2:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
var ENDPOINT = 'https://scratoon.herokuapp.com/register';

var ext = {
  sendScore: function sendScore(name, point) {
    var data = new FormData();
    data.append('name', name);
    data.append('point', point);

    fetch(ENDPOINT, {
      method: 'post',
      body: data,
      credentials: 'cors'
    }).then(function (res) {
      alert('送信しました');
    });
  }
};

exports.ext = ext;

},{}],3:[function(require,module,exports){
"use strict";

var _data = require("./data.json");

var data = _interopRequireWildcard(_data);

var _ext = require("./ext.js");

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

(function (e, ext, data) {
  // Check for GET param 'lang'
  // codes from https://github.com/khanning/scratch-arduino-extension/blob/da1ab317a215a8c1c5cda1b9db756b9edc14ba68/arduino_extension.js#L533-L541
  var variables = window.location.search.replace(/^\?|\/$/g, '').split('&');
  var lang = 'en';
  variables.forEach(function (variable) {
    var pair = variable.split('=');
    if (pair.length > 1 && pair[0] == 'lang') lang = pair[1];
  });

  Object.keys(ext).forEach(function (key) {
    e[key] = ext[key];
  });

  ScratchExtensions.register(data.title, data.descriptor[lang], e);
})({}, _ext.ext, data);

},{"./data.json":1,"./ext.js":2}]},{},[3])
//# sourceMappingURL=main.js.map
