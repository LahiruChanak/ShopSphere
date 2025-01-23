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
    private byte[] image;

    public void setImageBase64(String s) {
        this.image = Base64.getDecoder().decode(s);
    }

    public byte[] getImageBase64() {
        return null;
    }
}
