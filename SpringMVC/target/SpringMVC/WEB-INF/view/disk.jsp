<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>一个小云盘</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.4.9/css/fileinput.min.css" media="all" type="text/css" />
    <!-- if using RTL (Right-To-Left) orientation, load the RTL CSS file after fileinput.css by uncommenting below -->
    <!-- link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.4.9/css/fileinput-rtl.min.css" media="all" rel="stylesheet" type="text/css" /-->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <!-- piexif.min.js is needed for auto orienting image files OR when restoring exif data in resized images and when you
        wish to resize images before upload. This must be loaded before fileinput.min.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.4.9/js/plugins/piexif.min.js" type="text/javascript"></script>

    <!-- the main fileinput plugin file -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.4.9/js/fileinput.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="dashboard.css" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">一个小云盘</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">系统通知</a></li>
                <li><a href="#">设置</a></li>
                <li><a href="#">帮助</a></li>
                <li><a href="http://localhost:8080/SpringMVC">退出</a></li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="http://localhost:8080/SpringMVC/disk/show">主页 <span class="sr-only">(current)</span></a></li>
                <li><a href="http://localhost:8080/SpringMVC/disk/share">分享</a></li>
                <li><a href="http://localhost:8080/SpringMVC/disk/download">云盘管理</a></li>
                <li><a href="#">回收站</a></li>
                <li><a href="#">个人中心</a></li>
            </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">一个小云盘</h1>

            <form action="http://localhost:8080/SpringMVC/disk/upload" method="POST" enctype="multipart/form-data" content="charset=UTF-8">
<%--                <input class="file" type="file" name="file">--%>
                <input id="input" name="file" type="file" class="file" multiple
                       data-show-upload="false" data-show-caption="true" data-msg-placeholder="Select {files} for upload...">
                <button class="btn btn-success" type="submit">提交</button>
                <button class="btn btn-default" type="reset">重新设置</button>
            </form>

            <h2 class="sub-header">选择文件</h2>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>文件名</th>
                        <th>文件类型</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%
                        List<String> files = (List<String>) request.getAttribute("Files");
                    %>
                    <%
                        if(files !=null){
                            for(Integer i = 0; i< files.size(); i++){
                                String file = files.get(i);
                                String[] parts = file.split("\\.");
                                String fType = parts[parts.length - 1];
                    %>
                    <tr>
                        <td><%=i%></td>
                        <td><%=file%></td>
                        <td><%=fType%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>

<style>
    /*
 * Base structure
 */

    /* Move down content because we have a fixed navbar that is 50px tall */
    body {
        padding-top: 50px;
    }


    /*
     * Global add-ons
     */

    .sub-header {
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    /*
     * Top navigation
     * Hide default border to remove 1px line.
     */
    .navbar-fixed-top {
        border: 0;
    }

    /*
     * Sidebar
     */

    /* Hide for mobile, show later */
    .sidebar {
        display: none;
    }
    @media (min-width: 1024px) {
        .sidebar {
            position: fixed;
            top: 51px;
            bottom: 0;
            left: 0;
            z-index: 1000;
            display: block;
            padding: 20px;
            overflow-x: hidden;
            overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
            background-color: #f5f5f5;
            border-right: 1px solid #eee;
        }
    }

    /* Sidebar navigation */
    .nav-sidebar {
        margin-right: -21px; /* 20px padding + 1px border */
        margin-bottom: 20px;
        margin-left: -20px;
    }
    .nav-sidebar > li > a {
        padding-right: 20px;
        padding-left: 20px;
    }
    .nav-sidebar > .active > a,
    .nav-sidebar > .active > a:hover,
    .nav-sidebar > .active > a:focus {
        color: #fff;
        background-color: #6495ed;
    }


    /*
     * Main content
     */

    .main {
        padding: 20px;
    }
    @media (min-width: 1024px) {
        .main {
            padding-right: 40px;
            padding-left: 40px;
        }
    }
    .main .page-header {
        margin-top: 0;
    }


    /*
     * Placeholder dashboard ideas
     */

    .placeholders {
        margin-bottom: 30px;
        text-align: center;
    }
    .placeholders h4 {
        margin-bottom: 0;
    }
    .placeholder {
        margin-bottom: 20px;
    }
    .placeholder img {
        display: inline-block;
        border-radius: 50%;
    }

</style>
</html>
