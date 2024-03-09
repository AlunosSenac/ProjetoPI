document.addEventListener('DOMContentLoaded', function() {
    const toggleFormBtn = document.querySelector('.toggle-form-btn');
    const galleryForm = document.querySelector('.gallery-form');

    toggleFormBtn.addEventListener('click', function() {
        galleryForm.style.display = (galleryForm.style.display === 'none') ? 'block' : 'none';
    });
});

function showMenu() {
    var menu = document.getElementById("menuContent");
    if (menu.style.display === "block") {
      menu.style.display = "none";
    } else {
      menu.style.display = "block";
    }
  }
  