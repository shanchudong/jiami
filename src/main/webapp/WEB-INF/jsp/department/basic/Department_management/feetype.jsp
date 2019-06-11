<%--
  Created by IntelliJ IDEA.
  User: Luo Shijie
  Date: 2019/6/5
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
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
    <title>${name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="department/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="department/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">${name}</div>
                <div class="layui-card-body">
                    <div class="test-table-reload-btn" style="margin-bottom: 10px;">


                        <%--              <!-- 添加弹窗控件 -->--%>

                        <div class="layui-fluid" id="LAY-component-layer-special-demo">
                            <div class="layui-row">

                                <div class="demoTable">
                                    搜索ID：
                                    <div class="layui-inline">
                                        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
                                    </div>
                                    <button class="layui-btn" data-type="reload">搜索</button>
                                </div>

                                <div class="layui-col-xs6 layui-col-sm6 layui-col-md4" style="float: left;">

                                    <div class="layui-btn-container layadmin-layer-demo">
                                        <%--                  <button class="layui-btn" data-type="reload" style="margin: 10px;">搜索</button>--%>
                                        <button data-method="addTop" data-type="auto" class="layui-btn"
                                                style="margin: 10px;">添加
                                        </button>
                                        <button data-method="edit" data-type="auto" class="layui-btn"
                                                style="margin: 10px;">编辑
                                        </button>
                                        <!-- 删除部分还没有填充函数 ************************************************************************-->
                                        <button data-method="deltable" datatype="auto" class="layui-btn"
                                                style="margin: 10px;">删除
                                        </button>

                                    </div>
                                </div>
                            </div>

                        </div>


                        <table class="layui-hide" id="test-table-reload" lay-filter="user"></table>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="department/layui/layui.js"></script>
<script>
    layui.config({
        base: 'department/' //静态资源所在路径X
    })
        .extend({
            index: 'lib/index' //主入口模块X
        })
        .use(['index', 'table'], function () {
            var table = layui.table;

            //方法级渲染
            table.render({
                elem: '#test-table-reload'
                // 这部分url你们自己填你们部署的接口********************************************************************************************
                // ,url: layui.setter.base + 'data/table/nei.js'
                , url: 'fee/all'
                , method: 'get'
                , parseData: function (res) {
                    //TODO:解析JSON对象
                    return {
                        "code": res.status,
                        "msg": res.message,
                        "count": res.total,
                        "data": res.data
                    }
                }
                , cols: [[
                    {checkbox: true, fixed: true}
                    , {field: 'feetypeName', title: '结算类别', width: 180, sort: true, fixed: true}
                ]]
                , page: true
            });


            // 搜索函数X
            var $ = layui.$, active = {
                reload: function () {
                    var demoReload = $('#demoReload');

                    //执行重载
                    table.reload('test-table-reload', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            deptid: demoReload.val()
                        }
                    }, 'data');
                }
            };

            $('.test-table-reload-btn .layui-btn').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });


        });


