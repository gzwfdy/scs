package com.asvcloud.zone.service;

import com.asvcloud.zone.dao.SchoolmateDao;
import com.asvcloud.zone.entity.Schoolmate;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.ArticleData;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by g.zw@asvcloud.com on 15/11/22.21:27
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
@Service
@Transactional(readOnly = true)
public class SchoolmateService extends CrudService<SchoolmateDao,Schoolmate> {




    @Transactional(readOnly = false)
    public void save(Schoolmate schoolmate) {


        schoolmate.setDelFlag(Article.DEL_FLAG_NORMAL);



        if (StringUtils.isBlank(schoolmate.getId())){
            schoolmate.preInsert();
            dao.insert(schoolmate);
        }else{
            schoolmate.preUpdate();
            dao.update(schoolmate);
        }
    }

    public Page<Schoolmate> findSchoolmate(Page<Schoolmate> page,Schoolmate schoolmate){
        schoolmate.setPage(page);
        page.setList(dao.findList(schoolmate));
        return page;
    }

}
