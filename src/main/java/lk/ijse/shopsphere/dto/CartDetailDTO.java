package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDetailDTO {

    private int cartDetailId;
    private int cartId;
    private int itemCode;
    private int quantity;
    private String orderedSize;
    private String color;
    private ProductDTO product;

}