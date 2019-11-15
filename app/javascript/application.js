import 'bootstrap';

import "./application.scss";
import $ from "jquery";
window.$ = $;
import "jquery-ui/accordion";
import "jquery-ui/sortable";
import "jquery-ui/datepicker";
import "jquery-ui/draggable";
import "jquery-ui-themes/themes/dark-hive/jquery-ui.min.css";
import "jquery-ui-themes/themes/dark-hive/theme.css";
import Rails from "rails-ujs";
Rails.start();

import './common';
import './books';
import './songs';
import ready from './ready';

// start up your app
ready(function () {
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
});


/** ここから下はサンプル */
import { hello } from "./greeter";
console.log(hello("Rails"));

import { foo } from './hello';
foo();