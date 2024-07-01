// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// application.js (or any other JavaScript file included in your application)
document.addEventListener("DOMContentLoaded", function () {
    let timer;

    function resetSessionTimeout() {
        clearTimeout(timer);
        timer = setTimeout(logoutUser, 30 * 60 * 1000); // Reset the session timeout to 30 minutes of inactivity
    }

    function logoutUser() {
        // Perform any logout action, e.g., redirect the user to the logout path
        ajax({
            method: "DELETE",
            url: "/users/sign_out",
            success: () => {
                location.reload();
            }
        })
    }

    // Reset the session timeout on user activity
    document.addEventListener("mousemove", resetSessionTimeout);
    document.addEventListener("keydown", resetSessionTimeout);
});
