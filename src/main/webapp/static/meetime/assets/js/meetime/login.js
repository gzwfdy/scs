/**
 * 
 */


$(document).ready(function() {
	/*$('#login').click(function(){
		//alert($('#passwd').val());
		$.post('meetime/login.do?reqCode=login',{account:$('#username').val(),password:$('#password').val()},function callback(data,status){
//			{\"errorType\":\"1\",\"msg\":\"帐号输入错误,请重新输入!\",\"success\":false}
			if(data.success){
				
				window.location.href = 'index.html';
			}else{
				$("#msg").removeClass("hidden").empty().append(data.msg);
			}
			console.debug(data);
		},"json");
	});*/
	
	$('#regBtn').click(function(){
		//$.post('meetime/reg.do?reqCode=init',function(){
			//window.location.href = 'reg.html';
			window.location.href = 'http://192.168.1.116';
		//});
	});
	
	
	$("#service_center").on("click",function(e){
		window.location.href = 'login.html?reqCode=serviceCenter';
	});
	
	//var index_form = $('#validation-form').validate();
	$("#mainSubmit").click(function(){
		if($('#validation-form').valid()){
			$("#login_msg").addClass("hide")
			$(".help-button").popover('hide');
			$('.widget-box.visible').removeClass('visible');//hide others
			$("#inputpassword-box").addClass('visible');//show target
			$("#password").val("");
			$("#password").focus();
		} 
		
		return false;
	});
	
	$("#signup").click(function(){
		$(".help-button").popover('hide');
		$('.widget-box.visible').removeClass('visible');//hide others
		$("#signup-box").addClass('visible');//show target
		$("#signup-box").find(":input:first").focus();
		return false;
	});
	
	$("#forgotpassword").click(resetpassword);
	
	
	
	$("#showServiceProtocol").click(function(){
		$('.widget-box.visible').removeClass('visible');//hide others
		$(".login-container").css("margin","120px auto 0 auto");
		//console.debug($(".login-container").css('margin'));
		$("#ServiceProtocol").addClass('visible');//show target
		return false;
	});
	
	
	
	$('#validation-form').validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: true,
		rules: {
			username: {
				required: true
			},
			meetime_no: {
				required: true/*,
				remote:{
					url: "login.html?reqCode=checkConference&ts="+(new Date()).getTime(),
                    type: "post",
                    dataType: "json",
                    data: {
                        name: function () {
                            return $("#meetime_no").val();　　　　//这个是取要验证的密码
                        }
                    }
				}*/
			},
			password2: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			},
			name: {
				required: true
			},
			phone: {
				required: true,
				phone: 'required'
			},
			url: {
				required: true,
				url: true
			},
			comment: {
				required: true
			},
			state: {
				required: true
			},
			platform: {
				required: true
			},
			subscription: {
				required: true
			},
			gender: {
				required: true,
			},
			agree: {
				required: true,
			}
		},

		messages: {
			meetime_no: {
				
				remote:$.i18n.prop("meetimeNoNotAvailable")
			}
		},


		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.insertAfter(element.parent());
		},

		/*submitHandler: function (form) {
			return false;
		},*/
		invalidHandler: function (form) {
		}
	});
	
	$('#login-password-form').validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: true,
		rules: {
			
			password: {
				required: true
			}
			
		},

		messages: {
			
			
		},


		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.insertAfter(element.parent());
		},

		submitHandler: function (form) {
//			$(form).append("<input type='hidden' name='account' value='"+$('#meetime_no').val()+"'/>")
//			$(form).append("<input type='hidden' name='username' value='"+$('#username').val()+"'/>")
//			$(form).append("<input type='hidden' name='bandwidth' value='"+$('#bandwidth').val()+"'/>")
//			form.submit();
			var submitHtml = $("#login").html();
			$("#login").attr("disabled","disabled").empty().append("<i class=\"ace-icon fa fa-spinner fa-spin orange bigger-125\"></i><span class=\"bigger-110\">"+$.i18n.prop("loginbtn")+"</span>");
			$.post('login',{username:$('#meetime_no').val(),password:$('#password').val(),guestname:$("#username").val(),validateCode:$("#validateCode").val()},function callback(data,status){
//				{\"errorType\":\"1\",\"msg\":\"帐号输入错误,请重新输入!\",\"success\":false}
				if(data.success){
					//if(data.account === "service")
						//window.location.href = 'service.html';
					//else	
						window.location.href = data.url;
				}else{
					$("#login_msg").removeClass("hide").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>"+data.msg);
					$("#password").focus();
					$("#login").removeAttr("disabled").empty().append(submitHtml);
				}
				console.debug(data);
			},"json");
			return true;
		},
		invalidHandler: function (form) {
		}
	});
	
	
	$('#forgot-password-form').validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: true,
		rules: {
			
			forgotpassword: {
				required: true,
				email:true
			}
			
		},

		messages: {
			
			
		},


		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.insertAfter(element.parent());
		},

		submitHandler: function (form) {
			$.post('login.html?reqCode=forgotpassword',$("#forgot-password-form").serialize(),function callback(data,status){
//				{\"errorType\":\"1\",\"msg\":\"帐号输入错误,请重新输入!\",\"success\":false}
				if(data.success){
					$.gritter.add({
						title: "",
						text: data.msg,
						//image: $path_assets+'/avatars/avatar1.png',
						sticky: false,
						time: 3000,
						class_name: 'gritter-info gritter-center gritter-light',
						after_close: function(){
							window.location.href = 'login.html';
						}
					});
				}else{
					$("#forgot_msg").removeClass("hide").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>"+data.msg);
					$("#password").focus();
				}
				console.debug(data);
			},"json");
			return true;
		},
		invalidHandler: function (form) {
		}
	});
	
	
	$('#registration-validation-form').validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: false,
		rules: {
			regusername: {
				required: true,
				email:true
			},
			regpassword: {
				required: true,
				minlength: 5,
				maxlength:16
			},
			regpassword2: {
				required: true,
				minlength: 5,
				maxlength:16,
				equalTo: "#regpassword"
			},
			nickname: {
				required: true,
				maxlength:15,
			},
			agreement: {
				required: true
			}
		},

		messages: {
			
			agreement: $.i18n.prop("login.agreement")
			
		},


		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.insertAfter(element.parent());
		},

		submitHandler: function (form) {
			console.debug("reg button onclick");
			/*$.post('meetime/reg.do?reqCode=reg',{account:$('#regusername').val(),password:$('#regpassword').val(),nickname:$('#nickname').val()},function callback(data,status){
						if(data.success){
							var count = 10;
							countdown = setInterval(function(){
								$("#regmsg").removeClass("hide").removeClass("alert-danger").addClass("alert-success").children("strong").empty().append("<i class=\"ace-icon fa fa-check\"></i>"+data.msg+"<br/>" + count +"秒后跳转到登录页.");
								if(count == 0){
									clearInterval(countdown);
									$("#regmsg").addClass("hide").children("strong").empty();
									$("#regreset").trigger('click');
									$("#testback").trigger('click');
									
								}
								count--;
							},1000);
							
						}else{
							$("#regmsg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>"+data.msg);
						}
						console.debug(data);
					},"json");*/
			
			
			var submitHtml = $("#submit").html();
			$("#submit").attr("disabled","disabled").empty().append("<i class=\"ace-icon fa fa-spinner fa-spin orange bigger-125\"></i><span class=\"bigger-110\">"+$.i18n.prop("processing")+"</span>");
			$(form).ajaxSubmit({
		        type:"post",
		        url:"reg.html?reqCode=reg&time="+ (new Date()).getTime(),
				resetForm:true,
		        //beforeSubmit: showRequest,
		        success: function(responseText,statusText) {
		        	
		        	var data = jQuery.parseJSON( responseText );
		        	$("#regreset").trigger('click');
					$("#testback").trigger('click');
					$("#submit").removeAttr("disabled").empty().append(submitHtml);
		        	$.gritter.add({
						title: "",
						text: data.msg,
						//image: $path_assets+'/avatars/avatar1.png',
						sticky: false,
						time: 5000,
						class_name: 'gritter-info gritter-center gritter-light'
					});
		        	/*var count = 10;
					countdown = setInterval(function(){
						$("#regmsg").removeClass("hide").removeClass("alert-danger").addClass("alert-success").children("strong").empty().append("<i class=\"ace-icon fa fa-check\"></i>"+data.msg+"<br/>" + count +"秒后跳转到登录页.");
						if(count == 0){
							clearInterval(countdown);
							$("#regmsg").addClass("hide").children("strong").empty();
							$("#regreset").trigger('click');
							$("#testback").trigger('click');
							
						}
						count--;
					},1000);*/
		        },
		        error:function(xhr, status, error) {
		        	$("#regmsg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>"+data.msg);
		        	$("#submit").removeAttr("disabled").empty().append(submitHtml);
		        }
		      });
			
			
		},
		invalidHandler: function (form) {
		}
	});
	
	
	$('#shenqing-validation-form').validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: false,
		rules: {
			ty_email: {
				required: true,
				email:true
			},
			ty_nickname: {
				required: true
			},
			ty_telphone: {
				required: true,
				number:true,
				maxlength:11,
				minlength:11
			}
		},

		messages: {
			
		},


		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.insertAfter(element.parent());
		},

		submitHandler: function (form) {
			console.debug("ti button onclick");
			/*$.post('meetime/reg.do?reqCode=reg',{account:$('#regusername').val(),password:$('#regpassword').val(),nickname:$('#nickname').val()},function callback(data,status){
						if(data.success){
							$("#regmsg").removeClass("hide").removeClass("alert-danger").addClass("alert-success").children("strong").empty().append("<i class=\"ace-icon fa fa-check\"></i>"+data.msg);
						}else{
							$("#regmsg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>"+data.msg);
						}
						console.debug(data);
					},"json");*/
			var submitHtml = $("#tiyan").html();
			$("#tiyan").attr("disabled","disabled").empty().append("<i class=\"ace-icon fa fa-spinner fa-spin orange bigger-125\"></i><span class=\"bigger-110\">"+$.i18n.prop("processing")+"</span>");
			$(form).ajaxSubmit({
		        type:"post",
		        url:"login.html?reqCode=experience&time="+ (new Date()).getTime(),
				resetForm:true,
		        //beforeSubmit: showRequest,
		        success: function(responseText,statusText) {
		        	
		        	$("#tiyan").removeAttr("disabled").empty().append(submitHtml);
		        	var data = jQuery.parseJSON( responseText );
		        	$.gritter.add({
						title: "",
						text: data.msg,
						//image: $path_assets+'/avatars/avatar1.png',
						sticky: false,
						time: 10000,
						class_name: 'gritter-light'
					});
		        },
		        error:function(xhr, status, error) {
		        	$("#tiyan").removeAttr("disabled").empty().append(submitHtml);
		        	$.gritter.add({
						title: "",
						text: status,
						//image: $path_assets+'/avatars/avatar1.png',
						sticky: false,
						time: 10000,
						class_name: 'gritter-light'
					});
		        }
		      });
			return true;
		},
		invalidHandler: function (form) {
		}
	});
	
	
	
	$('#public-validation-form').validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: false,
		rules: {
			public_email: {
				required: true,
				email:true
			},
			public_password: {
				required: true
			},
			conference_date_start:{
				required:true
			},
			conference_date_end:{
				required:true
			},
			participants_tag:{
				inputTag:true
			}
			
		},

		messages: {
			
		},


		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.insertAfter(element.parent());
		},

		submitHandler: function (form) {
			var submitHtml = $("#publicSubmit").html();
			$("#publicSubmit").attr("disabled","disabled").empty().append("<i class=\"ace-icon fa fa-spinner fa-spin orange bigger-125\"></i><span class=\"bigger-110\">"+$.i18n.prop("processing")+"</span>");
			$(form).ajaxSubmit({
		        type:"post",
		        url:"login.html?reqCode=reqestPubulic&time="+ (new Date()).getTime(),
				//resetForm:true,
		        //beforeSubmit: showRequest,
		        success: function(responseText,statusText) {
		        	
		        	$("#publicSubmit").removeAttr("disabled").empty().append(submitHtml);
		        	if(responseText && responseText.length > 0){
			        	var data = jQuery.parseJSON( responseText );
			        	$.gritter.add({
							title: "",
							text: data.msg,
							//image: $path_assets+'/avatars/avatar1.png',
							sticky: false,
							time: 5000,
							class_name: 'gritter-info gritter-light gritter-center'
						});
		        	}
		        },
		        error:function(xhr, status, error) {
		        	$("#publicSubmit").removeAttr("disabled").empty().append(submitHtml);
		        	$.gritter.add({
						title: "",
						text: status,
						//image: $path_assets+'/avatars/avatar1.png',
						sticky: false,
						time: 5000,
						class_name: 'gritter-info gritter-light gritter-center'
					});
		        }
		      });
			return true;
		},
		invalidHandler: function (form) {
		}
	});
	
	/*jQuery.validator.addMethod("inputTag", function(value, element) {
		var length = $(element).siblings(".tag").length;
		$(element).siblings(".tag").each(function(i,t){
			console.debug($(t).find("span").text());
		});
		console.debug(length > 0);
			return length > 0;
	}, local["required"]);*/	
	
});

function resetpassword(){
	$("#forgot_msg").addClass("hide");
	$(".help-button").popover('hide');
	$("#forgotpassword").val("")
	$('.widget-box.visible').removeClass('visible');//hide others
	$("#forgot-box").addClass('visible');//show target
	$("#forgot-box").find(":input:first").focus();
	return false;
}