$(function(){

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

    $("#from").datepicker({
      defaultDate: "+1w", 
      changeMonth: true, 
      numberOfMonths: 3,
      onClose: function(selectedDate) {
        $("#to").datepicker("option", "minDate", selectedDate);
      }
    });
    $("#to").datepicker({
      defaultDate: "+1w", 
      changeMonth: true,
      numberOfMonths: 3,
      onClose: function(selecteDate) {
        $("#from").datepicker("option", "maxDate", selectedDate);
      }
    });
 });
