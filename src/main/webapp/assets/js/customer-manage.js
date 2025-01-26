document.addEventListener('DOMContentLoaded', function () {
    var confirmStatusModal = document.getElementById('confirm-status-model');
    var confirmStatusBtn = document.getElementById('confirm-status-btn');
    var statusAction = document.getElementById('statusAction');
    var customerEmail = document.getElementById('customerEmail');

    confirmStatusModal.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;
        var customerId = button.getAttribute('data-customer-id');
        var email = button.getAttribute('data-customer-email');
        var status = button.getAttribute('data-customer-status');

        customerEmail.textContent = email;
        statusAction.textContent = status === 'Active' ? 'deactivate' : 'activate';

        confirmStatusBtn.onclick = function () {
            // Send a POST request to the server to change the status
            fetch('CustomerManage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=changeStatus&id=' + customerId
            }).then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                }
            }).catch(error => {
                console.error('Error:', error);
            });
        };
    });

    confirmStatusModal.addEventListener('hidden.bs.modal', function () {
        customerEmail.textContent = '';
        statusAction.textContent = '';
        confirmStatusBtn.onclick = null;
    });
});