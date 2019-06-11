<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
  <meta charset="utf-8">
  <title>编辑门诊医生</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="department/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="department/style/admin.css" media="all">
</head>
<body>
 <div class="layui-fluid" id="html1">
    <div class="layui-row layui-col-space15">
        <div class="layui-card layui-form" lay-filter="component-form-element">
          <div style="padding: 20px;" style="margin: auto;">

            <div class="layui-row">

              <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">登录名：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
            <input class="layui-input" id="login_name" name="login_name" autocomplete="off" value="">
          </div>
          <br>

          <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">密码：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
            <input class="layui-input" name="password" id="password" autocomplete="off" >
          </div>
          <br>

          <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">真实姓名：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
            <input class="layui-input" name="real_name" autocomplete="off" readonly="readonly">
          </div>
          <br>

          <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">所在科室：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
                  <select name="deptid" lay-verify="required" lay-search>
                      <c:forEach items="${departments}" var="department">
                          <option value="${department.id}">${department.deptname}</option>
                      </c:forEach>
                  </select>
          </div>
          <br>

          <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">用户类别：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
            <input class="layui-input" name="category" autocomplete="off" readonly="readonly">
          </div>
          <br>

          <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">医生职称：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
               <select name="level" lay-verify="required" lay-search>
                      <option value="">请选择职称</option>
                      <option value="01">主任医师</option>
                      <option value="02">副主任医师</option>
                      <option value="03">主治医师</option>
                      <option value="04">住院医师</option>

                    </select>
          </div>
          <br>

           <div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
            <p style="margin: auto;">是否参与排班：</p>
              </div>
              <div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
               <select name="ifwork" lay-verify="required" lay-search>
                      <option value="">请选择是与否</option>
                      <option value="01">是</option>
                      <option value="02">否</option>


                    </select>
          </div>
          <br>



        </div>



            </div>





        </div>


      </div>

    </div>


<%-- <div class="layui-form" lay-filter="useradmin" id="useradmin">--%>
<%--     <div class="layui-form-item">--%>
<%--         <label class="layui-form-label">用 &nbsp;户&nbsp;名</label>--%>
<%--         <div class="layui-input-inline">--%>
<%--             <input type="text" name="username" lay-verify="required" id="username" placeholder="请输入用户名" autocomplete="off" class="layui-input">--%>
<%--         </div>--%>
<%--     </div>--%>
<%--     其它省略...--%>
<%-- </div>--%>



  
  <script src="department/layui/layui.js"></script>


   <script>
  layui.config({
    base: 'department/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'form'], function(){
    var $ = layui.$
    ,admin = layui.admin
    ,element = layui.element
    ,form = layui.form;
    
    form.render(null, 'component-form-element');
    element.render('breadcrumb', 'breadcrumb');
    
    form.on('submit(component-form-element)', function(data){
      layer.msg(JSON.stringify(data.field));
      return false;
    });
  });
  </script>

</body>
</html>