function updateQuantity(button, change) {
    const qtyElement = button.parentElement.querySelector("span");
    let qty = parseInt(qtyElement.innerText);
    qty = Math.max(0, qty + change);
    qtyElement.innerText = qty.toString().padStart(2, "0");
}