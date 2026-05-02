package com.datalink.dao;

import com.datalink.model.Usuario;
import java.sql.SQLException;
import java.util.List;

/**
 * Contrato DAO para la entidad Usuario (MySQL).
 */
public interface IUsuarioDAO {
    List<Usuario> listar() throws SQLException;
    Usuario buscarPorId(int id) throws SQLException;
    void guardar(Usuario usuario) throws SQLException;
    void eliminar(int id) throws SQLException;
}
