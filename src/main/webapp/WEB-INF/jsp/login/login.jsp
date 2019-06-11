<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>登录</title>

    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/sign-up-login.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/inputEffect.css" />
    <link rel="stylesheet" href="css/tooltips.css" />
    <link rel="stylesheet" href="css/spop.min.css" />

    <!-- 多彩 -->
    <link type="text/css" rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">
    <link type="text/css" rel="stylesheet" href="css/demo.css">
    <link type="text/css" rel="stylesheet" href="css/colorfulTab.min.css">

    <script src="js/jquery.min.js"></script>
    <script src="js/snow.js"></script>
    <script src="js/jquery.pure.tooltips.js"></script>
    <script src="js/spop.min.js"></script>
    <script src="js/jquery.min.js"></script>

    <!-- code.jpg自动生成，能正常运行，忽略报错-->
    <style type="text/css">
        .code
        {
            background-image:url(code.jpg);
            font-family:Arial;
            font-style:italic;
            color:Red;
            border:0;
            padding:2px 3px;
            letter-spacing:3px;
            font-weight:bolder;
        }
        .unchanged
        {
            border:0;
        }

        .left
        {
            float:left;
        }
    </style>

    <style type="text/css">
        html {
            width: 100%;
            height: 100%;
        }

        body {

            background-repeat: no-repeat;

            background-position: center center #2D0F0F;

            background-color: #00BDDC;

            background-image: url(images/snow.jpg);

            background-size: cover;

        }

        .snow-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 100001;
        }

        label {
            position: relative;
            cursor: pointer;

        input {
            cursor: pointer;
        }

        input:checked+.show-box {
            background: #ec6337;
        }

        .checkbox {
            width: 18px;
            position: relative;
            display: inline-block;
            vertical-align: middle;
        }

        .checkbox label {
            cursor: pointer;
            position: absolute;
            width: 18px;
            height: 18px;
            top: 0;
            left: 0;
            background: #ccc;
            border-radius: 3px;
        }

        .checkbox label i {
            content: '';
            position: absolute;
            width: 8px;
            height: 5px;
            background: transparent;
            top: 4px;
            left: 4px;
            border: 3px solid #fff;
            border-top: none;
            border-right: none;
            -webkit-transform: rotate(-45deg);
            -moz-transform: rotate(-45deg);
            -o-transform: rotate(-45deg);
            -ms-transform: rotate(-45deg);
            transform: rotate(-45deg);
        }

        .checkbox input[type=checkbox]+label i {
            border-color: #fff;
        }

        .checkbox input[type=checkbox]:checked+label i {
            opacity: 1;
            border-color: #fe5850;
        }
    </style>

</head>

<script type="text/javascript" language="JavaScript">
    function login() {
            var i = validate();
            if(i == false)
                return;
            rememberCheck();
            $.ajax({
                type: "post",
                url: "login/login_check",
                data: {
                    "login_name": $("#login_name").val(),
                    "password": $("#password").val(),
                },
                dataType: "JSON",
                async: false,

                beforeSend: function () {
                    $("#submit").attr({ disabled: "disabled" });
                    if(i == true)
                        alert("正在提交");
                },
                success: function (data) {
                    if (data == 1 && i == true) {
                        alert("登录成功");
                        window.location.href = "login/index01";
                    }
                    else if(data == 2 && i == true) {
                        alert("登录成功");
                        window.location.href = "login/index02";
                    }
                    else if(data == 3 && i == true) {
                        alert("登录成功");
                        window.location.href = "login/index03";
                    }
                    else if(data == 4 && i == true) {
                        alert("登录成功");
                        window.location.href = "login/index04";
                    }
                    else if(data == 5 && i == true) {
                        alert("登录成功");
                        window.location.href = "login/index05";
                    }
                    else if(data == 6 && i == true) {
                        alert("登录成功");
                        window.location.href = "login/index06";
                    }
                    else if(i == false) {

                    }
                    else if(data == 0 && i == true) {
                        alert("用户名或者密码错误!");
                    }
                    else if(data == 0 && i ==false) {
                        alert("用户名或者密码错误！验证码错误！");
                    }
                    else {
                        alert("发生未知错误，请重新输入");
                    }
                },
                error: function () {
                    alert("提交失败");
                }
            });
        }
</script>

<script type="text/javascript" language="JavaScript"> //注册
$(document).ready(function () {
    $('#register').click(function () {
        var i = inputCheck();
        if(i == false)
            return;
        $.ajax({
            type: "post",
            url: "login/implAdd",
            data: {
                login_name: $("#register-username").val(),
                password: $("#register-password").val(),
                category: $("#category").val(),
                question: $("#register-question").val(),
                answer: $("#register-answer").val(),
            },
            dataType: "JSON",
            async: false,
            beforeSend: function () {
                $("#submit").attr({ disabled: "disabled" });
                if(i == true)
                    alert("正在提交");
            },
            success: function (data) {
                if (data == -1 && i == true) {
                    alert("数据输入有误!");
                } else if (data == 0 && i == true) {
                    alert("该用户已存在，请重新输入!");

                }
                else if(i == false) {

                }
                else if(data != -1 && data != 0 && i == true){
                    alert("注册成功，即将跳转至登录");
                    window.location.href = "login/login";
                }
            },
            error: function () {
                alert("提交失败");
            }
        });
    })

})
</script>

<script type="text/javascript" language="JavaScript">
    function goto_register() {
        $("#tab-2").prop("checked", true);
    }

    function goto_login() {
        $("#tab-1").prop("checked", true);
    }

    function goto_forget() {
        $("#tab-3").prop("checked", true);
    }
</script>

<script type="text/javascript" language="JavaScript"> //正则表达式约束用户名和密码
function inputCheck() {
    var loginName = document.getElementById("register-username").value.toUpperCase();
    var passWord = document.getElementById("register-password").value.toUpperCase();
    var repassword = document.getElementById("register-repassword").value.toUpperCase();
    var Question = document.getElementById("register-question").value.toUpperCase();
    var Answer = document.getElementById("register-answer").value.toUpperCase();
    var regloginName = /^[a-zA-Z0-9-_]+$/;
    var regpassWord = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;
    if(!regloginName.test(loginName)) {
        alert("请填写正确的用户名，最长8位，仅支持英文字母数字和下划线");
        return false;
    }
    else if(!regpassWord.test(passWord)) {
        alert("请填写正确的密码，8-20位，同时包含英文字母和数字");
        return false;
    }
    else if(loginName == "") {
        alert("用户名不能为空");
        return false;
    }
    else if(passWord == "") {
        alert("密码不能为空");
        return false;
    }
    else if(repassword == "") {
        alert("请再次输入密码进行确认");
        return false;
    }
    else if(Question == "") {
        alert("密保问题不能为空");
        return false;
    }
    else if(Answer == "") {
        alert("密保答案不能为空");
        return false;
    }
    else if(repassword != passWord) {
        alert("两次密码不一致");
        return false;
    }
    else {
        return true;
    }
}
</script>

<script type="text/javascript" language="JavaScript"> //返回主页跳转
    $(document).ready(function () {
        $('#returnindex').click(function () {
            window.location.href = "login/return";
        })
    })
</script>

<script language="javascript" type="text/javascript"> //生成验证码

    var code ; //在全局 定义验证码
    function createCode()
    {
        code = "";
        var codeLength = 6;//验证码的长度
        var checkCode = document.getElementById("checkCode");
        var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');//所有候选组成验证码的字符，当然也可以用中文的
        for(var i=0;i<codeLength;i++)
        {
            var charIndex = Math.floor(Math.random()*36);
            code +=selectChar[charIndex];
        }
        if(checkCode)
        {
            checkCode.className="code";
            checkCode.value = code;
            checkCode.blur();
        }
    }
</script>

<script type="text/javascript" language="JavaScript"> //判断验证码是否正确
    function validate () {
        var inputCode = document.getElementById("validCode").value.toUpperCase();
        if(inputCode.length <= 0)
        {
            alert("请输入验证码！");
            return false;
        }
        else if(inputCode.toUpperCase() != code)
        {
            alert("验证码输入错误！");
            createCode(); //刷新验证码
            return false;
        }
        else {
            return true;
        }
    }
</script>

<script type="text/javascript" language="JavaScript"> //对cookie的基本操作定义
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name)  == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function delCookie(name) {
        setCookie(name, "", -1);
    }
