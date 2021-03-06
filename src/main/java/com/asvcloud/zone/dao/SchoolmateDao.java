package com.asvcloud.zone.dao;

import com.asvcloud.zone.entity.Schoolmate;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by g.zw@asvcloud.com on 15/11/22.16:32
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
@MyBatisDao
public interface SchoolmateDao extends CrudDao<Schoolmate> {

}
