package com.example.tienda.models;
import jakarta.validation.constraints.Size;

public class CategoryDto {
    @Size (min = 10, message = "La descripción no puede ser menor a 10 caracteres")


    @Size (max = 255, message = "La descripción no puede tener más de 255 caracteres")
    private String description;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}