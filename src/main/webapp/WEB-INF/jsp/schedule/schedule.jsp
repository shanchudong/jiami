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
        base: 'department/' //静态资源所在路径X
    })
        .extend({
            index: 'lib/index' //主入口模块X
        })
        .use(['index', 'table'], function(){
            var table = layui.table;

            //方法级渲染
            table.render({
                elem: '#test-table-reload1'
                // 这部分url你们自己填你们部署的接口********************************************************************************************
                ,url: 'schedule/list'
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
                    {checkbox: true, fixed: true}
                    ,{field:'id', title: '编号', width:100, sort: true, fixed: true}
                    ,{field:'doctor_id', title: '医生编号', width:140, sort: true}
                    ,{field:'week_time', title: '时间', width:100, sort: true}
                    ,{field:'department_name', title: '科室名称', width:140, sort: true}
                    ,{field:'doctor_name', title: '医生姓名', width:140}
                    ,{field:'register_level', title: '号别', width:100}
                    ,{field:'noon_level', title: '午别', width:100}
                    ,{field:'limit_num', title: '排班限额', width:140}
                    ,{field:'date', title: '操作日期'}

                ]]
                ,page: true
                ,height: 315
            });

            table.render({
                elem: '#test-table-reload2',
                // 这部分url你们自己填你们部署的接口********************************************************************************************
                url: 'schedule/schedulelist',
                method: 'get',
                parseData: function (res) {
                return {
                    "code": res.status,
                    "msg": res.message,
                    "count": res.total,
                    "data": res.data
                }
            }
                ,cols: [
                    [{
                        checkbox: true,
                        fixed: true
                    }, {
                        field: 'id',
                        title: '编号',
                        width: 100,
                        sort: true,
                        fixed: true
                    }, {
                        field: 'date',
                        title: '日期',
                        width: 180,
                        fixed: true
                    },{
                        field: 'doctor_id',
                        title: '医生编号',
                        width: 140
                    }, {
                        field: 'department_name',
                        title: '科室名称',
                        width: 180,
                        sort: true
                    }, {
                        field: 'doctor_name',
                        title: '医生姓名',
                        width: 140
                    }, {
                        field: 'register_level',
                        title: '号别',
                        width: 100
                    }, {
                        field: 'noon_level',
                        title: '午别',
                        width: 100
                    }, {
                        field: 'limit_num',
                        title: '排班限额'
                    }
                    ]
                ],
                page: true,
                height: 315
            });



            var $ = layui.$, active = {
                reload: function(){
                    var demoReload = $('#test-table-demoReload');

                    //执行重载
                    table.reload('test-table-reload1', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            key: {
                                id: demoReload.val()
                            }
                        }
                    });
                }
            };

            var $ = layui.$, active = {
                reload: function(){
                    var demoReload = $('#test-table-demoReload');

                    //执行重载
                    table.reload('test-table-reload2', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            key: {
                                id: demoReload.val()
                            }
                        }
                    });
                }
            };

            $('.test-table-reload-btn .layui-btn').on('click', function(){
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        });


</script>

<script>
    function getDoctorId() {
        var tabledata = layui.table.checkStatus('test-table-reload1').data;
        var num = tabledata[0].doctor_id;
        return num;
    }
</script>

<script>
    function create() {
        $.ajax({
            type: "post",
            url: "schedule/createSchedule",
            data: {
                "startDate": $("#test-laydate-start").val(),
                "endDate": $("#test-laydate-end").val(),
            },
            dataType: "JSON",
            async: false,

            beforeSend: function () {
                $("#submit").attr({ disabled: "disabled" });
            },
            success: function (data) {
                if(data == 1) {
                    alert("生成成功");
                    layui.table.reload('test-table-reload2',{page: {curr: 1}});
                }
                else
                    alert("生成失败");
            },
            error: function () {
                alert("提交失败");
            }
        });
    }
    
    function find() {
        $.ajax({
            type: "post",
            url: "schedule/find",
            data: {
                "keyword": $("#test-table-demoReload").val(),
            },
            dataType: "JSON",
            async: false,

            beforeSend: function () {
                $("#submit").attr({ disabled: "disabled" });
            },
            success: function () {

            },
            error: function () {
                alert("error");
            }
        });
    }

    function refresh() {
        window.location.reload();
    }
</script>

