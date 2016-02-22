// Generated by CoffeeScript 1.10.0
(function() {
  window.PageView = Backbone.View.extend({
    el: "body",
    events: {
      "click .editor-toolbar .edit a": "toggleEditView",
      "click .editor-toolbar .preview a": "togglePreviewView"
    },
    initialize: function(opts) {
      this.parentView = opts.parentView;
      return $("<div id='preview' class='markdown form-control'></div>").insertAfter($('#page_body'));
    },
    toggleEditView: function(e) {
      $(e.target).parent().addClass('active');
      $('.preview a').parent().removeClass('active');
      $('#preview').hide();
      $('#page_body').show();
      return false;
    },
    togglePreviewView: function(e) {
      $(e.target).parent().addClass('active');
      $('.edit a').parent().removeClass('active');
      $('#preview').html('Loading...');
      $('#page_body').hide();
      $('#preview').show();
      $.post('/wiki/preview', {
        body: $('#page_body').val()
      }, function(data) {
        $('#preview').html(data);
        return false;
      });
      return false;
    }
  });

}).call(this);