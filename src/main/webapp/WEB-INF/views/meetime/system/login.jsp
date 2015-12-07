<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title></title>
    <meta name="decorator" content="meetimelogin"/>


</head>
<body class="login-layout light-login">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container" style="margin:120px auto 0 auto;">
                    <div class="space-30"></div>
                    <div class="position-relative">

                        <div id="login-box" class="login-box visible widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main" style="padding: 16px 15px 23px 30px;">
                                    <div class="center">
                                        <h6 style="text-align: center !important;margin:1px;">
                                            <i class="ace-icon fa" style="text-align: center !important;">
                                                <img src="meetime/assets/images/8.png"
                                                     style="text-align: left !important;width:222px;height: 77px"/>
                                            </i>
                                        </h6>
                                    </div>
                                    <div class="space-6"></div>
                                    <form id="validation-form" action="${mctx}/login" method="post">
                                        <div id="msg" class="alert alert-danger hide">
                                            <strong> <i class="ace-icon fa fa-times"></i> Oh
                                                snap!
                                            </strong> <br/>
                                        </div>

                                        <div class="form-group">
                                            <label class="block clearfix">
												 <span class="block input-icon input-icon-left col-xs-12 col-sm-12"
                                                       style="padding-left:0px;">
														<input type="text" class="col-xs-11 col-sm-11"
                                                               placeholder="<fmt:message key='login.meetimenumber'/>"
                                                               id="meetime_no"
                                                               name="meetime_no" style="border-radius: 5px !important;"
                                                               required width="100px"/>
														<i class="ace-icon fa fa-user"></i>
														<span class="help-button" id="help1" data-rel="popover"
                                                              data-trigger="click" data-placement="right"
                                                              data-content="<fmt:message key='login.meetimenumber.help.content' />"
                                                              title="<fmt:message key='login.meetimenumber.help.title' />" html="true"
                                                              data-original-title="<fmt:message key='login.meetimenumber.help.title' />">?</span>
												</span>
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label class="block clearfix">
												 	<span class=" input-icon input-icon-left col-xs-12 col-sm-12"
                                                          style="padding-left:0px;">
												 		<input type="text" class="col-xs-11 col-sm-11"
                                                               placeholder="<fmt:message key='login.name' />"
                                                               id="username" name="username"
                                                               style="border-radius: 5px !important;" required/>

														<i class="ace-icon fa fa-pencil"></i>

														<span class="help-button" id="help2" data-rel="popover"
                                                              data-trigger="click" data-placement="right"
                                                              data-content="<fmt:message key='login.password.content' />"
                                                              title="<fmt:message key='login.password.title' />" html="true"
                                                              data-original-title="<fmt:message key='login.password.title' />">?</span>
													</span>
                                            </label>
                                        </div>
                                        <div class="clearfix form-inline">
                                            <button id="mainSubmit" name="submit" type="submit"
                                                    class="width-50 pull-left btn btn-sm btn-success">
                                                <span class="bigger-110"><fmt:message key="login.enter"/></span>
                                            </button>
                                            <button id="signup" name="signup" type="button"
                                                    class="width-35 pull-right btn btn-sm btn-primary"
                                                    style="margin: 0px 38px 0px 0px;">
                                                <span class="bigger-110"><fmt:message key="login.register"/> </span>
                                            </button>
                                        </div>
                                        <div class="space-4"></div>
                                    </form>
                                </div>
                                <!-- /.widget-main -->
                                <div class="toolbar clearfix">
                                    <div style="width:33%">
                                        <a href="http://x.eqxiu.com/s/09Gu7By0?eqrcode=1" target="_blank"
                                           class="forgot-password-link"> <i
                                                class="ace-icon fa fa-arrow-left"></i> <fmt:message key='login.introduce' />
                                        </a>
                                    </div>

                                    <div style="width:33%">
                                        <!-- <a href="#" data-target="#servicecenter" class="user-signup-link"> -->
                                        <a href="javascript:void(0)" id="service_center"
                                           class="forgot-password-link"> <fmt:message key='login.servicecenter' /> <i
                                                class="ace-icon fa fa-arrow-right"></i>
                                        </a>
                                    </div>

                                </div>

                            </div>
                            <!-- /.widget-body -->
                        </div>
                        <!-- /.login-box -->


                        <div id="inputpassword-box"
                             class="forgot-box widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header red lighter bigger">
                                        <i class="ace-icon fa fa-key"></i> <fmt:message key='login.login' />
                                    </h4>

                                    <div class="space-6"></div>
                                    <p>${password}</p>

                                    <form id="login-password-form"
                                          action="login.html?reqCode=login" method="post">
                                        <div id="login_msg" class="alert alert-danger hide">

                                            <strong> <i class="ace-icon fa fa-times"></i>
                                            </strong> <br><fmt:message key="youCanAlsoDo"/>
                                            <a href="javascript:void(0)" onclick="resetpassword()"><fmt:message
                                                    key="restPassword"/> </a>
                                        </div>
                                        <fieldset>
                                            <label class="block clearfix"> <span
                                                    class="block input-icon input-icon-left"> <input
                                                    type="password" class="form-control"
                                                    placeholder="<fmt:message key='login.password'/> " id="password"
                                                    name="password"/>
														<i class="ace-icon fa fa-key"></i>
												</span>
                                            </label>
                                            <c:if test="${isValidateCodeLogin}"><div class="validateCode">
                                                <label class="input-label mid" for="validateCode">验证码</label>
                                                <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                                            </div></c:if>
                                            <div class="clearfix">
                                                <button type="submit"
                                                        class="width-100 btn btn-sm btn-danger" name="login" id="login">
                                                    <i class="ace-icon fa fa-lightbulb-o"></i> <span
                                                        class="bigger-110"><fmt:message key="sure"/> </span>
                                                </button>
                                            </div>


                                        </fieldset>
                                    </form>
                                </div>
                                <!-- /.widget-main -->

                                <div class="toolbar center">
                                    <a href="#" data-target="#login-box"
                                       class="back-to-login-link"> <fmt:message key='back' /> </a>
                                </div>
                            </div>
                            <!-- /.widget-body -->
                        </div>

                        <!-- /.forgot-box -->


                        <div class="navbar-fixed-top align-right">
                            <!-- <br /> &nbsp; <a id="btn-login-dark" href="#">${dark}</a> &nbsp;
							<span class="blue">/</span> &nbsp; <a id="btn-login-blur"
								href="#">${blue}</a> &nbsp; <span class="blue">/</span> &nbsp; <a
								id="btn-login-light" href="#">${light}</a> &nbsp; &nbsp; &nbsp; -->
                            <br>

                            <div class="btn-group">
                                <button id="locale" data-toggle="dropdown"
                                        class="btn btn-info btn-xs dropdown-toggle">
                                    <fmt:message key='login.language' /> <span
                                        class="ace-icon fa fa-caret-down icon-on-right"></span>
                                </button>

                                <ul class="dropdown-menu dropdown-inverse"
                                    style="min-width:20px;">
                                    <li><a href="javascript:void(0)"
                                           onClick="changeLocale('zh_CN')">中文</a></li>

                                    <li><a href="javascript:void(0)"
                                           onClick="changeLocale('en_US')">English</a></li>

                                    <!-- <li><a href="javascript:void(0)"
                                        onClick="changeLocale('js_JA')">日本語</a></li>
                                    <li><a href="javascript:void(0)"
                                        onClick="changeLocale('fr_FR')">Français</a></li>
                                    <li><a href="javascript:void(0)"
                                        onClick="changeLocale('ru_RU')">русский</a></li>
                                    <li class="divider"></li>

                                    <li><a href="#">默认(Auto)</a></li> -->
                                </ul>
                            </div>
                            &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                        </div>
                    </div>

                    <div class="login-footer">
                        <a target="_blank">&copy; 2015 ASV&reg;
                        </a>
                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.main-content -->
    </div>
