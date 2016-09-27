package com.tellhow.common.unti;

import java.io.FileInputStream;
import java.util.Properties;

public class TsUrlUtil {
    public String getUrl() {
        //获取项目的根目录
        String url = this.getClass().getResource("").getPath().replaceAll("%20", " ");
        String path = url.substring(0, url.indexOf("WEB-INF")) + "WEB-INF/";
        Properties p = new Properties();
        try {
            //读取项目WEB-INF下的appurl.properties属性文件
            p.load(new FileInputStream(path + "apptsurl.properties"));
            // 读出具体的参数
            url = p.get("appts.url").toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;

    }
}
