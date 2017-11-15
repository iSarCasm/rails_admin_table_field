$(document).ready(function() {
  // Table view ADD button hack
  var oldNestedFormEvents = window.nestedFormEvents.insertFields
  window.nestedFormEvents.insertFields = function (content, assoc, link) {
    var insertable = $(link).parent().siblings('#tab_logic').find('.js-insertable');
    if (insertable.length > 0) {
      insertable.first().append(content);
      return insertable.first().children().last();
    } else {
      return oldNestedFormEvents(content, assoc, link);
    }
  }
});
