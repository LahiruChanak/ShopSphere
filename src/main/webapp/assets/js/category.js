// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

document.getElementById('icon').addEventListener('change', function (e) {
    const preview = document.getElementById('imagePreview');
    preview.innerHTML = '';
    const file = e.target.files[0];
    if (file) {
        const img = document.createElement('img');
        img.src = URL.createObjectURL(file);
        img.className = 'preview-image';
        preview.appendChild(img);
    }
});

function prepareUpdateModal(id, name, description, status, icon) {
    document.getElementById('updateCategoryId').textContent = id;
    document.getElementById('updateCategoryName').value = name;
    document.getElementById('updateDescription').value = description;
    document.getElementById('updateStatus').value = status;

    const preview = document.getElementById('updateImagePreview');
    preview.innerHTML = '';

    if (icon) {
        const img = document.createElement('img');
        img.src = `data:image/png;base64,${icon}`; // Set image source with base64 data
        img.className = 'preview-image';
        preview.appendChild(img);
    }
}
