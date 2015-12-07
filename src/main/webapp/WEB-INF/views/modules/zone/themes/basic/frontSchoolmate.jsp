<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/zone/include/taglib.jsp" %>
<!DOCTYPE html>
<!--[if IE 8]> <html class="ie ie8"> <![endif]-->
<!--[if IE 9]> <html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html> <!--<![endif]-->
<head>
    <title>校友录</title>
    <meta name="decorator" content="zoneDefault"/>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
</head>
<body>


<!-- Main Content start-->
<div class="breadcrumb-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-xs-12 col-sm-6 ">
                <h2 class="title pull-right">校友录</h2>
            </div>
            <div class="col-lg-6 col-md-6 col-xs-12 col-sm-6">
                <div class="breadcrumbs pull-right">
                    <ul>
                        <li><fmt:message key="zone.position"/> </li>
                        <li><a href="${ctx}/index-${site.id}${fns:getConfig("urlSuffix")}?locale=${site.locale}"><fmt:message key="zone.home"/></a></li>
                        <li>校友录</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="content">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 center" id="contact-form">

                <p>
                    亲爱的大连外国语大学汉学院校友，如果您变更了您的信息，请让我们知道您最新的联系方式。

                </p>
                <p>
                    请在下面填写您的联系信息或发电子邮件给我们更新您的信息.谢谢
                </p>
                <div class="divider"></div>
                <form:form method="post" class="reply" modelAttribute="schoolmate" action="${ctx}/schoolmate/save">

                    <fieldset>
                        <h3 class="title">基本信息</h3>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.firstName"/> : <span>*</span></label>
                                <form:errors path="firstname" cssClass="alert-danger"/>
                                <input class="form-control" id="firstname" name="firstname" type="text" value="${schoolmate.firstname}" required="">

                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.familyName"/>: <span>*</span></label>
                                <form:errors path="familyname" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="familyname" name="familyname" value="${schoolmate.familyname}" required="">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.cnName"/> : </label>
                                <form:errors path="cnname" cssClass="alert-danger"/>
                                <input class="form-control" id="cnname" name="cnname" type="text" value="">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.birthday"/>: <span>*</span></label>
                                <form:errors path="birthday" cssClass="alert-danger"/>
                                <input id="birthday" name="birthday" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
                                       value="<fmt:formatDate value="${schoolmate.birthday}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'${language}'});"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.nationality"/> : <span>*</span></label>
                                <form:select path="nationality" cssClass="form-control" >
                                    <form:options  items="${fns:getDictList('country')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.sex"/> : <span>*</span></label>
                                <form:errors path="gender" cssClass="alert-danger"/>
                                <div>
                                    <form:radiobuttons path="gender" cssClass="radio-inline" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.occupations"/> : <span>*</span></label>
                                <form:errors path="occupations" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="occupations" name="occupations" value="${schoolmate.occupations}" required="">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.workingaddress"/> : <span>*</span></label>
                                <form:errors path="workingaddress" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="workingaddress" name="workingaddress" value="${schoolmate.workingaddress}" required="">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.zipcode"/> : </label>
                                <form:errors path="zipcode" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="zipcode" name="zipcode" value="${schoolmate.zipcode}" required="">
                            </div>
                        </div>
                        <h3 class="title">在校信息</h3>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.learningType"/> : <span>*</span></label>
                                <form:errors path="learningtype" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="learningtype" name="learningtype" value="${schoolmate.learningtype}" required="">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label>主修专业: <span>*</span></label>
                                <form:errors path="subject" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="subject" name="subject" value="${schoolmate.subject}" required="">
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

                                <label><fmt:message key="zone.enrollment"/> : <span>*</span></label>
                                <form:errors path="enrollment" cssClass="alert-danger"/>
                                <input id="enrollment" name="enrollment" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
                                       value="<fmt:formatDate value="${schoolmate.enrollment}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'${language}'});"/>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

                                <label><fmt:message key="zone.graduation"/> : <span>*</span></label>
                                <form:errors path="graduation" cssClass="alert-danger"/>
                                <input id="graduation" name="graduation" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
                                       value="<fmt:formatDate value="${schoolmate.graduation}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'${language}'});"/>
                            </div>
                        </div>
                        <h3 class="title"><fmt:message key="zone.contact_information"/> </h3>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.address"/> : <span>*</span></label>
                                <form:errors path="address" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="address" name="address" value="${schoolmate.address}" required="">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.tel"/> : <span>*</span></label>
                                <form:errors path="tel" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="tel" name="tel" value="${schoolmate.tel}" required="">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.E_mail"/> : <span>*</span></label>
                                <form:errors path="email" cssClass="alert-danger"/>
                                <input class="form-control" type="email" id="email" name="email" value="${schoolmate.email}" required="">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label><fmt:message key="zone.fax"/> : </label>
                                <form:errors path="fax" cssClass="alert-danger"/>
                                <input class="form-control" type="text" id="fax" name="fax" value="${schoolmate.fax}" required="">
                            </div>
                        </div>

                    </fieldset>
                    <button class="btn-normal btn-color submit  bottom-pad" type="submit"><fmt:message key="zone.submit"/> </button>
                    <div class="success alert-success alert" style="display:none">Your message has been sent successfully.</div>
                    <div class="error alert-error alert" style="display:none">E-mail must be valid and message must be longer than 100 characters.</div>
                    <div class="clearfix">
                    </div>
                </form:form>
            </div>

        </div>

        <div class="divider"></div>
    </div>
</div>

<!-- The Scripts -->

</body>
</html>