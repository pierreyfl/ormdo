var $visitTypeSelect;
var $viewTypeSelect;

$(document).ready(function() {
  $visitTypeSelect = $('.ads #ad_visit_type');
  $viewTypeSelect = $('.ads #ad_view_type');

  var visitTypeValue = $visitTypeSelect.val();
  var viewTypeValue = $viewTypeSelect.val();

  toggleFieldsForSelectIDAndValue('ad_visit_type', visitTypeValue);
  toggleFieldsForSelectIDAndValue('ad_view_type', viewTypeValue);

  $('.ads #ad_view_type').change(function() {
    selectChanged(this);
  });

  $('.ads #ad_visit_type').change(function() {
    selectChanged(this);
  });
});

function selectChanged(select) {
  var selectID = select.id;
  var selectedValue = $(select).val();
  console.log(selectID + ' changed to ' + selectedValue);

  toggleFieldsForSelectIDAndValue(selectID, selectedValue);
};

function toggleFieldsForSelectIDAndValue(selectID, selectedValue) {
  var $photoContainer = $('.ad_view_type.photo');
  var $externalLinkContainer = $('.ad_visit_type.external_link');
  var $contactContainer = $('.ad_visit_type.contact');

  if (selectID === 'ad_view_type') {
    if (selectedValue === 'photo') {
      $photoContainer.show();

      visitTypeValue = $visitTypeSelect.val();
      if (visitTypeValue !== 'contact') {
        $contactContainer.hide();
      }

    } else if (selectedValue === 'sponsorship') {
      $photoContainer.hide();
      $contactContainer.show();
    }
  } else if (selectID === 'ad_visit_type') {
    if (selectedValue === 'contact') {
      $contactContainer.show();
      $externalLinkContainer.hide();
    } else if (selectedValue === 'external_link') {
      $externalLinkContainer.show();

      viewTypeValue = $viewTypeSelect.val();
      if (viewTypeValue !== 'sponsorship') {
        $contactContainer.hide();
      }
    }
  }
};