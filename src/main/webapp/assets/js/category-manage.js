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