/**
 * 
 */


$(document).ready(function() {
	$('#login').click(function(){
		//alert($('#passwd').val());
		$.post('login.html?reqCode=login',{account:$('#username').val(),password:$('#password').val()},function callback(data,status){
//			{\"errorType\":\"1\",\"msg\":\"帐号输入错误,请重新输入!\",\"success\":false}
			if(data.success){
				
				window.location.href = 'index.html';
			}else{
				$("#msg").removeClass("hidden").empty().append(data.msg);
			}
			console.debug(data);
		},"json");
	});
	
	$('#regBtn').click(function(){
		//$.post('meetime/reg.do?reqCode=init',function(){
			//window.location.href = 'reg.html';
			window.location.href = 'http://192.168.1.116';
		//});
	});
	
		
		/*$('.nav li').click(function(e) {
			console.debug("ssss");
		    $('.nav li.active').removeClass('active');
		    var $this = $(this);
		    if (!$this.hasClass('active')) {
		        $this.addClass('active');
		        //$this.trigger("onclick");
		        //$this.children("a").first().click();
		    }
		    console.debug(e.isDefaultPrevented());
		});*/
});