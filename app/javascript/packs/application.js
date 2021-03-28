// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import "channels";
import "controllers";

Rails.start();
ActiveStorage.start();

class Notifications {
  constructor() {
    this.handleSuccess = this.handleSuccess.bind(this);
    this.notifications = $("[data-behavior='notifications']");

    if (this.notifications.length > 0) {
      $("[data-behavior='notifications-link']").on("click", this.handleClick);
      this.getNewNotifications();
      setInterval(() => {
        return this.getNewNotifications();
      }, 2000);
    }
  }

  getNewNotifications() {
    $.ajax({
      url: "/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: this.handleSuccess,
    });
  }

  handleSuccess(data) {
    let count = 0;
    if (data["newNotifications"].length > 0) {
      $('#notify').children().not('.drop-footer').remove();
      data["newNotifications"].forEach(function (notification) {
        $("#notify").prepend(
          `<li class='dropdown-item'> ${notification.actor} ${notification.text} <a href='${notification.url}'>${notification.link}</a></li>`
        );
        count += 1;
      });
      this.unread_count = count;
      $("#unread-count").text(this.unread_count);
    }

    if (data["allNotifications"].length > 0){
      $('#all-notify').empty();
      data["allNotifications"].forEach(function (notification) {
        $("#all-notify").prepend(
          `<li> ${notification.actor} ${notification.text} &nbsp; <a href='${notification.url}'>${notification.link}</a></li>`
        );
      });
    }
  }
}

jQuery(function(){new Notifications();
});