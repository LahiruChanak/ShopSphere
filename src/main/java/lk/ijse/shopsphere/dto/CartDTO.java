package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CartDTO {

    private int cartId;
    private String customerId;
    private List<CartDetailDTO> cartDetails;
    private double subTotal;
    private double deliveryCharges;
    private double total;

}