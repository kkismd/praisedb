import 'bootstrap';

import "./application.scss";
import $ from "jquery";
import "jquery-ui/accordion";
import "jquery-ui/sortable";
import "jquery-ui/datepicker";
import "jquery-ui-themes/themes/dark-hive/jquery-ui.min.css";
import "jquery-ui-themes/themes/dark-hive/theme.css";

window.$ = $;

import Rails from "rails-ujs";
Rails.start();

/** ここから下はサンプル */
import { hello } from "./greeter";
console.log(hello("Rails"));

import { foo } from './hello';
foo();