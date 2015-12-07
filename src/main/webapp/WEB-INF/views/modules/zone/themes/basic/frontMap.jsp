<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp" %>
<!DOCTYPE html>
<!--[if IE 8]> <html class="ie ie8"> <![endif]-->
<!--[if IE 9]> <html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html> <!--<![endif]-->
<head>
	<title>站点地图</title>
	<meta name="decorator" content="zoneDefault"/>
	<meta name="description" content="${category.description}"/>
	<meta name="keywords" content="${category.keywords}"/>
	<style type="text/css">
		dl.map{border:1px solid #efefef;border-top:0;margin:10px 8px 8px;}
		dl.map dt{border-top:1px solid #efefef;padding:10px 15px;}
		dl.map dd{margin:10px 30px 20px;}
		dl.map span{border:1px solid #efefef;padding:8px 10px;}
		dl.map span:hover{border:1px solid #bbb;}
		dl.map span a:hover{text-decoration:none;color:#333;}
	</style>
</head>
<body>

		<zone:frontCurrentPosition category="${category}"/>
		<!-- Main Content start-->
		<div class="content">
			<div class="container">
				<div class="row">
					<dl class="map"><c:forEach items="${fnc:getMainNavList(site.id)}" var="tpl">
						<dt>
							<c:choose>
							<c:when test="${not empty tpl.href}">
							<c:choose>
								<c:when test="${fn:indexOf(tpl.href, '://') eq -1}"><c:set var="url" value="${ctx}${tpl.href}"/></c:when>
								<c:otherwise><c:set var="url" value="${tpl.href}"/></c:otherwise>
							</c:choose>
							</c:when>
								<c:otherwise><c:set var="url" value="${ctx}/list-${tpl.id}${urlSuffix}"/></c:otherwise>
							</c:choose>
							<a href="${url}" target="_blank">${tpl.name}</a>
						<dd>
							<c:forEach items="${fnc:getCategoryList(site.id, tpl.id, -1, '')}" var="category">
								<c:choose>
									<c:when test="${not empty tpl.href}">
										<c:choose>
											<c:when test="${fn:indexOf(tpl.href, '://') eq -1}"><c:set var="url" value="${ctx}${tpl.href}"/></c:when>
											<c:otherwise><c:set var="url" value="${tpl.href}"/></c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise><c:set var="url" value="${ctx}/list-${tpl.id}${urlSuffix}"/></c:otherwise>
								</c:choose>
								<span><a href="${url}" target="_blank">${tpl.name}</a></span>
							</c:forEach>
						</dd>
					</c:forEach></dl>

				</div>
			</div>
		</div>
		<!-- Main Content end-->

<!-- The Scripts -->
<script src="${ctxStatic}/zone/js/jquery.min.js"></script>
<script src="${ctxStatic}/zone/js/bootstrap.js"></script>
<script src="${ctxStatic}/zone/js/jquery.parallax.js"></script>
<script src="${ctxStatic}/zone/js/modernizr-2.6.2.min.js"></script>
<script src="${ctxStatic}/zone/js/revolution-slider/js/jquery.themepunch.revolution.min.js"></script>
<script src="${ctxStatic}/zone/js/jquery.nivo.slider.pack.js"></script>
<script src="${ctxStatic}/zone/js/jquery.prettyPhoto.js"></script>
<script src="${ctxStatic}/zone/js/superfish.js"></script>
<script src="${ctxStatic}/zone/js/tweetMachine.js"></script>
<script src="${ctxStatic}/zone/js/tytabs.js"></script>
<script src="${ctxStatic}/zone/js/jquery.sticky.js"></script>
<script src="${ctxStatic}/zone/js/jflickrfeed.js"></script>
<script src="${ctxStatic}/zone/js/imagesloaded.pkgd.min.js"></script>
<script src="${ctxStatic}/zone/js/waypoints.min.js"></script>
<script src="${ctxStatic}/zone/js/spectrum.js"></script>
<script src="${ctxStatic}/zone/js/switcher.js"></script>
<script src="${ctxStatic}/zone/js/jquery.gmap.min.js"></script>
<script src="${ctxStatic}/zone/js/custom.js"></script>
</body>
</html>