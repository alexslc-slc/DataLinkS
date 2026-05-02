
package com.datalink.servlet;

import com.datalink.dao.ExcelDAO;
import com.datalink.dao.IProyectoDAO;
import com.datalink.dao.IUsuarioDAO;
import com.datalink.dao.ProyectoDAOImpl;
import com.datalink.dao.UsuarioDAOImpl;
import com.datalink.model.ExcelData;
import com.datalink.model.Proyecto;
import com.datalink.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final IUsuarioDAO usuarioDAO = new UsuarioDAOImpl();
    private final IProyectoDAO proyectoDAO = new ProyectoDAOImpl();
    private final ExcelDAO excelDAO = new ExcelDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Cargar datos de MySQL (Usuarios)
        try {
            List<Usuario> usuarios = usuarioDAO.listar();
            req.setAttribute("usuarios", usuarios);
            req.setAttribute("totalUsuarios", usuarios.size());
        } catch (SQLException e) {
            req.setAttribute("errorMySQL", "Error MySQL: " + e.getMessage());
            req.setAttribute("usuarios", List.of());
            req.setAttribute("totalUsuarios", 0);
        }

        // 2. Cargar datos de PostgreSQL (Proyectos)
        try {
            List<Proyecto> proyectos = proyectoDAO.listar();
            req.setAttribute("proyectos", proyectos);
            req.setAttribute("totalProyectos", proyectos.size());
            
            // Contar proyectos por estado
            long activos = proyectos.stream()
                    .filter(p -> "Activo".equals(p.getEstado())).count();
            long completados = proyectos.stream()
                    .filter(p -> "Completado".equals(p.getEstado())).count();
            long pausados = proyectos.stream()
                    .filter(p -> "Pausado".equals(p.getEstado())).count();
            
            req.setAttribute("proyectosActivos", activos);
            req.setAttribute("proyectosCompletados", completados);
            req.setAttribute("proyectosPausados", pausados);
            
        } catch (SQLException e) {
            req.setAttribute("errorPostgreSQL", "Error PostgreSQL: " + e.getMessage());
            req.setAttribute("proyectos", List.of());
            req.setAttribute("totalProyectos", 0);
        }

        // 3. Cargar datos de Excel
        try {
            InputStream inputStream = getServletContext()
                    .getResourceAsStream("/WEB-INF/excel/datos.xlsx");
            
            if (inputStream != null) {
                ExcelData excelData = excelDAO.leerExcel(inputStream, "datos.xlsx");
                req.setAttribute("excelData", excelData);
                req.setAttribute("totalExcel", excelData.getTotalRegistros());
            } else {
                req.setAttribute("errorExcel", "Archivo Excel no encontrado");
                req.setAttribute("totalExcel", 0);
            }
        } catch (Exception e) {
            req.setAttribute("errorExcel", "Error Excel: " + e.getMessage());
            req.setAttribute("totalExcel", 0);
        }

        // Redirigir a la vista del dashboard
        req.getRequestDispatcher("/dashboard/index.jsp").forward(req, resp);
    }
}