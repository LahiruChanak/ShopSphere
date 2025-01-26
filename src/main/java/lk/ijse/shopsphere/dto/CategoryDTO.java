package lk.ijse.shopsphere.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CategoryDTO {

    private String id;
    private String name;
    private String description;
    private String status;
    private String icon;

    public CategoryDTO(int id, String name, String description, String status, String icon) {
        this.id = String.valueOf(id);
        this.name = name;
        this.description = description;
        this.status = status;
        this.icon = icon;
    }
}
