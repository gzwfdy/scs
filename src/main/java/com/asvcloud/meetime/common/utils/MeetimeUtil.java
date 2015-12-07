package com.asvcloud.meetime.common.utils;

import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.common.utils.SendMailUtil;
import de.javawi.jstun.test.DiscoveryInfo;
import de.javawi.jstun.test.DiscoveryTest;
import de.javawi.jstun.test.demo.DiscoveryTestDemo;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.LocaleResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.net.BindException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

/**
 * Created by g.zw@asvcloud.com on 15/10/22.20:43
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
@Service
@Lazy(false)
public class MeetimeUtil {

    public static boolean isAjax(HttpServletRequest request){
        return  (request.getHeader("X-Requested-With") != null  && "XMLHttpRequest".equals( request.getHeader("X-Requested-With").toString())   ) ;
    }

    //@Scheduled(cron="2 * *  * * ? ")
    public void findPublicIp(){
        try{
            Enumeration<NetworkInterface> ifaces = NetworkInterface.getNetworkInterfaces();
            while (ifaces.hasMoreElements()) {
                NetworkInterface iface = ifaces.nextElement();
                Enumeration<InetAddress> iaddresses = iface.getInetAddresses();
                while (iaddresses.hasMoreElements()) {
                    InetAddress iaddress = iaddresses.nextElement();
                    if (Class.forName("java.net.Inet4Address").isInstance(iaddress)) {
                        if ((!iaddress.isLoopbackAddress()) && (!iaddress.isLinkLocalAddress())) {
                            Thread thread = new Thread(new DiscoveryTestDemo(iaddress));
                            thread.start();
                        }
                    }
                }
            }
        }catch (Exception e){

        }

    }
}
