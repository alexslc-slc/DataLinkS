package com.datalink.dao;

import com.datalink.model.Proyecto;
import com.datalink.util.PGConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProyectoDAOImpl implements IProyectoDAO {

    private static final String SQL_LISTAR =
            "SELECT id, nombre, descripcion, cliente, estado, fecha_inicio " +
            "FROM proyectos ORDER BY fecha_inicio DESC";

    private static final String SQL_BUSCAR_POR_ID =
            "SELECT id, nombre, descripcion, cliente, estado, fecha_inicio " +
            "FROM proyectos WHERE id = ?";

    private static final String SQL_INSERTAR =
            "INSERT INTO proyectos (nombre, descripcion, cliente, estado, fecha_inicio) " +
            "VALUES (?, ?, ?, ?, ?)";

    // ✅ NUEVO: SQL para actualizar
    private static final String SQL_ACTUALIZAR =
            "UPDATE proyectos SET nombre = ?, descripcion = ?, cliente = ?, " +
            "estado = ?, fecha_inicio = ? WHERE id = ?";

    private static final String SQL_ELIMINAR =
            "DELETE FROM proyectos WHERE id = ?";

    @Override
    public List<Proyecto> listar() throws SQLException {
        List<Proyecto> lista = new ArrayList<>();
        try (Connection con = PGConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_LISTAR);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapear(rs));
            }
        }
        return lista;
    }

    @Override
    public Proyecto buscarPorId(int id) throws SQLException {
        try (Connection con = PGConnection.getConnection();
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
    public void guardar(Proyecto p) throws SQLException {
        // ✅ MODIFICADO: Si tiene ID, actualiza; si no, inserta
        if (p.getId() > 0) {
            actualizar(p);
        } else {
            insertar(p);
        }
    }

    private void insertar(Proyecto p) throws SQLException {
        try (Connection con = PGConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_INSERTAR)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getCliente());
            ps.setString(4, p.getEstado());
            ps.setDate(5, p.getFechaInicio() != null
                    ? Date.valueOf(p.getFechaInicio()) : null);
            ps.executeUpdate();
        }
    }

    // ✅ NUEVO MÉTODO
    private void actualizar(Proyecto p) throws SQLException {
        try (Connection con = PGConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_ACTUALIZAR)) {

            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getCliente());
            ps.setString(4, p.getEstado());
            ps.setDate(5, p.getFechaInicio() != null
                    ? Date.valueOf(p.getFechaInicio()) : null);
            ps.setInt(6, p.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws SQLException {
        try (Connection con = PGConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_ELIMINAR)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Proyecto mapear(ResultSet rs) throws SQLException {
        Proyecto p = new Proyecto();
        p.setId(rs.getInt("id"));
        p.setNombre(rs.getString("nombre"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setCliente(rs.getString("cliente"));
        p.setEstado(rs.getString("estado"));

        Date fecha = rs.getDate("fecha_inicio");
        if (fecha != null) {
            p.setFechaInicio(fecha.toLocalDate());
        }
        return p;
    }
}