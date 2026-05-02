<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="Dashboard — DataLink"/>
</jsp:include>

<style>
    .stats-row {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1rem;
        margin-bottom: 1.5rem;
    }

    .stat-box {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 6px;
        padding: 1rem 1.25rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .stat-info h3 {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #6b7280;
        margin: 0 0 0.25rem 0;
        font-weight: 500;
    }

    .stat-info .number {
        font-size: 1.75rem;
        font-weight: 600;
        color: #111827;
    }

    .stat-info .sub {
        font-size: 0.7rem;
        color: #9ca3af;
        margin-top: 0.15rem;
    }

    .stat-icon {
        font-size: 1.5rem;
        opacity: 0.7;
    }

    .section {
        margin-bottom: 1.25rem;
    }

    .section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0.5rem 0;
        border-bottom: 1px solid #e5e7eb;
        margin-bottom: 0.5rem;
    }

    .section-header h2 {
        font-size: 0.9rem;
        font-weight: 600;
        color: #374151;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin: 0;
    }

    .tag {
        font-size: 0.6rem;
        font-weight: 500;
        text-transform: uppercase;
        padding: 2px 8px;
        border-radius: 3px;
        letter-spacing: 0.5px;
    }

    .tag-mysql {
        background: #fef2f2;
        color: #991b1b;
        border: 1px solid #fecaca;
    }

    .tag-pg {
        background: #eff6ff;
        color: #1e40af;
        border: 1px solid #bfdbfe;
    }

    .tag-excel {
        background: #f0fdf4;
        color: #166534;
        border: 1px solid #bbf7d0;
    }

    .link-btn {
        font-size: 0.75rem;
        color: #6b7280;
        text-decoration: none;
        padding: 3px 10px;
        border: 1px solid #d1d5db;
        border-radius: 4px;
        transition: all 0.15s;
    }

    .link-btn:hover {
        background: #f9fafb;
        color: #374151;
        border-color: #9ca3af;
    }

    .link-btn.primary {
        background: #111827;
        color: #fff;
        border-color: #111827;
    }

    .link-btn.primary:hover {
        background: #374151;
    }

    .compact-table {
        width: 100%;
        font-size: 0.8rem;
        border-collapse: collapse;
    }

    .compact-table th {
        font-size: 0.7rem;
        font-weight: 500;
        color: #6b7280;
        text-transform: uppercase;
        letter-spacing: 0.3px;
        padding: 0.5rem 0.75rem;
        border-bottom: 2px solid #e5e7eb;
        background: #fafafa;
        text-align: left;
    }

    .compact-table td {
        padding: 0.4rem 0.75rem;
        border-bottom: 1px solid #f3f4f6;
        color: #374151;
        max-width: 140px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .compact-table tr:hover td {
        background: #fafafa;
    }

    .compact-table .muted {
        color: #9ca3af;
        font-size: 0.75rem;
    }

    .compact-table .mono {
        font-family: 'SF Mono', 'Monaco', 'Menlo', monospace;
        font-size: 0.75rem;
        color: #6b7280;
    }

    .status-dot {
        display: inline-block;
        width: 6px;
        height: 6px;
        border-radius: 50%;
        margin-right: 5px;
    }

    .dot-green { background: #059669; }
    .dot-blue { background: #2563eb; }
    .dot-yellow { background: #d97706; }
    .dot-gray { background: #9ca3af; }

    .empty-msg {
        text-align: center;
        padding: 1.5rem;
        color: #9ca3af;
        font-size: 0.8rem;
        background: #fafafa;
        border: 1px dashed #e5e7eb;
        border-radius: 4px;
    }

    .empty-msg a {
        color: #374151;
        font-weight: 500;
    }

    .more-row td {
        text-align: center;
        color: #9ca3af;
        font-size: 0.7rem;
        padding: 0.5rem;
    }

    @media (max-width: 768px) {
        .stats-row {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> / Dashboard
    </div>

    <div class="page-header" style="margin-bottom: 0.5rem;">
        <div>
            <h1>Dashboard</h1>
            <p>Resumen de MySQL · PostgreSQL · Excel</p>
        </div>
    </div>

    <!-- Estadísticas -->
    <div class="stats-row">
        <div class="stat-box">
            <div class="stat-info">
                <h3>Usuarios</h3>
                <div class="number">${totalUsuarios}</div>
                <div class="sub">MySQL · datalink_mysql</div>
            </div>
            <div class="stat-icon">👤</div>
        </div>

        <div class="stat-box">
            <div class="stat-info">
                <h3>Proyectos</h3>
                <div class="number">${totalProyectos}</div>
                <div class="sub">
                    ${proyectosActivos} activos · ${proyectosCompletados} completados
                </div>
            </div>
            <div class="stat-icon">📁</div>
        </div>

        <div class="stat-box">
            <div class="stat-info">
                <h3>Excel</h3>
                <div class="number">${totalExcel}</div>
                <div class="sub">datos.xlsx</div>
            </div>
            <div class="stat-icon">📊</div>
        </div>
    </div>

    <!-- Usuarios - MySQL -->
    <div class="section">
        <div class="section-header">
            <h2>
                👤 Usuarios 
                <span class="tag tag-mysql">MySQL</span>
            </h2>
            <div style="display: flex; gap: 0.4rem;">
                <a href="${pageContext.request.contextPath}/usuarios?action=nuevo" 
                   class="link-btn primary">+ Nuevo</a>
                <a href="${pageContext.request.contextPath}/usuarios" 
                   class="link-btn">Todos →</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty errorMySQL}">
                <div class="empty-msg">⚠ ${errorMySQL}</div>
            </c:when>
            <c:when test="${empty usuarios}">
                <div class="empty-msg">
                    Sin registros. <a href="${pageContext.request.contextPath}/usuarios?action=nuevo">Agregar usuario</a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="compact-table">
                    <thead>
                        <tr>
                            <th style="width:40px;">ID</th>
                            <th>Nombre</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th style="width:130px;">Registro</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${usuarios}" begin="0" end="4">
                            <tr>
                                <td class="muted">${u.id}</td>
                                <td>${u.nombre} ${u.apellido}</td>
                                <td class="mono">${u.username}</td>
                                <td class="muted">${u.email}</td>
                                <td class="muted">${u.fechaStr}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${fn:length(usuarios) > 5}">
                            <tr class="more-row">
                                <td colspan="5">··· ${fn:length(usuarios) - 5} registros más ···</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Proyectos - PostgreSQL -->
    <div class="section">
        <div class="section-header">
            <h2>
                📁 Proyectos 
                <span class="tag tag-pg">PostgreSQL</span>
            </h2>
            <div style="display: flex; gap: 0.4rem;">
                <a href="${pageContext.request.contextPath}/proyectos?action=nuevo" 
                   class="link-btn primary">+ Nuevo</a>
                <a href="${pageContext.request.contextPath}/proyectos" 
                   class="link-btn">Todos →</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty errorPostgreSQL}">
                <div class="empty-msg">⚠ ${errorPostgreSQL}</div>
            </c:when>
            <c:when test="${empty proyectos}">
                <div class="empty-msg">
                    Sin registros. <a href="${pageContext.request.contextPath}/proyectos?action=nuevo">Agregar proyecto</a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="compact-table">
                    <thead>
                        <tr>
                            <th style="width:40px;">ID</th>
                            <th>Nombre</th>
                            <th>Cliente</th>
                            <th>Estado</th>
                            <th style="width:100px;">Fecha</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${proyectos}" begin="0" end="4">
                            <tr>
                                <td class="muted">${p.id}</td>
                                <td>${p.nombre}</td>
                                <td class="muted">${p.cliente}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.estado eq 'Activo'}">
                                            <span class="status-dot dot-green"></span>Activo
                                        </c:when>
                                        <c:when test="${p.estado eq 'Completado'}">
                                            <span class="status-dot dot-blue"></span>Completado
                                        </c:when>
                                        <c:when test="${p.estado eq 'Pausado'}">
                                            <span class="status-dot dot-yellow"></span>Pausado
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-dot dot-gray"></span>${p.estado}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="muted">${p.fechaInicio}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${fn:length(proyectos) > 5}">
                            <tr class="more-row">
                                <td colspan="5">··· ${fn:length(proyectos) - 5} registros más ···</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Excel -->
    <div class="section">
        <div class="section-header">
            <h2>
                📊 Datos Excel 
                <span class="tag tag-excel">Apache POI</span>
            </h2>
            <div style="display: flex; gap: 0.4rem;">
                <a href="${pageContext.request.contextPath}/excel" 
                   class="link-btn">Ver completo →</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty errorExcel}">
                <div class="empty-msg">⚠ ${errorExcel}</div>
            </c:when>
            <c:when test="${empty excelData or excelData.totalRegistros == 0}">
                <div class="empty-msg">Sin datos disponibles.</div>
            </c:when>
            <c:otherwise>
                <table class="compact-table">
                    <thead>
                        <tr>
                            <th style="width:40px;">#</th>
                            <c:forEach var="h" items="${excelData.headers}" begin="0" end="3">
                                <th title="${h}">
                                    <c:choose>
                                        <c:when test="${fn:length(h) > 12}">
                                            ${fn:substring(h, 0, 12)}..
                                        </c:when>
                                        <c:otherwise>${h}</c:otherwise>
                                    </c:choose>
                                </th>
                            </c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${excelData.rows}" begin="0" end="4" varStatus="st">
                            <tr>
                                <td class="muted">${st.index + 1}</td>
                                <c:forEach var="cell" items="${row}" begin="0" end="3">
                                    <td title="${cell}">
                                        <c:choose>
                                            <c:when test="${fn:length(cell) > 18}">
                                                ${fn:substring(cell, 0, 18)}..
                                            </c:when>
                                            <c:otherwise>${cell}</c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        <c:if test="${excelData.totalRegistros > 5}">
                            <tr class="more-row">
                                <td colspan="${fn:length(excelData.headers) + 1}">
                                    ··· ${excelData.totalRegistros - 5} registros más ···
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>