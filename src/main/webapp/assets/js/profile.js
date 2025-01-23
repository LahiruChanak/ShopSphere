function showToast(message, type = 'success') {
    const toastContainer = document.querySelector('.toast-container');
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.innerHTML = `
            <div class="toast-header">
                <i class="bi bi-${type === 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
                <strong class="me-auto">Notification</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        `;
    toastContainer.appendChild(toast);
    const bsToast = new bootstrap.Toast(toast);
    bsToast.show();

    toast.addEventListener('hidden.bs.toast', () => {
        toast.remove();
    });
}

// Show toast for form submissions
document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', () => {
        showToast('Changes saved successfully!');
    });
});

function updateTime() {
    const currentTime = new Date();

    const options = {
        timeZone: "Asia/Colombo",
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
        hour12: false
    };
    const formatter = new Intl.DateTimeFormat("en-US", options);

    document.getElementById('current-time').textContent = formatter.format(currentTime);
}

updateTime();
setInterval(updateTime, 1000);