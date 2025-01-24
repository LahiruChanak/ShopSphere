package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductDTO {

    private int itemCode;
    private String name;
    private double unitPrice;
    private String description;
    private int qtyOnHand;
    private String image;
    private int categoryId;

}
