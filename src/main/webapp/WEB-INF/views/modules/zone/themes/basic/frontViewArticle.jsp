<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${article.title} - ${category.name}</title>
    <meta name="decorator" content="zoneDefault"/>
    <meta name="description" content="${article.description} ${category.description}"/>
    <meta name="keywords" content="${article.keywords} ${category.keywords}"/>
    <script type="text/javascript">
        $(document).ready(function () {
            if ("${category.allowComment}" == "1" && "${article.articleData.allowComment}" == "1") {
                $("#comment").show();
                page(1);
            }
        });
        function page(n, s) {
            $.get("${ctx}/comment", {
                theme: '${site.theme}',
                'category.id': '${category.id}',
                contentId: '${article.id}',
                title: '${article.title}',
                pageNo: n,
                pageSize: s,
                date: new Date().getTime()
            }, function (data) {
                $("#comment").html(data);
            });
        }
    </script>
</head>
<body class="page">
<div class="wrap">
    <!-- Header Start -->

    <!-- Content Start -->
    <div id="main">



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
                    <div class="posts-block col-lg-9 col-md-9 col-sm-8 col-xs-12">
                        <zone:frontCurrentPosition category="${category}"/>
                        <article class="post hentry">

                            <div class="post-content">
                                <h3 style="color:#555555;font-size:20px;text-align:center;border-bottom:1px solid #ddd;padding-bottom:15px;margin:25px 0;">${article.title}</h3>
                                <c:if test="${not empty article.description}">
                                    <div>摘要：${article.description}</div>
                                </c:if>
                                <div>${article.articleData.content}</div>
                                <c:if test="${not empty article.attachment}">
                                    <c:forTokens items="${article.attachment}" delims="|" var="att">
                                        <c:set var="paths" value="${fn:split(att, '/')}"/>
                                        <div><a href="${att}">${paths[fn:length(paths)-1]}</a></div>
                                    </c:forTokens>
                                </c:if>
                                <div style="border-top:1px solid #ddd;padding:10px;margin:25px 0;">
                                    发布者：${article.user.name} &nbsp;
                                    点击数：${article.hits} &nbsp; 发布时间：<fmt:formatDate value="${article.createDate}"
                                                                                    pattern="yyyy-MM-dd HH:mm:ss"/>
                                    &nbsp;
                                    更新时间：<fmt:formatDate value="${article.updateDate}"
                                                         pattern="yyyy-MM-dd HH:mm:ss"/></div>
                            </div>
                        </article>
                        <div class="blog-divider" style="margin:0px;"></div>
                        <div class="about-author">

                            <div class="author-content">
                                <div class="data">
                                    <h4><a href="#">相关文章</a></h4>
                                    <ol><c:forEach items="${relationList}" var="relation">
                                        <li style="float:left;width:230px;"><a
                                                href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}">${fns:abbr(relation[2],30)}</a>
                                        </li>
                                    </c:forEach></ol>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Left Section End -->
                </div>
            </div>
        </div>
        <!-- Main Content end-->


        <%--<div class="span10">
            <div class="row">
                <div class="span10">
                    <h3 style="color:#555555;font-size:20px;text-align:center;border-bottom:1px solid #ddd;padding-bottom:15px;margin:25px 0;">${article.title}</h3>
                    <c:if test="${not empty article.description}">
                        <div>摘要：${article.description}</div>
                    </c:if>
                    <div>${article.articleData.content}</div>
                    <div style="border-top:1px solid #ddd;padding:10px;margin:25px 0;">发布者：${article.user.name} &nbsp;
                        点击数：${article.hits} &nbsp; 发布时间：<fmt:formatDate value="${article.createDate}"
                                                                        pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;
                        更新时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                </div>
                <div class="divider"></div>
                <!-- Comments Section Start -->
                <div class="comment-wrapper">


                    <h5>相关文章</h5>
                    <ol><c:forEach items="${relationList}" var="relation">
                        <li style="float:left;width:230px;"><a
                                href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}">${fns:abbr(relation[2],30)}</a>
                        </li>
                    </c:forEach></ol>
                </div>
            </div>
            <div class="row">
                <div id="comment" class="hide span10">
                    正在加载评论...
                </div>
            </div>
            <div class="row">
                <div class="span10">
                    <h5>相关文章</h5>
                    <ol><c:forEach items="${relationList}" var="relation">
                        <li style="float:left;width:230px;"><a
                                href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}">${fns:abbr(relation[2],30)}</a>
                        </li>
                    </c:forEach></ol>
                </div>
            </div>--%>
    </div>
</div>
</div>
</body>
</html>