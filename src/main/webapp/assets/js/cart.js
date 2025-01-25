function updateQuantity(button, change, itemCode) {
    const quantityElement = button.parentElement.querySelector('span');
    let quantity = parseInt(quantityElement.textContent);
    quantity += change;
    if (quantity < 1) quantity = 1;
    quantityElement.textContent = quantity;

    fetch('${pageContext.request.contextPath}/updateCart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            itemCode: itemCode,
            quantity: quantity
        })
    }).then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            } else {
                alert('Failed to update quantity.');
            }
        });
}