package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    public ProductDTO(int itemCode, String name, double unitPrice, String description, int qtyOnHand, String imageBase64) {
        this.itemCode = itemCode;
        this.name = name;
        this.unitPrice = unitPrice;
        this.description = description;
        this.qtyOnHand = qtyOnHand;
        this.image = imageBase64;
    }

    public void setImageBase64(String image) {
        this.image = image;
    }

    public Object getImageBase64() {
        return null;
    }

    public String getCategory() {
        return null;
    }
}
