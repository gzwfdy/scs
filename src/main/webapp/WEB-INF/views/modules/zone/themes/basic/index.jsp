<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key="zone.title"/> - ${site.title}</title>
    <%@include file="/WEB-INF/views/modules/zone/include/head.jsp" %>
    <meta name="description" content="${site.description}"/>
    <meta name="keywords" content="${site.keywords}"/>
</head>
<body class="container">
<div class="wrap row">
    <!-- Header Start -->
    <header id="header" class="header-bg">
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
                                    <a href="${category.url}" target="${category.target}">
                                            ${category.name}
										<span class="sf-sub-indicator">
                                        	<i class="icon-angle-down "></i>
                                       </span>
                                    </a>
                                    <ul class="submenu">
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
        <!-- Slider Start-->
        <div class="slider-wrapper theme-default">
            <div id="nivoslider" class="nivoSlider">
                <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.homeAD ,10 ,'' )}" var="ad">
                    <a href="${ad.url}"><img src="${ad.image}" data-transition="slideInLeft" alt="Nature" title="#${ad.id}" ></a>
                </c:forEach>
                <%--<a href="#"><img src="${ctxStatic}/zone/img/slider/nivo_slider1.jpg" alt="Nature" title="#htmlcaption" ></a>
                <a href="#"><img src="${ctxStatic}/zone/img/slider/nivo_slider3.jpg" alt="" data-transition="slideInLeft" title="#htmlcaption2"></a>
                <a href="#"><img src="${ctxStatic}/zone/img/slider/nivo_slider4.jpg" alt="" data-transition="slideInRight" title="#htmlcaption3"></a>--%>
            </div>
            <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.homeAD ,10 ,'' )}" var="ad">
                <div id="${ad.id}" class="nivo-html-caption">
                    <h2>${ad.description}</h2>
                </div>
            </c:forEach>

        </div>

        <!-- Main Content start-->
        <div class="main-content" style="margin: 0;padding: 10px 0;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">${fnc:getCategory(site.row1col1).name}</h3>
                            </div>
                            <div class="panel-body">

                                <ul class="posts">
                                    <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.row1col1 ,5 ,'' )}" var="article">
                                        <li>
                                            <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}"><img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/recent-post-img.jpg"></a>
                                            <p><a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}">${fns:abbr(article.title,40)}</a></p>
                                        </li>
                                    </c:forEach>

                                </ul>
                            </div>
                            <div class="panel-footer"><a href="${fnc:getCategory(site.row1col1).url}">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title"><fmt:message key="zone.ep"/> </h3>
                            </div>
                            <div class="panel-body">

                                        <video id="my-video" class="video-js" controls autoplay preload="auto" width="370px" height="300px"
                                               poster="${ctxStatic}/zone/img/portfolio/portfolio-1.jpg" data-setup="{}">
                                            <source src="${site.row1col2}" type='video/mp4'>
                                            <p class="vjs-no-js">
                                                To view this video please enable JavaScript, and consider upgrading to a web browser that
                                                <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
                                            </p>
                                        </video>

                                                <%--<img src="${ctxStatic}/zone/img/portfolio/portfolio-6.jpg" alt=" ">--%>
                                            <div class="content-box-info">
                                                <%--<h4>招生宣传片</h4>--%>
                                            </div>
                            </div>
                            <div class="panel-footer"><%--<a href="#">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a>--%></div>
                        </div>


                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">${fnc:getCategory(site.row1col3).name}</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="posts">
                                    <c:forEach items="${fnc:getCategoryList(fnc:getCurrentSiteId(),site.row1col3 ,5 ,'' )}" var="row1col3">
                                        <li>
                                            <a href="${row1col3.url}"><img class="img-thumbnail recent-post-img" alt="" src="${row1col3.image}"></a>
                                            <p><a href="${row1col3.url}">${row1col3.name}</a></p>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="panel-footer"><a href="${fnc:getCategory(site.row1col3).url}">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Content end-->
        <!-- Main Content start-->
        <div class="main-content" style="margin:0px;padding: 0px;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">${fnc:getCategory(site.row2col1).name}</h3>
                            </div>
                            <div class="panel-body">

                                <ul class="posts">
                                    <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.row2col1 ,5 ,'' )}" var="article">
                                        <li>
                                            <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}"><img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/recent-post-img.jpg"></a>
                                            <p><a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}">${fns:abbr(article.title,40)}</a></p>
                                        </li>
                                    </c:forEach>

                                </ul>
                            </div>
                            <div class="panel-footer"><a href="${fnc:getCategory(site.row2col1).url}">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">在线视频咨询</h3>
                            </div>
                            <div class="panel-body">
                                <div class="services-big">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin: 0px;padding: 0px;">
                                        <div class="content-box">
                                            <div id="pexip" class="content-box-icon">
                                                <a href="${ctxStatic}/app/index.html">
                                                    <img src="${ctxStatic}/zone/img/portfolio/portfolio-8.jpg" alt=" ">
                                                    <span style="position: absolute;color: #fff;border-radius:0;background-color:#999;width:360px;height:30px;line-height:35px; top:240px; left: 5px;  background: url(${ctxStatic}/zone/img/bg_off.png) repeat;">&nbsp客服在线</span>
                                                </a>

                                            </div>

                                        </div>
                                    </div>
                                </div>


                            </div>

                        </div>
                        <div class="panel panel-info">

                            <div class="panel-body">
                                <a href="${site.aol}" target="_blank"> <fmt:message key="zone.aol"/> </a>｜<a href="${fnc:getCategory(site.download).url}"><fmt:message key="zone.download"/> </a>｜<a href="mailto:${site.email}"><fmt:message key="zone.email"/> </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">${fnc:getCategory(site.row2col3).name}</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="posts">
                                    <c:forEach items="${fnc:getCategoryList(fnc:getCurrentSiteId(),site.row2col3 ,5 ,'' )}" var="row2col3">
                                        <li>
                                            <a href="${row2col3.url}"><img class="img-thumbnail recent-post-img" alt="" src="${row2col3.image}"></a>
                                            <p><a href="${row2col3.url}">${row2col3.name}</a></p>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="panel-footer"><a href="${fnc:getCategory(site.row2col3).url}">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Content end-->
        <!-- Main Content start-->
        <div class="main-content" style="margin: 0px;padding: 0px;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">${fnc:getCategory(site.row3col1).name}</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="posts">
                                    <c:forEach items="${fnc:getCategoryList(fnc:getCurrentSiteId(),site.row3col1 ,5 ,'' )}" var="row3col1">
                                        <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(), row3col1.id,1 ,'' )}" var="art" varStatus="vs">
                                            <c:if test="${vs.first}">
                                                <li>
                                                    <a href="${art.url}"><img class="img-thumbnail recent-post-img" alt="" src="${art.image}"></a>
                                                    <p><a href="${row3col1.url}">${row3col1.name}</a> | <a href="#">${art.title}</a></p>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                    <%--<li>
                                        <a href="#"><img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/3a46aaedf54c1625b1e2008ccec86284.jpg"></a>
                                        <p><a href="#">活动</a> | <a href="#">异域风情展</a></p>
                                    </li>
                                    <li>
                                        <a href="#"><img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/1a61fe38cdf1472003b8791e4751c10c.jpg"></a>
                                        <p><a href="#">社团</a> | <a href="#">古筝表演</a></p>
                                    </li>
                                    <li>
                                        <a href="#"><img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/ea6259b063c424bc905e319c76695d17.jpg"></a>
                                        <p><a href="#">实践</a> | <a href="#">笔架山语言实践</a></p>
                                    </li>
                                    <li>
                                        <a href="#"><img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/59de9c08554f0ad138141bf7c87acb3a.jpg"></a>
                                        <p><a href="#">实习</a> | <a href="#">茶文化体验</a></p>
                                    </li>--%>

                                </ul>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">${fnc:getCategory(site.row3col2).name}</h3>
                            </div>
                            <div class="panel-body">
                                <ul class="posts">
                                    <c:forEach items="${fnc:getCategoryList(fnc:getCurrentSiteId(),site.row3col2 ,5 ,'' )}" var="row3col2">
                                        <li>
                                            <a href="${row3col2.url}"><img class="img-thumbnail recent-post-img" alt="" src="${row1col3.image}"></a>
                                            <p><a href="${row3col2.url}">${row3col2.name}</a></p>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <%--<div class="panel-footer"><a href="${fnc:getCategory(site.row3col2).url}">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Content end-->
        <!-- Main Content start-->
        <%--<div class="main-content" style="margin: 15px 0 15px;padding: 20px 0 0;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 col-md-5 col-sm-5">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">留学生管理</h3>
                            </div>
                            <div class="panel-body">
                                <ul>
                                    <li><a href="/z/view-3-1.html"
                                                                                     style="color:black">外管法规</a>
                                    </li>

                                    <li><a href="/z/view-3-2.html"
                                                                                     style="color:black">签证管理</a></li>

                                    <li><a href="/z/view-3-3.html"
                                                                                     style="color:black">留学生校外住宿管理</a>
                                    </li>

                                    <li><a href="/z/view-3-4.html"
                                                                                     style="color:black">留学生管理条例</a>
                                    </li>

                                    <li><a href="/z/view-3-5.html"
                                                                                     style="color:black">留学生新生手册</a>
                                    </li>
                                </ul>

                            </div>
                            <div class="panel-footer"><a href="#">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                    <div class="col-lg-5 col-md-5 col-sm-5">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">第二课堂</h3>
                            </div>
                            <div class="panel-body">
                                <ul>
                                    <li><a href="/z/view-3-1.html"
                                                                                     style="color:black">学生活动</a>
                                    </li>

                                    <li><a href="/z/view-3-2.html"
                                                                                     style="color:black">学生社团</a>
                                    </li>

                                    <li><a href="/z/view-3-3.html"
                                                                                     style="color:black">社会实践</a>
                                    </li>

                                    <li><a href="/z/view-3-4.html"
                                                                                     style="color:black">实习与就业</a>
                                    </li>


                                </ul>

                            </div>
                            <div class="panel-footer"><a href="#">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 align="center" class="panel-title">友情链接</h3>
                            </div>
                            <div class="panel-body">
                                <ul>
                                    <li><a href="/z/view-3-1.html"
                                           style="color:black">图书馆</a>
                                    </li>

                                    <li><a href="/z/view-3-2.html"
                                           style="color:black">国际交流处</a>
                                    </li>

                                    <li><a href="/z/view-3-3.html"
                                           style="color:black">研究生处</a>
                                    </li>

                                    <li><a href="/z/view-3-4.html"
                                           style="color:black">大外孔子学院</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="panel-footer"><a href="#">更多 <i class="icon-angle-right"></i><i class="icon-angle-right"></i></a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
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
                    <img src="userfiles/QRCode/${site.qrcode}.png" alt="QRCode" width="75" height="75"
                         style="margin:5px;">
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Top End -->
    <!-- Footer Bottom Start -->
    <!-- Footer Bottom End -->
    <!-- Scroll To Top -->
    <a href="#" class="scrollup"><i class="fa fa-angle-up"></i></a>
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
<script src="${ctxStatic}/zone/js/jquery.sticky.js"></script>
<script src="${ctxStatic}/zone/js/jflickrfeed.js"></script>
<script src="${ctxStatic}/zone/js/imagesloaded.pkgd.min.js"></script>
<script src="${ctxStatic}/zone/js/waypoints.min.js"></script>
<%--<script src="${ctxStatic}/zone/js/spectrum.js"></script>
<script src="${ctxStatic}/zone/js/switcher.js"></script>--%>
<script src="${ctxStatic}/zone/js/custom.js"></script>
<script src="http://vjs.zencdn.net/5.0.2/video.js"></script>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#pexip").each(function(){
            console.debug($(this).width());
            console.debug($(this).height());
            $(this).find("span").width($(this).width()).css("top",$(this).height() - 30);
        });


        function getService(){
            $.get("${ctx}/serviceOnLine?updateSession=0&t="+new Date().getTime(),function(data){
                console.debug(data);
            });
        }
        getService();
        setInterval(getService, 20000);


    });
</script>
</html>