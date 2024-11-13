document.addEventListener("DOMContentLoaded", function() {
    const dropdownToggle = document.getElementById('dropdown-toggle');
    const dropdownMenu = document.getElementById('category-dropdown');
  
    dropdownToggle.addEventListener('click', function(event) {
      event.stopPropagation(); 
  
      if (dropdownMenu.style.display === 'none' || dropdownMenu.style.display === '') {
        dropdownMenu.style.display = 'block';
      } else {
        dropdownMenu.style.display = 'none';
      }
    });
  
    document.addEventListener('click', function(event) {
      if (!dropdownMenu.contains(event.target) && event.target !== dropdownToggle) {
        dropdownMenu.style.display = 'none';
      }
    });
  });
  