$(document).on('click', '#calculate', function() {
  $('#kitchen_address').html('');
  $('#duration').html('');

  var address = $('#address').val();

  if (address === undefined || address === '') {
    alert("Please enter a valid address");
  } else {
    $.ajax({
      method: 'POST',
      url: 'dashboard/drive_time',
      data: { address: address },
      success: function(data, textStatus, jqXHR) {
        var kitchen = data.kitchen;
        if (kitchen !== undefined && kitchen !== '') {
          $('#kitchen_address').html('Kitchen address: ' + data.kitchen.address);
          $('#duration').html('Drive time: ' + data.kitchen.duration);
        }
      }
    });
  }
});
