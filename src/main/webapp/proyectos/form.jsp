<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="${empty proyecto ? 'Nuevo' : 'Editar'} Proyecto — DataLink"/>
</jsp:include>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Inicio</a> /
        <a href="${pageContext.request.contextPath}/proyectos">Proyectos</a> /
        ${empty proyecto ? 'Nuevo proyecto' : 'Editar proyecto'}
    </div>

    <div class="page-header">
        <div>
            <h1>${empty proyecto ? 'Nuevo Proyecto' : 'Editar Proyecto'}</h1>
            <p>Se guardará en <strong>PostgreSQL</strong> · tabla <code>proyectos</code></p>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">⚠ ${error}</div>
    </c:if>

    <div class="panel" style="max-width:600px;">
        <div class="panel-header">
            <h2>${empty proyecto ? 'Datos del proyecto' : 'Modificar datos'}</h2>
        </div>
        <div class="panel-body">
            <form method="post" action="${pageContext.request.contextPath}/proyectos">
                <input type="hidden" name="action" value="guardar"/>
                
                <!-- ✅ NUEVO: ID oculto para edición -->
                <c:if test="${not empty proyecto}">
                    <input type="hidden" name="id" value="${proyecto.id}"/>
                </c:if>

                <div class="form-group">
                    <label for="nombre">Nombre del proyecto</label>
                    <input type="text" id="nombre" name="nombre"
                           placeholder="Ej: Sistema de facturación" 
                           value="${proyecto.nombre}" required/>
                </div>

                <div class="form-group">
                    <label for="cliente">Cliente</label>
                    <input type="text" id="cliente" name="cliente"
                           placeholder="Ej: Empresa ABC" 
                           value="${proyecto.cliente}" required/>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="estado">Estado</label>
                        <select id="estado" name="estado">
                            <option value="Activo" ${proyecto.estado eq 'Activo' ? 'selected' : ''}>Activo</option>
                            <option value="Pausado" ${proyecto.estado eq 'Pausado' ? 'selected' : ''}>Pausado</option>
                            <option value="Completado" ${proyecto.estado eq 'Completado' ? 'selected' : ''}>Completado</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="fechaInicio">Fecha de inicio</label>
                        <input type="date" id="fechaInicio" name="fechaInicio"
                               value="${proyecto.fechaInicio}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea id="descripcion" name="descripcion"
                              placeholder="Descripción breve del proyecto...">${proyecto.descripcion}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        ${empty proyecto ? 'Guardar proyecto' : 'Actualizar proyecto'}
                    </button>
                    <a class="btn btn-outline"
                       href="${pageContext.request.contextPath}/proyectos">Cancelar</a>
                </div>
            </form>
        </div>
    </div>

</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>