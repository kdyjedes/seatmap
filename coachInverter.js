module.exports = function($) {

  // reverse all coach children
  var length = $('.coach').children().length-2; // let the last become the first
  for (var i = length; i >= 0; i--) {
    var child = $('.coach').children().eq(i).remove();
    $('.coach').append(child);
  }

  var last = $('.coach').children().last();
  // clearfix needs to be at the end
  var clearfix = $('.clearfix').remove();
  $('.coach').append(clearfix);
  // but entrance should still be the last one
  if (last.hasClass('entrance')) {
    last.remove();
    $('.coach').append(last);
  }

  // reverse all series' children
  $('.series').each(function(index, series) {
    var childrenLength = $(series).children().length-2; // let the last become the first
    for (var i = childrenLength; i >= 0; i--) {
      var child = $(series).children().eq(i).remove();
      $(series).append(child);
    }
  });

  // reverse all items in a wrapper
  $('.wrapper').each(function(index, wrapper) {
    var childrenLength = $(wrapper).children().length-2; // let the last become the first
    for (var i = childrenLength; i >= 0; i--) {
      var child = $(wrapper).children().eq(i).remove();
      $(wrapper).append(child);
    }
  });

  // switch classes l<->r, t<->b, left<->right for .empty and .wrapper
  $('.empty,.wrapper').each(function(i, empty) {
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
    if (empty.hasClass('left')) {
      empty.removeClass('left');
      empty.addClass('right');
    } else if (empty.hasClass('right')) {
      empty.removeClass('right');
      empty.addClass('left');
    }
  });

  // switch back<->*empty* class for seats
  $('.seat').each(function(i, seat) {
    seat = $(seat);
    if (seat.hasClass('back')) {
      seat.removeClass('back');
    } else {
      seat.addClass('back');
    }
  });

  // switch top<->bottom class for entrance
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