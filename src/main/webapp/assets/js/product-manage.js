// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

// Delete Confirmation Logic
document.addEventListener('DOMContentLoaded', function () {
  const deleteButtons = document.querySelectorAll('[data-bs-target="#confirm-delete-model"]');
  deleteButtons.forEach(button => {
    button.addEventListener('click', function () {
      // Get the product ID and name from the data attributes
      const productId = this.getAttribute('data-product-id');
      const productName = this.getAttribute('data-product-name');

      // Set the product ID and name in the modal
      document.getElementById('confirm-delete-btn').setAttribute('data-product-id', productId);
      document.getElementById('deleteProductName').textContent = productName;
    });
  });

  // Handle the delete action
  document.getElementById('confirm-delete-btn').addEventListener('click', function () {
    const productId = this.getAttribute('data-product-id');
    if (productId) {
      const form = document.createElement('form');
      form.method = 'post';
      form.action = 'ProductManage';

      // Add action input
      const actionInput = document.createElement('input');
      actionInput.type = 'hidden';
      actionInput.name = 'action';
      actionInput.value = 'delete';
      form.appendChild(actionInput);

      // Add product ID input
      const idInput = document.createElement('input');
      idInput.type = 'hidden';
      idInput.name = 'itemCode';
      idInput.value = productId;
      form.appendChild(idInput);

      // Submit the form
      document.body.appendChild(form);
      form.submit();
    }
  });
});

// Preview the selected image
function previewImage(input, previewId) {
  const preview = document.getElementById(previewId);
  preview.innerHTML = ''; // Clear previous preview

  if (input.files && input.files[0]) {
    const reader = new FileReader();

    reader.onload = function (e) {
      const img = document.createElement('img');
      img.src = e.target.result;
      img.className = 'preview-image';
      preview.appendChild(img);
    };

    reader.readAsDataURL(input.files[0]); // Read the selected file
  }
}

// Attach event listeners to all file inputs for image preview
document.addEventListener('DOMContentLoaded', function () {
  const fileInputs = document.querySelectorAll('input[type="file"]');
  fileInputs.forEach(input => {
    input.addEventListener('change', function () {
      const previewId = this.getAttribute('data-preview');
      previewImage(this, previewId);
    });
  });
});

// Attach event listener to the file input in the Add Product Modal
document.addEventListener('DOMContentLoaded', function () {
  const fileInput = document.getElementById('image');
  if (fileInput) {
    fileInput.addEventListener('change', function () {
      previewImage(this, 'imagePreview');
    });
  }
});