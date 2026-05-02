<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>${param.titulo != null ? param.titulo : 'DataLink Solutions'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        🔗 DataLink <span>Solutions</span>
    </a>
    <a class="nav-link" href="${pageContext.request.contextPath}/usuarios">👤 Usuarios</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/proyectos">📁 Proyectos</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/excel">📊 Excel</a>
</nav>
