package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDTO {

    private String orderId;
    private String date;
    private int customerId;
    private String customerEmail;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private double subTotal;
    private double delivery;
    private String paymentMethod;
    private String status;

}