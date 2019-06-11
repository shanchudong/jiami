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
    <title>挂号</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="department/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="department/style/admin.css" media="all">
    <script src="department/layui/layui.js"></script>
    <script src="js/jquery.min.js"></script>

    <style type="text/css">
        .layui-table th {
            font-weight: 600;
            font-size: 70%;
        }
    </style>
</head>

<script>
    layui.config({
        base: 'department/' //静态资源所在路径X
    })
        .extend({
            index: 'lib/index' //主入口模块X
        })
        .use(['index', 'table'], function () {
            var table = layui.table;


            // 搜索函数X
            var $ = layui.$,
                active = {
                    reload: function () {
                        var demoReload = $('#test-table-demoReload');

                        //执行重载
                        table.reload('test-table-reload', {
                            page: {
                                curr: 1 //重新从第 1 页开始
                            },
                            where: {
                                key: {
                                    id: demoReload.val()
                                }
                            }
                        });
                    }
                };

            $('.test-table-reload-btn .layui-btn').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });


        });
</script>

<script>
    function addRegister() {
        var flag = addControll();
        if(flag == false)
            return;

        $.ajax({
            type: "post",
            url: "register/add",
            data: {
                "medical_record_no": $("#number").val(),
                "patient_name": $("#patient_name").val(),
                "gender": $("#patient_gender").val(),
                "age": $("#age").val(),
                "birthday": $("#test-laydate-type-date").val(),
                "registration_category": $("#register_category").val(),
                "medical_category": $("#medical_category").val(),
                "identity_card_no": $("#id_card_no").val(),
                "family_address": $("#address").val(),
                "registration_date": $("#register_date").val(),
                //"see_doctor_date": $("#test-laydate-end").val(),
                "department_id": $("#departmentId").val(),
                "doctor_id": $("#doctorId").val(),
                "registration_source": $("#register_source").val(),
                "settle_accounts_category": $("#settle_category").val(),
                "is_seen_doctor": $("#see_doctor").val(),
                "status": $("#status").val(),
                "expense": $("#money").val(),
            },
            dataType: "JSON",
            async: false,

            beforeSend: function () {
                $("#submit").attr({ disabled: "disabled" });
            },
            success: function (data) {
                if(data == 1) {
                    alert("挂号成功");
                    window.location.reload();
                }
                else
                    alert("挂号失败");
            },
            error: function () {
                alert("提交失败");
            }
        });
    }
</script>

<script>
    function back() {
        var tabledata = layui.table.checkStatus('test-table-toolbar').data;

        var myArray = new Array();
        for(var i = 0; i < tabledata.length; i++){
            myArray.push(tabledata[i].id);
        }
        if(myArray.length < 1) {
            alert("请选择条目进行退号操作");
            return;
        }

        $.ajax({
            type: "POST",
            url: "register/back",
            traditional: true,
            data:{'id': myArray},
            beforeSend: function () {
                $("#submit").attr({ disabled: "disabled" });
                alert("请确认对所选的条目进行退号操作");
            },
            success: function (res) {
                if (res == 0) {
                    alert("退号失败");
                }
                else if(res == 2)
                    alert("该患者已经就诊，无法退号！");
                else {
                    alert("退号成功");
                }
                layui.table.reload('test-table-toolbar',{page: {curr: 1}});
            },
            error: function () {
                alert("出现错误");
                return false;
            }
        });

    }
</script>

