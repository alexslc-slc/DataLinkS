package com.datalink.dao;

import com.datalink.model.ExcelData;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelDAO {

    public ExcelData leerExcel(InputStream is, String nombreArchivo) throws IOException {
        ExcelData data = new ExcelData();
        data.setNombreArchivo(nombreArchivo);

        try (Workbook wb = new XSSFWorkbook(is)) {
            Sheet sheet = wb.getSheetAt(0);

            // PRIMERO: Contar solo filas con datos reales
            int lastRowWithData = -1;
            for (Row row : sheet) {
                if (row != null && row.getPhysicalNumberOfCells() > 0) {
                    for (int c = 0; c < row.getLastCellNum(); c++) {
                        Cell cell = row.getCell(c);
                        if (cell != null && cell.getCellType() != CellType.BLANK) {
                            String valor = valorCelda(cell);
                            if (!valor.isEmpty()) {
                                lastRowWithData = row.getRowNum();
                                break;
                            }
                        }
                    }
                }
            }

            if (lastRowWithData < 0) {
                return data; // Excel vacío
            }

            // SEGUNDO: Leer solo hasta la última fila con datos
            boolean primeraFila = true;

            for (int rowIndex = 0; rowIndex <= lastRowWithData; rowIndex++) {
                Row row = sheet.getRow(rowIndex);
                if (row == null) {
                    continue;
                }

                List<String> celdas = new ArrayList<>();
                int numCeldas = row.getLastCellNum();
                if (numCeldas == 0) {
                    continue;
                }

                if (primeraFila) {
                    // Leer headers
                    for (int c = 0; c < numCeldas; c++) {
                        celdas.add(valorCelda(row.getCell(c)));
                    }

                    // Eliminar headers vacíos al final
                    while (!celdas.isEmpty() && celdas.get(celdas.size() - 1).isEmpty()) {
                        celdas.remove(celdas.size() - 1);
                    }

                    if (!celdas.isEmpty()) {
                        data.setHeaders(celdas);
                        primeraFila = false;
                    }
                } else {
                    // Leer datos - limitar al número de headers
                    int numHeaders = data.getHeaders().size();
                    boolean tieneContenido = false;

                    for (int c = 0; c < numHeaders; c++) {
                        String valor = valorCelda(row.getCell(c));
                        celdas.add(valor);
                        if (!valor.isEmpty()) {
                            tieneContenido = true;
                        }
                    }

                    if (tieneContenido) {
                        data.getRows().add(celdas);
                    }
                }
            }
        }

        return data;
    }

    private String valorCelda(Cell cell) {
        if (cell == null) {
            return "";
        }

        try {
            CellType tipo = cell.getCellType();
            return switch (tipo) {
                case STRING ->
                    cell.getStringCellValue().trim();
                case NUMERIC ->
                    DateUtil.isCellDateFormatted(cell)
                    ? cell.getLocalDateTimeCellValue().toLocalDate().toString()
                    : formatearNumero(cell.getNumericCellValue());
                case BOOLEAN ->
                    cell.getBooleanCellValue() ? "Sí" : "No";
                case FORMULA ->
                    valorFormula(cell);
                case BLANK, ERROR ->
                    "";
                default ->
                    "";
            };
        } catch (Exception e) {
            return "";
        }
    }

    private String valorFormula(Cell cell) {
        try {
            return switch (cell.getCachedFormulaResultType()) {
                case STRING ->
                    cell.getStringCellValue();
                case NUMERIC ->
                    formatearNumero(cell.getNumericCellValue());
                default ->
                    "";
            };
        } catch (Exception e) {
            return "";
        }
    }

    private String formatearNumero(double d) {
        if (d == Math.floor(d) && !Double.isInfinite(d)) {
            return String.valueOf((long) d);
        }
        return String.format("%.2f", d);
    }
}
