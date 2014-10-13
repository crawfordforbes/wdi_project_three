// Splash page navigation rollover
   function createMouseRollover(createIcon) {
      createIcon.src = "./images/create_icon_gray.png";
    }
    
    function createMouseOut(createIconHover) {
      createIconHover.src = "./images/create_icon.png";
    }
    
   	function joinMouseRollover(joinIcon) {
      joinIcon.src = "./images/join_icon_gray.png";
    }
    
    function joinMouseOut(joinIconHover) {
      joinIconHover.src = "./images/join_icon.png";
    }


$(function(){

// all this is for the calendar

    $("#dates").multiDatesPicker({
      onClose: function(datesString){
        sendWindowDates(datesString);
        /* TO WHOMSOEVER WRITES THE AJAX CALLS: 
        I think what we actually
        want to do here is, onClose, 
        set the value of this input#dates element
        to the value of dateString.
        When the submit button is pressed, 
        we will require a function that implements the following:  
        1) break the dateString into X different 
        dateStrings (dateStrings are seperated by the substring ", "), 
        2) send off X different AJAX requests 
        3) to create X window objs on the server, which are then saved 
        to the db, associated w/ the Event in Question. */ 
        

      }
    });


$('#create_link').on('click', function(e){
// debugger;
  e.preventDefault();
  console.log("this button clicked");
})


 });
// end of onLoad




function sendWindowDates(datesStr, eventId) {
  var eventId = 1;
  var dates = datesStr.split(", ");
  $.each(dates, function(idx, dateStr) {
    var theWindowJSON = {
      event_id: eventId,
      day: dateStr
    };
    $.post(
      "/windows",
      theWindowJSON,
      function(response) {
        console.log(response);
      }); 
  });
}

