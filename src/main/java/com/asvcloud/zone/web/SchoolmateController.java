package com.asvcloud.zone.web;

import com.asvcloud.zone.entity.Schoolmate;
import com.asvcloud.zone.service.SchoolmateService;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.ZxingHandler;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;

/**
 * Created by g.zw@asvcloud.com on 15/11/19.10:25
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
@Controller
public class SchoolmateController  extends BaseController {

    @Autowired
    private SchoolmateService schoolmateService;

    @ModelAttribute
    public Schoolmate get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return schoolmateService.get(id);
        }else{
            return new Schoolmate();
        }
    }

    @RequestMapping(value = "${zonePath}/schoolmate", method= RequestMethod.GET)
    public String index(Schoolmate schoolmate,Model model,RedirectAttributes redirectAttributes){

        Site site = CmsUtils.getSite(Site.getCurrentSiteId());
        //Schoolmate schoolmate = new Schoolmate();
        model.addAttribute("site", site);
        model.addAttribute("schoolmate",schoolmate);
        return "modules/zone/themes/"+site.getTheme()+"/frontSchoolmate";
    }

    @RequestMapping(value = "${zonePath}/schoolmate/save")
    public String save(HttpServletRequest request, HttpServletResponse response,@Valid Schoolmate schoolmate,BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()){
            System.out.println(1);
        }
        /*String fileName = "校友数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
        Page<Schoolmate> page = schoolmateService.findSchoolmate(new Page<Schoolmate>(request, response, -1), schoolmate);
        try {
            new ExportExcel("校友数据", Schoolmate.class).setDataList(page.getList()).write(response, fileName).dispose();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (!beanValidator(model, schoolmate)){
            return index(schoolmate, model, redirectAttributes);
        }*/
        schoolmateService.save(schoolmate);
        addMessage(redirectAttributes, "保存文章成功");
        //String categoryId = article.getCategory()!=null?article.getCategory().getId():null;
        return "redirect:" + zonePath;
    }

    @RequiresPermissions("cms:schoolmate:view")
    @RequestMapping(value = {"${adminPath}/schoolmate/list"})
    public String list(Schoolmate schoolmate, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Schoolmate> page = schoolmateService.findPage(new Page<Schoolmate>(request, response), schoolmate);
        model.addAttribute("page", page);
        return "modules/zone/schoolmateList";
    }

    @RequiresPermissions("cms:schoolmate:view")
    @RequestMapping(value = "${adminPath}/schoolmate/form")
    public String form(Schoolmate schoolmate, Model model) {
        model.addAttribute("schoolmate", schoolmate);
        return "modules/zone/schoolmateForm";
    }

    @RequiresPermissions("cms:schoolmate:edit")
    @RequestMapping(value = "${adminPath}/schoolmate/save")
    public String save(Schoolmate schoolmate, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, schoolmate)){
            return form(schoolmate, model);
        }

        schoolmateService.save(schoolmate);
        addMessage(redirectAttributes, "保存成功");
        return "redirect:" + adminPath + "/schoolmate/list/?repage";
    }

    @RequiresPermissions("cms:schoolmate:edit")
    @RequestMapping(value = "${adminPath}/schoolmate/delete")
    public String delete(Schoolmate schoolmate, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
        if (Site.isDefault(schoolmate.getId())){
            addMessage(redirectAttributes, "删除站点失败, 不允许删除默认站点");
        }else{
            schoolmate.setDelFlag(isRe!=null&&isRe?Site.DEL_FLAG_NORMAL:Site.DEL_FLAG_DELETE);
            schoolmateService.delete(schoolmate);
        }
        return "redirect:" + adminPath + "/schoolmate/list/?repage";
    }

    @RequiresPermissions("sys:user:view")
    @RequestMapping(value = "${adminPath}/schoolmate/export", method=RequestMethod.POST)
    public String exportFile(Schoolmate schoolmate, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        String fileName = "校友数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
        Page<Schoolmate> page = schoolmateService.findSchoolmate(new Page<Schoolmate>(request, response, -1), schoolmate);
        try {
            new ExportExcel("校友数据", Schoolmate.class).setDataList(page.getList()).write(response, fileName).dispose();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
        }


        return "redirect:" + adminPath + "/schoolmate/list?repage";
    }
}
