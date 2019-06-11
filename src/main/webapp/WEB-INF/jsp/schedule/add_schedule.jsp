<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>"/>

<html>
<head>
  <meta charset="utf-8">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
  <title>排班管理</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="department/layui/css/layui.css" media="all">
	<link rel="stylesheet" href="department/style/admin.css" media="all">
	<script src="department/layui/layui.js"></script>
	<script src="js/jquery.min.js"></script>
</head>

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

<script type="text/javascript" language="JavaScript">
	function getDoctorName(doctor_id) {
		$.ajax({
			type: "get",
			url: "schedule/getDoctorName/" + doctor_id,
			success: function (name) {
				var result = name;
				var opt = document.getElementById("doctorName");
				opt.setAttribute("value", result);
			}
		});
	}

	function getDepartmentName(doctor_id) {
		$.ajax({
			type: "get",
			url: "schedule/getDepartmentName/" + doctor_id,
			success: function (name) {
				var result = name;
				var opt = document.getElementById("departmentName");
				opt.setAttribute("value", result);
			}
		});
	}

	function getDate() {
		var date = new Date();
		var seperator1 = "-";
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var strDate = date.getDate();
		if (month >= 1 && month <= 9) {
			month = "0" + month;
		}
		if (strDate >= 0 && strDate <= 9) {
			strDate = "0" + strDate;
		}
		var currentdate = year + seperator1 + month + seperator1 + strDate;
		var opt = document.getElementById("operateDate");
		opt.setAttribute("value", currentdate);
		return currrentdate;
	}
</script>

<script>
	function addControll() {
		var doctorId = document.getElementById("doctorId").value.toUpperCase();
		var weekTime = document.getElementById("weekTime").value.toUpperCase();
		var registerLevel = document.getElementById("registerLevel").value.toUpperCase();
		var noonLevel = document.getElementById("noonLevel").value.toUpperCase();
		var limitNum = document.getElementById("limitNum").value.toUpperCase();
		if(doctorId == ""){
			alert("医生编号不能为空");
			return false;
		}
		else if(weekTime == "") {
			alert("时间（星期）不能为空");
			return false;
		}
		else if(registerLevel == "") {
			alert("号别不能为空");
			return false;
		}
		else if(noonLevel == "") {
			alert("午别不能为空");
			return false;
		}
		else if(limitNum == "") {
			alert("排班限额不能为空");
			return false;
		}
	}
</script>

<body>

 <div class="layui-fluid" id="html1">
    <div class="layui-row layui-col-space15">
        <div class="layui-card layui-form" lay-filter="component-form-element">
        	<div style="padding: 20px;" style="margin: auto;">

                <form id="add" method="post" action="#" style="padding: 20px;" role="form">
						<div class="layui-row">

							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
								<p style="margin: auto;">医生编号：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<input class="layui-input" id="doctorId" autocomplete="off" onblur="getDoctorName(this.value);getDepartmentName(this.value);getDate()">
							</div>
							<br>

							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
								<p style="margin: auto;">医生姓名：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<input class="layui-input" type="text" id="doctorName" autocomplete="off" readonly="true">
							</div>
							<br>

							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
								<p style="margin: auto;">科室名称：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<input class="layui-input" id="departmentName" autocomplete="off" readonly="true">
							</div>
							<br>


							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1"><p>时间：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">

								<select name="week" lay-verify="required" lay-search id="weekTime">
									<option value="">请选择星期</option>
									<option value="01">星期一</option>
									<option value="02">星期二</option>
									<option value="03">星期三</option>
									<option value="04">星期四</option>
									<option value="05">星期五</option>
									<option value="06">星期六</option>
									<option value="07">星期日</option>

								</select>
							</div>
							<br>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1" ><p style="margin: auto;">号别：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<select name="week" lay-verify="required" lay-search id="registerLevel">
									<option value="">请选择号别</option>
									<option value="01">普通</option>
									<option value="02">专家</option>
									<option value="03">急诊</option>


								</select>
							</div>
							<br>

							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1"><p style="margin: auto;">午别：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<select name="week" lay-verify="required" lay-search id="noonLevel">
									<option value="">请选择午别</option>
									<option value="01">全天</option>
									<option value="02">上午</option>
									<option value="03">下午</option>
									<option value="04">晚上</option>
								</select>
							</div>
							<br>

							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
								<p style="margin: auto;">排班限额：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<input class="layui-input" id="limitNum" autocomplete="off" >
							</div>
							<br>


							<div class="layui-col-xs6 layui-col-sm6 layui-col-md1" >
								<p style="margin: auto;">操作日期：</p>
							</div>
							<div class="layui-col-xs6 layui-col-sm6 layui-col-md11">
								<input class="layui-input" id="operateDate" autocomplete="off" readonly="readonly" >
							</div>
							<br>
						</div>
                    </form>
        		</div>
        </div>


      </div>

    </div>

</body>
</html>