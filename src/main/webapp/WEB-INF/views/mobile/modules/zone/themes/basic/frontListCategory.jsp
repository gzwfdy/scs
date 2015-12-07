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
    <!--列表标题-->
    <div class="am-list-news-hd am-cf">
        <!--带更多链接-->
        <a href="##" class="">
            <h2>栏目标题</h2>
            <span class="am-list-news-more am-fr">更多 &raquo;</span>
        </a>
    </div>

    <div class="am-list-news-bd">
        <ul class="am-list">

            <li class="am-g am-list-item-dated">
                <a href="##" class="am-list-item-hd ">我很囧，你保重....晒晒旅行中的那些囧！</a>

                <span class="am-list-date">2013-09-18</span>


            </li>
            <li class="am-g am-list-item-dated">
                <a href="##" class="am-list-item-hd ">我最喜欢的一张画</a>

                <span class="am-list-date">2013-10-14</span>


            </li>
            <li class="am-g am-list-item-dated">
                <a href="##" class="am-list-item-hd ">“你的旅行，是什么颜色？” 晒照片，换北欧梦幻极光之旅！</a>

                <span class="am-list-date">2013-11-18</span>


            </li>
        </ul>
    </div>

</div>






</body>
</html>
