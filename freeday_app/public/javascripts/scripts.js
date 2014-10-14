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



$('#create_link, #nav_create').on('click', function(e) {
// debugger;
  e.preventDefault();
  console.log("this button clicked");

  $("#dates").multiDatesPicker();

  // make the splash_view div hidden and the create_view div visible
  $('div.create_event_view').removeClass('noshow');
  $('div.splash_view').addClass('noshow');
  $('div.dashboard_view').addClass('noshow');

});

$('#join_link, #nav_join').on('click', function(e){
// debugger;
  e.preventDefault();
  console.log("this button clicked");

  // make the splash_view div hidden and the dashboard_view div visible
  $('div.dashboard_view').removeClass('noshow');
  $('div.splash_view').addClass('noshow');
  $('div.create_event_view').addClass('noshow');

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

function createActivityList() {
  $.ajax({
    type: "GET",
    url: "http://127.0.0.1:4567/activities",
    datatype: JSON,
    success: function(data) {
      console.log(data)
      var div = $("#activityList")
      var ul = document.createElement("ul")
      var li = document.createElement("li")
      ul.setAttribute("id", "masterActivityList")
      div.append(ul)
      for(i=0; i<data.length; i++){
        var name = document.createElement("li")
        name.innerText = data[i]["name"]
        var address = document.createElement("li")
        address.innerText = data[i]["address"]
        var description = document.createElement("li")
        description.innerText = data[i]["description"]
        var urlLi = document.createElement("li")
        var url = document.createElement("a")
        url.setAttribute("href", data[i]["url"])
        url.innerText = data[i]["url"]
        var ul = document.getElementById("masterActivityList")
        ul.appendChild(name)
        ul.appendChild(address)
        ul.appendChild(urlLi)
        urlLi.appendChild(url)

      }
    }
  })
}

$(window).load(createActivityList)
