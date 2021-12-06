<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>一个小云盘</title>

    <!-- Bootstrap core CSS -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">
    <div class="header clearfix">
        <nav>
            <ul class="nav nav-pills pull-right">
                <li role="presentation" class="active"><a href="#">首页</a></li>
                <li role="presentation"><a href="#">更多</a></li>
                <li role="presentation"><a href="#">联系我们</a></li>
            </ul>
        </nav>
        <h3 class="text-muted">一个小云盘</h3>
    </div>

    <div class="jumbotron">
        <h1>一个小云盘</h1>
        <h3>永远期待美好的事情即将发生</h3>
        <p><a class="btn btn-lg btn-primary" href="http://localhost:8080/SpringMVC/user/login" role="button">立即登录</a></p>
        <p><a class="btn btn-lg btn-success" href="http://localhost:8080/SpringMVC/user/signup" role="button">立即注册</a></p>
    </div>

    <footer class="footer">
        <p>beautiful</p>
    </footer>

</div> <!-- /container -->


</body>
<style>
    /* Space out content a bit */
    body {
        padding-top: 20px;
        padding-bottom: 20px;
    }

    /* Everything but the jumbotron gets side spacing for mobile first views */
    .header,
    .marketing,
    .footer {
        padding-right: 15px;
        padding-left: 15px;
    }

    /* Custom page header */
    .header {
        padding-bottom: 20px;
        border-bottom: 1px solid #e5e5e5;
    }
    /* Make the masthead heading the same height as the navigation */
    .header h3 {
        margin-top: 10px;
        margin-bottom: 10px;
        padding-bottom: 10px;
        line-height: 40px;
    }
	.header h1 {
        margin-top: 10px;
        margin-bottom: 10px;
        line-height: 40px;
    }
    /* Custom page footer */
    .footer {
        padding-top: 19px;
        color: #777;
        border-top: 1px solid #e5e5e5;
    }

    /* Customize container */
    @media (min-width: 1024px) {
        .container {
            max-width: 900px;
        }
    }
    .container-narrow > hr {
        margin: 30px 0;
    }

    /* Main marketing message and sign up button */
    .jumbotron {
        text-align: center;
        background-color: #e1ffff
        border-bottom: 1px solid #f0ffff;
    }
    .jumbotron .btn {
        padding: 14px 24px;
        font-size: 21px;
    }

    /* Supporting marketing content */
    .marketing {
        margin: 40px 0;
    }
    .marketing p + h4 {
        margin-top: 28px;
    }

    /* Responsive: Portrait tablets and up */
    @media screen and (min-width: 1024px) {
        /* Remove the padding we set earlier */
        .header,
        .marketing,
        .footer {
            padding-right: 0;
            padding-left: 0;
        }
        /* Space out the masthead */
        .header {
            margin-bottom: 30px;
        }
        /* Remove the bottom border on the jumbotron for visual effect */
        .jumbotron {
            border-bottom: 0;
        }
    }

</style>
</html>

