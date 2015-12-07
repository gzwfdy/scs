<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>校友管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/schoolmate/list">校友列表</a></li>
		<li class=""><a href="${ctx}/schoolmate/form?id=${schoolmate.id}"><shiro:hasPermission name="cms:schoolmate:edit">${not empty schoolmate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:schoolmate:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="schoolmate" action="${ctx}/schoolmate/export/" method="post" class="breadcrumb form-search">

		<input id="btnSubmit" class="btn btn-primary" type="submit" value="导出"/>&nbsp;&nbsp;
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名</th><th>姓</th><th>中文名</th><th>主修专业</th><th>毕业时间</th><th>性别</th><th>国籍</th><shiro:hasPermission name="cms:schoolmate:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolmate">
			<tr>
				<td><a href="${ctx}/schoolmate/form?id=${schoolmate.id}" title="${schoolmate.firstname}">${fns:abbr(schoolmate.firstname,40)}</a></td>
				<td>${fns:abbr(schoolmate.familyname,40)}</td>
				<td>${fns:abbr(schoolmate.cnname,40)}</td>
				<td>${fns:abbr(schoolmate.subject,40)}</td>
				<td><fmt:formatDate value="${schoolmate.graduation}" pattern="yyyy年MM月dd日 E"/></td>
				<td>${fns:abbr(schoolmate.gendercn,40)}</td>
				<td>${schoolmate.nationalitycn}</td>
				<shiro:hasPermission name="cms:schoolmate:edit"><td>
    				<a href="${ctx}/schoolmate/form?id=${schoolmate.id}">修改</a>
					<a href="${ctx}/schoolmate/delete?id=${schoolmate.id}${schoolmate.delFlag ne 0?'&isRe=true':''}" onclick="return confirmx('确认要${schoolmate.delFlag ne 0?'恢复':''}删除该站点吗？', this.href)" >${schoolmate.delFlag ne 0?'恢复':''}删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>