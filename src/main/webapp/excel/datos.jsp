<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="Datos Excel — DataLink"/>
</jsp:include>

<style>
    .table-wrap {
        overflow-x: auto;
        max-width: 100%;
    }

    table {
        width: auto;
        min-width: 100%;
        table-layout: auto;
    }

    th, td {
        white-space: nowrap;
        padding: 8px 12px;
        max-width: 200px;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    th {
        background: #f8f9fa;
        font-weight: 600;
        position: sticky;
        top: 0;
    }
</style>

<div class="container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> /
        <a href="${pageContext.request.contextPath}/excel">Importar Excel</a> /
        Resultados
    </div>

    <div class="page-header">
        <div>
            <h1>Registros importados</h1>
            <p>
                Archivo: <strong>${excelData.nombreArchivo}</strong>
                &nbsp;·&nbsp;
                <strong>${excelData.totalRegistros}</strong> registros encontrados.
            </p>
        </div>
        <a class="btn btn-outline"
           href="${pageContext.request.contextPath}/excel">← Nueva importación</a>
    </div>

    <c:choose>
        <c:when test="${empty excelData.rows}">
            <div class="alert alert-danger">
                ⚠ El archivo no contiene datos o no pudo ser leído.
            </div>
        </c:when>
        <c:otherwise>
            <div class="panel">
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 40px;">#</th>
                                    <c:forEach var="h" items="${excelData.headers}">
                                    <th title="${h}">
                                        <c:choose>
                                            <c:when test="${fn:length(h) > 30}">
                                                ${fn:substring(h, 0, 30)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${h}
                                            </c:otherwise>
                                        </c:choose>
                                    </th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${excelData.rows}" varStatus="st">
                                <tr>
                                    <td class="text-muted text-sm">${st.index + 1}</td>
                                    <c:forEach var="cell" items="${row}">
                                        <td>${cell}</td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>