<script>
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
        var opt = document.getElementById("register_date");
        opt.setAttribute("value", currentdate);
    }

    function getRegisterNo() {
        $.ajax({
            type: "POST",
            url: "register/getmedicalrecordno" ,
            success: function (result) {
                if (result.status == 0) {
                    //$("#number").val(result.data);
                    var num = result.data;
                    var opt = document.getElementById("number");
                    opt.setAttribute("value", num);
                }
            },
            error : function(result) {
                alert(result.msg);
            }
        });
    }
    
    function doctor() {
        $.ajax({
            type: "POST",//方法类型
            url: "register/doctorlist" ,//url
            async: false,
            success: function (result) {
                if (result.status == 0) {
                    doctorList = result.data;
                    $("#doctorId").empty();
                    for(var i = 0; i < doctorList.length; i++){
                        $("#doctorId").append("<option value='" + doctorList[i].id + "'>" + doctorList[i].name + "</option>");
                    }
                };
            },
            error : function(result) {
                alert(result.msg);
            }
        });
    }
    
    function department() {
        $.ajax({
            type: "POST",//方法类型
            url: "register/departmentlist" ,//url
            async: false,
            success: function (result) {
                if (result.status == 0) {
                    departmentList = result.data;
                    $("#departmentId").empty();
                    for(var i = 0; i < departmentList.length; i++){
                        $("#departmentId").append("<option value='" + departmentList[i].id + "'>" + departmentList[i].name + "</option>");
                    }
                };
            },
            error : function(result) {
                alert(result.msg);
            }
        });
    }

    function addControll() {
        var patient_name = document.getElementById("patient_name").value.toUpperCase();
        var age = document.getElementById("age").value.toUpperCase();
        var register_category = document.getElementById("register_category").value.toUpperCase();
        var medical_category = document.getElementById("medical_category").value.toUpperCase();
        var id_card_no = document.getElementById("id_card_no").value.toUpperCase();
        var departmentId = document.getElementById("departmentId").value.toUpperCase();
        var doctorId = document.getElementById("doctorId").value.toUpperCase();
        var register_source = document.getElementById("register_source").value.toUpperCase();
        var settle_category = document.getElementById("settle_category").value.toUpperCase();
        var money = document.getElementById("money").value.toUpperCase();

        if(patient_name == "") {
            alert("患者姓名不能为空");
            return false;
        }
        else if(age == "") {
            alert("年龄不能为空");
            return false;
        }
        else if(register_category == "") {
            alert("挂号类别不能为空");
            return false;
        }
        else if(medical_category == "") {
            alert("医疗类别不能为空");
            return false;
        }
        else if(id_card_no == "") {
            alert("身份证号不能为空");
            return false;
        }
        else if(departmentId == "") {
            alert("科室不能为空");
            return false;
        }
        else if(doctorId == "") {
            alert("医生不能为空");
            return false;
        }
        else if(register_source == "") {
            alert("挂号来源不能为空");
            return false;
        }
        else if(settle_category == "") {
            alert("结算类别不能为空");
            return false;
        }
        else if(money == "") {
            alert("结算金额不能为空");
            return false;
        }
    }
    
    function refresh() {
        window.location.reload();
        //layui.table.reload('registerTable',{page: {curr: 1}});
    }
</script>

