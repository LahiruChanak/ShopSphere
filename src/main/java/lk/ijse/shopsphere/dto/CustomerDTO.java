package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

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
    private byte[] image;

}