<script>
    layui.config({
        base: 'department/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index'], function(){
        var $ = layui.$
            ,admin = layui.admin
            ,element = layui.element
            ,router = layui.router();

        element.render();

        var active = {

            // 添加函数***************************************************************************************
            addTop: function(othis){
                var that = this;
                var type = othis.data('type')
                    ,text = othis.text();

                layer.open({
                    type: 1
                    ,title: '排班添加'
                    ,area: ['490px', '500px']
                    ,shade: 0
                    ,maxmin: true
                    ,offset: type
                    // 这个地方不要缩进分行，我查了这个content不能分行orz,id内容你们自己定一个吧****************************************************************
                    ,content: '<iframe src="schedule/addUI" frameborder="0" id="addSchedule" name="addSchedule" class="layadmin-iframe"></iframe>'
                    ,btn: ['继续添加','全部确定']
                    ,yes: function(){
                        var flag = document.getElementById("addSchedule").contentWindow.addControll();
                        if(flag == false)
                            return;

                        var doctorId = window.frames["addSchedule"].document.getElementById('doctorId').value;
                        var weekTime = window.frames["addSchedule"].document.getElementById('weekTime').value;
                        var registerLevel = window.frames["addSchedule"].document.getElementById('registerLevel').value;
                        var noonLevel = window.frames["addSchedule"].document.getElementById('noonLevel').value;
                        var limitNum = window.frames["addSchedule"].document.getElementById('limitNum').value;

                        $.ajax({
                            type: "post",
                            url: "schedule/add",
                            data: {
                                "doctor_id": doctorId,
                                "week_time": weekTime,
                                "register_level": registerLevel,
                                "noon_level": noonLevel,
                                "limit_num": limitNum,
                            },
                            dataType: "JSON",
                            async: false,
                            beforeSend: function () {

                            },
                            success: function (data) {
                                if(data == 1) {
                                    alert("添加成功");
                                }
                                else
                                    alert("添加失败");
                            },
                            error: function () {
                                alert("提交失败");
                            }
                        });
                        layui.table.reload('test-table-reload1',{page: {curr: 1}});
                    }
                    ,btn2: function(){
                        // 此处要写递交的函数，但是不要把我closall的函数删掉***********************************************************************
                        layer.closeAll();
                        //layui.table.reload('test-table-reload1',{page: {curr: 1}});
                    }

                    ,zIndex: layer.zIndex
                    ,success: function(layero){
                        layer.setTop(layero);
                    }
                });
            }

            // 编辑弹窗
            ,edit: function(othis){
                var type = othis.data('type')
                    ,text = othis.text();
                var tabledata = layui.table.checkStatus('test-table-reload1').data;
                var myArray = new Array();
                for(var i = 0; i < tabledata.length; i++){
                    myArray.push(tabledata[i].id);
                }
                if(myArray.length > 1) {
                    alert("一次只能修改一条规则！");
                    return;
                }
                else if(myArray.length < 1) {
                    alert("请选择一条规则编辑！");
                    return;
                }

                layer.open({
                    type: 1
                    ,offset: type
                    ,title: '排班编辑'
                    ,id: 'layerDemo'+type
                    ,area: ['490px', '460px']
                    ,content: '<iframe src="schedule/editUI" frameborder="0" id="editSchedule" name="editSchedule" class="layadmin-iframe"></iframe>'
                    ,btn:['确定','取消']
                    ,maxmin: true
                    ,btnAlign: 'c'
                    ,shade: 0
                    ,yes: function(){
                        var flag = document.getElementById("editSchedule").contentWindow.editControll();
                        if(flag == false)
                            return;

                        var doctorId = window.frames["editSchedule"].document.getElementById('doctorId').value;
                        var weekTime = window.frames["editSchedule"].document.getElementById('weekTime').value;
                        var registerLevel = window.frames["editSchedule"].document.getElementById('registerLevel').value;
                        var noonLevel = window.frames["editSchedule"].document.getElementById('noonLevel').value;
                        var limitNum = window.frames["editSchedule"].document.getElementById('limitNum').value;
                        $.ajax({
                            type: "post",
                            url: "schedule/update",
                            data: {
                                "id": tabledata[0].id,
                                "doctor_id": doctorId,
                                "week_time": weekTime,
                                "register_level": registerLevel,
                                "noon_level": noonLevel,
                                "limit_num": limitNum,
                            },
                            dataType: "JSON",
                            async: false,
                            beforeSend: function () {

                            },
                            success: function (data) {
                                if(data == 1) {
                                    alert("修改成功");
                                }

                                else
                                    alert("修改失败");
                            },
                            error: function () {
                                alert("提交失败");
                            }
                        });
                        layui.table.reload('test-table-reload1',{page: {curr: 1}});
                        layer.closeAll();
                    }
                    ,btn2:function(){
                        layer.closeAll();
                    }
                });
            }

            ,deltable: function(othis){
                var type = othis.data('type')
                    ,text = othis.text();
                var tabledata = layui.table.checkStatus('test-table-reload1').data;
                if(myArray.length < 1) {
                    alert("请选择规则删除");
                    return;
                }
                var myArray = new Array();
                for(var i = 0; i < tabledata.length; i++){
                    myArray.push(tabledata[i].id);
                }


                layer.open({
                    type: 1
                    ,offset: type
                    ,title: '排班删除'
                    ,id: 'layerDemo'+type
                    ,area: ['190px', '160px']
                    ,content: '<iframe src="schedule/delUI" frameborder="0" class="layadmin-iframe"></iframe>'
                    ,btn:['确定','取消']
                    ,btnAlign: 'c'
                    ,shade: 0
                    ,yes: function(){
                        $.ajax({
                            type: "POST",
                            url: "schedule/delete",
                            traditional: true,
                            data:{'id': myArray},
                            success: function (res) {
                                if (res.status == 0) {
                                } else {
                                    layer.msg(res.message)
                                }
                                layer.closeAll();
                            },
                            error: function () {
                                alert("出现错误");
                                return false;
                            }
                        });
                        layui.table.reload('test-table-reload1',{page: {curr: 1}});
                        layer.closeAll();
                    }
                    ,btn2:function(){
                        layer.closeAll();
                    }
                });
            }
        };

        $('#LAY-component-layer-special-demo .layadmin-layer-demo .layui-btn').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    });
