/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.security;

import javax.servlet.Servlet;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.asvcloud.meetime.common.utils.MeetimeUtil;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.util.AntPathMatcher;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.utils.StringUtils;

import java.io.IOException;

/**
 * 表单验证（包含验证码）过滤类
 * @author ThinkGem
 * @version 2014-5-19
 */
@Service
public class FormAuthenticationFilter extends org.apache.shiro.web.filter.authc.FormAuthenticationFilter {

	public static final String DEFAULT_CAPTCHA_PARAM = "validateCode";
	public static final String DEFAULT_MOBILE_PARAM = "mobileLogin";
	public static final String DEFAULT_MESSAGE_PARAM = "message";
	public static final String DEFAULT_GUESTNAME_PARAM = "guestname";

	private String captchaParam = DEFAULT_CAPTCHA_PARAM;
	private String mobileLoginParam = DEFAULT_MOBILE_PARAM;
	private String messageParam = DEFAULT_MESSAGE_PARAM;
	private String guestNameParam = DEFAULT_GUESTNAME_PARAM;

	private static final Logger log = LoggerFactory.getLogger(FormAuthenticationFilter.class);

	/**
	 * 管理基础路径
	 */
	@Value("${adminPath}")
	protected String adminPath;

	/**
	 * 前端基础路径
	 */
	@Value("${frontPath}")
	protected String frontPath;

	/**
	 * meetime管理路径
	 */
	@Value("${meetimePath}")
	protected String meetimePath;

	protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {

		String username = getUsername(request);
		String password = getPassword(request);
		if (password==null){
			password = "";
		}
		/**
		 * add by g.zw@asvcloud.com
		 *
		 */
		boolean isAdminLogin = false;

		if(pathsMatch(adminPath+"/**",((HttpServletRequest)request).getRequestURI())){
			isAdminLogin = true;
		}

		boolean rememberMe = isRememberMe(request);
		String host = StringUtils.getRemoteAddr((HttpServletRequest)request);
		String captcha = getCaptcha(request);
		boolean mobile = isMobileLogin(request);
		String guestName = getGuestName(request);
		return new UsernamePasswordToken(username, password.toCharArray(), rememberMe, host, captcha, mobile,isAdminLogin,guestName);
	}

	public String getCaptchaParam() {
		return captchaParam;
	}

	protected String getCaptcha(ServletRequest request) {
		return WebUtils.getCleanParam(request, getCaptchaParam());
	}

	protected String getGuestName(ServletRequest request){
		return WebUtils.getCleanParam(request,getGuestName());
	}

	public String getGuestName(){
		return guestNameParam;
	}

	public String getMobileLoginParam() {
		return mobileLoginParam;
	}
	
	protected boolean isMobileLogin(ServletRequest request) {
        return WebUtils.isTrue(request, getMobileLoginParam());
    }
	
	public String getMessageParam() {
		return messageParam;
	}
	
	/**
	 * 登录成功之后跳转URL
	 */
	public String getSuccessUrl() {
		return super.getSuccessUrl();
	}
	
	@Override
	protected void issueSuccessRedirect(ServletRequest request,
			ServletResponse response) throws Exception {
		System.out.println(((HttpServletRequest) request).getRequestURI());


		AntPathMatcher pathMatcher = new AntPathMatcher();
		if(pathMatcher.match(adminPath+"/login",((HttpServletRequest) request).getRequestURI()))
			WebUtils.issueRedirect(request, response, adminPath, null, true);
		else {
			if(MeetimeUtil.isAjax((HttpServletRequest)request)){
				try {
					response.setContentType("application/json;charset=UTF-8");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write("{\"success\":true,\"url\":\""+getSuccessUrl()+"\"}");

				} catch (IOException e1) {
					e1.printStackTrace();
				}

			}else
				WebUtils.issueRedirect(request, response, meetimePath, null, true);

		}
//		Principal p = UserUtils.getPrincipal();
//		if (p != null && !p.isMobileLogin()){
			 //WebUtils.issueRedirect(request, response, getSuccessUrl(), null, true);
//		}else{
//			super.issueSuccessRedirect(request, response);
//		}
	}

	/**
	 * 登录失败调用事件
	 */
	@Override
	protected boolean onLoginFailure(AuthenticationToken token,
			AuthenticationException e, ServletRequest request, ServletResponse response) {
		String className = e.getClass().getName(), message = "";
		if (IncorrectCredentialsException.class.getName().equals(className)
				|| UnknownAccountException.class.getName().equals(className)){
			message = "用户或密码错误, 请重试.";
		}
		else if (e.getMessage() != null && StringUtils.startsWith(e.getMessage(), "msg:")){
			message = StringUtils.replace(e.getMessage(), "msg:", "");
		}
		else{
			message = "系统出现点问题，请稍后再试！";
			e.printStackTrace(); // 输出到控制台
		}
		response.setContentType("application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setAttribute(getFailureKeyAttribute(), className);
        request.setAttribute(getMessageParam(), message);
		if(MeetimeUtil.isAjax((HttpServletRequest)request)){
			try {
				response.getWriter().write("{\"success\":false,\"msg\":\""+message+"\"}");

			} catch (IOException e1) {
				e1.printStackTrace();
			}
			return false;
		}else
			return true;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		//return super.onAccessDenied(request, response);
		if (isLoginRequest(request, response)) {
			if (isLoginSubmission(request, response)) {
				if (log.isTraceEnabled()) {
					log.trace("Login submission detected.  Attempting to execute login.");
				}
				return executeLogin(request, response);
			} else {
				if (log.isTraceEnabled()) {
					log.trace("Login page view.");
				}
				//allow them to see the login page ;)
				return true;
			}
		} else {

			/**
			 * 如果是后台登录放过
			 */
			if(pathMatcher.matches(adminPath + "/login", getPathWithinApplication(request))){
				if (log.isTraceEnabled()) {
					log.trace("请求登录管理后台");
				}
				if (isLoginSubmission(request, response)) {
					if (log.isTraceEnabled()) {
						log.trace("Login submission detected.  Attempting to execute login.");
					}
					return executeLogin(request, response);
				} else {
					if (log.isTraceEnabled()) {
						log.trace("Login page view.");
					}
					//allow them to see the login page ;)
					return true;
				}

			}else{
				if (log.isTraceEnabled()) {
					log.trace("Attempting to access a path which requires authentication.  Forwarding to the " +
							"Authentication url [" + getLoginUrl() + "]");
				}

				saveRequestAndRedirectToLogin(request, response);
				return false;

			}

		}
	}
}