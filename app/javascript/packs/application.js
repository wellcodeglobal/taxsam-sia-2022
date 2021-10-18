// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'controllers'

import Util from './lib/util';
window.Util = Util;

import Ajax from './lib/ajax';
window.Ajax = Ajax;

import Flash from './lib/flash';
window.Flash = Flash;

Rails.start()
Turbolinks.start()
ActiveStorage.start()
