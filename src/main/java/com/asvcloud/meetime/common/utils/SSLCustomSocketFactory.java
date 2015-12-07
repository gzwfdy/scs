package com.asvcloud.meetime.common.utils;

import com.thinkgem.jeesite.common.config.Global;
import org.apache.commons.io.FileUtils;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.ssl.SSLContexts;

import javax.net.ssl.SSLContext;
import java.io.File;
import java.io.InputStream;
import java.security.KeyStore;

/**
 * Created by hying on 14-1-21.
 */
public class SSLCustomSocketFactory{
    private static final String TAG = "SSLCustomSocketFactory";


    private static final String KEY_PASS = Global.getConfig("keystorePassword");




    public static SSLConnectionSocketFactory getSocketFactory() {
        try {

            InputStream ins = FileUtils.openInputStream(new File(SSLCustomSocketFactory.class.getResource("/").getPath()+ Global.getConfig("keystore")));

            KeyStore trustStore = KeyStore.getInstance(KeyStore.getDefaultType());
            try {
                trustStore.load(ins, KEY_PASS.toCharArray());
            }
            finally {
                ins.close();
            }
            SSLContext sslcontext = SSLContexts.custom()
                    .loadTrustMaterial(trustStore,
                            new TrustSelfSignedStrategy())
                    .build();
            SSLConnectionSocketFactory factory = new SSLConnectionSocketFactory(
                    sslcontext,
                    new String[] { "TLSv1" },
                    null,
                    SSLConnectionSocketFactory.getDefaultHostnameVerifier());
            return factory;
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return null;
    }
}
