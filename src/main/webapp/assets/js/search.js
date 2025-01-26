// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
const tooltipList = [...tooltipTriggerList].map(
    (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl)
);

// View management
let currentView = "list";
const listView = document.getElementById("listView");
const gridView = document.getElementById("gridView");
const productContainer = document.getElementById("productContainer");

// Update active view style
function updateViewButtons() {
    listView.classList.toggle("active", currentView === "list");
    gridView.classList.toggle("active", currentView === "grid");
}

// Render products
function renderProducts(isGrid = false, filters = {}) {
    currentView = isGrid ? "grid" : "list";
    updateViewButtons();

    // Get all product items
    const productItems = document.querySelectorAll(".product-item");

    // Filter products based on selected filters
    productItems.forEach((product) => {
        const category = product.getAttribute("data-category");
        const price = parseFloat(product.getAttribute("data-price"));

        const categoryMatch = !filters.category || filters.category === "all-categories" || category === filters.category;
        const priceMatch = !filters.price || checkPriceRange(price, filters.price);

        if (categoryMatch && priceMatch) {
            product.style.display = "block";
        } else {
            product.style.display = "none";
        }
    });

    // Update container class for grid/list view
    productContainer.classList.remove("product-list", "product-grid");
    productContainer.classList.add(isGrid ? "product-grid" : "product-list");
}

// Check if price falls within the selected range
function checkPriceRange(price, range) {
    const [min, max] = range.split("-").map(Number);
    return price >= min && price <= max;
}

// Event listeners for view toggles
listView.addEventListener("click", () => renderProducts(false));
gridView.addEventListener("click", () => renderProducts(true));

// Filter handling
const categoryFilter = document.getElementById("categoryFilter");
const priceFilter = document.getElementById("priceFilter");

categoryFilter.addEventListener("change", () => {
    const filters = {
        category: categoryFilter.value,
        price: priceFilter.value,
    };
    renderProducts(currentView === "grid", filters);
});

priceFilter.addEventListener("change", () => {
    const filters = {
        category: categoryFilter.value,
        price: priceFilter.value,
    };
    renderProducts(currentView === "grid", filters);
});

// Initial render
renderProducts(false);