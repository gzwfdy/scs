<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>站点管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/site/">站点列表</a></li>
		<li class="active"><a href="${ctx}/cms/site/form?id=${site.id}">站点<shiro:hasPermission name="cms:site:edit">${not empty site.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:site:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="site" action="${ctx}/cms/site/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">站点名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">站点标题:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits"/>
				<span class="help-inline">站点的排列次序，影响首页语言切换的现实顺序</span>
			</div>
		</div>
		<c:if test="${empty site.id}">
			<div class="control-group">
				<label class="control-label">语言:</label>
				<div class="controls">
					<form:select path="locale">
						<form:options  items="${fns:getSiteLocaleNotUsed()}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty site.id}">
			<div class="control-group">
				<label class="control-label">语言:</label>
				<div class="controls">
					<form:select path="locale">
						<form:options  items="${fns:getDictList('locale')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">站点Logo:</label>
			<div class="controls">
				<form:hidden path="logo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="logo" type="images" uploadPath="/cms/site"/>
				<span class="help-inline">建议Logo大小：285 × 60（像素）</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">填写描述及关键字，有助于搜索引擎优化</span>
			</div>
		</div>

		<%--<c:if test="${not empty site.homeADs}">
			<c:forEach items="${site.homeADs}" var="homead" varStatus="status">
				<div class="control-group">
					<label class="control-label">宣传图片及描述${status.index}:</label>
					<div class="controls">
						<input type="hidden" readonly="readonly" id="homeADs_${status.index}_image" name="homeADs[${status.index}].image" value="${homead.image}" />
						<sys:ckfinder input="homeADs_${status.index}_image" type="images" uploadPath="/cms/article" selectMultiple="false"/>
					</div>
					<div class="controls">
						<form:textarea rows="2" path="homeADs[${status.index}].des" htmlEscape="false" maxlength="200" class="input-xxlarge"/>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty site.homeADs}">
			<c:forEach var="i" begin="0" end="5" step="1">
				<div class="control-group">
					<label class="control-label">宣传图片及描述${i}:</label>
					<div class="controls">
						<input type="hidden" readonly="readonly" id="homeADs_${i}_image" name="homeADs[${i}].image" value="" />
						<sys:ckfinder input="homeADs_${i}_image" type="images" uploadPath="/cms/article" selectMultiple="false"/>
					</div>
					<div class="controls">
						<form:textarea rows="2" path="homeADs[${i}].des" htmlEscape="false" maxlength="200" class="input-xxlarge"/>
					</div>
				</div>
			</c:forEach>
		</c:if>--%>
		<div class="control-group">
			<label class="control-label">首页广告位:</label>
			<div class="controls">
				<sys:treeselect id="homeAD" name="homeAD" value="${site.homeAD}" labelName="_homeAD" labelValue="${site.homeADcn}"
									title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第一行第一列:</label>
			<div class="controls">
				<sys:treeselect id="row1col1" name="row1col1" value="${site.row1col1}" labelName="_row1col1" labelValue="${site.row1col1cn}"
									title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第一行第二列:</label>
			<div class="controls">
				<input type="hidden" readonly="readonly" id="row1col2" name="row1col2" data-filename="${site.row1col2}" value="${site.row1col2}" />
				<sys:ckfinder input="row1col2" type="files" uploadPath="/cms/files" selectMultiple="false"/>
				<span class="help-inline">请选择mp4格式的视频文件</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第一行第三列:</label>
			<div class="controls">
				<sys:treeselect id="row1col3" name="row1col3" value="${site.row1col3}" labelName="_row1col3" labelValue="${site.row1col3cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">第二行第一列:</label>
			<div class="controls">
				<sys:treeselect id="row2col1" name="row2col1" value="${site.row2col1}" labelName="_row2col1" labelValue="${site.row2col1cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">第二行第二列:</label>
			<div class="controls">
				<sys:treeselect id="row2col2" name="row2col2" value="${site.row2col2}" labelName="_row2col2" labelValue="${site.row2col2cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">第二行第三列:</label>
			<div class="controls">
				<sys:treeselect id="row2col3" name="row2col3" value="${site.row2col3}" labelName="_row2col3" labelValue="${site.row2col3cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">第三行第一列:</label>
			<div class="controls">
				<sys:treeselect id="row3col1" name="row3col1" value="${site.row3col1}" labelName="_row3col1" labelValue="${site.row3col1cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第三行第二列:</label>
			<div class="controls">
				<sys:treeselect id="row3col2" name="row3col2" value="${site.row3col2}" labelName="_row3col2" labelValue="${site.row3col2cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第三行第三列:</label>
			<div class="controls">
				<sys:treeselect id="row3col3" name="row3col3" value="${site.row3col3}" labelName="_row3col3" labelValue="${site.row3col3cn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">在线申请:</label>
			<div class="controls">
				<form:input path="aol" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">资料下载:</label>
			<div class="controls">
				<sys:treeselect id="download" name="download" value="${site.download}" labelName="_download" labelValue="${site.downloadcn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">友情链接:</label>
			<div class="controls">
				<sys:treeselect id="link" name="link" value="${site.link}" labelName="_link" labelValue="${site.linkcn}"
								title="栏目" url="/cms/category/treeData" extId="0" cssClass="required"/>
				<span class="help-inline">请选择要显示的栏目名称，不能选择“顶级栏目”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">二维码:</label>
			<div class="controls">
				<form:textarea path="qrcodecontents" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">版权信息:</label>
			<div class="controls">
				<form:textarea id="copyright" htmlEscape="true" path="copyright" rows="4" maxlength="200" class="input-xxlarge" uploadPath="/cms/site"/>
				<%--<form:textarea id="copyright" htmlEscape="true" path="copyright" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="copyright" uploadPath="/cms/site" />--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义首页视图:</label>
			<div class="controls">
				<form:input path="customIndexView" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">域名:</label>
			<div class="controls">
				<form:input path="domain" htmlEscape="false" maxlength="10"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:site:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>