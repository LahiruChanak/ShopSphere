// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

document.addEventListener('DOMContentLoaded', function () {
    const deleteButtons = document.querySelectorAll('[data-bs-target="#confirm-delete-model"]');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function () {
            const categoryId = this.getAttribute('data-category-id');
            document.getElementById('confirm-delete-btn').setAttribute('data-category-id', categoryId);
        });
    });

    document.getElementById('confirm-delete-btn').addEventListener('click', function () {
        const categoryId = this.getAttribute('data-category-id');
        if (categoryId) {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = 'CategoryManage';

            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);

            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = categoryId;
            form.appendChild(idInput);

            document.body.appendChild(form);
            form.submit();
        }
    });
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
document.addEventListener('DOMContentLoaded', function () {
    const fileInputs = document.querySelectorAll('input[type="file"]');
    fileInputs.forEach(input => {
        input.addEventListener('change', function () {
            const previewId = this.getAttribute('data-preview');
            previewImage(this, previewId);
        });
    });
});

// view category name in delete modal
document.addEventListener('DOMContentLoaded', function () {
    const deleteButtons = document.querySelectorAll('[data-bs-target="#confirm-delete-model"]');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function () {
            const categoryName = this.getAttribute('data-category-name');
            document.getElementById('deleteCategoryName').textContent = categoryName;
        });
    });
});

// Attach event listener to the file input
document.addEventListener('DOMContentLoaded', function () {
    const fileInput = document.getElementById('icon');
    if (fileInput) {
        fileInput.addEventListener('change', function () {
            previewImage(this, 'imagePreview');
        });
    }
});