</script>

<script type="text/javascript" language="JavaScript">
    function rememberCheck() { //检查是否保存用户名密码
        var loginname = document.getElementById("login_name").value.trim();
        var password = document.getElementById("password").value.trim();
        var isRmbPwd = document.getElementById("isRmbPwd").checked;
        if(isRmbPwd == true) {
            setCookie("This is login_name", loginname, 7);
            setCookie(loginname, password, 7);
        }
        else {
            delCookie("This is login_name");
            delCookie(loginname);
        }
        return true;
    }
</script>

<script type="text/javascript" language="JavaScript">
    function rememberLoad() { //获取cookie里的用户名和密码
        var loginname = getCookie("This is login_name");
        if(loginname == "") {
            document.getElementById("login_name").value = "";
            document.getElementById("password").value = "";
            document.getElementById("isRmbPwd").checked = false;
        }
        else {
            var password = getCookie(loginname);
            document.getElementById("login_name").value = loginname;
            document.getElementById("password").value = password;
            document.getElementById("isRmbPwd").checked = true;
        }
    }
</script>

<script type="text/javascript" language="JavaScript">
    function selectQue(login_name) { //获取用户名对应的密保问题
        $.ajax({
            type: "get",
            url: "login/getQue/" + login_name,
            success: function (user) {
                var result = user;
                var opt = document.getElementById("forget-question");
                opt.setAttribute("value", result.question);
            }
        });
    }
