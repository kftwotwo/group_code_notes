
$(document).ready(function(){

  $('.button-collapse').sideNav({
        menuWidth: 300, // Default is 240
        closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
      }
    );
    $('.collapsible').collapsible();

    //snippet *Kevin*
    $('.modal-trigger').leanModal();{}
    $('select').material_select('open');
    $('.chips').material_chip({
      data: [{
          tag: 'Enter Here',
        }]
      });
});

var chip = {
    tag: 'chip content',
  };
