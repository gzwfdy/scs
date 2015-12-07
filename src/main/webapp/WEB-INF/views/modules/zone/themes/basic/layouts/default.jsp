<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="<fmt:message key='zone.description'/>"/> - ${site.title}</title>

	<%@include file="/WEB-INF/views/modules/zone/include/head.jsp" %>
	<sitemesh:head/>
</head>
<body class="container">
<div class="wrap row">
	<!-- Header Start -->
	<header id="header">
		<!-- Header Top Bar Start -->
		<div class="top-bar">
			<div class="slidedown collapse">
				<div class="container" style="margin-right: 10px; margin-left: 75px;max-width: 100%;">
					<div class="row">
						<div class="col-lg-6 col-md-6 col-sm-6">
							<!-- Logo Start -->
							<div class="logo pull-left">
								<h1 align="center" style="margin:0px;">
									<a href="index.html">
										<img src="${site.logo}" alt="logo" width="468" height="143">
									</a>

								</h1>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6" style="text-align: right;">

							<div class="logo" style="padding-top: 110px;">
								<%--<p style="text-align: right;margin-right: 50px;"><fmt:message key="zone.login"/></p>--%>
								<div class="head-menu">
									<ul>
										<c:forEach items="${fnc:getSiteList()}" var="site">
											<li class="${site.locale}"><a href="${ctx}/index-${site.id}${fns:getConfig("urlSuffix")}?locale=${site.locale}">${site.name}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>



						</div>
					</div>

					<div class="">



					</div>
					<!-- Logo End -->
					<%--<div class="phone-email pull-left">
                        <a><i class="icon-phone"></i> 咨询电话 : 86-411-86115286</a>
                        <a href="mail%40example.html"><i class="icon-envelope"></i> 邮箱 : mail@example.com</a>
                    </div>--%>
					<div class="pull-right">
						<%--<div class="phone-email pull-left">
                           <a>登录</a>
                        </div>--%>
						<%--<div class="phone-email pull-left">
                            <a href="#">在线申请</a>
                        </div>--%>
						<%--<div id="search-form" class="pull-right">
                            <form action="#" method="get">
                                <input type="text" class="search-text-box">
                            </form>
                        </div>--%>
					</div>
				</div>
			</div>
		</div>
		<!-- Header Top Bar End -->
		<!-- Main Header Start -->
		<div class="main-header">
			<div class="container" style="margin-right: 10px; margin-left: 10px;max-width: 100%;">
				<!-- TopNav Start -->
				<div class="topnav navbar-header">
					<a class="navbar-toggle down-button" data-toggle="collapse" data-target=".slidedown">
						<i class="icon-angle-down icon-current"></i>
					</a>
				</div>
				<!-- TopNav End -->

				<!-- Mobile Menu Start -->
				<div class="mobile navbar-header">
					<a class="navbar-toggle" data-toggle="collapse" href=".html">
						<i class="icon-reorder icon-2x"></i>
					</a>
				</div>
				<!-- Mobile Menu End -->
				<!-- Menu Start -->
				<nav class="collapse navbar-collapse menu">
					<ul class="nav navbar-nav sf-menu">
						<c:set var="firstMenu" value="true"/>
						<c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status">
							<c:if test="${status.index lt 10}">
								<c:set var="menuCategoryId" value=",${category.id},"/>
								<li>
									<a  href="${category.url}" target="${category.target}" ${requestScope.category.id eq category.id||fn:indexOf(requestScope.category.parentIds,menuCategoryId) ge 1?'id="current"':''}>
										${category.name}
										<span class="sf-sub-indicator">
                                        	<i class="icon-angle-down "></i>
                                       </span>
									</a>
										<ul class="submenu">
											<c:forEach items="${fnc:getCategoryList(site.id,category.id ,-1 ,'' )}" var="submenu" varStatus="subStatus">
												<li class="">
													<a href="${submenu.url}" class="sf-with-ul" target="_self">
															${submenu.name}
													</a>
												</li>
											</c:forEach>
										</ul>
								</li>
							</c:if>
							<c:set var="firstMenu" value="false"/>
						</c:forEach>
					</ul>
				</nav>
				<!-- Menu End -->
			</div>
		</div>
		<!-- Main Header End -->
	</header>
	<!-- Header End -->
	<!-- Content Start -->
	<div id="main">

		<!-- Main Content start-->
			<sitemesh:body></sitemesh:body>
		<!-- Main Content end-->
	</div>
	<!-- Content End -->
	<!-- Footer Start -->
	<footer id="footer">
		<!-- Footer Top Start -->
		<div class="footer-top">
			<div class="container">
				<div class="row">
					<p align="center" style="margin:0px;">
						<span>友情链接：</span>
						<c:forEach items="${fnc:getLinkList(fnc:getCurrentSiteId(),fnc:getCategory(site.link) ,-1 ,'' )}" var="link" varStatus="ls">
							<c:if test="${ls.last}">
								<a href="${link.href}" target="_blank">${link.title}</a>
							</c:if>
							<c:if test="${!ls.last}">
								<a href="${link.href}" target="_blank">${link.title}</a> |
							</c:if>

						</c:forEach>

					</p>
				</div>
			</div>
		</div>
		<!-- Footer Top End -->
		<!-- Footer Bottom Start -->
		<div class="footer-bottom">
			<div class="row">
				<div class="col-lg-8 col-md-8 col-xs-8 col-sm-8 ">
					<div class="container pull-right">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 "
								 style="text-align: center;">
								<div class="footer_nav">
									<a
											href="${ctx}/search"
											target="_blank">全站搜索</a> | <a
										href="${ctx}/map-${site.id}${fns:getUrlSuffix()}" target="_blank">站点地图</a> | <a
										href="mailto:g.zw@asvcloud.com">技术支持</a> | <a
										href="${pageContext.request.contextPath}${fns:getAdminPath()}/login" target="_blank">后台管理</a>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 "
									 style="text-align: center;">${site.copyright}</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-4 col-xs-4 col-sm-4 ">
					<img src="/userfiles/QRCode/${site.qrcode}.png" alt="QRCode" width="75" height="75"
						 style="margin:5px;">
				</div>
			</div>
		</div>
	</footer>
	<!-- Scroll To Top -->
	<a href="#" class="scrollup"><i class="icon-angle-up"></i></a>
</div>

	<!-- The Scripts -->
	<script src="${ctxStatic}/zone/js/jquery.min.js"></script>
	<script src="${ctxStatic}/zone/js/bootstrap.js"></script>
	<script src="${ctxStatic}/zone/js/jquery.parallax.js"></script>
	<script src="${ctxStatic}/zone/js/modernizr-2.6.2.min.js"></script>
	<script src="${ctxStatic}/zone/js/jquery.nivo.slider.pack.js"></script>
	<script src="${ctxStatic}/zone/js/jquery.prettyPhoto.js"></script>
	<script src="${ctxStatic}/zone/js/superfish.js"></script>
	<script src="${ctxStatic}/zone/js/tytabs.js"></script>
	<script src="${ctxStatic}/zone/js/jquery.gmap.min.js"></script>
	<script src="${ctxStatic}/zone/js/circularnav.js"></script>
	<script src="${ctxStatic}/zone/js/jflickrfeed.js"></script>
	<script src="${ctxStatic}/zone/js/imagesloaded.pkgd.min.js"></script>
	<script src="${ctxStatic}/zone/js/waypoints.min.js"></script>
	<script src="${ctxStatic}/zone/js/custom.js"></script>




</body>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
</html>