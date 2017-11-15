// Write your JavaScript code.

/*
    function which hides the sign out button if the user is not logged in
*/
$(document).ready(function () {

    if (document.cookie.indexOf('user_logged_in') < 0)
        $('#SignOut').css("visibility", "hidden");

    /*if (document.cookie.indexOf('user_logged_in') >= 0) {
        var now = new Date();
        now.setTime(now.getTime() + 1 * 60 * 1000);
        document.cookie = "user_logged_in=NOK; expires=" + now.toUTCString() + "; path=/";
    }*/
});

/* 
    This function is used to filter devices shown on the home page in real time.
    The filtering is done based by the device's name
*/
function FilterResults() {
    var i, td;
    var input = document.getElementById("search_input");
    var table = document.getElementById("device_table");
    var filter = input.value.toUpperCase();
    var tr = table.getElementsByTagName("tr");

    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[1];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }

}
