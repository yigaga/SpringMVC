<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style> 
	body{text-align:center} 
</style>
<body>
<h2>This is app2! 欢迎您访问!</h2>
<h3>hello <%=request.getAttribute("username")%></h3>
<p>点击下方链接进入app2主页面</p>>
<p>
    <a href="http://localhost:8080/app2/app">进入app2主页面</a>
</p>
</body>
</html>
