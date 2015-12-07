package com.asvcloud.zone.web;

import com.asvcloud.meetime.common.utils.HttpUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.cms.entity.Link;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.service.*;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by g.zw@asvcloud.com on 15/10/30.15:52
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */

@Controller
@RequestMapping(value = "${zonePath}")
public class ZoneController extends BaseController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private ArticleDataService articleDataService;
    @Autowired
    private LinkService linkService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private SiteService siteService;

    @Resource
    LocaleResolver localeResolver;

    static ObjectMapper mapper = new ObjectMapper();

    /**
     * 网站首页
     */
    @RequestMapping
    public String index(Model model) {
        Site site = CmsUtils.getSite(Site.defaultSiteId());
        System.out.println("44444");
        model.addAttribute("site", site);
        model.addAttribute("isIndex", true);
        return "modules/zone/themes/"+site.getTheme()+"/index";
    }

    /**
     * 网站首页
     */
    @RequestMapping(value = "index-{siteId}${urlSuffix}")
    public String index(@PathVariable String siteId, Model model) {
        Site site = CmsUtils.getSite(siteId);
        Site.setCurrentSiteId(site.getId());
        if (siteId.equals("1")){
            return "redirect:"+ site.getDomain();//Global.getFrontPath();
        }

        // 子站有独立页面，则显示独立页面
        if (StringUtils.isNotBlank(site.getCustomIndexView())){
            model.addAttribute("site", site);
            model.addAttribute("isIndex", true);
            return "modules/zone/front/themes/"+site.getTheme()+"/frontIndex"+site.getCustomIndexView();
        }else{
            model.addAttribute("site", site);
            model.addAttribute("isIndex", true);
            String a ="modules/zone/front/themes/"+site.getTheme()+"/index";
            return "modules/zone/themes/"+site.getTheme()+"/index";
        }
        // 否则显示子站第一个栏目
        /*List<Category> mainNavList = CmsUtils.getMainNavList(siteId);
        if (mainNavList.size() > 0){
            String firstCategoryId = CmsUtils.getMainNavList(siteId).get(0).getId();
            return "redirect:"+Global.getFrontPath()+"/list-"+firstCategoryId+Global.getUrlSuffix();
        }else{
            model.addAttribute("site", site);
            return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory";
        }*/
    }

    /**
     * 内容列表
     */
    @RequestMapping(value = "list-{categoryId}${urlSuffix}")
    public String list(@PathVariable String categoryId, @RequestParam(required=false, defaultValue="1") Integer pageNo,
                       @RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
        Category category = categoryService.get(categoryId);
        if (category==null){
            Site site = CmsUtils.getSite(Site.defaultSiteId());
            model.addAttribute("site", site);
            return "error/404";
        }
        Site site = siteService.get(category.getSite().getId());
        model.addAttribute("site", site);
        // 2：简介类栏目，栏目第一条内容
        if("2".equals(category.getShowModes()) && "article".equals(category.getModule())){
            // 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
            List<Category> categoryList = Lists.newArrayList();
            if (category.getParent().getId().equals("1")){
                categoryList.add(category);
            }else{
                categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
            }
            model.addAttribute("category", category);
            model.addAttribute("categoryList", categoryList);
            // 获取文章内容
            Page<Article> page = new Page<Article>(1, 1, -1);
            Article article = new Article(category);
            page = articleService.findPage(page, article, false);
            if (page.getList().size()>0){
                article = page.getList().get(0);
                article.setArticleData(articleDataService.get(article.getId()));
                articleService.updateHitsAddOne(article.getId());
            }
            model.addAttribute("article", article);
            CmsUtils.addViewConfigAttribute(model, category);
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
            return "modules/zone/themes/"+site.getTheme()+"/"+getTpl(article);
        }else{
            List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
            // 展现方式为1 、无子栏目或公共模型，显示栏目内容列表
            if("1".equals(category.getShowModes())||categoryList.size()==0){
                // 有子栏目并展现方式为1，则获取第一个子栏目；无子栏目，则获取同级分类列表。
                if(categoryList.size()>0){
                    category = categoryList.get(0);
                }else{
                    // 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
                    if (category.getParent().getId().equals("1")){
                        categoryList.add(category);
                    }else{
                        categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
                    }
                }
                model.addAttribute("category", category);
                model.addAttribute("categoryList", categoryList);
                // 获取内容列表
                if ("article".equals(category.getModule())){
                    Page<Article> page = new Page<Article>(pageNo, pageSize);
                    //System.out.println(page.getPageNo());
                    page = articleService.findPage(page, new Article(category), false);
                    model.addAttribute("page", page);
                    // 如果第一个子栏目为简介类栏目，则获取该栏目第一篇文章
                    if ("2".equals(category.getShowModes())){
                        Article article = new Article(category);
                        if (page.getList().size()>0){
                            article = page.getList().get(0);
                            article.setArticleData(articleDataService.get(article.getId()));
                            articleService.updateHitsAddOne(article.getId());
                        }
                        model.addAttribute("article", article);
                        CmsUtils.addViewConfigAttribute(model, category);
                        CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
                        return "modules/zone/themes/"+site.getTheme()+"/"+getTpl(article);
                    }
                }else if ("link".equals(category.getModule())){
                    Page<Link> page = new Page<Link>(1, -1);
                    page = linkService.findPage(page, new Link(category), false);
                    model.addAttribute("page", page);
                }
                String view = "/frontList";
                if (StringUtils.isNotBlank(category.getCustomListView())){
                    view = "/"+category.getCustomListView();
                }
                CmsUtils.addViewConfigAttribute(model, category);
                site =siteService.get(category.getSite().getId());
                //System.out.println("else 栏目第一条内容 _2 :"+category.getSite().getTheme()+","+site.getTheme());
                return "modules/zone/themes/"+siteService.get(category.getSite().getId()).getTheme()+view;
                //return "modules/cms/front/themes/"+category.getSite().getTheme()+view;
            }
            // 有子栏目：显示子栏目列表
            else{
                model.addAttribute("category", category);
                model.addAttribute("categoryList", categoryList);
                String view = "/frontListCategory";
                if (StringUtils.isNotBlank(category.getCustomListView())){
                    view = "/"+category.getCustomListView();
                }
                CmsUtils.addViewConfigAttribute(model, category);
                return "modules/zone/themes/"+site.getTheme()+view;
            }
        }
    }

    private String getTpl(Article article){
        if(StringUtils.isBlank(article.getCustomContentView())){
            String view = null;
            Category c = article.getCategory();
            boolean goon = true;
            do{
                if(StringUtils.isNotBlank(c.getCustomContentView())){
                    view = c.getCustomContentView();
                    goon = false;
                }else if(c.getParent() == null || c.getParent().isRoot()){
                    goon = false;
                }else{
                    c = c.getParent();
                }
            }while(goon);
            return StringUtils.isBlank(view) ? Article.DEFAULT_TEMPLATE : view;
        }else{
            return article.getCustomContentView();
        }
    }

    /**
     * 显示内容
     */
    @RequestMapping(value = "view-{categoryId}-{contentId}${urlSuffix}")
    public String view(@PathVariable String categoryId, @PathVariable String contentId, Model model) {
        Category category = categoryService.get(categoryId);
        if (category==null){
            Site site = CmsUtils.getSite(Site.defaultSiteId());
            model.addAttribute("site", site);
            return "error/404";
        }
        model.addAttribute("site", category.getSite());
        if ("article".equals(category.getModule())){
            // 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
            List<Category> categoryList = Lists.newArrayList();
            if (category.getParent().getId().equals("1")){
                categoryList.add(category);
            }else{
                categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
            }
            // 获取文章内容
            Article article = articleService.get(contentId);
            if (article==null || !Article.DEL_FLAG_NORMAL.equals(article.getDelFlag())){
                return "error/404";
            }
            // 文章阅读次数+1
            articleService.updateHitsAddOne(contentId);
            // 获取推荐文章列表
            List<Object[]> relationList = articleService.findByIds(articleDataService.get(article.getId()).getRelation());
            // 将数据传递到视图
            model.addAttribute("category", categoryService.get(article.getCategory().getId()));
            model.addAttribute("categoryList", categoryList);
            article.setArticleData(articleDataService.get(article.getId()));
            model.addAttribute("article", article);
            model.addAttribute("relationList", relationList);
            CmsUtils.addViewConfigAttribute(model, article.getCategory());
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
            Site site = siteService.get(category.getSite().getId());
            model.addAttribute("site", site);
//			return "modules/cms/front/themes/"+category.getSite().getTheme()+"/"+getTpl(article);
            System.out.println("modules/zone/themes/"+site.getTheme()+"/"+getTpl(article));
            return "modules/zone/themes/"+site.getTheme()+"/"+getTpl(article);
        }
        return "error/404";
    }

    /**
     * 站点地图
     */
    @RequestMapping(value = "map-{siteId}${urlSuffix}")
    public String map(@PathVariable String siteId, Model model) {
        Site site = CmsUtils.getSite(siteId != null ? siteId : Site.defaultSiteId());
        model.addAttribute("site", site);
        return "modules/zone/themes/"+site.getTheme()+"/frontMap";
    }


    @RequestMapping(value = "search")
    public String search(@RequestParam(required = false) String q,HttpServletRequest request, HttpServletResponse response, Model model) {

        Site site = CmsUtils.getSite(Site.defaultSiteId());
        model.addAttribute("site", site);
        String qStr = StringUtils.replace(StringUtils.replace(q, "，", " "), ", ", " ");
        long start = System.currentTimeMillis();
        if (StringUtils.isNotBlank(q)){
            Page<Article> page = articleService.search(new Page<Article>(request, response), qStr, "", "", "");
            page.setMessage("匹配结果，共耗时 " + (System.currentTimeMillis() - start) + "毫秒。");
            model.addAttribute("page", page);
        }

        model.addAttribute("q", q);// 搜索关键字
        return "modules/zone/themes/"+site.getTheme()+"/frontSearch";
    }


    @RequestMapping(value = "serviceOnLine")
    public String serviceOnLine(HttpServletResponse response){
        String res = HttpUtil.get("https://pexip-manager.asvcloud.com/api/admin/status/v1/participant/?conference=70008");
        String result = Global.NO;
        if (StringUtils.isBlank(res))
            return renderString(response, Global.NO);
        else{
            try {
                //res = "{\"meta\": {\"limit\": 20, \"next\": null, \"offset\": 0, \"previous\": null, \"total_count\": 2}, \"objects\": [{\"bandwidth\": 0, \"call_direction\": \"in\", \"call_uuid\": \"413fbc2a-c433-4849-bce0-e205ca6ddcd2\", \"conference\": \"70008\", \"connect_time\": \"2015-11-25T16:13:19.853978\", \"destination_alias\": \"70008\", \"display_name\": \"dfdf\", \"encryption\": \"On\", \"has_media\": false, \"id\": \"413fbc2a-c433-4849-bce0-e205ca6ddcd2\", \"is_muted\": false, \"is_on_hold\": false, \"is_presentation_supported\": false, \"is_presenting\": false, \"is_streaming\": false, \"license_count\": 0, \"media_node\": \"192.168.1.116\", \"parent_id\": \"\", \"participant_alias\": \"Infinity_Connect_192.168.1.108\", \"protocol\": \"WebRTC\", \"remote_address\": \"192.168.1.108\", \"remote_port\": 61536, \"resource_uri\": \"/api/admin/status/v1/participant/413fbc2a-c433-4849-bce0-e205ca6ddcd2/\", \"role\": \"chair\", \"service_tag\": \"\", \"service_type\": \"waiting_room\", \"signalling_node\": \"192.168.1.116\", \"source_alias\": \"Infinity_Connect_192.168.1.108\", \"system_location\": \"pexip-node-1\", \"vendor\": \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36\"}, {\"bandwidth\": 0, \"call_direction\": \"in\", \"call_uuid\": \"8a76986c-da27-4b6f-8bef-e0b7ee18047a\", \"conference\": \"70008\", \"connect_time\": \"2015-11-25T16:14:23.827287\", \"destination_alias\": \"70008\", \"display_name\": \"dfdf\", \"encryption\": \"On\", \"has_media\": true, \"id\": \"8a76986c-da27-4b6f-8bef-e0b7ee18047a\", \"is_muted\": false, \"is_on_hold\": false, \"is_presentation_supported\": true, \"is_presenting\": false, \"is_streaming\": false, \"license_count\": 1, \"media_node\": \"192.168.1.116\", \"parent_id\": \"413fbc2a-c433-4849-bce0-e205ca6ddcd2\", \"participant_alias\": \"Infinity_Connect_Media_192.168.1.108\", \"protocol\": \"WebRTC\", \"remote_address\": \"192.168.1.108\", \"remote_port\": 61536, \"resource_uri\": \"/api/admin/status/v1/participant/8a76986c-da27-4b6f-8bef-e0b7ee18047a/\", \"role\": \"chair\", \"service_tag\": \"\", \"service_type\": \"invalid_license_screen\", \"signalling_node\": \"192.168.1.116\", \"source_alias\": \"Infinity_Connect_Media_192.168.1.108\", \"system_location\": \"pexip-node-1\", \"vendor\": \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36\"}]}";
                Map json = mapper.readValue(res, Map.class);
                String total_count = ((LinkedHashMap)json.get("meta")).get("total_count").toString();
                String limit = ((LinkedHashMap)json.get("meta")).get("limit").toString();
                String offset = ((LinkedHashMap)json.get("meta")).get("offset").toString();
                ArrayList<LinkedHashMap<String,String>> objects = ((ArrayList<LinkedHashMap<String,String>>)json.get("objects"));
                for (LinkedHashMap<String,String> L : objects){
                    String role = L.get("role");
                    if (role.equalsIgnoreCase("chair")) {
                        result = Global.YES;
                        break;
                    }else {
                        result = Global.NO;
                    }
                }
                return renderString(response,result);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return renderString(response, Global.NO);
    }
}
