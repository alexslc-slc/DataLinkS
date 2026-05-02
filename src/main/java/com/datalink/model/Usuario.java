package com.datalink.model;

import java.time.LocalDateTime;

/**
 * Modelo: Usuario (almacenado en MySQL).
 */
public class Usuario {

    private int id;
    private String nombre;
    private String apellido;
    private String email;
    private String username;
    private LocalDateTime fechaRegistro;

    public Usuario() {}

    public Usuario(int id, String nombre, String apellido,
                   String email, String username, LocalDateTime fechaRegistro) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.username = username;
        this.fechaRegistro = fechaRegistro;
    }

    // ── Getters y Setters ──────────────────────────────────────────────────

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public LocalDateTime getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    /** Nombre completo para mostrar en vistas. */
    public String getNombreCompleto() {
        return nombre + " " + apellido;
    }

    /** Fecha formateada para mostrar en vistas (dd/MM/yyyy HH:mm). */
    public String getFechaStr() {
        if (fechaRegistro == null) return "";
        return String.format("%02d/%02d/%04d %02d:%02d",
                fechaRegistro.getDayOfMonth(),
                fechaRegistro.getMonthValue(),
                fechaRegistro.getYear(),
                fechaRegistro.getHour(),
                fechaRegistro.getMinute());
    }
}
