package com.example.tienda.models;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;

public class ProductDto {
    @Size(min = 10, message = "La descripción no puede ser menor a 10 caracteres")
    @Size(max = 255, message = "La descripción no puede tener más de 255 caracteres")
    private String description;

    @Min(0)
    private double price;

    @Min(0)
    private int amount;


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    private int category;

    private int mark;   

    private String imageFileName;


}
