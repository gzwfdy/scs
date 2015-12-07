<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/mobile/modules/zone/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default=""/>${site.title}</title>

	<%@include file="/WEB-INF/views/mobile/modules/zone/include/head.jsp" %>
	<sitemesh:head/>
</head>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，本应用暂不支持。 请 <a
		href="http://browsehappy.com/" target="_blank">升级浏览器</a>
	以获得更好的体验！</p>
<![endif]-->

<header data-am-widget="header"
		class="am-header am-header-default">
	<div class="am-header-left am-header-nav">
		<a href="${ctx}" class="">

			<i class="am-header-icon am-icon-home"></i>
		</a>
	</div>

	<h1 class="am-header-title">
		<a href="#title-link" class="">
			大连外国语大学汉学院
		</a>
	</h1>


</header>

<nav data-am-widget="menu" class="am-menu  am-menu-offcanvas1" data-am-menu-offcanvas >
	<a href="javascript: void(0)" class="am-menu-toggle">
		<i class="am-menu-toggle-icon am-icon-bars"></i>
	</a>

	<div class="am-offcanvas" >
		<div class="am-offcanvas-bar">

			<ul class="am-menu-nav am-avg-sm-1">
				<c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status">
					<c:if test="${status.index lt 10}">
						<c:set var="menuCategoryId" value=",${category.id},"/>
						<li class="am-parent">
							<a href="${category.url}" target="${category.target}">
									${category.name}
							</a>
							<ul class="am-menu-sub am-collapse  am-avg-sm-2">
								<c:forEach items="${fnc:getCategoryList(site.id,category.id ,-1 ,'' )}"
										   var="submenu" varStatus="subStatus">
									<li class="">
										<a href="${submenu.url}" class="sf-with-ul" target="_self">
												${submenu.name}
										</a>
									</li>
								</c:forEach>
							</ul>
						</li>
					</c:if>
				</c:forEach>






			</ul>

		</div>
	</div>
</nav>
<sitemesh:body></sitemesh:body>


<footer data-am-widget="footer"
		class="am-footer am-footer-default"
		data-am-footer="{  }">
	<div class="am-footer-miscs ">

		<p>由 <a href="http://www.meetime.com/" title="艾思葳"
				target="_blank" class="">艾思葳（大连）有限公司</a>
			提供技术支持</p>
		<p>CopyRight©2015</p>
		<p>辽ICP备05003548</p>
	</div>
</footer>



<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="static/AmazeUI/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${ctxStatic}/AmazeUI/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<script src="${ctxStatic}/AmazeUI/assets/js/amazeui.min.js"></script>
</body>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
</html>