package com.datalink.dao;

import com.datalink.model.Proyecto;
import java.sql.SQLException;
import java.util.List;

/**
 * Contrato DAO para la entidad Proyecto (PostgreSQL).
 */
public interface IProyectoDAO {
    List<Proyecto> listar() throws SQLException;
    Proyecto buscarPorId(int id) throws SQLException;
    void guardar(Proyecto proyecto) throws SQLException;
    void eliminar(int id) throws SQLException;
}
