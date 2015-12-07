package com.asvcloud.meetime.modules.system.web;


import com.asvcloud.meetime.common.utils.MeetimeUtil;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.CookieUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.security.FormAuthenticationFilter;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.util.AntPathMatcher;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by g.zw@asvcloud.com on 15/10/21.17:40
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
@Controller
public class MeetimeLoginController  extends BaseController {

    @Resource
    private SessionDAO sessionDAO;



    /**
     * meetime login page
     * @return
     */
    @RequestMapping(value = "${meetimePath}/login",method = RequestMethod.GET)
    public String login(HttpServletResponse response,HttpServletRequest request,Model model){
        {
            AntPathMatcher pathMatcher = new AntPathMatcher();
            if (pathMatcher.match(adminPath+"/**",request.getRequestURI()))
                return "redirect:" + adminPath;
            SystemAuthorizingRealm.Principal principal = UserUtils.getPrincipal();

//		// 默认页签模式
//		String tabmode = CookieUtils.getCookie(request, "tabmode");
//		if (tabmode == null){
//			CookieUtils.setCookie(response, "tabmode", "1");
//		}

            if (logger.isDebugEnabled()){
                logger.debug("login, active session size: {}", sessionDAO.getActiveSessions(false).size());
            }

            // 如果已登录，再次访问主页，则退出原账号。
            if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
                CookieUtils.setCookie(response, "LOGINED", "false");
            }

            if(Integer.valueOf(Global.getConfig("failValidateCode"))==0) {
                model.addAttribute("isValidateCodeLogin", true);
            }
            // 如果已经登录，则跳转到管理首页
            if(principal != null && !principal.isMobileLogin()){
                //return "redirect:" + meetimePath;
            }
//		String view;
//		view = "/WEB-INF/views/modules/sys/sysLogin.jsp";
//		view = "classpath:";
//		view += "jar:file:/D:/GitHub/jeesite/src/main/webapp/WEB-INF/lib/jeesite.jar!";
//		view += "/"+getClass().getName().replaceAll("\\.", "/").replace(getClass().getSimpleName(), "")+"view/sysLogin";
//		view += ".jsp";

            return "meetime/system/login";
        }
    }

    /**
     * 登录失败，真正登录的POST请求由shiroFilter完成,能走到这说明登录失败了
     */
    @RequestMapping(value = "${meetimePath}/login", method = RequestMethod.POST)
    public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model) {
        SystemAuthorizingRealm.Principal principal = UserUtils.getPrincipal();

        AntPathMatcher pathMatcher = new AntPathMatcher();
        // 如果已经登录，则跳转到管理首页
        if(principal != null){
            if(pathMatcher.match(adminPath+"/**",request.getRequestURI())){
                return "redirect:" + adminPath;

            }else{
                return "redirect:" + meetimePath;
            }

        }

        String username = WebUtils.getCleanParam(request, FormAuthenticationFilter.DEFAULT_USERNAME_PARAM);
        boolean rememberMe = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM);
        boolean mobile = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_MOBILE_PARAM);
        String exception = (String)request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
        String message = (String)request.getAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);

        if (StringUtils.isBlank(message) || StringUtils.equals(message, "null")){
            message = "用户或密码错误, 请重试.";
        }

        model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
        model.addAttribute(FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM, rememberMe);
        model.addAttribute(FormAuthenticationFilter.DEFAULT_MOBILE_PARAM, mobile);
        model.addAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME, exception);
        model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);

        if (logger.isDebugEnabled()){
            logger.debug("login fail, active session size: {}, message: {}, exception: {}",
                    sessionDAO.getActiveSessions(false).size(), message, exception);
        }

        // 非授权异常，登录失败，验证码加1。
        if (!UnauthorizedException.class.getName().equals(exception)){
            model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));
        }

        // 验证失败清空验证码
        request.getSession().setAttribute(ValidateCodeServlet.VALIDATE_CODE, IdGen.uuid());

        // 如果是手机登录，则返回JSON字符串
        if (mobile){
            return renderString(response, model);
        }
        if(pathMatcher.match(adminPath+"/**",request.getRequestURI())){
            return "modules/sys/sysLogin";

        }else{
            return  "meetime/system/login";
        }
    }

    @RequestMapping(value = "${meetimePath}" )
    public String index(HttpServletRequest request, HttpServletResponse response){

        SystemAuthorizingRealm.Principal principal = UserUtils.getPrincipal();

        // 登录成功后，验证码计算器清零
        isValidateCodeLogin(principal.getLoginName(), false, true);

        if (logger.isDebugEnabled()){
            logger.debug("show index, active session size: {}", sessionDAO.getActiveSessions(false).size());
        }

        // 如果已登录，再次访问主页，则退出原账号。
        if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
            String logined = CookieUtils.getCookie(request, "LOGINED");
            if (StringUtils.isBlank(logined) || "false".equals(logined)){
                CookieUtils.setCookie(response, "LOGINED", "true");
            }else if (StringUtils.equals(logined, "true")){
                UserUtils.getSubject().logout();
                return "redirect:" + meetimePath + "/login";
            }
        }

        // 如果是手机登录，则返回JSON字符串
        if (principal.isMobileLogin()){
            if (request.getParameter("login") != null){
                return renderString(response, principal);
            }
            if (request.getParameter("index") != null){
                return "meetime/index";
            }
            return "redirect:" + meetimePath + "/login";
        }
        if (MeetimeUtil.isAjax(request)){
            return renderString(response,"{\"success\":true,\"url\":\""+meetimePath+"\"}","application/json");
        }
        return "meetime/index";
    }

    @RequestMapping(value = "${meetimePath}/unauthorized")
    public String unauthorized(){

        return "error/403";
    }

    /**
     * 是否是验证码登录
     * @param useruame 用户名
     * @param isFail 计数加1
     * @param clean 计数清零
     * @return
     */
    @SuppressWarnings("unchecked")
    public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean){
        Map<String, Integer> loginFailMap = (Map<String, Integer>) CacheUtils.get("loginFailMap");
        if (loginFailMap==null){
            loginFailMap = Maps.newHashMap();
            CacheUtils.put("loginFailMap", loginFailMap);
        }
        Integer loginFailNum = loginFailMap.get(useruame);
        if (loginFailNum==null){
            loginFailNum = 0;
        }
        if (isFail){
            loginFailNum++;
            loginFailMap.put(useruame, loginFailNum);
        }
        if (clean){
            loginFailMap.remove(useruame);
        }
        return loginFailNum >= Integer.valueOf(Global.getConfig("failValidateCode"));
    }
}
