package com.datalink.model;

import java.time.LocalDate;

/**
 * Modelo: Proyecto (almacenado en PostgreSQL).
 */
public class Proyecto {

    private int id;
    private String nombre;
    private String descripcion;
    private String cliente;
    private String estado;
    private LocalDate fechaInicio;

    public Proyecto() {}

    public Proyecto(int id, String nombre, String descripcion,
                    String cliente, String estado, LocalDate fechaInicio) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.cliente = cliente;
        this.estado = estado;
        this.fechaInicio = fechaInicio;
    }

    // ── Getters y Setters ──────────────────────────────────────────────────

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public LocalDate getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(LocalDate fechaInicio) { this.fechaInicio = fechaInicio; }
}
