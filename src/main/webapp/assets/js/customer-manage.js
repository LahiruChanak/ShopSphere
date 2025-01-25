// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

document.addEventListener('DOMContentLoaded', function () {
    var confirmStatusModal = document.getElementById('confirm-status-model');
    var confirmStatusBtn = document.getElementById('confirm-status-btn');
    var statusAction = document.getElementById('statusAction');
    var customerEmail = document.getElementById('customerEmail');

    confirmStatusModal.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget; // Button that triggered the modal
        var customerId = button.getAttribute('data-customer-id'); // Get customer ID
        var name = button.getAttribute('data-customer-email'); // Get customer name
        var status = button.getAttribute('data-customer-status'); // Get current status

        // Update modal content
        customerEmail.textContent = name; // Set customer name
        statusAction.textContent = status === 'Active' ? 'deactivate' : 'activate'; // Set action text

        // Set up the confirmation button click event
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
                    // Redirect to the customer list page after status change
                    window.location.href = response.url;
                }
            }).catch(error => {
                console.error('Error:', error);
            });
        };
    });

    // Reset modal when hidden
    confirmStatusModal.addEventListener('hidden.bs.modal', function () {
        customerEmail.textContent = ''; // Clear customer email
        statusAction.textContent = ''; // Clear action text
        confirmStatusBtn.onclick = null; // Remove click event listener
    });
});