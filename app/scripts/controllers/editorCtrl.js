'use strict';

angular.module('seatmap')
  .controller('EditorCtrl', function ($scope, $http) {
    var editor = ace.edit('editor');
    editor.getSession().setTabSize(4);
    editor.getSession().setUseSoftTabs(true);
    editor.getSession().setMode("ace/mode/html");
//    editor.setTheme("ace/theme/monokai");
    $http.get('views/le.html').then(function(response) {
      editor.getSession().setValue(response.data)
    })
  });
