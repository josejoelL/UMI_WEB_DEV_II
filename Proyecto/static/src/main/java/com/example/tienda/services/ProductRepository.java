package com.example.tienda.services;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<com.example.tienda.models.Product, Integer> {
}