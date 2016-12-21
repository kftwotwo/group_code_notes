
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

      });


});

var chip = {
    tag: 'chip content',
  };


//
// // Materialize.toast(message, displayLength, className, completeCallback);
//   Materialize.toast('Updated', 4000) // 4000 is the duration of the toast
