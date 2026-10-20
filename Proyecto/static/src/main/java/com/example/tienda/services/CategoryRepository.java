package com.example.tienda.services;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository< com.example.tienda.models.Category, Integer> {
}