</div>
<!-- /.main-container -->


<script src="${ctxStatic}/meetime/assets/js/jquery.nestable.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/fuelux/fuelux.spinner.min.js"></script>

<script src="${ctxStatic}/meetime/assets/js/date-time/moment-with-locales.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/date-time/bootstrap-datetimepicker.min.js"></script>

<script src="${ctxStatic}/meetime/assets/js/jquery-ui.custom.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/bootbox.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/jquery.easypiechart.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/jquery.gritter.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/bootstrap-tag.min.js"></script>
<script src="${ctxStatic}/meetime/assets/js/spin.min.js"></script>

<script src="${ctxStatic}/meetime/assets/js/meetime/login.js"></script>

<!-- inline scripts related to this page -->
<script type="text/javascript">

    jQuery.i18n.properties({
        name: 'messages',// 资源文件名称
        path: '${ctxStatic}/meetime/resource/i18n/',// 资源文件所在目录路径
        mode: 'both',// 模式：变量或 Map
        cache: false,
        language: '${language}',
        encoding: 'UTF-8',
        callback: function () {// 回调方法
            //alert($.i18n.browserLang());
        }
    });

    jQuery(function ($) {
        $('[data-rel="tooltip"]').tooltip();
        $('[data-rel=popover]').popover({container: 'body', html: true, show: 10, hide: 1000});
        $("#meetime_no").focus();
        //$("#meetime_no").popover('toggle');


        $("#help1").click(function (event) {
            //$(this).popover('toggle');
            $("#help2").popover('hide');
            event.stopPropagation();
        });
        $("#help2").click(function (event) {
            //$(this).popover('toggle');
            $("#help1").popover('hide');
            event.stopPropagation();
        });

        $("#meetime_no").keydown(function () {
            $(".help-button").popover('hide');
        });

        $("#username").keydown(function () {
            $(".help-button").popover('hide');
        });


        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.data('size') || 400,
                //styleClass: 'scroll-left scroll-margin scroll-thin scroll-dark scroll-light no-track scroll-visible'
            });
        });

        $(document).on('click', '.toolbar a[data-target]', function (e) {
            //console.debug("document click");
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
            $(target).find(":input:first").focus();
        });

        $(document).on('click', '.widget-toolbox a[data-target]', function (e) {
            //console.debug("document click");
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
            var flag = $(this).data('flag');
            $(target).find(":input:first").focus();
            //login-container
            $(".login-container").css("margin", "margin", "120px auto 0 auto");
            if (flag) {
                $("#agreement").prop("checked", true);
            }
            else
                $("#agreement").prop("checked", false);
        });


        $("div .dd-handle").click(function (e) {
            console.debug($(this).html());
        });


        $('#conference_date_start').datetimepicker({
                    format: 'YYYY年MM月DD日 HH点mm分',
                    stepping: 15
                }
        );
        $('#conference_date_end').datetimepicker({
            format: 'YYYY年MM月DD日 HH点mm分',
            stepping: 15
        });


        var tag_input = $('#conference_participants');
        try {
            tag_input.tag(
                    {
                        placeholder: tag_input.attr('placeholder'),
                        id: "participants_tag",

                        //enable typeahead by specifying the source array
                        //source: ace.vars['US_STATES'],//defined in ace.js >> ace.enable_search_ahead
                        /**
                         //or fetch data from database, fetch those that match "query"
                         source: function(query, process) {
						  $.ajax({url: 'remote_source.php?q='+encodeURIComponent(query)})
						  .done(function(result_items){
							process(result_items);
						  });
						}
                         */
                    }
            )

            //programmatically add a new
            /* var $tag_obj = $('#conference_participants');
             var x = $tag_obj.data('tag');
             x.add('Programmatically Added'); */
        }
        catch (e) {
            //display a textarea for old IE, because it doesn't support this plugin or another one I tried!
            tag_input.after('<textarea id="' + tag_input.attr('id') + '" name="' + tag_input.attr('name') + '" rows="3">' + tag_input.val() + '</textarea>').remove();
            //$('#form-field-tags').autosize({append: "\n"});
        }

        $('#conference_participants').on('added', function (e, value) {
            //alert($(this).siblings('.tag').length);
            if ($('#particpant_count').val() - $(this).siblings('.tag').length == 0) {
                $('#participants_tag').attr("placeholder", "");
            } else {
                if ($('#particpant_count').val() - $(this).siblings('.tag').length < 0) {
                    $('#participants_tag').attr("placeholder", "需要" + $('#particpant_count').val() + "个邮箱地址，实际提供了" + $(this).siblings('.tag').length + "个，不符合要求！");
                } else {
                    $('#participants_tag').attr("placeholder", "还需要" + ($('#particpant_count').val() - $(this).siblings('.tag').length) + "位参与人员的邮箱地址");
                }
            }
        })

        $('#conference_participants').on('removed', function (e, value) {
            //alert($(this).siblings('.tag').length);
            if ($(this).siblings('.tag').length == 0) {
                $('#participants_tag').attr("placeholder", "输入" + $('#particpant_count').val() + "位参与人员的邮箱地址");
            } else {
                $('#participants_tag').attr("placeholder", "还需要" + ($('#particpant_count').val() - $(this).siblings('.tag').length) + "位参与人员的邮箱地址");
            }
        })

        $('#particpant_count').ace_spinner({
            value: 1,
            min: 1,
            max: 10,
            step: 1,
            on_sides: true,
            icon_up: 'ace-icon fa fa-plus smaller-75',
            icon_down: 'ace-icon fa fa-minus smaller-75',
            btn_up_class: 'btn-success',
            btn_down_class: 'btn-danger'
        }).on('change', function () {
            if (this.value - $('#participants_tag').siblings('.tag').length > 0)
                $('#participants_tag').attr("placeholder", "输入" + (this.value - $('#participants_tag').siblings('.tag').length) + "位参与人员的邮箱地址");
            else if (this.value - $('#participants_tag').siblings('.tag').length < 0) {
                $('#participants_tag').attr("placeholder", "需要" + this.value + "个邮箱地址，实际提供了" + $('#participants_tag').siblings('.tag').length + "个，不符合要求！");

            } else {
                $('#participants_tag').attr("placeholder", "");
            }
            //alert($('#particpant_count').val());
        });


        $("#password").keydown(function () {
            $("#login_msg").addClass("hide")
        });

    });

    //you don't need this, just used for changing background
    jQuery(function ($) {
        $('#btn-login-dark').on('click', function (e) {
            $('body').attr('class', 'login-layout');
            //$('#id-text2').attr('class', 'white');
            //$('#id-company-text').attr('class', 'blue');
            $('#locale').attr('class', 'btn btn-inverse btn-xs dropdown-toggle');
            e.preventDefault();
        });
        $('#btn-login-light').on('click', function (e) {
            $('body').attr('class', 'login-layout light-login');
            //$('#id-text2').attr('class', 'grey');
            //$('#id-company-text').attr('class', 'blue');
            $('#locale').attr('class', 'btn btn-xs dropdown-toggle');
            e.preventDefault();
        });
        $('#btn-login-blur').on('click', function (e) {
            $('body').attr('class', 'login-layout blur-login');
            //$('#id-text2').attr('class', 'white');
            //$('#id-company-text').attr('class', 'light-blue');
            $('#locale').attr('class', 'btn btn-info btn-xs dropdown-toggle');
            e.preventDefault();
        });


        $('#reg').on('click', function (e) {
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
        });

        $('.dd').nestable();
        $('.dd').nestable('collapseAll');
        $('.dd-handle a').on('mousedown', function (e) {
            e.stopPropagation();
        });

    });

    function changeLocale(l) {
        document.location.href = "login.html?locale=" + l
        /* $.post('meetime/login.do?reqCode=init',{locale:l},function callback(data,status){
         if(data.success){
         }else{
         }
         console.debug(data);
         },"json"); */
    }
</script>
</body>
</html>
