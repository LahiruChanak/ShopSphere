// Thumbnail click handler
document.querySelectorAll(".thumbnail").forEach((thumb) => {
    thumb.addEventListener("click", function () {
        document
            .querySelectorAll(".thumbnail")
            .forEach((t) => t.classList.remove("active"));
        this.classList.add("active");
        document.querySelector(".product-img").src = this.src;
    });
});

// Color option click handler
document.querySelectorAll(".color-option").forEach((option) => {
    option.addEventListener("click", function () {
        document
            .querySelectorAll(".color-option")
            .forEach((o) => o.classList.remove("active"));
        this.classList.add("active");
    });
});

// size button click handler
document.querySelectorAll(".size-btn").forEach((btn) => {
    btn.addEventListener("click", function () {
        document
            .querySelectorAll(".size-btn")
            .forEach((b) => b.classList.remove("active"));
        this.classList.add("active");
    });
});

// Specs tab click handler
document.querySelectorAll(".specs-tab").forEach((tab) => {
    tab.addEventListener("click", function () {
        document
            .querySelectorAll(".specs-tab")
            .forEach((t) => t.classList.remove("active"));
        this.classList.add("active");
    });
});

function updateQuantity(button, change) {
    const qtyElement = button.parentElement.querySelector("span");
    let qty = parseInt(qtyElement.innerText);
    qty = Math.max(0, qty + change);
    qtyElement.innerText = qty.toString().padStart(2, "0");
}

document.querySelectorAll(".specs-tab").forEach((tab) => {
    tab.addEventListener("click", function () {
        // Remove active class from all tabs
        document.querySelectorAll(".specs-tab").forEach((t) => {
            t.classList.remove("active");
        });

        // Add active class to clicked tab
        this.classList.add("active");

        // Hide all tab contents
        document.querySelectorAll(".tab-content").forEach((content) => {
            content.classList.remove("active");
        });

        // Show selected tab content
        const tabId = this.getAttribute("data-tab");
        document.getElementById(tabId).classList.add("active");
    });
});