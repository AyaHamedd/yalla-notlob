// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import Rails from "@rails/ujs"
import "channels"
import "controllers"

Rails.start()
ActiveStorage.start()

class Notifications {
    constructor() {
      this.handleClick = this.handleClick.bind(this);
      this.handleSuccess = this.handleSuccess.bind(this);
      this.notifications = $("[data-behavior='notifications']");
  
      if (this.notifications.length > 0) {
        this.handleSuccess(this.notifications.data("notifications"));
        $("[data-behavior='notifications-link']").on("click", this.handleClick);
        setInterval((() => {
          return this.getNewNotifications();
        }
        ), 5000);
      }
    }

    getNewNotifications() {
        return $.ajax({
          url: "/notifications.json",
          dataType: "JSON",
          method: "GET",
          success: this.handleSuccess
        });
    }

    handleClick(e) {
        return $.ajax({
          url: "/notifications/mark_as_read",
          dataType: "JSON",
          method: "POST",
          success() {
            return $("[data-behavior='unread-count']").text(0);
          }
        });
    }

    handleSuccess(data) {
        let unread_count = 0;
        $("#notify").empty();
        data.forEach(function(notification) {
            $("#notify").append(`<li class='dropdown-item' href='${notification.url}'> ${notification.actor}</li>`);
            if (notification.unread) {
                unread_count += 1;
            }});
        $("#unread-count").text(unread_count);
    }
}
	
jQuery(() => new Notifications);