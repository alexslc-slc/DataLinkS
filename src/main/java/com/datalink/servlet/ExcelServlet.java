package com.datalink.servlet;

import com.datalink.dao.ExcelDAO;
import com.datalink.model.ExcelData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/excel")
public class ExcelServlet extends HttpServlet {

    private final ExcelDAO excelDAO = new ExcelDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        cargarYMostrarExcel(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Si no quieres POST, puedes eliminarlo o redirigir al GET
        cargarYMostrarExcel(req, resp);
    }

    private void cargarYMostrarExcel(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            // Intentar cargar el archivo del proyecto
            InputStream inputStream = getServletContext()
                    .getResourceAsStream("/WEB-INF/excel/datos.xlsx");
            
            if (inputStream == null) {
                req.setAttribute("error", 
                    "❌ No se encontró el archivo Excel en /WEB-INF/excel/datos.xlsx");
                req.getRequestDispatcher("/excel/datos.jsp").forward(req, resp);
                return;
            }
            
            System.out.println("✅ Archivo Excel encontrado, leyendo...");
            
            // Leer el Excel
            ExcelData data = excelDAO.leerExcel(inputStream, "datos.xlsx");
            
            System.out.println("Headers encontrados: " + data.getHeaders());
            System.out.println("Total registros: " + data.getTotalRegistros());
            
            if (data.isEmpty()) {
                req.setAttribute("error", "⚠ El archivo Excel está vacío o no tiene datos");
                req.getRequestDispatcher("/excel/datos.jsp").forward(req, resp);
                return;
            }
            
            req.setAttribute("excelData", data);
            req.getRequestDispatcher("/excel/datos.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", 
                "❌ Error al leer el archivo Excel: " + e.getMessage());
            req.getRequestDispatcher("/excel/datos.jsp").forward(req, resp);
        }
    }
}