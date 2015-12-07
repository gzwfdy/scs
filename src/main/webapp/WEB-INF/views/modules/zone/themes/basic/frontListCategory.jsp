<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp" %>
<!DOCTYPE html>
<!--[if IE 8]> <html class="ie ie8"> <![endif]-->
<!--[if IE 9]> <html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html> <!--<![endif]-->
<head>
    <title>${category.name}</title>
    <meta name="decorator" content="zoneDefault"/>
    <meta name="description" content="${category.description}"/>
    <meta name="keywords" content="${category.keywords}"/>
</head>
<body>


<!-- Main Content start-->
<div class="content">
    <div class="container">
        <div class="row">
            <div class="sidebar col-lg-3 col-md-3 col-sm-3 col-xs-12">
                <!-- Search Widget Start -->
                <div class="widget search-form">
                    <div class="input-group">
                        <input type="text" value="搜索..." onfocus="if(this.value=='Search...')this.value='';"
                               onblur="if(this.value=='')this.value='搜索...';" class="search-input form-control"/>
                              <span class="input-group-btn">
                              <button type="submit" class="subscribe-btn btn"><i class="icon-search"></i></button>
                              </span>
                    </div>
                    <!-- /input-group -->
                </div>
                <!-- Search Widget End -->

                <!-- Category Widget Start -->
                <div class="widget category">
                    <h3 class="title">栏目列表</h3>
                    <ul class="category-list slide">
                        <zone:frontCategoryList categoryList="${categoryList}"/>
                    </ul>
                </div>
                <!-- Category Widget End -->
                <!-- Category Widget Start -->
                <div class="widget category">
                    <h3 class="title">推荐阅读</h3>
                    <ul class="category-list slide">
                        <zone:frontArticleHitsTop category="${category}"/>
                    </ul>
                </div>
                <!-- Category Widget End -->
            </div>
            <!-- Sidebar End -->
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-9">
                <zone:frontCurrentPosition category="${category}"/>
                <c:set var="index" value="1"/>
                <c:forEach items="${categoryList}" var="tpl">
                    <c:if test="${tpl.inList eq '1' && tpl.module ne ''}">
                        <c:set var="index" value="${index+1}"/>
                        ${index % 2 eq 0 ? '<div class="main-content" style="margin:15px 0px 15px;padding:20px 0px 0px;"><div class="container"><div class="row">':''}

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <h3 class="title">
                                <small><a href="${ctx}/list-${tpl.id}${urlSuffix}" class="pull-right">更多&gt;&gt;</a>
                                </small>
                                    ${tpl.name}</h3>
                            <div class="content-box big ch-item bottom-pad-small">
                                <div class="content-box-info">
                                    <c:if test="${tpl.module eq 'article'}">
                                        <ul><c:forEach items="${fnc:getArticleList(site.id, tpl.id, 5, '')}"
                                                       var="article">
                                            <li><span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                                         pattern="yyyy.MM.dd"/></span><a
                                                    href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                                                    style="color:${article.color}">${fns:abbr(article.title,40)}</a>
                                            </li>
                                        </c:forEach></ul>
                                    </c:if>
                                    <c:if test="${tpl.module eq 'link'}">
                                        <ul>
                                            <c:forEach items="${fnc:getLinkList(site.id, tpl.id, 5, '')}" var="link">
                                                <li>
                                                    <span class="pull-right">
                                                        <fmt:formatDate value="${link.updateDate}" pattern="yyyy.MM.dd"/>
                                                    </span>
                                                    <a target="_blank" href="${link.href}" style="color:${link.color}">${fns:abbr(link.title,40)}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        ${index % 2 ne 0 ? '</div></div></div>':''}
                    </c:if>
                </c:forEach>
                ${index % 2 eq 0 ? '</div></div></div>':''}
            </div>
        </div>
    </div>
</div>
<!-- Main Content end-->


<!-- The Scripts -->

</body>
</html>