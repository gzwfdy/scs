<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/modules/zone/include/taglib.jsp" %>
<!doctype html>
<html class="no-js">
<head>
    <meta name="decorator" content="zoneMobileDefault"/>
    <meta name="description" content="${category.description}"/>
    <meta name="keywords" content="${category.keywords}"/>
</head>
<body>

<div data-am-widget="list_news" class="am-list-news am-list-news-default" >
    <c:if test="${category.module eq 'article'}">
        <!--列表标题-->
        <div class="am-list-news-hd am-cf">
            <!--带更多链接-->
            <a href="#" class="">
                <h2>${category.name}</h2>
            </a>
        </div>
        <div class="am-list-news-bd">
            <ul class="am-list">
                <c:forEach items="${page.list}" var="article">
                    <li class="am-g">
                        <a href="${article.url}" class="am-list-item-hd "
                           style="color:${article.color}">${fns:abbr(article.title,96)}</a>
                    </li>
                </c:forEach>
            </ul>

        </div>
        <!--更多在底部-->
        <div class="am-list-news-ft">
            <a class="am-list-news-more am-btn am-btn-default " href="###">查看更多 &raquo;</a>
        </div>


    </c:if>


</div>




</body>
</html>
