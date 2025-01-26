document.addEventListener('DOMContentLoaded', function () {
    // Initialize Bootstrap tooltips
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

    // Handle delete button click
    const deleteButtons = document.querySelectorAll('[data-bs-target="#confirm-delete-model"]');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function () {
            const categoryId = this.getAttribute('data-category-id');
            const categoryName = this.getAttribute('data-category-name');

            // Set the category name in the modal
            document.getElementById('deleteCategoryName').textContent = categoryName;

            // Set the category ID in the confirm button
            document.getElementById('confirm-delete-btn').setAttribute('data-category-id', categoryId);
        });
    });

    // Handle confirm delete button click
    document.getElementById('confirm-delete-btn').addEventListener('click', function () {
        const categoryId = this.getAttribute('data-category-id');
        if (categoryId) {
            // Create a form and submit it
            const form = document.createElement('form');
            form.method = 'post';
            form.action = 'CategoryManage';

            // Add hidden input for action
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);

            // Add hidden input for category ID
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = categoryId;
            form.appendChild(idInput);

            // Append the form to the body and submit it
            document.body.appendChild(form);
            form.submit();
        }
    });

    // Preview the selected image
    function previewImage(input, previewId) {
        const preview = document.getElementById(previewId);
        preview.innerHTML = '';

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function (e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'preview-image';
                preview.appendChild(img);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    // Attach event listeners to all file inputs
    const fileInputs = document.querySelectorAll('input[type="file"]');
    fileInputs.forEach(input => {
        input.addEventListener('change', function () {
            const previewId = this.getAttribute('data-preview');
            previewImage(this, previewId);
        });
    });
});