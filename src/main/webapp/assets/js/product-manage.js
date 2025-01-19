// Bootstrap tooltip initialization
const tooltipTriggerList = document.querySelectorAll(
  '[data-bs-toggle="tooltip"]'
);
const tooltipList = [...tooltipTriggerList].map(
  (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl)
);

// Sample product data loading with Ajax
// async function fetchProducts(filters = {}) {
//   try {
//     const response = await $.ajax({
//       url: "/api/products", // Replace with your actual API endpoint
//       method: "GET",
//       data: filters,
//     });
//     return response.data; // Adjust based on the API's response structure
//   } catch (error) {
//     console.error("Failed to fetch products:", error);
//     return [];
//   }
// }

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

async function renderProducts(isGrid = false, filters = {}) {
  currentView = isGrid ? "grid" : "list";
  updateViewButtons();

  // Add loading state
  $("#productContainer").html('<div class="text-center py-5">Loading...</div>');

  // Get products data with filters
  const products = await fetchProducts(filters);

  // Update container class
  $("#productContainer")
    .removeClass("product-list product-grid")
    .addClass(isGrid ? "product-grid" : "product-list");

  if (isGrid) {
    // Render products for grid view
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
            <div class="mt-3">
              <div class="d-flex justify-content-between mb-2">
                <div>Price: $${product.price}</div>
                <div>Products: ${product.products}</div>
              </div>
              <div class="d-flex justify-content-between mb-2">
                <div>Views: ${product.views}</div>
                <div>
                  <span class="status-dot ${getStatusDotColor(product.status)}">
                  </span>
                  ${product.status}
                </div>
              </div>
              <div class="d-flex justify-content-between">
                <button id="editProductButton" class="btn border-0 text-warning">
                    <i class="hgi-stroke hgi-pencil-edit-02 fs-5"></i></button>

                <button id="deleteProductButton" class="btn border-0 text-danger">
                    <i class="hgi-stroke hgi-delete-02 fs-5"></i></button>
              </div>
            </div>
          </div>
        `;
    });

    $("#productContainer").html(productElements.join(""));
  } else {
    // Render products for table view
    const tableHeader = `
        <table class="table table-borderless">
          <thead>
            <tr>
              <th>Image</th>
              <th>Name</th>
              <th>SKU</th>
              <th>Price</th>
              <th>Products</th>
              <th>Views</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
      `;

    const tableRows = products
      .map((product) => {
        return `
            <tr>
              <td>
                <img src="${product.image}" alt="${
          product.name
        }" class="table-product-image">
              </td>
              <td>${product.name}</td>
              <td>${product.sku}</td>
              <td>$${product.price}</td>
              <td>${product.products}</td>
              <td>${product.views}</td>
              <td>
                <span class="status-dot ${getStatusDotColor(product.status)}">
                </span>
                ${product.status}
              </td>
              <td>
                <button id="editProductButton" class="btn border-0 text-warning">
                    <i class="hgi-stroke hgi-pencil-edit-02 fs-5"></i></button>

                <button id="deleteProductButton" class="btn border-0 text-danger">
                    <i class="hgi-stroke hgi-delete-02 fs-5"></i></button>
              </td>
            </tr>
          `;
      })
      .join("");

    const tableFooter = `
          </tbody>
        </table>
      `;

    $("#productContainer").html(tableHeader + tableRows + tableFooter);
  }
}

// Event listeners
listView.addEventListener("click", () => renderProducts(false));
gridView.addEventListener("click", () => renderProducts(true));

// Initialize
renderProducts(false);

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

    // Reload products with new filters
    await renderProducts(currentView === "grid", activeFilters);
  });
});

// Stock status dot color
function getStatusDotColor(status) {
  switch (status.toLowerCase()) {
    case "available":
      return "bg-success"; // stocked
    case "out of stock":
      return "bg-danger"; // out of stock
    case "pending":
      return "bg-warning"; // pending
    default:
      return "bg-secondary"; // unknown
  }
}

// Add Modal functionality
$("#addProductButton").on("click", function () {
  $("#addProductModal").modal("show");
});

$("#addProductForm").on("submit", function (e) {
  e.preventDefault();

  const formData = {
    name: $("#productName").val(),
    sku: $("#productSku").val(),
    price: parseFloat($("#productPrice").val()),
    products: parseInt($("#productQuantity").val(), 10),
    views: parseInt($("#productViews").val(), 10),
    status: $("#productStatus").val(),
    image: $("#productImage").val(),
  };

  // Simulate Ajax Request to Add Product
  $.ajax({
    url: "/api/add-product", // Replace with your API endpoint
    type: "POST",
    data: JSON.stringify(formData),
    contentType: "application/json",
    success: function (response) {
      alert("Product added successfully!");
      $("#addProductModal").modal("hide");
      // Optionally, reload products
      renderProducts(false);
    },
    error: function () {
      alert("Error adding product. Please try again.");
    },
  });
});

// Update Modal functionality
$(document).on("click", "#editProductButton", function () {
  const productRow = $(this).closest("tr");
  const productData = {
    name: productRow.find("td:nth-child(2)").text(),
    sku: productRow.find("td:nth-child(3)").text(),
    price: parseFloat(
      productRow.find("td:nth-child(4)").text().replace("$", "")
    ),
    products: parseInt(productRow.find("td:nth-child(5)").text(), 10),
    views: parseInt(productRow.find("td:nth-child(6)").text(), 10),
    status: productRow.find("td:nth-child(7)").text().trim(),
    image: productRow.find("img").attr("src"),
  };

  // Pre-fill modal fields
  $("#updateProductName").val(productData.name);
  $("#updateProductSku").val(productData.sku);
  $("#updateProductPrice").val(productData.price);
  $("#updateProductQuantity").val(productData.products);
  $("#updateProductViews").val(productData.views);
  $("#updateProductStatus").val(productData.status.toLowerCase());
  $("#updateProductImage").val(productData.image);

  // Show modal
  $("#updateProductModal").modal("show");
});

// Handle Update Product Form Submission
$("#updateProductForm").on("submit", function (e) {
  e.preventDefault();

  const formData = {
    name: $("#updateProductName").val(),
    sku: $("#updateProductSku").val(),
    price: parseFloat($("#updateProductPrice").val()),
    products: parseInt($("#updateProductQuantity").val(), 10),
    views: parseInt($("#updateProductViews").val(), 10),
    status: $("#updateProductStatus").val(),
    image: $("#updateProductImage").val(),
  };

  // Simulate Ajax Request to Update Product
  $.ajax({
    url: "/api/update-product", // Replace with your API endpoint
    type: "PUT",
    data: JSON.stringify(formData),
    contentType: "application/json",
    success: function (response) {
      alert("Product updated successfully!");
      $("#updateProductModal").modal("hide");
      // Optionally, reload products
      renderProducts(false);
    },
    error: function () {
      alert("Error updating product. Please try again.");
    },
  });
});

// Delete Modal functionality
let deleteProductId = null;

// Open Delete Confirmation Modal
$(document).on("click", "#deleteProductButton", function () {
  const studentId = $(this).data("id"); // Get student ID from data attribute
  deleteProductId = studentId; // Store it for deletion
  $("#student_id").text(studentId); // Update modal with student ID
  $("#deleteModal").modal("show"); // Show the modal
});

// Handle Confirm Delete Action
$("#confirm-delete-btn").on("click", function () {
  if (deleteProductId) {
    // Simulate Ajax Request to Delete Student
    $.ajax({
      url: `/api/delete-student/${deleteProductId}`, // Replace with your API endpoint
      type: "DELETE",
      success: function (response) {
        alert(`Student ID ${deleteProductId} deleted successfully!`);
        $("#deleteModal").modal("hide"); // Hide the modal
        deleteProductId = null; // Reset the ID variable

        // Optionally, reload or remove the student row from the table
        $(`tr[data-id="${deleteProductId}"]`).remove();
      },
      error: function () {
        alert("Error deleting student. Please try again.");
      },
    });
  }
});

/////////////////////////// Sample data /////////////////////////////////////

// delete this and uncommit upper function
async function fetchProducts(filters = {}) {
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
