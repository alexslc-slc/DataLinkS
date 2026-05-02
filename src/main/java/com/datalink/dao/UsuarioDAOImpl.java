package com.datalink.dao;

import com.datalink.model.Usuario;
import com.datalink.util.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOImpl implements IUsuarioDAO {

    private static final String SQL_LISTAR =
            "SELECT id, nombre, apellido, email, username, fecha_registro " +
            "FROM usuarios ORDER BY fecha_registro DESC";

    private static final String SQL_BUSCAR_POR_ID =
            "SELECT id, nombre, apellido, email, username, fecha_registro " +
            "FROM usuarios WHERE id = ?";

    private static final String SQL_INSERTAR =
            "INSERT INTO usuarios (nombre, apellido, email, username) VALUES (?, ?, ?, ?)";

    // ✅ NUEVO: SQL para actualizar
    private static final String SQL_ACTUALIZAR =
            "UPDATE usuarios SET nombre = ?, apellido = ?, email = ?, username = ? WHERE id = ?";

    private static final String SQL_ELIMINAR =
            "DELETE FROM usuarios WHERE id = ?";

    @Override
    public List<Usuario> listar() throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        try (Connection con = MySQLConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_LISTAR);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapear(rs));
            }
        }
        return lista;
    }

    @Override
    public Usuario buscarPorId(int id) throws SQLException {
        try (Connection con = MySQLConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_BUSCAR_POR_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }
        return null;
    }

    @Override
    public void guardar(Usuario u) throws SQLException {
        // ✅ MODIFICADO: Si tiene ID, actualiza; si no, inserta
        if (u.getId() > 0) {
            actualizar(u);
        } else {
            insertar(u);
        }
    }

    private void insertar(Usuario u) throws SQLException {
        try (Connection con = MySQLConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_INSERTAR)) {

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getUsername());
            ps.executeUpdate();
        }
    }

    // ✅ NUEVO MÉTODO
    private void actualizar(Usuario u) throws SQLException {
        try (Connection con = MySQLConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_ACTUALIZAR)) {

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getUsername());
            ps.setInt(5, u.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws SQLException {
        try (Connection con = MySQLConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_ELIMINAR)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Usuario mapear(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id"));
        u.setNombre(rs.getString("nombre"));
        u.setApellido(rs.getString("apellido"));
        u.setEmail(rs.getString("email"));
        u.setUsername(rs.getString("username"));

        Timestamp ts = rs.getTimestamp("fecha_registro");
        if (ts != null) {
            u.setFechaRegistro(ts.toLocalDateTime());
        }
        return u;
    }
}