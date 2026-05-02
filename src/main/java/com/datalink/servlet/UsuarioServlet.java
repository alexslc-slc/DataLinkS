package com.datalink.servlet;

import com.datalink.dao.IUsuarioDAO;
import com.datalink.dao.UsuarioDAOImpl;
import com.datalink.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {

    private final IUsuarioDAO dao = new UsuarioDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "lista";

        try {
            switch (action) {
                case "nuevo" -> {
                    // Formulario vacío para nuevo usuario
                    req.getRequestDispatcher("/usuarios/form.jsp")
                            .forward(req, resp);
                }

                // ✅ NUEVO: Cargar usuario para editar
                case "editar" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    Usuario usuario = dao.buscarPorId(id);
                    if (usuario != null) {
                        req.setAttribute("usuario", usuario);
                        req.getRequestDispatcher("/usuarios/form.jsp")
                                .forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() 
                                + "/usuarios?error=Usuario no encontrado");
                    }
                }

                case "eliminar" -> {
                    int id = Integer.parseInt(req.getParameter("id"));
                    dao.eliminar(id);
                    resp.sendRedirect(req.getContextPath() 
                            + "/usuarios?msg=eliminado");
                }

                default -> {
                    // Listar todos los usuarios
                    List<Usuario> lista = dao.listar();
                    req.setAttribute("usuarios", lista);
                    req.setAttribute("msg", req.getParameter("msg"));
                    req.setAttribute("error", req.getParameter("error"));
                    req.getRequestDispatcher("/usuarios/lista.jsp")
                            .forward(req, resp);
                }
            }
        } catch (SQLException | NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() 
                    + "/usuarios?error=" + java.net.URLEncoder
                    .encode("Error: " + e.getMessage(), 
                            java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("guardar".equals(action)) {
            String idStr    = req.getParameter("id");
            String nombre   = req.getParameter("nombre");
            String apellido = req.getParameter("apellido");
            String email    = req.getParameter("email");
            String username = req.getParameter("username");

            // Validación básica
            if (estaVacio(nombre) || estaVacio(apellido) || 
                estaVacio(email) || estaVacio(username)) {
                
                req.setAttribute("error", "Todos los campos son obligatorios.");
                req.setAttribute("nombre", nombre);
                req.setAttribute("apellido", apellido);
                req.setAttribute("email", email);
                req.setAttribute("username", username);
                req.getRequestDispatcher("/usuarios/form.jsp").forward(req, resp);
                return;
            }

            Usuario u = new Usuario();
            
            // ✅ Si viene ID, es actualización
            if (!estaVacio(idStr)) {
                u.setId(Integer.parseInt(idStr));
            }
            
            u.setNombre(nombre.trim());
            u.setApellido(apellido.trim());
            u.setEmail(email.trim());
            u.setUsername(username.trim());

            try {
                dao.guardar(u);
                String operacion = (!estaVacio(idStr)) ? "actualizado" : "guardado";
                resp.sendRedirect(req.getContextPath() + "/usuarios?msg=" + operacion);
            } catch (SQLException e) {
                req.setAttribute("error", "Error al guardar: " + e.getMessage());
                req.setAttribute("nombre", nombre);
                req.setAttribute("apellido", apellido);
                req.setAttribute("email", email);
                req.setAttribute("username", username);
                req.getRequestDispatcher("/usuarios/form.jsp").forward(req, resp);
            }
        }
    }

    private boolean estaVacio(String s) {
        return s == null || s.isBlank();
    }
}