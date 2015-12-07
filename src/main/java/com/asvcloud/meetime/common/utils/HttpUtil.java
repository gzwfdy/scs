package com.asvcloud.meetime.common.utils;


import com.asvcloud.meetime.common.pexip.ParseJson_01;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.thinkgem.jeesite.common.config.Global;
import org.apache.http.*;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CookieStore;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.AuthSchemes;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.config.*;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.DnsResolver;
import org.apache.http.conn.HttpConnectionFactory;
import org.apache.http.conn.ManagedHttpClientConnection;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.DefaultHttpResponseFactory;
import org.apache.http.impl.client.*;
import org.apache.http.impl.conn.*;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.impl.io.DefaultHttpRequestWriterFactory;
import org.apache.http.io.HttpMessageParser;
import org.apache.http.io.HttpMessageParserFactory;
import org.apache.http.io.HttpMessageWriterFactory;
import org.apache.http.io.SessionInputBuffer;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicLineParser;
import org.apache.http.message.LineParser;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.CharArrayBuffer;
import org.apache.http.util.EntityUtils;

import javax.net.ssl.SSLContext;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.CodingErrorAction;
import java.util.Arrays;
import java.util.Map;

import org.apache.http.impl.client.CloseableHttpClient;

/**
 *
 */
public class HttpUtil {
    private static final int MAX_CONN_PER_ROUTE = 10;
    private static final int MAX_CONNECTIONS = 20;
    private static final int TIMEOUT = 30 * 1000;
    static ObjectMapper mapper = new ObjectMapper();


