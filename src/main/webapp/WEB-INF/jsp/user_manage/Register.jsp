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
  <title>${name}管理</title>
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
          <div class="layui-card-header">${name}管理</div>

          <!-- 选项卡 -->

                    <!-- 按钮部分 -->
                    <div class="layui-card-body">

                      <div class="test-table-reload-btn" style="margin-bottom: 10px;">


                        <!-- 添加弹窗控件 -->
                        <div class="layui-fluid" id="LAY-component-layer-special-demo">
                          <div class="layui-row">

                            <div class="demoTable">
                              搜索登录名或真实姓名：
                              <div class="layui-inline">
                                <input class="layui-input" name="id" id="demoReload" autocomplete="off">
                              </div>
                              <button class="layui-btn" data-type="reload">搜索</button>
                            </div>

                            <div class="layui-col-xs6 layui-col-sm8 layui-col-md4" style="float: left;">




                              <div class="layui-btn-container layadmin-layer-demo">

                                <button data-method="addTop" data-type="auto" class="layui-btn"
                                  style="margin: 10px;">添加</button>
                                <button data-method="edit" data-type="auto" class="layui-btn"
                                  style="margin: 10px;">编辑</button>
                                <button data-method="deltable" datatype="auto" class="layui-btn"
                                  style="margin: 10px;">删除</button>


                              </div>
                            </div>


                          </div>
                        </div>
                        <!-- 表格 -->
                        <table class="layui-hide" id="test-table-reload" lay-filter="user"></table>
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
            ,
          url:  'user/findall?id=${id}'
          ,method:'get'
          ,parseData:function (res) {
            //TODO:解析JSON对象
            return {
              "code":res.status,
              "msg":res.message,
              "count":res.total,
              "data":res.data
            }
          }
          ,cols: [
            [{
                checkbox: true,
                fixed: true
              }, {
                field: 'login_name',
                title: '用户名',
                width: 180,
                sort: true,
                fixed: true
              }, {
                field: 'password',
                title: '密码',
                width: 180
              }, {
                field: 'real_name',
                title: '真实姓名',
                width: 180,
                sort: true
              }, {
                field: 'deptid',
                title: '所在科室',
                width: 180
              }, {
                field: 'category',
                title: '用户类别',
                width: 180
              }
            ]
          ],
          page: true,
          height: 315
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
                login_name: demoReload.val(),
                real_name: demoReload.val()
              }
            },'data');
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
      var $ = layui.$,
        admin = layui.admin,
        element = layui.element,
        router = layui.router();

      element.render();

      var active = {

        // 添加函数***************************************************************************************
        addTop: function (othis) {
            var that = this;
            var type = othis.data('type'),
              text = othis.text();

            layer.open({
              type: 1,
              title: '${name}添加',
              area: ['490px', '400px'],
              shade: 0,
              maxmin: true,
              offset: type
                // 这个地方不要缩进分行，我查了这个content不能分行orz,id内容你们自己定一个吧****************************************************************
                ,
              content: '<iframe src="user/addUI1?id=${id}&name=${name}" frameborder="0" class="layadmin-iframe"></iframe>',
              btn: ['确定', '关闭'],
              yes: function (index,layero) {
                var iframes = $(layero).find("iframe")[0].contentWindow;
                var form = iframes.document.getElementById("add");
                $.ajax({
                  type: "POST",
                  url: "user/add",
                  data: $(form).serialize(),
                  success: function (res) {
                    if (res.status == 0) {
                    } else {
                      layer.msg(res.message)
                    }
                    layer.closeAll();
                    parent.layui.table.reload('test-table-reload',{page: {curr: 1}});
                  },
                  error: function () {
                    alert("出现错误");
                    return false;
                  }
                }) //ajax结束
              },
              btn2: function () {
                  // 此处要写递交的函数，但是不要把我closall的函数删掉***********************************************************************

                  layer.closeAll();
                }

                ,
              zIndex: layer.zIndex,
              success: function (layero) {
                layer.setTop(layero);
              }
            });
          }

          // 编辑弹窗
          ,
        edit: function (othis) {
            var type = othis.data('type'),
              text = othis.text();

            layer.open({
              type: 1,
              offset: type,
              title: '${name}编辑',
              id: 'layerDemo' + type,
              area: ['490px', '460px'],
              content: '<iframe src="user/editUI1" frameborder="0" class="layadmin-iframe"></iframe>',
              btn: ['确定', '取消'],
              maxmin: true,
              btnAlign: 'c',
              shade: 0,
              yes: function () {
                // 写下编辑的提交方法**********************************************************
                layer.closeAll();
              },
              btn2: function () {
                layer.closeAll();
              }
            });
          }

          // 导入弹窗
          ,
        upload: function (othis) {
            var type = othis.data('type'),
              text = othis.text();

            layer.open({
              type: 2,
              offset: type,
              title: '文件导入',
              id: 'layerDemo' + type,
              area: ['490px', '460px'],
              content: 'upload.html',
              btn: ['确定', '取消'],
              btnAlign: 'c',
              shade: 0,
              yes: function () {
                // 写下导入的提交方法**********************************************************
                layer.closeAll();
              },
              btn2: function () {
                layer.closeAll();
              }
            });
          }

          ,
        deltable: function (othis) {
          var type = othis.data('type')
                  ,text = othis.text();
          var tabledata=layui.table.checkStatus('test-table-reload').data;
          var myArray=new Array();
          for(var i=0;i<tabledata.length;i++){
            myArray.push(tabledata[i].login_name);
          }

          layer.open({
            type: 1,
            offset: type,
            title: '${name}删除',
            id: 'layerDemo' + type,
            area: ['190px', '160px'],
            content: '<p style="margin:auto;">您确定要删除选中项吗</p>',
            btn: ['确定', '取消'],
            btnAlign: 'c',
            shade: 0,
            yes: function () {
              // 写下编辑的提交方法**********************************************************
              $.ajax({
                type: "POST",
                url: "user/delete",
                traditional: true,
                data:{'names': myArray},
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
              layer.closeAll();
              parent.layui.table.reload('test-table-reload',{page: {curr: 1}});
            },
            btn2: function () {
              layer.closeAll();
            }
          });
        }






      };

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
    }).use(['index', 'upload'], function () {
      var $ = layui.jquery,
        upload = layui.upload;


      //拖拽上传
      upload.render({
        elem: '#test-upload-drag',
        url: '/upload/',
        done: function (res) {
          console.log(res)
        }
      });


      //绑定原始文件域
      upload.render({
        elem: '#test-upload-primary',
        url: '/upload/',
        done: function (res) {
          console.log(res)
        }
      });

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

  <script>
    layui.config({
      base: 'department/' //静态资源所在路径
    }).extend({
      index: 'lib/index' //主入口模块
    }).use(['index', 'form'], function () {
      var $ = layui.$,
        admin = layui.admin,
        element = layui.element,
        form = layui.form;

      form.render(null, 'component-form-element');
      element.render('breadcrumb', 'breadcrumb');

      form.on('submit(component-form-element)', function (data) {
        layer.msg(JSON.stringify(data.field));
        return false;
      });
    });
  </script>


</body>

</html>