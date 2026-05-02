<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="Importar Excel — DataLink"/>
</jsp:include>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> / Importar Excel
    </div>

    <div class="page-header">
        <div>
            <h1>Importar datos desde Excel</h1>
            <p>Carga un archivo <strong>.xlsx</strong> con registros históricos. 
               La primera fila se usa como cabecera.</p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠ ${error}</div>
    </c:if>

    <div class="panel" style="max-width:520px;">
        <div class="panel-header"><h2>Seleccionar archivo</h2></div>
        <div class="panel-body">
            <form method="post"
                  action="${pageContext.request.contextPath}/excel"
                  enctype="multipart/form-data">

                <div class="form-group">
                    <label for="archivo">Archivo Excel (.xlsx)</label>
                    <input type="file" id="archivo" name="archivo"
                           accept=".xlsx" required/>
                    <p class="text-muted text-sm mt-1">
                        Tamaño máximo: 10 MB · Solo formato .xlsx (Excel 2007+)
                    </p>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        📊 Cargar y mostrar datos
                    </button>
                </div>
            </form>
        </div>
    </div>


</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
