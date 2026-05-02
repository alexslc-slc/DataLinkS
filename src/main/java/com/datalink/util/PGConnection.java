package com.datalink.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class PGConnection {

    private static final String URL =
            "jdbc:postgresql://localhost:5432/datalink_pg";
    private static final String USER = "postgres";  
    private static final String PASS = "admin";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("Driver PostgreSQL no encontrado: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}