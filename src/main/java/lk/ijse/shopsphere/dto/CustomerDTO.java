package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Base64;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CustomerDTO {

    private int id;
    private String name;
    private String email;
    private String password;
    private String address;
    private String phoneNumber;
    private Timestamp registeredDate;
    private String image;
    private String status;

    public CustomerDTO(int id, String name, String email, String address, String phoneNumber, String registeredDate, String imageBase64, String status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.registeredDate = Timestamp.valueOf(registeredDate);
        this.image = imageBase64;
        this.status = status;
    }
}
