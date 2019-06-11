<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>"/>
<html>
<head>
    <title>挂号收费员</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
</head>

<script type="text/javascript" language="JavaScript">
    $(document).ready(function () {
        $('#logout').click(function () {
            alert("注销成功");
            window.location.href = "login/logout";
        })
    })
</script>

<body>
<div align="center">
    <h1>挂号收费员的主页</h1>
    <button class="btn btn-info" style="align-content: center" id="logout">注销</button>
</div>

</body>
</html>
