/*
 *  Function which hides the sign out button if the user is not logged in
 *  
*/
$(document).ready(function () {

    if (document.cookie.indexOf('user_logged_in') < 0)
        $('#SignOut').css("visibility", "hidden");

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

/*
 *  This method makes checks does a live check of the username from the input via an ajax call. 
 */

function CheckUserAvailability() {

    var username = $("#username").val();

    jQuery.ajax({

        url: '/dms/CheckUser?username='+username,

        type: "POST",

        dataType: "json",

        data: "{}",

        contentType: "application/json; charset=utf-8",

        success: function (data) {

            if (data == true)
                $("#userTaken").show(0, RegBtnDisabled);
            else
                $("#userTaken").hide(0, RegBtnEnabled);

        }

    });
}

function RegBtnDisabled() {
    $("#RegisterButton").prop("disabled", true);
}

function RegBtnEnabled() {
    $("#RegisterButton").prop("disabled", false);
}



