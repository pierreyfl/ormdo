//= require jquery
//= require jquery_ujs
//= require bootstrap-material-design
//= require selectize
//= require_tree .

var regions = [];

$(document).ready(function() {

  $('.tags').selectize({
      plugins: ['remove_button'],
      delimiter: ',',
      persist: false,
      create: function(input) {
          return {
              value: input,
              text: input
          }
      }
  });

    $('.selectize').selectize({
        plugins: ['remove_button'],
        delimiter: ',',
        persist: false,
        create: false
    });


    $.getJSON('/regions.json').then(function(data, response, event){
        regions = data
    });

    function findRegionById(id)
    {
        var results = $.grep(regions, function(item){ return item.id == id });
        if(results.length > 0)
        {
            return results[0];
        }
        else
        {
            return false;
        }
    }

    $(document).on('change', '#contact_region_id', function(){
        var region_id   = $(this).val();
        var region      = findRegionById(region_id);

        $('[name*=area]').each(function(index, element){
            var $el = $(element);

            $el.val( region.ddd  );
        });
    });



});
