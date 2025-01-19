// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll(
    '[data-bs-toggle="tooltip"]'
);
const tooltipList = [...tooltipTriggerList].map(
    (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl)
);

// Sample product data fetching
async function fetchProducts(filters = {}) {

    // delete this sample data after testing
    const sampleProducts = [
        {
            name: "Gabriela Cashmere Blazer",
            sku: "GC12345",
            price: 199.99,
            products: 100,
            views: 2300,
            status: "Available",
            image: "https://i.postimg.cc/3RQ5zzHt/14981.jpg",
        },
        {
            name: "Loewe Blend Jacket - Blue",
            sku: "LB98765",
            price: 349.99,
            products: 50,
            views: 1200,
            status: "Available",
            image: "https://i.postimg.cc/P5ckQPVs/14982.jpg",
        },
        {
            name: "Vintage Leather Satchel",
            sku: "VLS54321",
            price: 149.49,
            products: 30,
            views: 3000,
            status: "Out of stock",
            image: "https://i.postimg.cc/qRcVrQJ4/14983.jpg",
        },
        {
            name: "Classic White Sneakers",
            sku: "CWS11223",
            price: 89.99,
            products: 200,
            views: 5000,
            status: "Available",
            image: "https://i.postimg.cc/QMTZ4hvB/14984.jpg",
        },
        {
            name: "Silk Blend Scarf",
            sku: "SBS33445",
            price: 49.99,
            products: 300,
            views: 2100,
            status: "Pending",
            image: "https://via.placeholder.com/150/8E44AD/FFFFFF?text=Product+5",
        },
        {
            name: "Modern Stainless Watch",
            sku: "MSW99876",
            price: 129.99,
            products: 80,
            views: 12000,
            status: "Out of stock",
            image: "https://via.placeholder.com/150/1ABC9C/FFFFFF?text=Product+6",
        },
        {
            name: "Denim Jacket - Unisex",
            sku: "DJ55567",
            price: 179.49,
            products: 150,
            views: 4500,
            status: "Available",
            image: "https://via.placeholder.com/150/E74C3C/FFFFFF?text=Product+7",
        },
        {
            name: "Premium Sunglasses",
            sku: "PS99234",
            price: 249.99,
            products: 25,
            views: 600,
            status: "Unknown",
            image: "https://via.placeholder.com/150/34495E/FFFFFF?text=Product+8",
        },
    ];

    // Simulate filtering logic
    return sampleProducts.filter((product) => {
        return Object.entries(filters).every(([key, value]) => {
            if (!value) return true;
            return product[key]
                ?.toString()
                .toLowerCase()
                .includes(value.toLowerCase());
        });
    });
}

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
async function renderProducts(isGrid = false, filters = {}) {
    currentView = isGrid ? "grid" : "list";
    updateViewButtons();

    // Add loading state
    $("#productContainer").html('<div class="text-center py-5">Loading...</div>');

    const products = await fetchProducts(filters);

    // Update container class
    $("#productContainer")
        .removeClass("product-list product-grid")
        .addClass(isGrid ? "product-grid" : "product-list");

    if (isGrid) {
        // Grid view rendering
        const productElements = products.map((product) => {
            return `
          <div class="product-item d-flex justify-content-between w-100 card p-3">
            <div class="d-flex align-items-center w-100 gap-3">
              <img src="${product.image}" alt="${
                product.name
            }" class="product-image">
              <div>
                <h6 class="mb-1">${product.name}</h6>
                <small class="text-muted">SKU: ${product.sku}</small>
              </div>
            </div>
            <div class="mt-3">Price: $${product.price.toFixed(2)}</div>
          </div>
        `;
        });
        $("#productContainer").html(productElements.join(""));
    } else {
        // List view rendering
        const tableHeader = `
        <table class="table table-borderless">
          <thead>
            <tr>
              <th>Image</th>
              <th>Name</th>
              <th>SKU</th>
              <th>Price</th>
            </tr>
          </thead>
          <tbody>
      `;
        const tableRows = products
            .map((product) => {
                return `
            <tr>
              <td><img src="${product.image}" alt="${
                    product.name
                }" class="table-product-image"></td>
              <td>${product.name}</td>
              <td>${product.sku}</td>
              <td>$${product.price.toFixed(2)}</td>
            </tr>
          `;
            }).join("");
        const tableFooter = `</tbody></table>`;

        $("#productContainer").html(tableHeader + tableRows + tableFooter);
    }
}

// Event listeners for view toggles
listView.addEventListener("click", () => renderProducts(false));
gridView.addEventListener("click", () => renderProducts(true));

// Filter handling
const filters = document.querySelectorAll('select[id$="Filter"]');
filters.forEach((filter) => {
    filter.addEventListener("change", async () => {
        const activeFilters = Array.from(filters).reduce((acc, filterEl) => {
            if (filterEl.value) {
                acc[filterEl.name] = filterEl.value; // Adjust based on your API's filter parameters
            }
            return acc;
        }, {});
        await renderProducts(currentView === "grid", activeFilters);
    });
});

renderProducts(false);

