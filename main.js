'use strict';

const Electron = require('electron');

module.exports = {
  load () {
  },

  unload () {
  },

  messages: {
    'open' () {
      Editor.Panel.open('da');
    }
  }
};
