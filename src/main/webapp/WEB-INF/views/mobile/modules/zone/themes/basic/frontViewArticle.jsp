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

<article data-am-widget="paragraph"
         class="am-paragraph am-paragraph-default"

         data-am-paragraph="{ tableScrollable: true, pureview: true }">

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
</article>
<div data-am-widget="gotop" class="am-gotop am-gotop-default" >
    <a href="#top" title="回到顶部">
        <span class="am-gotop-title">回到顶部</span>
        <i class="am-gotop-icon am-icon-chevron-up"></i>
    </a>
</div>


</body>
</html>
