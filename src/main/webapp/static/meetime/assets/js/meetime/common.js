/**
 * 
 */


$(document).ready(function() {
	$('#changpasswd').click(function(){
		var modal = 
			'<div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel" aria-hidden="true">\
			   <div class="modal-dialog">\
			      <div class="modal-content">\
					<div class="modal-header">\
			            <button type="button" class="close" data-dismiss="modal" \
			               aria-hidden="true">×\
			            </button>\
			            <h4 class="modal-title" id="createModalLabel">'
							+$.i18n.prop("changepassword")+
			            '</h4>\
			         </div>\
			         <div class="modal-body">\
				         <form class="form-horizontal" role="form" id="resetpasswordform">\
							<div id="changpw_msg" class="alert alert-danger hide">\
									<strong>\
									</strong>\
								<br />\
							</div>\
							<fieldset>\
							<input  type="text" class="form-control hide"  id="order_service_type" name="order_service_type" value=""   placeholder=""/>\
								<div class="form-group">\
									<label class="col-sm-3 control-label no-padding-right" for="subject">' +$.i18n.prop("oldpassword") +'</label>\
									<div class="col-xs-12 col-sm-9">\
										<div class="clearfix">\
										<input type="password" id="oldpassword" name="oldpassword" required="required" placeholder="'+$.i18n.prop("input.oldpassword")+'"  class="form-control col-xs-10 col-sm-5" />\
									</div>\
									</div>\
								</div>\
					            <div class="form-group">\
									<label class="col-sm-3 control-label no-padding-right" for="conference_date_start"> '+$.i18n.prop("newpassword")+' </label>\
									<div class="col-xs-12 col-sm-9">\
									<div class="clearfix">\
										<input type="password" id="password" name="password" required="required" placeholder="'+$.i18n.prop("input.newpassword")+'"  class="form-control col-xs-10 col-sm-5" />\
									</div>\
									</div>\
								</div>\
								<div class="form-group">\
									<label class="col-sm-3 control-label no-padding-right" for="conference_date_end"> '+$.i18n.prop("newpassword2")+' </label>\
									<div class="col-xs-12 col-sm-9">\
										<div class="clearfix">\
											<input type="password" id="password2" name="password2"  required="required" placeholder="'+$.i18n.prop("input.newpassword2")+'"  class="form-control col-xs-10 col-sm-5" />\
										</div>\
									</div>\
								</div>\
							</fieldset>\
						</form>\
			         </div>\
			         <div class="modal-footer">\
			         	<button type="button" class="btn btn-sm btn-danger" data-action="sure"><i class="ace-icon fa fa-check"></i> '+$.i18n.prop("sure")+'</button>\
						<button type="button" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-times"></i> '+$.i18n.prop("cancel")+'</button>\
			         </div>\
			      </div>\
			   </div>\
			</div>';
	
	
		var modal = $(modal).appendTo('body');
		modal.find('form').on('submit', function(ev){
			ev.preventDefault();

			
			modal.modal("hide");
		});
		
		
		modal.find('form').validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: true,
			rules: {
				
				oldpassword: {
					required: true,
					minlength: 5,
					maxlength:16
				},
				password: {
					required: true,
					minlength: 5,
					maxlength:16
				},
				password2: {
					required: true,
					minlength: 5,
					maxlength:16,
					equalTo: "#password"
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

			submitHandler: function (form) {},
			invalidHandler: function (form) {
			}
		});
		
		
		
		modal.find('button[data-action=sure]').on('click', function() {
			console.debug(modal.find('form').valid());
			modal.find("#changpw_msg").addClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty();
			var oldpassword = modal.find("#oldpassword").val();
			var password = modal.find("#password").val();
			var password2 = modal.find("#password2").val();
			/*if(oldpassword.length == 0){
				modal.find("#changpw_msg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>旧密码不能为空");
				return;
			}
			
			if(password.length == 0){
				modal.find("#changpw_msg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>新密码不能为空");
				return;
			}
			
			if(password2.length == 0){
				modal.find("#changpw_msg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>密码确认不能为空");
				return;
			}
			
			if(password2 != password){
				modal.find("#changpw_msg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>两次输入的密码不一致");
				return;
			}
			*/
			//$("#order_msg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>与会者不能为空");
			if(modal.find('form').valid()){
				$.post('profile.html?reqCode=changePassword',{loginuserid:'${loginuserid}',password:password,oldpassword:oldpassword,password2:password2},function callback(data,status){
					if(data.success){
						modal.modal("hide");
					}else{
						modal.find("#changpw_msg").removeClass("hide").removeClass("alert-success").addClass("alert-danger").children("strong").empty().append("<i class=\"ace-icon fa fa-times\"></i>"+data.msg);
					}
					console.debug(data);
				},"json");
			}
			//modal.modal("hide");
		});
		
		modal.modal('show').on('hidden', function(){
			modal.remove();
		});
	});
	
});