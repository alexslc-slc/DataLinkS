package com.datalink.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Modelo: datos leídos de un archivo Excel.
 * La primera fila se usa como cabecera; el resto son registros.
 */
public class ExcelData {

    private List<String> headers = new ArrayList<>();
    private List<List<String>> rows = new ArrayList<>();
    private String nombreArchivo = "";

    public List<String> getHeaders() { return headers; }
    public void setHeaders(List<String> headers) { this.headers = headers; }

    public List<List<String>> getRows() { return rows; }
    public void setRows(List<List<String>> rows) { this.rows = rows; }

    public String getNombreArchivo() { return nombreArchivo; }
    public void setNombreArchivo(String nombreArchivo) { this.nombreArchivo = nombreArchivo; }

    public boolean isEmpty() {
        return headers.isEmpty() && rows.isEmpty();
    }

    public int getTotalRegistros() {
        return rows.size();
    }
}
