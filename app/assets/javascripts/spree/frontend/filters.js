$(document).ready(function() {
  if ($('#slider-range').length > 0) {
    var collection_min_price = parseInt($( '#range_limits' ).data('collection-min-price'));
    var collection_max_price = parseInt($( '#range_limits' ).data('collection-max-price'));
    var min_range = parseInt($( '#range_limits' ).data('min-range'));
    var max_range = parseInt($( '#range_limits' ).data('max-range'));
    var currency  = $('#amount').data('currency');

    var slider = $('#slider-range').slider({
      range: true,
      min: collection_min_price,
      max: collection_max_price,
      values: [min_range, max_range],
      slide: function(event, ui) {
        $('#amount').val(currency + ' ' + ui.values[0] + ' - '+ currency + ' ' + ui.values[1]);
      },
      stop: function(_, ui) {
        $('#min_price_range').val(ui.values[0]);
        $('#max_price_range').val(ui.values[1]);
      }
    });

    $('#amount').val(currency + ' ' + $('#slider-range' ).slider('values', 0) +
      ' - ' + currency + ' ' + $('#slider-range').slider('values', 1));
  }
});
