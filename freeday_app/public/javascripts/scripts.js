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

// dropdown menus

// add id "eventDropDown" to element to make this list appear
function dropdownEvents() {
  $.ajax({
    type: "GET",
    url: "http://127.0.0.1:4567/events",
    datatype: JSON,
    success: function(data) {
      var div = $("#eventDropDown")
      var form = document.createElement("form")
      form.setAttribute("name", "eventDropdownForm")
      form.setAttribute("action", "chooseEvent")
      form.setAttribute("method", "POST")
      div.append(form)
      var select = document.createElement("select")
      select.setAttribute("id", "eventDropdownSelect")
      form.appendChild(select)      
      for(i=0; i<data.length; i++){
        var option = document.createElement("option")
        option.setAttribute("value", data[i]["id"])
        option.innerText = data[i]["name"]
        select.appendChild(option)
      }
    }
  })
}

// add id "eventDropDown" to element to make this list appear

function dropdownPeople() {
  $.ajax({
    type: "GET",
    url: "http://127.0.0.1:4567/people",
    datatype: JSON,
    success: function(data) {
      var div = $("#peopleDropDown")
      var form = document.createElement("form")
      form.setAttribute("name", "peopleDropdownForm")
      form.setAttribute("id", "peopleDropDown")
      form.setAttribute("action", "choosePerson")
      form.setAttribute("method", "POST")
      div.append(form)
      var select = document.createElement("select")
      select.setAttribute("id", "peopleDropdownSelect")
      form.appendChild(select)      
      for(i=0; i<data.length; i++){
        var option = document.createElement("option")
        option.setAttribute("value", data[i]["id"])
        option.innerText = data[i]["name"]
        select.appendChild(option)
      }
    }
  })
}
// add id datesDropDown to element to see this menu
function dropdownDates() {
  $.ajax({
    type: "GET",
    url: "http://127.0.0.1:4567/people",
    datatype: JSON,
    success: function(data) {
      var admin;
      for(i=0; i<data.length; i++){
        if (data[i]["admin"] == true) {
          admin = data[i]
        }
      }
      daysList = admin.days_avail.split(" & ")
      var div = $("#datesDropDown")
      var form = document.createElement("form")
      form.setAttribute("name", "datesDropdownForm")
      form.setAttribute("id", "datesDropdownForm")
      form.setAttribute("action", "chooseDate")
      form.setAttribute("method", "POST")
      div.append(form)
      var select = document.createElement("select")
      select.setAttribute("multiple", "true")
      select.setAttribute("id", "datesDropdownSelect")
      form.appendChild(select)      
      for(i=0; i<daysList.length; i++){
        var option = document.createElement("option")
        option.setAttribute("value", daysList[i])
        option.innerText = daysList[i]
        select.appendChild(option)
      }
    }
  })
}


$(window).load(dropdownDates)
$(window).load(dropdownPeople)
$(window).load(dropdownEvents)