<script>
    layui.config({
        base: 'department/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index'], function () {
        var $ = layui.$,
            admin = layui.admin,
            element = layui.element,
            router = layui.router();

        element.render();

        $('#LAY-component-layer-special-demo .layadmin-layer-demo .layui-btn').on('click', function () {
            var othis = $(this),
                method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    })
        .use(['index'], function () {
            var $ = layui.$,
                admin = layui.admin,
                element = layui.element,
                router = layui.router();

            element.render();

            element.on('tab(component-tabs-brief)', function (obj) {
                // layer.msg(obj.index + '：' + this.innerHTML);
            });

            /* 触发事件 */
            var active = {
                tabAdd: function () {
                    /* 新增一个Tab项 */
                    element.tabAdd('demo', {
                        title: '新选项' + (Math.random() * 1000 | 0) /* 用于演示 */ ,
                        content: '内容' + (Math.random() * 1000 | 0),
                        id: new Date().getTime() /* 实际使用一般是规定好的id，这里以时间戳模拟下 */
                    })
                },
                tabDelete: function (othis) {
                    /* 删除指定Tab项 */
                    element.tabDelete('demo', '22');
                    othis.addClass('layui-btn-disabled');
                },
                tabChange: function () {
                    /* 切换到指定Tab项 */
                    element.tabChange('demo', '33');
                }
            };

            $('#component-tabs .site-demo-active').on('click', function () {
                var othis = $(this),
                    type = othis.data('type');
                active[type] ? active[type].call(this, othis) : '';
            });

            /* Hash地址的定位 */
            var layid = router.hash.replace(/^#layid=/, '');
            layid && element.tabChange('component-tabs-hash', layid);

            element.on('tab(component-tabs-hash)', function (elem) {
                location.hash = '/' + layui.router().path.join('/') + '#layid=' + $(this).attr('lay-id');
            });
        }).use(['index', 'upload'], function () {
        var $ = layui.jquery,
            upload = layui.upload;


        // //拖拽上传
        // upload.render({
        //     elem: '#test-upload-drag',
        //     url: '/upload/',
        //     done: function (res) {
        //         console.log(res)
        //     }
        // });
        //
        //
        // //绑定原始文件域
        // upload.render({
        //     elem: '#test-upload-primary',
        //     url: '/upload/',
        //     done: function (res) {
        //         console.log(res)
        //     }
        // });

    }).use(['index', 'laydate'], function(){
        var laydate = layui.laydate;

        //示例代码

        //开始日期
        var insStart = laydate.render({
            elem: '#test-laydate-start'
            ,min: 0
            ,done: function(value, date){
                //更新结束日期的最小日期
                insEnd.config.min = lay.extend({}, date, {
                    month: date.month - 1
                });

                //自动弹出结束日期的选择器
                insEnd.config.elem[0].focus();
            }
        });

        //结束日期
        var insEnd = laydate.render({
            elem: '#test-laydate-end'
            ,min: 0
            ,done: function(value, date){
                //更新开始日期的最大日期
                insStart.config.max = lay.extend({}, date, {
                    month: date.month - 1
                });
            }
        });
    });
</script>

<!-- 选择输入框 -->
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
            // layer.msg(JSON.stringify(data.field));
            return false;
        });
    });
</script>
<script>
    layui.config({
        base: 'department/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'laydate'], function(){
        var laydate = layui.laydate;


        //常规用法
        laydate.render({
            elem: '#test-laydate-normal-cn'
        });

        //国际版
        laydate.render({
            elem: '#test-laydate-normal-en'
            ,lang: 'en'
        });

        //年选择器
        laydate.render({
            elem: '#test-laydate-type-year'
            ,type: 'year'
        });

        //年月选择器
        laydate.render({
            elem: '#test-laydate-type-month'
            ,type: 'month'
        });

        //日期选择器
        laydate.render({
            elem: '#test-laydate-type-date'
            //,type: 'date' //type 默认为 date，所以可不填
        });

        //时间选择器
        laydate.render({
            elem: '#test-laydate-type-time'
            ,type: 'time'
        });

        //日期时间选择器
        laydate.render({
            elem: '#test-laydate-type-datetime'
            ,type: 'datetime'
        });

        //日期范围
        laydate.render({
            elem: '#test-laydate-range-date'
            ,range: true
        });

        //年范围
        laydate.render({
            elem: '#test-laydate-range-year'
            ,type: 'year'
            ,range: true
        });

        //年月范围
        laydate.render({
            elem: '#test-laydate-range-month'
            ,type: 'month'
            ,range: true
        });

        //时间范围
        laydate.render({
            elem: '#test-laydate-range-time'
            ,type: 'time'
            ,range: true
        });

        //日期时间范围
        laydate.render({
            elem: '#test-laydate-range-datetime'
            ,type: 'datetime'
            ,range: true
        });

        //自定义格式
        laydate.render({
            elem: '#test-laydate-format-date1'
            ,format: 'yyyy年MM月dd日'
        });
        laydate.render({
            elem: '#test-laydate-format-date2'
            ,format: 'dd/MM/yyyy'
        });
        laydate.render({
            elem: '#test-laydate-format-month'
            ,type: 'month'
            ,format: 'yyyyMM'
        });
        laydate.render({
            elem: '#test-laydate-format-time'
            ,type: 'time'
            ,format: 'H点m分'
        });
        laydate.render({
            elem: '#test-laydate-format-range1'
            ,range: '~'
        });
        laydate.render({
            elem: '#test-laydate-format-range2'
            ,type: 'datetime'
            ,range: '到'
            ,format: 'yyyy年M月d日H时m分s秒'
        });

        //同时绑定多个
        lay('.test-laydate-item').each(function(){
            laydate.render({
                elem: this
                ,trigger: 'click'
            });
        });

    });
