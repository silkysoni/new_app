document.addEventListener('DOMContentLoaded', function() {
    const categorySelect = document.getElementById('category-select');
    const subcategorySelect = document.getElementById('sub-category-select');
  
    categorySelect.addEventListener('change', function() {
      const categoryId = this.value;
  
      if (categoryId) {
        fetch(`/sub_categories?category_id=${categoryId}`)
          .then(response => response.json())
          .then(data => {
            subcategorySelect.innerHTML = '';
            data.forEach(subcategory => {
              const option = document.createElement('option');
              option.value = subcategory.id;
              option.textContent = subcategory.subcategory_name;
              subcategorySelect.appendChild(option);
            });
          });
      } else {
        subcategorySelect.innerHTML = '';
      }
    });
  });
  