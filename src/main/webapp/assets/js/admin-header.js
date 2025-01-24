// Add any necessary JavaScript functionality here
// For example, toggling dropdowns or handling cart updates
document.addEventListener("DOMContentLoaded", function () {
    // Example: Toggle profile dropdown
    const profileDropdown = document.querySelector(".dropdown");
    profileDropdown.addEventListener("click", function (e) {
        e.preventDefault();
        const dropdownMenu = this.querySelector(".dropdown-menu");
        dropdownMenu.classList.toggle("show");
    });

    // Close dropdown when clicking outside
    document.addEventListener("click", function (e) {
        if (!e.target.closest(".dropdown")) {
            const dropdowns = document.querySelectorAll(".dropdown-menu");
            dropdowns.forEach((dropdown) => dropdown.classList.remove("show"));
        }
    });
});