</script>


<!-- 开启头部工具栏 -->
<script>
    layui.config({
        base: 'department/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table'], function(){
        var table = layui.table;

        table.render({
            elem: '#test-table-toolbar'
            ,id: 'test-table-toolbar'
            ,url: 'register/list'
            ,title: '挂号数据表'
            ,toolbar: '#test-table-toolbar-toolbarDemo'
            ,method: 'get'
            ,parseData: function (res) {
                return {
                    "code":res.status,
                    "msg":res.message,
                    "count":res.total,
                    "data":res.data
                }
            }
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{
                    field: 'medical_record_no',
                    title: '病历号',
                    width: 200,
                    sort: true,
                    fixed: true
                }, {
                    field: 'status',
                    title: '状态',
                    templet:'#test-table-statusTpl',
                    width: 80
                }, {
                    field: 'patient_name',
                    title: '姓名',
                    width: 80
                }, {
                    field: 'gender',
                    title: '性别',
                    width: 80
                }, {
                    field: 'age',
                    title: '年龄',
                    width: 80
                }, {
                    field: 'birthday_date',
                    title: '出生日期',
                    width: 150
                }, {
                    field: 'identity_card_no',
                    title: '身份证号',
                    width: 300
                }, {
                    field: 'department_name',
                    title: '科室',
                    width: 70
                }, {
                    field: 'doctor_name',
                    title: '医生',
                    width: 70
                }, {
                    field: 'settle_accounts_category',
                    title: '结算类别',
                    width: 80
                }, {
                    field: 'registration_category',
                    title: '挂号类别',
                    width: 80
                }, {
                    field: 'date',
                    title: '挂号日期',
                    width: 150
                }, {
                    field: 'is_seen_doctor',
                    title: '是否已诊',
                    width: 80
                }, {
                    field: 'expense',
                    title: '实收费用',
                    width: 80
                }
            ]]
            ,page: true
        });

        var $ = layui.$, active = {
            reload: function(){
                var keyword = $('#search_text');
                //var keyword = document.getElementById("search_text").value.toUpperCase();

                //执行重载
                table.reload('test-table-toolbar', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        key: {
                            patient_name: keyword.val()
                        }
                    }
                });
            }
        };

        $('.layui-row .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>

<body onload="getDate();getRegisterNo();doctor();department()">

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="layui-row">
                        <div class="layui-col-xs6 layui-col-sm6 layui-col-md9"><lable>挂号</lable></div>



                    </div>

                </div>

                <!-- 表单 -->
                <div class="layui-card-body">
                    <form class="layui-form" method="post" lay-filter="component-form-element">
                    <div class="layui-form-item" style="float: right;">
                        <div class="layui-input-block">
                            <button class="layui-btn" onclick="addRegister()" >挂号</button>
                                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>

                    <div class="test-table-reload-btn" style="margin-bottom: 10px;">
                        <div>

                            <div class="layui-row" style="height: 50px;">

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">病历号：</div>

                                    <input type="text" id="number" name="title" placeholder="请输入病历号" autocomplete="off" class="layui-input"style="float: right;width: 70%;" readonly="readonly">
                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">姓名：</div>

                                    <input type="text" id="patient_name" name="title" placeholder="请输入患者姓名" autocomplete="off" class="layui-input"style="float: right;width: 70%;">
                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">性别：</div>

                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="float: right;width: 70%;">
                                        <select name="week" id="patient_gender" lay-verify="required" lay-search>
                                            <option value="">请选择性别</option>
                                            <option value="1">男</option>
                                            <option value="2">女</option>
                                        </select>
                                    </div>

                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left; width: 30%">年龄：</div>

                                    <div class="layui-input-inline" style="float: right;width: 70%;">
                                        <input type="text" id="age" name="title" placeholder="年龄" autocomplete="off" class="layui-input" style="width: 50%;float: left;">
                                        <div class="layui-card layui-form" lay-filter="component-form-element" style="width: 50%;float: right;">
                                            <select name="week" lay-verify="required" lay-search>

                                                <option value="01">岁</option>
                                                <option value="02">月</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>


                            </div>

                            <div class="layui-row" style="height: 50px;">

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">出生日期：</div>

                                    <div class="layui-inline" style="float: right;width: 70%;">
                                        <!-- <label class="layui-form-label">日期选择器</label> -->
                                        <div class="layui-input-inline" style="width: 100%">
                                            <input type="text" class="layui-input" placeholder="请选择出生日期" id="test-laydate-type-date" autocomplete="off" placeholder="yyyy-MM-dd">
                                        </div>
                                    </div>

                                </div>


                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">家庭住址：</div>

                                    <input type="text" id="address" name="title" placeholder="请输入家庭住址" autocomplete="off" class="layui-input"style="float: right;width: 70%;">
                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">身份证号：</div>

                                    <input type="text" id="id_card_no" name="title" placeholder="请输入身份证号" autocomplete="off" class="layui-input"style="float: right;width: 70%;">
                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">结算类别：</div>

                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="float: right;width: 70%;">
                                        <select name="week" id="settle_category" lay-verify="required" lay-search>
                                            <option value="">请选择结算类别</option>
                                            <option value="01">自费</option>
                                            <option value="02">医保</option>
                                        </select>
                                    </div>

                                </div>

                            </div>

                            <div class="layui-row" style="height: 50px;">

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">挂号日期：</div>

                                    <input type="text" id="register_date" name="title" readonly="true" autocomplete="off" class="layui-input"style="float: right;width: 70%;">
                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">医疗类别：</div>

                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="float: right;width: 70%;">
                                        <select name="week" id="medical_category" lay-verify="required" lay-search>
                                            <option value="">请选择医疗类别</option>
                                            <option value="01">自付</option>
                                            <option value="02">城镇职工</option>
                                            <option value="03">城镇居民</option>
                                            <option value="04">新农合</option>
                                        </select>
                                    </div>

                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">挂号科室：</div>
                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="width: 70%;float: right;">
                                        <select class="form-control" id="departmentId" name="departmentId" lay-verify="required" lay-search>
                                            <option value="">请选择科室</option>
                                            <c:forEach items="${departmentList}" var="department">
                                                <option value="${department.id}">${department.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">看诊医生：</div>
                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="width: 70%;float: right;">
                                        <select class="form-control" id="doctorId" name="doctorId" lay-verify="required" lay-search>
                                            <option value="">请选择看诊医生</option>
                                            <c:forEach items="${doctorlist}" var="doctor">
                                                <option value="${doctor.id}">${doctor.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                            </div>

                            <div class="layui-row" style="height: 40px;margin-bottom: 0px;">

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">挂号来源：</div>

                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="float: right;width: 70%;">
                                        <select name="week" id="register_source" lay-verify="required" lay-search>
                                            <option value="">请选择挂号来源</option>
                                            <option value="01">医院挂号</option>
                                            <option value="02">预约挂号</option>
                                        </select>
                                    </div>

                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">病历本：</div>

                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="float: right;width: 70%;height: 40px;">
                                        <div class="layui-form-item">
                                            <div class="layui-input-block">
                                                <input type="checkbox" name="marriage" lay-skin="switch" lay-text="有|无">
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >

                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">结算金额：</div>

                                    <input type="number" id="money" name="title" placeholder="请输入结算金额" autocomplete="off" class="layui-input"style="float: right;width: 70%;">


                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" >
                                    <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;">挂号类别：</div>

                                    <div class="layui-card layui-form" lay-filter="component-form-element" style="float: right;width: 70%;">
                                        <select name="week" id="register_category" lay-verify="required" lay-search>
                                            <option value="">请选择挂号类别</option>
                                            <option value="01">普通</option>
                                            <option value="02">专家</option>
                                            <option value="03">急诊</option>
                                        </select>
                                    </div>

                                </div>
                                <input style="display: none" id="status" value="01">
                                <input style="display: none" id="see_doctor" value="01">

                            </div>
                        </div>

<%--                        <div class="layui-row">--%>

<%--                            <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">--%>
<%--                                <div  style="text-align: right;margin-top: 5px;float: left;width: 30%;"> </div>--%>

<%--                                <input type="text" name="title" placeholder="请输入XXX" autocomplete="off" class="layui-input"style="float: right;width: 70%;" style="float: left;">--%>
<%--                            </div>--%>
<%--                            <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">--%>
<%--                                <div class="layui-btn-container">--%>
<%--                                    <button class="layui-btn layui-btn-sm" lay-event="" style="margin-top: 5px;margin-left: 10px;">搜索</button>--%>
<%--                                    <button class="layui-btn layui-btn-sm" onclick="back()" lay-event="" style="margin-top: 5px;margin-left: 10px;">退号</button>--%>

<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>


                        <!-- 表格 -->
                        <div class="layui-fluid" style="margin-top: 0px">
                            <div class="layui-row layui-col-space15">
                                <div class="layui-col-md12">
                                    <div class="layui-card">

                                        <div class="layui-card-body">
                                            <table class="layui-hide" id="test-table-toolbar" lay-filter="test-table-toolbar"></table>

                                            <script type="text/html" id="test-table-statusTpl">
                                                {{#  if(d.status === '已退号' || d.status === '无效'){ }}
                                                  <span style="color: #FF0000;">{{ d.status }}</span>
                                                {{#  } else if(d.status === '正常') { }}
                                                    <span style="color: #05F936;">{{ d.status }}</span>

                                                {{#  } }}
                                              </script>


                                            <script type="text/html" id="test-table-toolbar-toolbarDemo">

                                                <div class="layui-row">


                                                      <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
                                                        <div style="text-align: right;margin-top: 5px;float: left;width: 30%;"> </div>
                                                        <input type="text" id="search_text" name="title" placeholder="请输入搜索内容" autocomplete="off" class="layui-input" style="float: right;width: 70%;" style="float: left;">
                                                      </div>
                                                      <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
                                                        <div class="layui-btn-container">
                                                          <button class="layui-btn layui-btn-sm" data-type="reload" id="search" lay-event="" style="margin-top: 5px;margin-left: 10px;">搜索</button>
                                                          <button class="layui-btn layui-btn-sm" onclick="back()" style="margin-top: 5px;margin-left: 10px;">退号</button>
                                                            <button class="layui-btn layui-btn-sm" onclick="refresh()" style="margin-top: 5px;margin-left: 10px;">刷新</button>
                                                        </div>
                                                      </div>

                                                </div>
                                            </script>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    </form>
                </div>
            </div>
        </div>
            </div>



        </div>
    </div>
</div>
</div>



</div>
</div>
</div>
</div>
</div>

</body>
</html>
