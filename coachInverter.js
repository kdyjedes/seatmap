module.exports = function($) {

  // 1) reverse all coach children
  var length = $('.coach').children().length-2;
  for (var i = length; i >= 0; i--) {
    var child = $('.coach').children().eq(i).remove();
    $('.coach').append(child);
  }

  // 2) clearfix needs to be the last item
  var clearfix = $('.clearfix').remove();
  $('.coach').append(clearfix);

  // 3) reverse all series' children
  $('.series').each(function(index, series) {
    var childrenLength = $(series).children().length-2;
    for (var i = childrenLength; i >= 0; i--) {
      var child = $(series).children().eq(i).remove();
      $(series).append(child);
    }
  });

  // 4) switch classes l<->r, t<->b for .empty
  $('.empty').each(function(i, empty) {
    empty = $(empty);
    if (empty.hasClass('l')) {
      empty.removeClass('l');
      empty.addClass('r');
    } else if (empty.hasClass('r')) {
      empty.removeClass('r');
      empty.addClass('l');
    }
    if (empty.hasClass('t')) {
      empty.removeClass('t');
      empty.addClass('b');
    } else if (empty.hasClass('b')) {
      empty.removeClass('b');
      empty.addClass('t');
    }
  });

  // 5) switch back<->*empty* class for seats
  $('.seat').each(function(i, seat) {
    seat = $(seat);
    if (seat.hasClass('back')) {
      seat.removeClass('back');
    } else {
      seat.addClass('back');
    }
  });

  // 6) switch top<->bottom class for entrance
  $('.entrance').each(function(i, entrance) {
    entrance = $(entrance);
    if (entrance.hasClass('top')) {
      entrance.removeClass('top');
      entrance.addClass('bottom');
    } else if (entrance.hasClass('bottom')) {
      entrance.removeClass('bottom');
      entrance.addClass('top');
    }
  });

}