<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp" %>
<%@ attribute name="category" type="com.thinkgem.jeesite.modules.cms.entity.Category" required="true"
              description="栏目对象" %>
<%--
<li><strong>当前位置：</strong><a href="${ctx}/index-${site.id}${urlSuffix}">首页</a></li>
<c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}" var="tpl">
    <c:if test="${tpl.id ne '1'}">
        <li><span class="divider">/</span> <a href="${ctx}/list-${tpl.id}${urlSuffix}">${tpl.name}</a></li>
    </c:if>
</c:forEach>
<li><span class="divider">/</span> <a href="${ctx}/list-${category.id}${urlSuffix}">${category.name}</a></li>
--%>


<!-- Title, Breadcrumb Start-->
<div class="breadcrumb-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-xs-12 col-sm-6">
                <h2 class="title pull-right">${category.name}</h2>
            </div>
            <div class="col-lg-6 col-md-6 col-xs-12 col-sm-6">
                <div class="breadcrumbs pull-right">
                    <ul>
                        <li><strong><fmt:message key="zone.position"/> </strong></li>
                        <li><a href="${ctx}/index-${site.id}${fns:getConfig("urlSuffix")}?locale=${site.locale}"><fmt:message key="zone.home"/> </a></li>
                        <c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}" var="tpl">
                            <c:if test="${tpl.id ne '1'}">
                                <li><a href="${ctx}/list-${tpl.id}${urlSuffix}">${tpl.name}</a></li>
                            </c:if>
                        </c:forEach>
                        <li><a href="${ctx}/list-${category.id}${urlSuffix}">${category.name}</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Title, Breadcrumb End-->