/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.entity;

import com.drew.lang.annotations.NotNull;
import com.thinkgem.jeesite.common.utils.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.factory.annotation.Value;

import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

/**
 * 站点Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
public class Site extends DataEntity<Site> {
	
	private static final long serialVersionUID = 1L;
	private String name;	// 站点名称
	private String title;	// 站点标题
	private String logo;	// 站点logo
	private String description;// 描述，填写有助于搜索引擎优化
	private String keywords;// 关键字，填写有助于搜索引擎优化
	private String theme;	// 主题
	private String copyright;// 版权信息
	private String customIndexView;// 自定义首页视图文件
	@Value("${zonePath}")
	private String domain;
	private List<HomeAD> homeADs;//首页广告
	@NotNull
	@NotEmpty
	private String homeAD;
	private String homeADcn;
	@NotNull
	@NotEmpty
	private String row1col1;
	@NotNull
	@NotEmpty
	private String row1col2;
	@NotNull
	@NotEmpty
	private String row1col3;
	@NotNull
	@NotEmpty
	private String row2col1;
	//@NotNull
	//@NotEmpty
	private String row2col2;
	@NotNull
	@NotEmpty
	private String row2col3;
	@NotNull
	@NotEmpty
	private String row3col1;
	@NotNull
	@NotEmpty
	private String row3col2;
	@NotNull
	@NotEmpty
	private String row3col3;
	@NotNull
	@NotEmpty
	private String localeCN;//语言中文名
	@NotNull
	@NotEmpty
	private String aol;//在线申请
	@NotNull
	@NotEmpty
	private String download;//资料下载
	@NotNull
	@NotEmpty
	private String email;//邮件联络
	@NotNull
	@NotEmpty
	private String link;//友情链接

	private String qrcode;//二维码图片
	@NotNull
	@NotEmpty
	private String qrcodecontents;//二维码内容

	private String row1col1cn;
	private String row1col2cn;
	private String row1col3cn;
	private String row2col1cn;
	private String row2col2cn;
	private String row2col3cn;
	private String row3col1cn;
	private String row3col2cn;
	private String row3col3cn;
	private String downloadcn;
	private String linkcn;





	private Integer sort = 10;

	public Site() {
		super();
	}

	public Site(String id){
		this();
		this.id = id;
	}

	public String getHomeADcn() {
		return homeADcn;
	}

	public void setHomeADcn(String homeADcn) {
		this.homeADcn = homeADcn;
	}

	public String getRow1col1() {
		return row1col1;
	}

	public String getRow1col1cn() {
		return row1col1cn;
	}

	public void setRow1col1cn(String row1col1cn) {
		this.row1col1cn = row1col1cn;
	}

	public String getRow1col2cn() {
		return row1col2cn;
	}

	public void setRow1col2cn(String row1col2cn) {
		this.row1col2cn = row1col2cn;
	}

	public String getRow1col3cn() {
		return row1col3cn;
	}

	public void setRow1col3cn(String row1col3cn) {
		this.row1col3cn = row1col3cn;
	}

	public String getRow2col1cn() {
		return row2col1cn;
	}

	public void setRow2col1cn(String row2col1cn) {
		this.row2col1cn = row2col1cn;
	}

	public String getRow2col2cn() {
		return row2col2cn;
	}

	public void setRow2col2cn(String row2col2cn) {
		this.row2col2cn = row2col2cn;
	}

	public String getRow2col3cn() {
		return row2col3cn;
	}

	public void setRow2col3cn(String row2col3cn) {
		this.row2col3cn = row2col3cn;
	}

	public String getRow3col1cn() {
		return row3col1cn;
	}

	public void setRow3col1cn(String row3col1cn) {
		this.row3col1cn = row3col1cn;
	}

	public String getRow3col2cn() {
		return row3col2cn;
	}

	public void setRow3col2cn(String row3col2cn) {
		this.row3col2cn = row3col2cn;
	}

	public String getRow3col3cn() {
		return row3col3cn;
	}

	public void setRow3col3cn(String row3col3cn) {
		this.row3col3cn = row3col3cn;
	}

	public String getDownloadcn() {
		return downloadcn;
	}

	public void setDownloadcn(String downloadcn) {
		this.downloadcn = downloadcn;
	}

	public String getLinkcn() {
		return linkcn;
	}

	public void setLinkcn(String linkcn) {
		this.linkcn = linkcn;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public void setRow1col1(String row1col1) {
		this.row1col1 = row1col1;
	}

	public String getRow1col2() {
		return row1col2;
	}

	public void setRow1col2(String row1col2) {
		this.row1col2 = row1col2;
	}

	public String getRow1col3() {
		return row1col3;
	}

	public void setRow1col3(String row1col3) {
		this.row1col3 = row1col3;
	}

	public String getRow2col1() {
		return row2col1;
	}

	public void setRow2col1(String row2col1) {
		this.row2col1 = row2col1;
	}

	public String getRow2col2() {
		return row2col2;
	}

	public void setRow2col2(String row2col2) {
		this.row2col2 = row2col2;
	}

	public String getRow2col3() {
		return row2col3;
	}

	public void setRow2col3(String row2col3) {
		this.row2col3 = row2col3;
	}

	public String getRow3col1() {
		return row3col1;
	}

	public void setRow3col1(String row3col1) {
		this.row3col1 = row3col1;
	}

	public String getRow3col2() {
		return row3col2;
	}

	public void setRow3col2(String row3col2) {
		this.row3col2 = row3col2;
	}

	public String getRow3col3() {
		return row3col3;
	}

	public void setRow3col3(String row3col3) {
		this.row3col3 = row3col3;
	}

	public String getHomeAD() {
		/*if (this.homeADs != null && this.homeADs.size() > 0){
			String imageAndPath = "";
			for (HomeAD ha : this.homeADs){
				imageAndPath += StringUtils.isBlank(imageAndPath) ? (ha.getImage() + "|" + ha.getDes()) : (imageAndPath + "||" + ha.getImage() + "|" + ha.getDes());
			}
			homeAD = imageAndPath;
		}*/
		return homeAD;
	}

	public void setHomeAD(String homeAD) {
		this.homeAD = homeAD;
		/*if (StringUtils.isNotBlank(homeAD)){
			List<HomeAD> list = new ArrayList<HomeAD>();
			String[] imageAndPaths = homeAD.split("\\|\\|");
			for (String string : imageAndPaths){
				String[] imageAndPath = string.split("\\|");
				String image = imageAndPath[0];
				String path = imageAndPath[1];
				HomeAD ha = new HomeAD();
				ha.setImage(image);
				ha.setDes(path);
				list.add(ha);
			}
			setHomeADs(list);
		}*/
	}

	public String getAol() {
		return aol;
	}

	public void setAol(String aol) {
		this.aol = aol;
	}

	public String getDownload() {
		return download;
	}

	public void setDownload(String download) {
		this.download = download;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getQrcodecontents() {
		return qrcodecontents;
	}

	public void setQrcodecontents(String qrcodecontents) {
		this.qrcodecontents = qrcodecontents;
	}

	public String getQrcode() {
		return qrcode;
	}

	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}

	public String getLocaleCN() {
		return localeCN;
	}

	public void setLocaleCN(String localeCN) {
		this.localeCN = localeCN;
	}

	public List<HomeAD> getHomeADs() {
		return homeADs;
	}

	public void setHomeADs(List<HomeAD> homeADs) {
		this.homeADs = homeADs;
	}

	@Length(min=1, max=100)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min=1, max=100)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	@Length(min=0, max=255)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Length(min=0, max=255)
	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	@Length(min=1, max=255)
	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public String getCustomIndexView() {
		return customIndexView;
	}

	public void setCustomIndexView(String customIndexView) {
		this.customIndexView = customIndexView;
	}

	/**
	 * 获取默认站点ID
	 */
	public static String defaultSiteId(){
		return "1";
	}
	
	/**
	 * 判断是否为默认（主站）站点
	 */
	public static boolean isDefault(String id){
		return id != null && id.equals(defaultSiteId());
	}
	
	/**
	 * 获取当前编辑的站点编号
	 */
	public static String getCurrentSiteId(){
		String siteId = (String)UserUtils.getCache(UserUtils.CACHE_SITE);
		return StringUtils.isNotBlank(siteId)?siteId:defaultSiteId();
	}

	public static void setCurrentSiteId(String id){
		UserUtils.putCache(UserUtils.CACHE_SITE,id);
	}

    /**
   	 * 模板路径
   	 */
   	public static final String TPL_BASE = "/WEB-INF/views/modules/cms/front/themes";

    /**
   	 * 获得模板方案路径。如：/WEB-INF/views/modules/cms/front/themes/jeesite
   	 *
   	 * @return
   	 */
   	public String getSolutionPath() {
   		return TPL_BASE + "/" + getTheme();
   	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}
	
}