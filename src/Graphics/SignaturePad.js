"use strict";

var resize = function (elm, options) {
  elm.height = options.height;
  elm.width = options.width;
};

exports.mkSignaturePadImpl = function (elm, options) {
  resize(elm, options);
  return new SignaturePad(elm, options);
};

exports.mkSignaturePadSimpleImpl = function (elm) {
  return new SignaturePad(elm);
};

exports.toDataURLImpl = function (pad, format) {
  return pad.toDataURL(format);
};

exports.fromDataURLImpl = function (pad, data) {
  return pad.fromDataURL(data);
};

exports.clearImpl = function (pad) {
  pad.clear();
};

exports.isEmptyImpl = function (pad) {
  return pad.isEmpty();
};

exports.onImpl = function (pad) {
  pad.on();
};

exports.offImpl = function (pad) {
  pad.off();
};