</script>
<script>

    layui.config({
        base: 'department/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index'], function () {
        var $ = layui.$
            , admin = layui.admin
            , element = layui.element
            , router = layui.router();
        element.render();

        var active = {
            // 添加函数***************************************************************************************
            addTop: function (othis) {

                var that = this;
                var type = othis.data('type')
                    , text = othis.text();
                layer.open({
                    type: 1
                    ,
                    title: '添加结算类别'
                    ,
                    area: ['490px', '460px']
                    ,
                    shade: 0
                    ,
                    maxmin: true
                    ,
                    offset: type
                    // id：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="layui-input" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" align="center"><br>
                    // 这个地方不要缩进分行，我查了这个content不能分行orz,id内容你们自己定一个吧****************************************************************
                    //TODO:使用form标签对每个input设定name属性值并与bean属性名一致完成参数绑定
                    ,
                    content: '<form id="add" style="padding: 20px;" role="form">结算类别：<input class="layui-input"  name="feetypeName" autocomplete="off" style="width: 200px;display: inline;margin:10px;"><br></form>'
                    ,
                    btn: ['确定', '关闭']
                    ,
                    yes: function () {
                        $.ajax({
                            type: "POST",
                            url: "fee/add",
                            data: $('#add').serialize(),
                            success: function (res) {
                                if (res.status == 0) {
                                } else {
                                    layer.msg(res.message)
                                }
                                layer.closeAll();
                                parent.layui.table.reload('test-table-reload', {page: {curr: 1}});
                            },
                            error: function () {
                                alert("出现错误");
                                return false;
                            }
                        }) //ajax结束
                    }
                    ,
                    btn2: function () {
                        // 此处要写递交的函数，但是不要把我closall的函数删掉***********************************************************************

                        layer.closeAll();
                    }

                    ,
                    zIndex: layer.zIndex
                    ,
                    success: function (layero) {
                        layer.setTop(layero);
                    }
                });
            }

            // 编辑弹窗
            , edit: function (othis) {
                var tabledata = layui.table.checkStatus('test-table-reload').data;
                var html = '<form id="update" style="padding: 20px;">id：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                    '<input class="layui-input" name="id" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" align="center" value="' + tabledata[0].id + '"><br>' +
                    '结算类别：<input class="layui-input" name="feetypeName"  autocomplete="off" style="width: 200px;display: inline;margin:10px;" value="' + tabledata[0].feetypeName + '">' +
                    '<br></form>';
                var type = othis.data('type')
                    , text = othis.text();

                layer.open({
                    type: 1
                    , offset: type
                    , title: '编辑结算类别'
                    , id: 'layerDemo' + type
                    , area: ['490px', '460px']
                    , content: html            // '<form id="update" style="padding: 20px;">id：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="layui-input" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" align="center" value="'+tabledata[0].id+'"><br>科室编码：<input class="layui-input" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" value="'+tabledata[0].deptcode+'"><br>科室名称：<input class="layui-input" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" value="'+tabledata[0].deptname+'"><br>科室分类：<input class="layui-input" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" value="'+tabledata[0].deptcategoryid+'"><br>科室类型：<input class="layui-input" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" value="'+tabledata[0].depttype+'"><br></form>'
                    , btn: ['确定', '取消']
                    , btnAlign: 'c'
                    , shade: 0
                    , yes: function () {
                        // 写下编辑的提交方法**********************************************************
                        $.ajax({
                            type: "POST",
                            url: "fee/update",
                            data: $('#update').serialize(),
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
                        }) //ajax结束
                        layer.closeAll();
                        $(".layui-laypage-btn")[0].click();
                    }
                    , btn2: function () {
                        layer.closeAll();
                    }
                });
            }
            , deltable: function (othis) {
                var type = othis.data('type')
                    , text = othis.text();
                var tabledata = layui.table.checkStatus('test-table-reload').data;
                var html = '<form id="delete" style="padding: 20px;">id：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="layui-input" name="feetypeName" id="" autocomplete="off" style="width: 200px;display: inline;margin:10px;" align="center" readonly="readonly" value="' + tabledata[0].id + '"><br>结算类别：<input class="layui-input" name="deptcode"  autocomplete="off" style="width: 200px;display: inline;margin:10px;" readonly="readonly" value="' + tabledata[0].feetypeName+ '"><br></form>';
                var table = "<div style='text-align: center;'> <table border='1px' style='margin: auto' cellspacing='10px' cellpadding='10px'><th>ID</th><th>类别名称</th>"
                for (var i = 0; i < tabledata.length; i++) {
                    table += "<tr><td>" + tabledata[i].id + "</td><td>" + tabledata[i].feetypeName+"</td></tr>";
                }
                table += "</table> </div>";

                var myArray = new Array();
                for (var i = 0; i < tabledata.length; i++) {
                    // myArray[i]=tabledata[i].id;
                    myArray.push(tabledata[i].id);
                }


                layer.open({
                    type: 1
                    , offset: type
                    , title: '删除结算类别'
                    , id: 'layerDemo' + type
                    , area: ['490px', '460px']
                    , content: table
                    , btn: ['确定', '取消']
                    , btnAlign: 'c'
                    , shade: 0
                    , yes: function () {

                        $.ajax({
                            type: "POST",
                            url: "fee/delete",
                            traditional: true,
                            data: {'ids': myArray},
                            success: function (res) {
                                if (res.status == 0) {
                                    layer.msg(res.message);
                                } else {
                                    layer.msg(res.message);
                                }
                                layer.closeAll();
                            },
                            error: function () {
                                alert("出现错误");
                                return false;
                            }
                        })

                        // 此处填充方法
                        layer.closeAll();
                        parent.layui.table.reload('test-table-reload', {page: {curr: 1}});
                    }
                    , btn2: function () {
                        layer.closeAll();
                    }

                })

            }
        };

        $('#LAY-component-layer-special-demo .layadmin-layer-demo .layui-btn').on('click', function () {
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
    }).use(['index', 'upload'], function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //绑定原始文件域
        upload.render({
            elem: '#test-upload-primary'
            , url: '/upload/'
            , done: function (res) {
                console.log(res)
            }
        });

    });
</script>
</body>
</html>