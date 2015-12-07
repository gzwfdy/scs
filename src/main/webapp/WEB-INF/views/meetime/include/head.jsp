<%@ page contentType="text/html;charset=UTF-8" %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta charset="utf-8" />
<meta name="author" content="http://www.meetime.com/"/>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10"/>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />


<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/font-awesome/4.1.0/css/font-awesome.min.css" />

<!-- page specific plugin styles -->

<!-- text fonts -->
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

<!-- ace styles -->
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/css/ace.min.css" id="main-ace-style" />

<!--[if lte IE 9]>
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/css/ace-part2.min.css" />
<![endif]-->
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/css/ace-rtl.min.css" />

<!--[if lte IE 9]>
<link rel="stylesheet" href="${ctxStatic}/meetime/assets/css/ace-ie.min.css" />
<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="${ctxStatic}/meetime/assets/js/ace-extra.min.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
<script src="${ctxStatic}/meetime/assets/js/html5shiv.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/respond.min.js"></script>
<![endif]-->

<!-- basic scripts -->

<!--[if !IE]> -->
<script src="${ctxStatic}/meetime/assets/js/jquery/jquery-2.1.1.min.js"></script>
<!-- <![endif]-->

<!--[if IE]>
<script src="${ctxStatic}/meetime/assets/js/jquery/jquery-1.11.1.min.js"></script>
<![endif]-->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='assets/js/jquery.min.js'>"+"<"+"/script>");
</script>
<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
window.jQuery || document.write("<script src='assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctxStatic}/meetime/assets/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
<script src="${ctxStatic}/meetime/assets/js/excanvas.min.js"></script>
<![endif]-->
<!-- ace scripts -->
<script src="${ctxStatic}/meetime/assets/js/ace-elements.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/ace.min.js"></script>


<script src="${ctxStatic}/meetime/assets/js/jquery.form.js"></script>
<script src="${ctxStatic}/meetime/assets/js/jquery.validate.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/localization/messages_${language}.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/jquery.i18n.properties.js"></script>
<script type="text/javascript">var ctx = '${ctx}', ctxStatic = '${ctxStatic}', mctx = '${mctx}';</script>