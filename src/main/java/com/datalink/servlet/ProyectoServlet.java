package com.datalink.servlet;

import com.datalink.dao.IProyectoDAO;
import com.datalink.dao.ProyectoDAOImpl;
import com.datalink.model.Proyecto;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/proyectos")
public class ProyectoServlet extends HttpServlet {

    private final IProyectoDAO dao = new ProyectoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "lista";

        try {
            switch (action) {
                case "nuevo" -> {
                    // Formulario vacío para nuevo proyecto
                    req.getRequestDispatcher("/proyectos/form.jsp")
                            .forward(req, resp);
                }

                // ✅ NUEVO: Cargar proyecto para editar
                case "editar" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Proyecto proyecto = dao.buscarPorId(id);
                    if (proyecto != null) {
                        req.setAttribute("proyecto", proyecto);
                        req.getRequestDispatcher("/proyectos/form.jsp")
                                .forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() 
                                + "/proyectos?error=Proyecto no encontrado");
                    }
                }

                case "eliminar" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    dao.eliminar(id);
                    resp.sendRedirect(req.getContextPath() 
                            + "/proyectos?msg=eliminado");
                }

                default -> {
                    // Listar todos
                    List<Proyecto> lista = dao.listar();
                    req.setAttribute("proyectos", lista);
                    req.setAttribute("msg", req.getParameter("msg"));
                    req.setAttribute("error", req.getParameter("error"));
                    req.getRequestDispatcher("/proyectos/lista.jsp")
                            .forward(req, resp);
                }
            }
        } catch (SQLException | NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() 
                    + "/proyectos?error=" + java.net.URLEncoder
                    .encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("guardar".equals(action)) {
            String idStr       = req.getParameter("id");
            String nombre      = req.getParameter("nombre");
            String descripcion = req.getParameter("descripcion");
            String cliente     = req.getParameter("cliente");
            String estado      = req.getParameter("estado");
            String fechaStr    = req.getParameter("fechaInicio");

            if (estaVacio(nombre) || estaVacio(cliente)) {
                req.setAttribute("error", "Nombre y cliente son obligatorios.");
                req.getRequestDispatcher("/proyectos/form.jsp").forward(req, resp);
                return;
            }

            Proyecto p = new Proyecto();
            
            // ✅ Si viene ID, es actualización
            if (!estaVacio(idStr)) {
                p.setId(Integer.parseInt(idStr));
            }
            
            p.setNombre(nombre.trim());
            p.setDescripcion(descripcion != null ? descripcion.trim() : "");
            p.setCliente(cliente.trim());
            p.setEstado(estado != null ? estado : "Activo");

            if (!estaVacio(fechaStr)) {
                try { 
                    p.setFechaInicio(LocalDate.parse(fechaStr)); 
                } catch (Exception e) { 
                    p.setFechaInicio(LocalDate.now()); 
                }
            } else {
                p.setFechaInicio(LocalDate.now());
            }

            try {
                dao.guardar(p);
                String operacion = (p.getId() > 0 && !estaVacio(idStr)) 
                        ? "actualizado" : "guardado";
                resp.sendRedirect(req.getContextPath() 
                        + "/proyectos?msg=" + operacion);
            } catch (SQLException e) {
                req.setAttribute("error", "Error al guardar: " + e.getMessage());
                req.setAttribute("proyecto", p);
                req.getRequestDispatcher("/proyectos/form.jsp").forward(req, resp);
            }
        }
    }

    private boolean estaVacio(String s) {
        return s == null || s.isBlank();
    }
}