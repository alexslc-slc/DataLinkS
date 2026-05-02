<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="Proyectos — DataLink"/>
</jsp:include>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> / Proyectos
    </div>

    <!-- Mensajes -->
    <c:if test="${msg eq 'guardado'}">
        <div class="alert alert-success">✔ Proyecto guardado correctamente.</div>
    </c:if>
    <c:if test="${msg eq 'actualizado'}">
        <div class="alert alert-success">✔ Proyecto actualizado correctamente.</div>
    </c:if>
    <c:if test="${msg eq 'eliminado'}">
        <div class="alert alert-success">✔ Proyecto eliminado.</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠ ${error}</div>
    </c:if>

    <div class="page-header">
        <div>
            <h1>Proyectos</h1>
            <p>Fuente de datos: <strong>PostgreSQL</strong> · tabla <code>proyectos</code></p>
        </div>
        <a class="btn btn-primary"
           href="${pageContext.request.contextPath}/proyectos?action=nuevo">
            + Nuevo proyecto
        </a>
    </div>

    <div class="panel">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Cliente</th>
                        <th>Estado</th>
                        <th>Fecha inicio</th>
                        <th>Descripción</th>
                        <th style="width: 160px;">Acciones</th> <!-- ✅ Cambiado -->
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty proyectos}">
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <div class="empty-icon">📁</div>
                                        <p>No hay proyectos registrados.
                                           <a href="${pageContext.request.contextPath}/proyectos?action=nuevo">
                                               Agrega el primero.
                                           </a>
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${proyectos}">
                                <tr>
                                    <td class="text-muted text-sm">${p.id}</td>
                                    <td><strong>${p.nombre}</strong></td>
                                    <td>${p.cliente}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.estado eq 'Activo'}">
                                                <span class="badge badge-green">Activo</span>
                                            </c:when>
                                            <c:when test="${p.estado eq 'Completado'}">
                                                <span class="badge badge-blue">Completado</span>
                                            </c:when>
                                            <c:when test="${p.estado eq 'Pausado'}">
                                                <span class="badge badge-yellow">Pausado</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-gray">${p.estado}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-sm">${p.fechaInicio}</td>
                                    <td class="text-muted text-sm">${p.descripcion}</td>
                                    <td>
                                        <!-- ✅ NUEVO: Grupo de botones -->
                                        <div style="display: flex; gap: 5px;">
                                            <a class="btn btn-primary btn-sm"
                                               href="${pageContext.request.contextPath}/proyectos?action=editar&id=${p.id}">
                                                ✏️ Editar
                                            </a>
                                            <a class="btn btn-danger btn-sm"
                                               href="${pageContext.request.contextPath}/proyectos?action=eliminar&id=${p.id}"
                                               onclick="return confirm('¿Eliminar proyecto ${p.nombre}?')">
                                                🗑️ Eliminar
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>