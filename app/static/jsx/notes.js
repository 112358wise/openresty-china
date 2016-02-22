// Generated by CoffeeScript 1.10.0
(function() {
  window.NoteView = Backbone.View.extend({
    el: "body",
    events: {
      "click .editor-toolbar .edit a": "toggleEditView",
      "click .editor-toolbar .preview a": "togglePreviewView"
    },
    initialize: function(opts) {
      this.parentView = opts.parentView;
      return $("<div id='preview' class='markdown' style='display:none;'></div>").insertAfter($('#note_body'));
    },
    toggleEditView: function(e) {
      $(e.target).parent().addClass('active');
      $('.preview a').parent().removeClass('active');
      $('#preview').hide();
      $('#note_body').show();
      return false;
    },
    togglePreviewView: function(e) {
      $(e.target).parent().addClass('active');
      $('.edit a').parent().removeClass('active');
      $('#preview').html('Loading...');
      $('#note_body').hide();
      $('#preview').show();
      $.post('/notes/preview', {
        body: $('#note_body').val()
      }, function(data) {
        $('#preview').html(data);
        return false;
      });
      return false;
    }
  });

}).call(this);