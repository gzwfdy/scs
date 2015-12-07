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
                        <input type="text" value="搜索..." onfocus="if(this.value=='搜索...')this.value='';"
                               onblur="if(this.value=='')this.value='Search...';"
                               class="search-input form-control">
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
                <div class="main-content" style="margin: 15px 0 15px;padding: 20px 0 0;">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="content-box big ch-item bottom-pad-small">
                                <div class="content-box-info">
                                    <%--<h4>${category.name}</h4>--%>
                                    <c:if test="${category.module eq 'article'}">
                                        <ul>
                                            <c:forEach items="${page.list}" var="article">
                                                <li>
                                                    <span class="pull-right">
                                                        <fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/>
                                                    </span>
                                                    <a href="${article.url}"
                                                       style="color:${article.color}">${fns:abbr(article.title,96)}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <div class="pagination-centered">${page}</div>
                                        <script type="text/javascript">
                                            function page(n, s) {
                                                location = "${ctx}/list-${category.id}${urlSuffix}?pageNo=" + n + "&pageSize=" + s;
                                            }
                                        </script>
                                    </c:if>
                                    <c:if test="${category.module eq 'link'}">
                                        <ul>
                                            <c:forEach items="${page.list}" var="link">
                                                <li>
                                                    <a href="${link.href}" target="_blank" style="color:${link.color}">
                                                        <c:out value="${link.title}"/>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </div>
                            </div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- The Scripts -->

</body>
</html>