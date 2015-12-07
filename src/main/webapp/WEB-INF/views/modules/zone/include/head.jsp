<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta name="author" content="http://www.asv.com"/>
<meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10"/>
<meta charset="utf-8">
<meta name="description" content="<fmt:message key='zone.description'/> ">
<meta name="author" content="www.meetime.com">
<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="${ctxStatic}/zone/js/jquery.min.js" type="text/javascript"></script>
<c:if test="${site.theme eq 'basic'}">

    <!-- Google Fonts
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald:400,300,700' rel='stylesheet' type='text/css'>
    -->
    <!-- Library CSS -->
    <script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${ctxStatic}/zone/css/bootstrap.css">
    <link rel="stylesheet" href="${ctxStatic}/zone/css/fonts/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${ctxStatic}/zone/css/animations.css" media="screen">

    <link rel="stylesheet" href="${ctxStatic}/zone/css/revolution-slider/css/settings.css" media="screen">
    <link rel="stylesheet" href="${ctxStatic}/zone/css/nivo-slider.css" media="screen">
    <link rel="stylesheet" href="${ctxStatic}/zone/css/prettyPhoto.css" media="screen">
    <link href="${ctxStatic}/zone/css/switcher.css" rel="stylesheet">
    <link href="http://vjs.zencdn.net/5.0.2/video-js.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${ctxStatic}/zone/css/style.css">
    <link href="${ctxStatic}/common/jeesite.min.css" type="text/css" rel="stylesheet"/>
    <!-- Skin -->
    <link rel="stylesheet" href="${ctxStatic}/zone/css/colors/blue.css" id="colors">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="${ctxStatic}/zone/css/theme-responsive.css">
    <!-- Switcher CSS -->
    <link href="${ctxStatic}/zone/css/switcher.css" rel="stylesheet">
    <link href="${ctxStatic}/zone/css/spectrum.css" rel="stylesheet">


    <link rel="stylesheet" href="${ctxStatic}/zone/css/superfish.css" media="screen">
    <!-- Favicons -->
    <link rel="shortcut icon" href="${ctxStatic}/zone/img/ico/favicon.png">
    <link rel="apple-touch-icon" href="${ctxStatic}/zone/img/ico/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="${ctxStatic}/zone/img/ico/apple-touch-icon-72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="${ctxStatic}/zone/img/ico/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="144x144" href="${ctxStatic}/zone/img/ico/apple-touch-icon-144.png">
    <!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="${ctxStatic}/zone/html5shiv.js"></script>
    <script src="${ctxStatic}/zone/js/respond.min.js"></script>
    <![endif]-->
    <!--[if IE]>
    <link rel="stylesheet" href="${ctxStatic}/zone/css/ie.css">
    <![endif]-->
</c:if>