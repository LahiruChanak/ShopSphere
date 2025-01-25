package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDetailDTO {

    private int itemCode;
    private int quantity;
    private ProductDTO product;

    public Object getOrderedSize() {
        return null;
    }

    public Object getColor() {
        return null;
    }
}