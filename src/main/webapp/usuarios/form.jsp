<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="${empty usuario ? 'Nuevo' : 'Editar'} Usuario — DataLink"/>
</jsp:include>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> /
        <a href="${pageContext.request.contextPath}/usuarios">Usuarios</a> /
        ${empty usuario ? 'Nuevo usuario' : 'Editar usuario'}
    </div>

    <div class="page-header">
        <div>
            <h1>${empty usuario ? 'Nuevo Usuario' : 'Editar Usuario'}</h1>
            <p>Se guardará en <strong>MySQL</strong> · tabla <code>usuarios</code></p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠ ${error}</div>
    </c:if>

    <div class="panel" style="max-width:560px;">
        <div class="panel-header">
            <h2>${empty usuario ? 'Datos del usuario' : 'Modificar datos'}</h2>
        </div>
        <div class="panel-body">
            <form method="post" action="${pageContext.request.contextPath}/usuarios">
                <input type="hidden" name="action" value="guardar"/>
                
                <!-- ✅ NUEVO: ID oculto para edición -->
                <c:if test="${not empty usuario}">
                    <input type="hidden" name="id" value="${usuario.id}"/>
                </c:if>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <input type="text" id="nombre" name="nombre"
                               value="${not empty usuario ? usuario.nombre : nombre}" 
                               placeholder="Ej: Juan" required/>
                    </div>
                    <div class="form-group">
                        <label for="apellido">Apellido</label>
                        <input type="text" id="apellido" name="apellido"
                               value="${not empty usuario ? usuario.apellido : apellido}" 
                               placeholder="Ej: Pérez" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email"
                           value="${not empty usuario ? usuario.email : email}" 
                           placeholder="usuario@empresa.com" required/>
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username"
                           value="${not empty usuario ? usuario.username : username}" 
                           placeholder="Ej: jperez" required/>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        ${empty usuario ? 'Guardar usuario' : 'Actualizar usuario'}
                    </button>
                    <a class="btn btn-outline"
                       href="${pageContext.request.contextPath}/usuarios">Cancelar</a>
                </div>
            </form>
        </div>
    </div>

</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>