</script>

<script type="text/javascript" language="JavaScript">
    function forget() { //重置密码
        var i = forget_check();
        if(i == false)
            return;
        $.ajax({
            type: "post",
            url: "login/verify",
            data: {
                "login_name": $("#forget-username").val(),
                "password" : $("#forget-password").val(),
                "answer": $("#forget-answer").val(),
            },
            dataType: "JSON",
            async: false,

            beforeSend: function () {
                alert("正在提交");
            },
            success: function (data) {
                if(data == 1) {
                    alert("重置密码成功，即将跳转至登录界面");
                    window.location.href = "login/login";
                }
                else
                    alert("重置失败");
            },
            error: function () {
                alert("提交失败");
            }
        });
    }
</script>

<script type="text/javascript" language="JavaScript">
    function forget_check() {
        var loginName = document.getElementById("forget-username").value.toUpperCase();
        var passWord = document.getElementById("forget-password").value.toUpperCase();
        var Answer = document.getElementById("forget-answer").value.toUpperCase();
        var regpassWord = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$/;

        if(!regpassWord.test(passWord)) {
            alert("请填写正确的密码，8-20位，同时包含英文字母和数字");
            return false;
        }
        else if(loginName == "") {
            alert("用户名不能为空");
            return false;
        }
        else if(passWord == "") {
            alert("密码不能为空");
            return false;
        }
        else if(Answer == "") {
            alert("密保答案不能为空");
            return false;
        }
        else
            return true;
    }
</script>

<script src="js/jquery.min.js" type="text/javascript"></script>

<script type="text/javascript" language="JavaScript">
    window.jQuery || document.write('<script src="js/jquery-1.11.0.min.js"><\/script>')
</script>

<script type="text/javascript" src="js/colorfulTab.min.js"></script>

<script type="text/javascript" language="JavaScript">
    $(document).ready(function () {

        $("#colorful").colorfulTab();

        $("#colorful-elliptic").colorfulTab({
            theme: "elliptic"
        });

        $("#colorful-flatline").colorfulTab({
            theme: "flatline"
        });

        $("#colorful-background-image").colorfulTab({
            theme: "flatline",
            backgroundImage: "true",
            overlayColor: "#002F68",
            overlayOpacity: "0.8"
        });

    });
</script>

<body onload="createCode();rememberLoad()">

