package com.asvcloud.meetime.common.interceptor;

import com.thinkgem.jeesite.common.utils.CookieUtils;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by g.zw@asvcloud.com on 15/10/22.21:03
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
public class LocaleInterceptor implements HandlerInterceptor {

    @Resource
    LocaleResolver localeResolver;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        SystemAuthorizingRealm.Principal principal = UserUtils.getPrincipal();
        if(principal != null && principal.isAdminLogin()) {
            CookieUtils.setCookie(response, "LOGINED", "false");
            UserUtils.logout();
        }
        UserUtils.setLocale(localeResolver.resolveLocale(request));
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        if (modelAndView != null){
            modelAndView.addObject("locale",localeResolver.resolveLocale(request).toString());
            modelAndView.addObject("language",localeResolver.resolveLocale(request).getLanguage());
            modelAndView.addObject("country",localeResolver.resolveLocale(request).getCountry());
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
