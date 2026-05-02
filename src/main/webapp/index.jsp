<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="titulo" value="DataLink Solutions — Inicio"/>
</jsp:include>

<div class="container">

    <div class="hero">
        <h1>Sistema de Gestión Multifuente de Datos</h1>
        <p>Integración unificada de MySQL · PostgreSQL · Excel bajo los patrones MVC y DAO.</p>
    </div>

    <div class="cards">

        <a class="card" href="${pageContext.request.contextPath}/usuarios">
            <div class="card-icon">👤</div>
            <h3>Usuarios</h3>
            <p>Registrar, consultar y eliminar usuarios del sistema.</p>
            <span class="card-badge badge-mysql">MySQL</span>
        </a>

        <a class="card" href="${pageContext.request.contextPath}/proyectos">
            <div class="card-icon">📁</div>
            <h3>Proyectos</h3>
            <p>Información secundaria de proyectos por cliente y estado.</p>
            <span class="card-badge badge-postgres">PostgreSQL</span>
        </a>

        <a class="card" href="${pageContext.request.contextPath}/excel">
            <div class="card-icon">📊</div>
            <h3>Importar Excel</h3>
            <p>Cargar registros históricos desde un archivo .xlsx.</p>
            <span class="card-badge badge-excel">Apache POI</span>
        </a>

        <!-- ✅ NUEVA TARJETA -->
        <a class="card" href="${pageContext.request.contextPath}/dashboard">
            <div class="card-icon">📈</div>
            <h3>Dashboard</h3>
            <p>Vista unificada de todas las fuentes de datos.</p>
            <span class="card-badge" style="background: #667eea; color: white;">MULTIFUENTE</span>
        </a>

    </div>

</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
<jsp:include page="/WEB-INF/includes/footer.jsp"/>