<!-- 雪花背景 -->
<div class="snow-container"></div>

<!-- 登录控件 -->
<div id="login">

    <div class="htmleaf-container">

        <!-- Background Image -->
        <div class="colorful-tab-wrapper" id="colorful-background-image"
             style="top: 90px; width: 1000px; height: 550px">
            <ul class="colorful-tab-menu">
                <li class="colorful-tab-menu-item active" tab-background="images/tab1.jpg"><a href="#bg-0">挂号收费员</a>
                </li>
                <li class="colorful-tab-menu-item" tab-background="images/tab2.jpg"><a href="#bg-1">门诊医生</a></li>
                <li class="colorful-tab-menu-item" tab-background="images/tab3.jpg"><a href="#bg-2">医技医生</a></li>
                <li class="colorful-tab-menu-item" tab-background="images/tab4.jpg"><a href="#bg-3">药房操作员</a></li>
                <li class="colorful-tab-menu-item" tab-background="images/tab5.jpg"><a href="#bg-4">财务管理员</a></li>
                <li class="colorful-tab-menu-item" tab-background="images/tab6.jpg"><a href="#bg-5">医院管理员</a></li>
            </ul>


            <div class="colorful-tab-container">

                <div class="colorful-tab-content active" id="bg-0" style="height: 800px">

                    <input id="tab-1" type="radio" name="tab" class="sign-in hidden" checked />
                    <input id="tab-2" type="radio" name="tab" class="sign-up hidden" />
                    <input id="tab-3" type="radio" name="tab" class="sign-out hidden" />

                    <div class="wrapper" style="bottom: 160px">
                        <!-- 登录页面 -->
                        <div class="login sign-in-htm" style="top: 50px">
                            <form class="container offset1 loginform" method="post">
                                <div class="pad input-container">
                                    <c:if test="${msg != null}">
                                        <div>
                                            <h4><span style="color: crimson;">${msg}</span></h4>
                                        </div>
                                    </c:if>
                                    <section class="content">
                                            <span class="input input--hideo">
                                                <input class="input__field input__field--hideo" type="text" id="login_name" name="login_name" autocomplete="on" placeholder="请输入用户名" tabindex="1" maxlength="15" />
                                                <label class="input__label input__label--hideo" for="login_name">
                                                    <i class="fa fa-fw fa-user icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo">
                                                <input class="input__field input__field--hideo" type="password" id="password" name="password" placeholder="请输入密码" tabindex="2" maxlength="15" />
                                                <label class="input__label input__label--hideo" for="password">
                                                    <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>

                                        <div class="row123" style="width: 250px">
                                                <span class="input input--hideo">
                                                    <input class="input__field input__field--hideo" type="text" id="validCode" name="check_code" placeholder="请输入验证码" tabindex="3" maxlength="15" />
                                                    <label class="input__label input__label--hideo" for="validCode" style="width: 50px;">
                                                        <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                                        <span class="input__label-content input__label-content--hideo"></span>
                                                    </label>
                                                </span>
                                        </div>

                                        <input type="text" onClick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="height:55px;width: 100px;cursor:pointer;bottom: 68px;left: 120px; position: relative;"><br />
                                    </section>
                                </div>
                                <div class="form-actions">
                                    <a tabindex="4" class="btn pull-left btn-link text-muted" onClick="goto_forget()">忘记密码?</a>
                                    <div class="left" style="left:-40px;top: 5px; position: relative;">
                                        <input class="checkboxisRmbPwd" type="checkbox" id="isRmbPwd" name="isRmbPwd" checked="checked">
                                        <p style="color:#B0C4DE;position: relative;bottom: 20px;left: 70px">记住密码</p>
                                    </div>
                                    <a tabindex="5" class="btn btn-link text-muted" onclick="goto_register()">注册</a>
                                    <input class="btn btn-primary" type="button" tabindex="3" onClick="login()" value="登录" style="color:white;" />
                                </div>
                            </form>
                        </div>

                        <!-- 忘记密码页面 -->
                        <div class="login sign-out-htm">
                            <form action="#" method="post" class="container offset1 loginform">
                                <div class="pad input-container">
                                    <section class="content">
                                            <span class="input input--hideo">
                                                <input class="input__field input__field--hideo" type="text" id="forget-username" autocomplete="off" placeholder="请输入用户名" onblur="selectQue(this.value)" />
                                                <label class="input__label input__label--hideo" for="forget-username">
                                                    <i class="fa fa-fw fa-user icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo">
                                                <input class="input__field input__field--hideo" type="text" id="forget-question" autocomplete="off" readonly="true" value="这是你的问题" />
                                                <label class="input__label input__label--hideo" for="forget-question">
                                                    <i class="fa fa-fw fa-wifi icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo">
                                                <input class="input__field input__field--hideo" type="text" id="forget-answer" autocomplete="off" placeholder="请输入上述问题答案" />
                                                <label class="input__label input__label--hideo" for="forget-answer">
                                                    <i class="fa fa-fw fa-wifi icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo">
                                                <input class="input__field input__field--hideo" type="password" id="forget-password" placeholder="请重置密码" />
                                                <label class="input__label input__label--hideo" for="forget-password">
                                                    <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                    </section>
                                </div>

                                <div class="form-actions">
                                    <a class="btn pull-left btn-link text-muted" onClick="goto_login()">返回登录</a>
                                    <input class="btn btn-primary" type="button" onClick="forget()" value="重置密码" style="color:white;" />
                                </div>
                            </form>
                        </div>

                        <!-- 注册界面 -->
                        <div class="login sign-up-htm">
                            <form action="#" method="post" class="container offset1 loginform">

                                <div class="pad input-container">
                                    <section class="content">
                                            <span class="input input--hideo" style="height: 40px">
                                                <input class="input__field input__field--hideo " type="text" id="register-username" autocomplete="off" placeholder="请输入用户名，不超过8位" maxlength="8" />
                                                <label class="input__label input__label--hideo" for="register-username">
                                                    <i class="fa fa-fw fa-user icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo" style="height: 40px">
                                                <input class="input__field input__field--hideo" type="password" id="register-password" placeholder="请输入密码，8-20位" minlength="8" maxlength="20" />
                                                <label class="input__label input__label--hideo" for="register-password">
                                                    <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo" style="height: 40px">
                                                <input class="input__field input__field--hideo" type="password" id="register-repassword" placeholder="请确认密码" maxlength="15" />
                                                <label class="input__label input__label--hideo" for="register-repassword">
                                                    <i class="fa fa-fw fa-lock icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <input style="display: none" id="category" value="01">
                                        <span class="input input--hideo" style="height: 40px">
                                                <input class="input__field input__field--hideo" type="text"
                                                       id="register-question" autocomplete="off" placeholder="请输入密保问题" />
                                                <label class="input__label input__label--hideo" for="register-question">
                                                    <i class="fa fa-fw fa-wifi icon icon--hideo"></i>
                                                    <span class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                        <span class="input input--hideo" style="height: 40px">
                                                <input class="input__field input__field--hideo" type="text" id="register-answer" autocomplete="off" placeholder="请输入密保答案" />
                                                <label class="input__label input__label--hideo" for="register-answer">
                                                    <i class="fa fa-fw fa-wifi icon icon--hideo"></i>
                                                    <span
                                                            class="input__label-content input__label-content--hideo"></span>
                                                </label>
                                            </span>
                                    </section>
                                </div>
                                <div class="form-actions">
                                    <a class="btn pull-left btn-link text-muted" onClick="goto_login()">返回登录</a>
                                    <input class="btn btn-primary" type="button" id="register" value="注册" style="color:white;" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="colorful-tab-content" id="bg-1">

                </div>

                <div class="colorful-tab-content" id="bg-2">
                        <p>这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三这是页面三
                        </p>
                    </div>
                    <div class="colorful-tab-content" id="bg-3">
                        <p>这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四这是页面四
                        </p>
                    </div>
                    <div class="colorful-tab-content" id="bg-4">
                        <p>
                            页面五
                        </p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
