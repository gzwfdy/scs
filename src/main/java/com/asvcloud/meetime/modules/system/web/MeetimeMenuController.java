package com.asvcloud.meetime.modules.system.web;

import com.thinkgem.jeesite.common.web.BaseController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by g.zw@asvcloud.com on 15/10/27.14:49
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
@Controller
@RequestMapping(value = "${meetimePath}/sys/menu")
public class MeetimeMenuController extends BaseController {

    @RequiresPermissions("user")
    @RequestMapping(value = "tree")
    public String tree() {
        return "meetime/system/menuTree";
    }
}
