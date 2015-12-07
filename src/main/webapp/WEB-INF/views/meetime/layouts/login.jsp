<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html style="overflow-x:auto;overflow-y:auto;">
<head>
	<title><sitemesh:title/></title><!--  - Powered By JeeSite -->
	<%@include file="/WEB-INF/views/meetime/include/head.jsp" %>
	<style type="text/css">
		.login-footer {
			text-align: center;
			text-shadow: 1px 1px 1px black;
			font-size: smaller;
			background-color: transparent!important;
		}
		.login-footer a {
			display: inline-block;
			text-decoration: none;
			padding: 8px 16px;
		}
		.login-footer a:link,
		.login-footer a:visited {
			color: inherit;
			opacity: .5;
		}
		.login-footer a:hover,
		.login-footer a:active {
			color: inherit;
			opacity: 1;
		}
	</style>
	<sitemesh:head/>
</head>
<body class="login-layout light-login">
	<sitemesh:body/>
</body>
</html>