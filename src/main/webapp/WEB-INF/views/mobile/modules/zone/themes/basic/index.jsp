<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/modules/zone/include/taglib.jsp" %>
<!doctype html>
<html class="no-js">
<head>
    <meta name="decorator" content="zoneMobileIndex"/>
    <meta name="description" content="${category.description}"/>
    <meta name="keywords" content="${category.keywords}"/>
</head>
<body>

<div data-am-widget="slider" class="am-slider am-slider-default"
     data-am-slider='{"animation":"slide","slideshow":true,randomize:false}'>
    <ul class="am-slides">
        <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.homeAD ,10 ,'' )}" var="ad">
            <li>
                <a href="${ad.url}"><img src="${ad.image}"></a>
                <div class="am-slider-desc">${ad.description}</div>
            </li>
        </c:forEach>
    </ul>
</div>
<hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>

<div class="am-container">
    <div class="am-g">
        <div class="am-u-lg-6 am-u-md-6 am-u-sm-12">
            <div data-am-widget="list_news" class="am-list-news am-list-news-default">
                <!--列表标题-->
                <div class="am-list-news-hd am-cf">
                    <!--带更多链接-->
                    <a href="${fnc:getCategory(site.row1col1).url}" class="">
                        <h2>${fnc:getCategory(site.row1col1).name}</h2>
                        <span class="am-list-news-more am-fr">更多 &raquo;</span>
                    </a>
                </div>

                <div class="am-list-news-bd">
                    <ul class="am-list">
                        <!--缩略图在标题左边-->
                        <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.row1col1 ,5 ,'' )}" var="article">
                            <li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left">
                                <div class="am-u-sm-4 am-list-thumb">
                                    <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}">
                                        <img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/recent-post-img.jpg">
                                    </a>
                                </div>
                                <div class=" am-u-sm-8 am-list-main">
                                    <h3 class="am-list-item-hd"><a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}">${fns:abbr(article.title,40)}</a>
                                    </h3>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div class="am-u-lg-6 am-u-md-6 am-u-sm-12">
            <div data-am-widget="list_news" class="am-list-news am-list-news-default">
                <!--列表标题-->
                <div class="am-list-news-hd am-cf">
                    <!--带更多链接-->
                    <a href="${fnc:getCategory(site.row2col1).url}" class="">
                        <h2>${fnc:getCategory(site.row2col1).name}</h2>
                        <span class="am-list-news-more am-fr">更多 &raquo;</span>
                    </a>
                </div>
                <div class="am-list-news-bd">
                    <ul class="am-list">
                        <!--缩略图在标题左边-->
                        <c:forEach items="${fnc:getArticleList(fnc:getCurrentSiteId(),site.row2col1 ,5 ,'' )}" var="article">
                            <li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left">
                                <div class="am-u-sm-4 am-list-thumb">
                                    <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}">
                                        <img class="img-thumbnail recent-post-img" alt="" src="${ctxStatic}/zone/img/recent-post-img.jpg">
                                    </a>
                                </div>
                                <div class=" am-u-sm-8 am-list-main">
                                    <h3 class="am-list-item-hd"><a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}" style="color:${article.color}">${fns:abbr(article.title,40)}</a>
                                    </h3>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>