    public static void main(String[] args){
        ParseJson_01 tt = new ParseJson_01();
        Map m = tt.testjson("");
        System.out.println(m.get("objects"));
        try {
            Map n = mapper.readValue("{\"meta\": {\"limit\": 20, \"next\": null, \"offset\": 0, \"previous\": null, \"total_count\": 2}, \"objects\": [{\"bandwidth\": 0, \"call_direction\": \"in\", \"call_uuid\": \"413fbc2a-c433-4849-bce0-e205ca6ddcd2\", \"conference\": \"70008\", \"connect_time\": \"2015-11-25T16:13:19.853978\", \"destination_alias\": \"70008\", \"display_name\": \"dfdf\", \"encryption\": \"On\", \"has_media\": false, \"id\": \"413fbc2a-c433-4849-bce0-e205ca6ddcd2\", \"is_muted\": false, \"is_on_hold\": false, \"is_presentation_supported\": false, \"is_presenting\": false, \"is_streaming\": false, \"license_count\": 0, \"media_node\": \"192.168.1.116\", \"parent_id\": \"\", \"participant_alias\": \"Infinity_Connect_192.168.1.108\", \"protocol\": \"WebRTC\", \"remote_address\": \"192.168.1.108\", \"remote_port\": 61536, \"resource_uri\": \"/api/admin/status/v1/participant/413fbc2a-c433-4849-bce0-e205ca6ddcd2/\", \"role\": \"guest\", \"service_tag\": \"\", \"service_type\": \"waiting_room\", \"signalling_node\": \"192.168.1.116\", \"source_alias\": \"Infinity_Connect_192.168.1.108\", \"system_location\": \"pexip-node-1\", \"vendor\": \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36\"}, {\"bandwidth\": 0, \"call_direction\": \"in\", \"call_uuid\": \"8a76986c-da27-4b6f-8bef-e0b7ee18047a\", \"conference\": \"70008\", \"connect_time\": \"2015-11-25T16:14:23.827287\", \"destination_alias\": \"70008\", \"display_name\": \"dfdf\", \"encryption\": \"On\", \"has_media\": true, \"id\": \"8a76986c-da27-4b6f-8bef-e0b7ee18047a\", \"is_muted\": false, \"is_on_hold\": false, \"is_presentation_supported\": true, \"is_presenting\": false, \"is_streaming\": false, \"license_count\": 1, \"media_node\": \"192.168.1.116\", \"parent_id\": \"413fbc2a-c433-4849-bce0-e205ca6ddcd2\", \"participant_alias\": \"Infinity_Connect_Media_192.168.1.108\", \"protocol\": \"WebRTC\", \"remote_address\": \"192.168.1.108\", \"remote_port\": 61536, \"resource_uri\": \"/api/admin/status/v1/participant/8a76986c-da27-4b6f-8bef-e0b7ee18047a/\", \"role\": \"guest\", \"service_tag\": \"\", \"service_type\": \"invalid_license_screen\", \"signalling_node\": \"192.168.1.116\", \"source_alias\": \"Infinity_Connect_Media_192.168.1.108\", \"system_location\": \"pexip-node-1\", \"vendor\": \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36\"}]}",Map.class);
            System.out.println(n);
        } catch (IOException e) {
            e.printStackTrace();
        }
        CloseableHttpClient httpClient = getCustomClient();
        HttpClientContext context = HttpClientContext.create();
        //HttpGet httpget = new HttpGet("https://pexip-manager.asvcloud.com/api/admin/status/v1/participant/?conference=70008");
        HttpGet httpget = new HttpGet("http://localhost:8080/app/rpc/service/meetime.html?reqCode=participants");
        try{
            httpget.addHeader("Accept-Language", "zh-CN");
            httpget.addHeader("Content-Type", "text/html;charset=UTF-8");
            CloseableHttpResponse response = httpClient.execute(httpget, context);
            try {
                System.out.println("----------------------------------------");
                System.out.println(response.getStatusLine());
                System.out.println(EntityUtils.toString(response.getEntity(),"UTF-8"));
                System.out.println("----------------------------------------");

                // Once the request has been executed the local context can
                // be used to examine updated state and various objects affected
                // by the request execution.

                // Last executed request
                context.getRequest();
                // Execution route
                context.getHttpRoute();
                // Target auth state
                context.getTargetAuthState();
                // Proxy auth state
                context.getTargetAuthState();
                // Cookie origin
                context.getCookieOrigin();
                // Cookie spec used
                context.getCookieSpec();
                // User security token
                context.getUserToken();

            }catch (Exception e){
                e.printStackTrace();
            }finally {
                response.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static String get(String url){
        CloseableHttpClient httpClient = getCustomClient();
        HttpClientContext context = HttpClientContext.create();
        //HttpGet httpget = new HttpGet("https://pexip-manager.asvcloud.com/api/admin/status/v1/participant/?conference=70008");
        HttpGet httpget = new HttpGet(url);
        try{
            httpget.addHeader("Accept-Language", "zh-CN");
            httpget.addHeader("Content-Type", "text/html;charset=UTF-8");
            CloseableHttpResponse response = httpClient.execute(httpget, context);
            try {
                //System.out.println("----------------------------------------");
                //System.out.println(response.getStatusLine());
                //System.out.println(EntityUtils.toString(response.getEntity(),"UTF-8"));
                //System.out.println("----------------------------------------");

                // Once the request has been executed the local context can
                // be used to examine updated state and various objects affected
                // by the request execution.

                // Last executed request
                //context.getRequest();
                // Execution route
                //context.getHttpRoute();
                // Target auth state
                //context.getTargetAuthState();
                // Proxy auth state
                //context.getTargetAuthState();
                // Cookie origin
                //context.getCookieOrigin();
                // Cookie spec used
                //context.getCookieSpec();
                // User security token
                //context.getUserToken();
                return EntityUtils.toString(response.getEntity(),"UTF-8");
            }catch (Exception e){
                e.printStackTrace();
            }finally {
                response.close();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public static HttpClient getClient() {
        BasicHttpParams params = new BasicHttpParams();
        HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
        HttpProtocolParams.setContentCharset(params, HTTP.DEFAULT_CONTENT_CHARSET);
        HttpProtocolParams.setUseExpectContinue(params, true);

        SchemeRegistry schReg = new SchemeRegistry();
        schReg.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));

        ClientConnectionManager connMgr = new ThreadSafeClientConnManager(params, schReg);
        return new DefaultHttpClient(connMgr, params);
    }

    public static HttpClient getHttpsClient() {
        BasicHttpParams params = new BasicHttpParams();
        HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
        HttpProtocolParams.setContentCharset(params, HTTP.DEFAULT_CONTENT_CHARSET);
        HttpProtocolParams.setUseExpectContinue(params, true);

        SchemeRegistry schReg = new SchemeRegistry();
        schReg.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        schReg.register(new Scheme("https", SSLSocketFactory.getSocketFactory(), 443));

        ClientConnectionManager connMgr = new ThreadSafeClientConnManager(params, schReg);
        return new DefaultHttpClient(connMgr, params);
    }

    public static HttpClient getTrustAllClient() {
        BasicHttpParams params = new BasicHttpParams();
        HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
        HttpProtocolParams.setContentCharset(params, HTTP.DEFAULT_CONTENT_CHARSET);
        HttpProtocolParams.setUseExpectContinue(params, true);

        SchemeRegistry schReg = new SchemeRegistry();
        schReg.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        schReg.register(new Scheme("https", SSLTrustAllSocketFactory.getSocketFactory(), 443));

        ClientConnectionManager connMgr = new ThreadSafeClientConnManager(params, schReg);
        return new DefaultHttpClient(connMgr, params);
    }

    public static CloseableHttpClient getCustomClient() {
        HttpMessageParserFactory<HttpResponse> responseParserFactory = new DefaultHttpResponseParserFactory() {

            @Override
            public HttpMessageParser<HttpResponse> create(
                    SessionInputBuffer buffer, MessageConstraints constraints) {
                LineParser lineParser = new BasicLineParser() {
                    @Override
                    public Header parseHeader(final CharArrayBuffer buffer) {
                        try {
                            return super.parseHeader(buffer);
                        } catch (ParseException ex) {
                            return new BasicHeader(buffer.toString(), null);
                        }
                    }

                };
                return new DefaultHttpResponseParser(
                        buffer, lineParser, DefaultHttpResponseFactory.INSTANCE, constraints) {

                    @Override
                    protected boolean reject(final CharArrayBuffer line, int count) {
                        // try to ignore all garbage preceding a status line infinitely
                        return false;
                    }

                };
            }

        };

        HttpMessageWriterFactory<HttpRequest> requestWriterFactory = new DefaultHttpRequestWriterFactory();

        // Use a custom connection factory to customize the process of
        // initialization of outgoing HTTP connections. Beside standard connection
        // configuration parameters HTTP connection factory can define message
        // parser / writer routines to be employed by individual connections.
        HttpConnectionFactory<HttpRoute, ManagedHttpClientConnection> connFactory = new ManagedHttpClientConnectionFactory(
                requestWriterFactory, responseParserFactory);

        // Client HTTP connection objects when fully initialized can be bound to
        // an arbitrary network socket. The process of network socket initialization,
        // its connection to a remote address and binding to a local one is controlled
        // by a connection socket factory.

        // SSL context for secure connections can be created either based on
        // system or application specific properties.
        SSLContext sslcontext = SSLContexts.createSystemDefault();

        // Create a registry of custom connection socket factories for supported
        // protocol schemes.
        Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory>create()
                .register("http", PlainConnectionSocketFactory.INSTANCE)
                .register("https", SSLCustomSocketFactory.getSocketFactory())
                .build();

        // Use custom DNS resolver to override the system DNS resolution.
        DnsResolver dnsResolver = new SystemDefaultDnsResolver() {

            @Override
            public InetAddress[] resolve(final String host) throws UnknownHostException {
                if (host.equalsIgnoreCase(Global.getConfig("pexipManager"))) {
                    String str = Global.getConfig("pexipManagerIp");
                    String[] ipStr = str.split("\\.");
                    byte[] ipBuf = new byte[4];
                    for(int i = 0; i < 4; i++){
                        ipBuf[i] = (byte)(Integer.parseInt(ipStr[i])&0xff);
                    }
                    return new InetAddress[] { InetAddress.getByAddress(ipBuf) };
                } else {
                    return super.resolve(host);
                }
            }

        };

        // Create a connection manager with custom configuration.
        PoolingHttpClientConnectionManager connManager = new PoolingHttpClientConnectionManager(
                socketFactoryRegistry, connFactory, dnsResolver);

        // Create socket configuration
        SocketConfig socketConfig = SocketConfig.custom()
                .setTcpNoDelay(true)
                .build();
        // Configure the connection manager to use socket configuration either
        // by default or for a specific host.
        connManager.setDefaultSocketConfig(socketConfig);
        //connManager.setSocketConfig(new HttpHost("somehost", 80), socketConfig);
        // Validate connections after 1 sec of inactivity
        connManager.setValidateAfterInactivity(1000);

        // Create message constraints
        MessageConstraints messageConstraints = MessageConstraints.custom()
                .setMaxHeaderCount(200)
                .setMaxLineLength(2000)
                .build();
        // Create connection configuration
        ConnectionConfig connectionConfig = ConnectionConfig.custom()
                .setMalformedInputAction(CodingErrorAction.IGNORE)
                .setUnmappableInputAction(CodingErrorAction.IGNORE)
                .setCharset(Consts.UTF_8)
                .setMessageConstraints(messageConstraints)
                .build();
        // Configure the connection manager to use connection configuration either
        // by default or for a specific host.
        connManager.setDefaultConnectionConfig(connectionConfig);
        //connManager.setConnectionConfig(new HttpHost("somehost", 80), ConnectionConfig.DEFAULT);

        // Configure total max or per route limits for persistent connections
        // that can be kept in the pool or leased by the connection manager.
        connManager.setMaxTotal(100);
        connManager.setDefaultMaxPerRoute(10);
        //connManager.setMaxPerRoute(new HttpRoute(new HttpHost("somehost", 80)), 20);

        // Use custom cookie store if necessary.
        CookieStore cookieStore = new BasicCookieStore();
        // Use custom credentials provider if necessary.
        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        credentialsProvider.setCredentials(new AuthScope(Global.getConfig("pexipManager"), 443),
                new UsernamePasswordCredentials(Global.getConfig("pexipUserName"), Global.getConfig("pexipPasswork")));
        // Create global request configuration
        RequestConfig defaultRequestConfig = RequestConfig.custom()
                .setCookieSpec(CookieSpecs.DEFAULT)
                .setExpectContinueEnabled(true)
                .setSocketTimeout(5000)
                .setConnectTimeout(5000)
                .setConnectionRequestTimeout(5000)
                .setTargetPreferredAuthSchemes(Arrays.asList(AuthSchemes.BASIC,AuthSchemes.NTLM, AuthSchemes.DIGEST))
                .setProxyPreferredAuthSchemes(Arrays.asList(AuthSchemes.BASIC))
                .build();

        // Create an HttpClient with the given custom dependencies and configuration.
        CloseableHttpClient httpclient = HttpClients.custom()
                .setConnectionManager(connManager)
                //.setDefaultCookieStore(cookieStore)
                .setDefaultCredentialsProvider(credentialsProvider)
                //.setProxy(new HttpHost("myproxy", 8080))
                .setDefaultRequestConfig(defaultRequestConfig)
                .build();

        return httpclient;

        /*BasicHttpParams params = new BasicHttpParams();
        HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
        HttpProtocolParams.setContentCharset(params, HTTP.DEFAULT_CONTENT_CHARSET);
        HttpProtocolParams.setUseExpectContinue(params, true);

        HttpConnectionParams.setConnectionTimeout(params, TIMEOUT);
        HttpConnectionParams.setSoTimeout(params, TIMEOUT);

        SchemeRegistry schReg = new SchemeRegistry();
        schReg.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        schReg.register(new Scheme("https", SSLCustomSocketFactory.getSocketFactory(), 443));

        ClientConnectionManager connMgr = new ThreadSafeClientConnManager(params, schReg);
        return new DefaultHttpClient(connMgr, params);*/
    }
}
