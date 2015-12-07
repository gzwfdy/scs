<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>校友管理</title>
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
		<li><a href="${ctx}/schoolmate/list/">校友列表</a></li>
		<li class="active"><a href="${ctx}/schoolmate/form?id=${schoolmate.id}"><shiro:hasPermission name="cms:schoolmate:edit">${not empty schoolmate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:schoolmate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="schoolmate" action="${ctx}/schoolmate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">名:</label>
			<div class="controls">
				<form:input path="firstname" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓:</label>
			<div class="controls">
				<form:input path="familyname" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">中文名:</label>
			<div class="controls">
				<form:input path="cnname" htmlEscape="false" maxlength="10" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生日:</label>
			<div class="controls">
				<input id="birthday" name="birthday" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					   value="<fmt:formatDate value="${schoolmate.birthday}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,lang:'zh'});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">国籍:</label>
			<div class="controls">
				<form:select path="nationality">
					<form:options  items="${fns:getDictList('country')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别:</label>
			<div class="controls">
				<form:radiobuttons path="gender" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目前职业:</label>
			<div class="controls">
				<form:input path="occupations" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作地址:</label>
			<div class="controls">
				<form:input path="workingaddress" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮编:</label>
			<div class="controls">
				<form:input path="zipcode" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学习类别:</label>
			<div class="controls">
				<form:input path="learningtype" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">主修专业:</label>
			<div class="controls">
				<form:input path="subject" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入学时间:</label>
			<div class="controls">
				<input id="enrollment" name="enrollment" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					   value="<fmt:formatDate value="${schoolmate.enrollment}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">毕业时间:</label>
			<div class="controls">
				<input id="graduation" name="graduation" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
					   value="<fmt:formatDate value="${schoolmate.graduation}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">居住地址:</label>
			<div class="controls">
				<form:input path="address" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话:</label>
			<div class="controls">
				<form:input path="tel" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮件:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">传真:</label>
			<div class="controls">
				<form:input path="fax" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:site:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>