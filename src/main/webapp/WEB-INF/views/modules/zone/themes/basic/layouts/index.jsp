<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="<fmt:message key='zone.description'/>"/> - ${site.title}</title>
	<%@include file="/WEB-INF/views/modules/zone/include/head.jsp" %>
	<title><fmt:message key="zone.title"/> </title>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
</head>
<body class="home-3">
<div class="wrap">
	<!-- Header Start -->
	<header id="header">
		<!-- Header Top Bar Start -->
		<div class="top-bar">
			<div class="slidedown collapse">
				<div class="container">
					<div class="phone-email pull-left">
						<a><i class="icon-phone"></i> Call Us : +880 41 723 272</a>
						<a href="mail%40example.html"><i class="icon-envelope"></i> Email : mail@example.com</a>
					</div>
					<div class="pull-right">
						<div class="phone-email pull-left">
							<a>登录</a>
						</div>
						<div class="phone-email pull-left">
							<a>注册</a>
						</div>
						<div id="search-form" class="pull-right">
							<form action="#" method="get">
								<input type="text" class="search-text-box">
							</form>
						</div>
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
				<!-- Logo Start -->
				<div class="logo pull-left">
					<h1>
						<a href="index.html">
							<img src="${ctxStatic}/zone/img/logo.png" alt="logo" width="285" height="60">
						</a>
					</h1>
				</div>
				<!-- Logo End -->
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
									<a  href="${category.url}" target="${category.target}">
										${category.name}
										<span class="sf-sub-indicator">
                                        	<i class="icon-angle-down "></i>
                                       </span>
									</a>
										<ul class="submenu">
											<c:forEach items="${fnc:getCategoryList(site.id,category.id ,-1 ,'' ,language)}" var="submenu" varStatus="subStatus">
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

						<%--<c:set var="firstMenu" value="true"/>
						<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">

							<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
								<li>
									<c:if test="${empty menu.href}">
										<a class="" href="#" >

												${menu.name}
                                       <span class="sf-sub-indicator">
                                        <i class="icon-angle-down "></i>
                                       </span>
										</a>

										<ul class="submenu">
											<c:forEach items="${fns:getMenuList()}" var="submenu" varStatus="subStatus">
												<c:if test="${submenu.parent.id eq (not empty menu.id ? menu.id:1)&&submenu.isShow eq '1'}">
													<li class="">
														<a href="${fn:indexOf(submenu.href, '://') eq -1 ? ctx : ''}${submenu.href}" class="sf-with-ul" target="_self">
															${submenu.name}

														</a>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</c:if>
									<c:if test="${not empty menu.href}">
										<a class="" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="_self">
												${menu.name}
                                       <span class="sf-sub-indicator">
                                            <i class="icon-angle-down "></i>
                                       </span>
										</a>
									</c:if>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="firstMenuId" value="${menu.id}"/>
								</c:if>
								<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:forEach>--%>
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
		<div class="fullwidthbanner-container">
			<div class="fullwidthbanner rslider">
				<ul>
					<!-- THE FIRST SLIDE -->
					<li data-delay="6000" data-masterspeed="300" data-transition="fade">
						<div class="slotholder"><img src="${ctxStatic}/zone/img/slider/slider-bg-1.jpg" data-fullwidthcentering="on" alt="Pixma"></div>
						<div class="caption modern_big_bluebg h1 lft tp-caption start"
							 data-x="40"
							 data-y="85"
							 data-speed="700"
							 data-endspeed="800"
							 data-start="1000"
							 data-easing="easeOutQuint"
							 data-endeasing="easeOutQuint">
							<h3>广告标题</h3>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="1400"
							 data-speed="1050"
							 data-y="180"
							 data-x="40">
							<div class="list-slide">
								<i class="icon-camera slide-icon"></i>
								<h5 class="dblue"> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="1800"
							 data-speed="1200"
							 data-y="220"
							 data-x="40">
							<div class="list-slide">
								<i class="icon-search slide-icon"></i>
								<h5 class="dblue"> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="2200"
							 data-speed="1350"
							 data-y="260"
							 data-x="40">
							<div class="list-slide">
								<i class="icon-code slide-icon"></i>
								<h5 class="dblue"> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption lfb caption_button_1 fadeout tp-caption start"
							 data-x="40"
							 data-y="330"
							 data-speed="900"
							 data-endspeed="300"
							 data-start="2700"
							 data-hoffset="-70"
							 data-easing="easeOutExpo">
							<a class="btn-special hidden-xs btn-grey" href="#">更多内容</a>
						</div>
						<div class="caption lfb caption_button_2 fadeout tp-caption start"
							 data-x="210"
							 data-y="330"
							 data-speed="800"
							 data-endspeed="300"
							 data-start="2900"
							 data-hoffset="70"
							 data-easing="easeOutExpo">
							<a class="btn-special hidden-xs btn-color" href="#">购买</a>
						</div>
					</li>
					<!-- THE RESPONSIVE SLIDE -->
					<li data-transition="fade" data-slotamount="1" data-masterspeed="300">
						<img src="${ctxStatic}/zone/img/slider/slider-bg-2.jpg" data-fullwidthcentering="on" alt="">
						<div class="caption large_text sft"
							 data-x="660"
							 data-y="54"
							 data-speed="300"
							 data-start="800"
							 data-easing="easeOutExpo"  >广告</div>
						<div class="caption medium_text sfl"
							 data-x="689"
							 data-y="92"
							 data-speed="300"
							 data-start="1100"
							 data-easing="easeOutExpo"  >&</div>
						<div class="caption large_text sfr"
							 data-x="738"
							 data-y="88"
							 data-speed="300"
							 data-start="1100"
							 data-easing="easeOutExpo"  ><span class="dblue">标题</span></div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="1400"
							 data-speed="1050"
							 data-y="180"
							 data-x="660">
							<div class="list-slide">
								<i class="icon-eye-open slide-icon"></i>
								<h5> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="1800"
							 data-speed="1200"
							 data-y="220"
							 data-x="660">
							<div class="list-slide">
								<i class="icon-table slide-icon"></i>
								<h5> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="2200"
							 data-speed="1350"
							 data-y="260"
							 data-x="660">
							<div class="list-slide">
								<i class="icon-ok slide-icon"></i>
								<h5> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="2600"
							 data-speed="1350"
							 data-y="300"
							 data-x="660">
							<div class="list-slide">
								<i class="icon-twitter slide-icon"></i>
								<h5> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption list_slide lfb tp-caption start"
							 data-easing="easeOutExpo"
							 data-start="3000"
							 data-speed="1350"
							 data-y="340"
							 data-x="660">
							<div class="list-slide">
								<i class="icon-th slide-icon"></i>
								<h5> 内容介绍 </h5>
							</div>
						</div>
						<div class="caption lfl"
							 data-x="53"
							 data-y="30"
							 data-speed="300"
							 data-start="1400"
							 data-easing="easeOutExpo">
							<img src="${ctxStatic}/zone/img/slider/responsive-imac.png" alt="iMac Responsive">
						</div>
						<div class="caption lfl"
							 data-x="323"
							 data-y="145"
							 data-speed="300"
							 data-start="1500"
							 data-easing="easeOutExpo">
							<img src="${ctxStatic}/zone/img/slider/responsive-ipad.png" alt="iPad Responsive">
						</div>
						<div class="caption lfl"
							 data-x="472"
							 data-y="253"
							 data-speed="300"
							 data-start="1600"
							 data-easing="easeOutExpo">
							<img src="${ctxStatic}/zone/img/slider/responsive-iphone.png" alt="iPhone Responsive">
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- Slogan Start-->
          <div class="slogan bottom-pad-small">
             <div class="container">
                <div class="row">
                   <div class="slogan-content">
                      <div class="col-lg-9 col-md-9">
                         <h2 class="slogan-title">We design and develop the best website’s for customers!</h2>
                      </div>
                      <div class="col-lg-3 col-md-3">
                         <div class="get-started">
                            <button class="btn btn-special btn-color pull-right">Get Started Now</button>
                         </div>
                      </div>
                      <div class="clearfix"></div>
                   </div>
                </div>
             </div>
          </div>
          <!-- Slogan End-->
		<!-- Main Content start-->
		<div class="main-content" style="margin:1px;">
			<sitemesh:body></sitemesh:body>
		</div>
		<!-- Main Content end-->
	</div>
	<!-- Content End -->
	<!-- Footer Start -->
	<footer id="footer">
		<!-- Footer Top Start -->
		<div class="footer-top">
			<div class="container">
				<div class="row">
					<section class="col-lg-4 col-md-4 col-xs-12 col-sm-4 footer-one">
						<h3>关于</h3>
						<p>
							大连外国语大学坐落在美丽的海滨城市——大连，是辽宁省省属高校。学校于1964年在周恩来总理的亲切关怀下成立，时为大连日语专科学校，1970年更名为辽宁外语专科学校，1978年更名为大连外国语学院，2013年4月更名为大连外国语大学。学校秉承"崇德尚文、兼收并蓄"的校训精神，遵循"育人为本、质量至上、突出特色、科学发展"的办学理念，已经建设发展成为以外语为主，以国际化办学为特色，文学、管理学、经济学、工学、法学、艺术学、教育学等学科相互支撑、协调发展的多科性外国语大学。
						</p>
					</section>
					<section class="col-lg-4 col-md-4 col-xs-12 col-sm-4 footer-two">
						<h3>联系我们</h3>
						<ul class="contact-us">
							<li>
								<i class="icon-map-marker"></i>
								<p>
									<strong>地址:</strong> 地址：辽宁省大连旅顺南路西段6号 <br>

								</p>
							</li>
							<li>
								<i class="icon-phone"></i>
								<p><strong>电话:</strong> 86-411-86115286</p>
							</li>
							<li>
								<i class="icon-phone"></i>
								<p><strong>传真:</strong> 86-411-86115296</p>
							</li>
							<li>
								<i class="icon-phone"></i>
								<p><strong>邮编:</strong> 116044</p>
							</li>
							<!--li>
                               <i class="icon-envelope"></i>
                               <p><strong>Email:</strong><a href="mailto:service@dlbestcity.gov.cn">service@dlbestcity.gov.cn</a></p>
                            </li-->
						</ul>
					</section>
					<section class="col-lg-4 col-md-4 col-xs-12 col-sm-4 footer-three">
						<h3>友情链接</h3>
						<ul id="">
							<li class=""><a href="http://www.hanban.edu.cn" target="_blank" data-toggle="tooltip" title="国家汉办">国家汉办</a></li>
							<li class=""><a href="http://www.csc.edu.cn" target="_blank" data-toggle="tooltip" title="国家留学基金管理委员会">国家留学基金管理委员会</a></li>
						</ul>
					</section>
				</div>
			</div>
		</div>
		<!-- Footer Top End -->
		<!-- Footer Bottom Start -->
		<div class="footer-bottom">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 " style="text-align: center;">${site.copyright}</div>

				</div>
			</div>
		</div>
	</footer>
	<!-- Footer Top End -->
	<!-- Footer Bottom Start -->
	<!-- Footer Bottom End -->
	<!-- Scroll To Top -->
	<a href="#" class="scrollup"><i class="icon-angle-up"></i></a>
</div>

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
	<script src="${ctxStatic}/zone/js/jquery.gmap.min.js"></script>
	<script src="${ctxStatic}/zone/js/circularnav.js"></script>
	<script src="${ctxStatic}/zone/js/jquery.sticky.js"></script>
	<script src="${ctxStatic}/zone/js/jflickrfeed.js"></script>
	<script src="${ctxStatic}/zone/js/imagesloaded.pkgd.min.js"></script>
	<script src="${ctxStatic}/zone/js/waypoints.min.js"></script>
	<script src="${ctxStatic}/zone/js/spectrum.js"></script>
	<script src="${ctxStatic}/zone/js/switcher.js"></script>
	<script src="${ctxStatic}/zone/js/custom.js"></script>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$(window).resize(function () {          //当浏览器大小变化时
			$(".content-box .content-box-icon").each(function(){
				console.debug($(this).width());
				console.debug($(this).height());
				$(this).find("span").width($(this).width()).css("top",$(this).height() - 30);
			});
		});
		$(".content-box .content-box-icon").each(function(){
			console.debug($(this).width());
			console.debug($(this).height());
			$(this).find("span").width($(this).width()).css("top",$(this).height() - 30);
		});
	});
</script>
</html>