</script>

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

<!-- 选项卡的模块加载 -->
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

        element.on('tab(component-tabs-brief)', function (obj) {
            layer.msg(obj.index + '：' + this.innerHTML);
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
    });
</script>

<!-- 日历模块加载 -->
<script>
    layui.config({
        base: 'department/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
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

<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">排班管理</div>

                <!-- 选项卡 -->
                <div class="layui-card">
                    <div class="layui-card-body">
                        <div class="layui-tab layui-tab-brief" lay-filter="component-tabs-brief">
                            <ul class="layui-tab-title">
                                <li class="layui-this">医生排班规则维护</li>
                                <li >医生排班信息</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <!-- 选项1的内容 -->
                                    <!-- 按钮部分 -->
                                    <div class="layui-card-body">

                                        <div class="test-table-reload-btn" style="margin-bottom: 10px;">


                                            <!-- 添加弹窗控件 -->
                                            <div class="layui-fluid" id="LAY-component-layer-special-demo">
                                                <div class="layui-row">
                                                    <div class="layui-col-xs6 layui-col-sm4 layui-col-md2">
<%--                                                        <div style="width: 60%;float: left;">--%>
<%--                                                        <input class="layui-input" name="id" id="test-table-demoReload" placeholder="请输入医生姓名"--%>
<%--                                                               style="width: 120px;display: inline;margin:10px;"></div>--%>
<%--                                                        <div style="width: 40%;float: right;">--%>
<%--&lt;%&ndash;                                                            <button class="layui-btn" data-type="reload" style="margin: 10px;">搜索</button>&ndash;%&gt;--%>
<%--                                                            <input class="layui-btn" type="button" value="搜索" data-type="reload" style="margin: 10px;">--%>
<%--                                                        </div>--%>

                                                    </div>


                                                    <div class="layui-col-xs6 layui-col-sm8 layui-col-md4" style="float: left;">




                                                        <div class="layui-btn-container layadmin-layer-demo">

<%--                                                            <button data-method="addTop" data-type="auto" class="layui-btn" style="margin: 10px;">添加</button>--%>
                                                            <input type="button" value="添加" data-method="addTop" data-type="auto" class="layui-btn" style="margin: 10px;">
<%--                                                            <button data-method="edit" data-type="auto" class="layui-btn" style="margin: 10px;">编辑</button>--%>
                                                            <input type="button" value="编辑" data-method="edit" data-type="auto" class="layui-btn" style="margin: 10px;">
                                                            <!-- 删除部分还没有填充函数 ************************************************************************-->
<%--                                                            <button data-method="deltable" datatype="auto" class="layui-btn" style="margin: 10px;">删除</button>--%>
                                                            <input type="button" value="删除" data-method="deltable" data-type="auto" class="layui-btn" style="margin: 10px;">
                                                            <!--   <button data-method="upload" data-type="auto" class="layui-btn" style="margin: 10px;"> 导入</button> -->
                                                            <input type="button" value="刷新"  class="layui-btn" style="margin: 10px;" onclick="refresh()">


                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                            <!-- 表格 -->
                                            <table class="layui-hide" id="test-table-reload1" lay-filter="user"></table>

                                        </div>
                                    </div>
                                </div>

                                <div class="layui-tab-item">
                                    <!-- 标签2中内容部分 -->

                                    <!-- 日期选择框 -->
                                    <div class="layui-fluid">
                                        <div class="layui-row layui-col-space15">
                                            <div class="layui-col-md12">
                                                <div class="layui-card">
                                                    <div class="layui-card-header">请选择生成排班表时间区间</div>
                                                    <div class="layui-card-body" pad15>
                                                        <div class="layui-form" wid100>
                                                            <div class="layui-form-item">
                                                                <form method="post">
                                                                    <div class="layui-inline">
                                                                        <label class="layui-form-label">日期</label>
                                                                        <div class="layui-input-inline">
                                                                            <input type="text" class="layui-input" id="test-laydate-start" autocomplete="off" placeholder="开始日期">
                                                                        </div>
                                                                        <div class="layui-form-mid">
                                                                            -
                                                                        </div>
                                                                        <div class="layui-input-inline">
                                                                            <input type="text" class="layui-input" id="test-laydate-end" autocomplete="off" placeholder="结束日期">
                                                                        </div>

                                                                        <input type="button" value="生成" class="layui-btn" id="chaxun" style="margin:auto;" onClick="create()"/>

                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 表格 -->
                                    <table class="layui-hide" id="test-table-reload2" lay-filter="user"></table>
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
