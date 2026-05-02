<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="Usuarios — DataLink"/>
</jsp:include>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> / Usuarios
    </div>

    <!-- Mensajes -->
    <c:if test="${msg eq 'guardado'}">
        <div class="alert alert-success">✔ Usuario registrado correctamente.</div>
    </c:if>
    <c:if test="${msg eq 'actualizado'}">
        <div class="alert alert-success">✔ Usuario actualizado correctamente.</div>
    </c:if>
    <c:if test="${msg eq 'eliminado'}">
        <div class="alert alert-success">✔ Usuario eliminado.</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠ ${error}</div>
    </c:if>

    <!-- Encabezado -->
    <div class="page-header">
        <div>
            <h1>Usuarios</h1>
            <p>Fuente de datos: <strong>MySQL</strong> · tabla <code>usuarios</code></p>
        </div>
        <a class="btn btn-primary"
           href="${pageContext.request.contextPath}/usuarios?action=nuevo">
            + Nuevo usuario
        </a>
    </div>

    <!-- Tabla -->
    <div class="panel">
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre completo</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Registro</th>
                        <th style="width: 160px;">Acciones</th> <!-- ✅ Cambiado -->
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty usuarios}">
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <div class="empty-icon">👤</div>
                                        <p>No hay usuarios registrados.
                                           <a href="${pageContext.request.contextPath}/usuarios?action=nuevo">
                                               Agrega el primero.
                                           </a>
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="u" items="${usuarios}">
                                <tr>
                                    <td class="text-muted text-sm">${u.id}</td>
                                    <td><strong>${u.nombre} ${u.apellido}</strong></td>
                                    <td><code>${u.username}</code></td>
                                    <td>${u.email}</td>
                                    <td class="text-muted text-sm">
                                        ${u.fechaStr}
                                    </td>
                                    <td>
                                        <!-- ✅ NUEVO: Grupo de botones -->
                                        <div style="display: flex; gap: 5px;">
                                            <a class="btn btn-primary btn-sm"
                                               href="${pageContext.request.contextPath}/usuarios?action=editar&id=${u.id}">
                                                ✏️ Editar
                                            </a>
                                            <a class="btn btn-danger btn-sm"
                                               href="${pageContext.request.contextPath}/usuarios?action=eliminar&id=${u.id}"
                                               onclick="return confirm('¿Eliminar al usuario ${u.nombre}?')">
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