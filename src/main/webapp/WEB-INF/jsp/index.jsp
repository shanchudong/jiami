<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<base href="<%=basePath%>"/>

<html>
<head>
    <title>首页</title>
</head>
<body>
    <div align="center">
        <h1>首页</h1>
    </div>
    <div align="center">
        <h3><a href="/login/login">登录</a></h3>

    </div>
</body>
</html>