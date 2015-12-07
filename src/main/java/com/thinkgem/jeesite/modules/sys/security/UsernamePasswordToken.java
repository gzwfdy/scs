/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.security;

/**
 * 用户和密码（包含验证码）令牌类
 * @author ThinkGem
 * @version 2013-5-19
 */
public class UsernamePasswordToken extends org.apache.shiro.authc.UsernamePasswordToken {

	private static final long serialVersionUID = 1L;

	private String captcha;
	private boolean mobileLogin;

	/**
	 * add by g.zw@asvcloud.com
	 * 2015.10.21   是否管理员路径登录，不作为是不是管理员身份的判断标准
	 */
	private boolean adminLogin;

	/**
	 *  add by g.zw@asvcloud.com
	 *  2015.10.28 访客名字
	 */
	private String guestName;

	public UsernamePasswordToken() {
		super();
	}

	public UsernamePasswordToken(String username, char[] password,
			boolean rememberMe, String host, String captcha, boolean mobileLogin,boolean adminLogin,String guestName) {
		super(username, password, rememberMe, host);
		this.captcha = captcha;
		this.mobileLogin = mobileLogin;
		this.adminLogin = adminLogin;
		this.guestName = guestName;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public boolean isMobileLogin() {
		return mobileLogin;
	}

	public boolean isAdminLogin(){return adminLogin;}

	public String getGuestName() {
		return guestName;
	}
}