import 'bootstrap';

import "./application.scss";
import $ from "jquery";
window.$ = $;
import "jquery-ui/ui/effects/effect-highlight";
import "jquery-ui/ui/widgets/accordion";
import "jquery-ui/ui/widgets/sortable";
import "jquery-ui/ui/widgets/datepicker";
import "jquery-ui/ui/widgets/draggable";
import "jquery-ui-themes/themes/dark-hive/jquery-ui.min.css";
import "jquery-ui-themes/themes/dark-hive/theme.css";
import Rails from "rails-ujs";
Rails.start();

import './common';
import './books';
import './songs';
import './slides';
import ready from './ready';

// start up your app
ready(function () {
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
});