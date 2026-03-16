// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  const toggle = document.getElementById("nav-toggle");
  const menu = document.getElementById("nav-menu");

  if (toggle) {
    toggle.addEventListener("click", () => {
      menu.classList.toggle("active");
    });
  }
});