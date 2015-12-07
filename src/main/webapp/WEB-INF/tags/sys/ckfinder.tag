<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="input" type="java.lang.String" required="true" description="输入框" %>
<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb" %>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="打开文件管理的上传路径" %>
<%@ attribute name="selectMultiple" type="java.lang.Boolean" required="false" description="是否允许多选" %>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="是否查看模式" %>
<%@ attribute name="maxWidth" type="java.lang.String" required="false" description="最大宽度" %>
<%@ attribute name="maxHeight" type="java.lang.String" required="false" description="最大高度" %>
<ol id="${input}Preview"></ol>
<c:if test="${!readonly}"><a href="javascript:" onclick="${input}FinderOpen();"
                             class="btn">${selectMultiple?'添加':'选择'}</a>&nbsp;<a href="javascript:" onclick="${input}DelAll();" class="btn">清除</a></c:if>
<script type="text/javascript">
    //<c:if test="${type eq 'files'}">
    if(typeof($("#${input}").data("filename")) == "undefined")
        $("#${input}").data("filename","");
    //</c:if>
    function ${input}FinderOpen() {//<c:if test="${type eq 'thumb'}"><c:set var="ctype" value="images"/></c:if><c:if test="${type ne 'thumb'}"><c:set var="ctype" value="${type}"/></c:if>
        var date = new Date(), year = date.getFullYear(), month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
        var url = "${ctxStatic}/ckfinder/ckfinder.html?type=${ctype}&start=${ctype}:${uploadPath}/" + year + "/" + month +
                "/&action=js&func=${input}SelectAction&thumbFunc=${input}ThumbSelectAction&cb=${input}Callback&dts=${type eq 'thumb'?'1':'0'}&sm=${selectMultiple?1:0}";
        windowOpen(url, "文件管理", 1000, 700);
        //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
    }
    function ${input}SelectAction(fileUrl, data, allFiles) {
        var url = "",name="", files = ckfinderAPI.getSelectedFiles();

        for (var i = 0; i < files.length; i++) {
        //<c:if test="${type eq 'thumb'}">
            url += files[i].getThumbnailUrl();
            //</c:if>
            //<c:if test="${type eq 'images'}">
            url += files[i].getUrl();
            //</c:if>
            //<c:if test="${type eq 'files'}">
                url += files[i].getUrl();
                name += files[i].name;
            //</c:if>
            if (i < files.length - 1) {url += "|";name += "|";}
        }
        //<c:if test="${selectMultiple}">
            $("#${input}").val($("#${input}").val() + ($("#${input}").val() == "" ? url : "|" + url));
            $("#${input}").data("filename",$("#${input}").data("filename") + ($("#${input}").data("filename") == "" ? name : "|" + name));
        //</c:if>
        //<c:if test="${!selectMultiple}">
            $("#${input}").val(url);
        $("#${input}").data("filename",name);
        //</c:if>
        //if("${type}" == 'images' || "${type}" == "thumb")
            ${input}Preview();
        //top.$.jBox.close();
    }
    function ${input}ThumbSelectAction(fileUrl, data, allFiles) {
        var url = "", files = ckfinderAPI.getSelectedFiles();
        for (var i = 0; i < files.length; i++) {
            url += files[i].getThumbnailUrl();
            if (i < files.length - 1) url += "|";
        }//<c:if test="${selectMultiple}">
        $("#${input}").val($("#${input}").val() + ($("#${input}").val(url) == "" ? url : "|" + url));//</c:if><c:if test="${!selectMultiple}">
        $("#${input}").val(url);//</c:if>
        //if("${type}" == 'images' || "${type}" == "thumb")
            ${input}Preview();
        //top.$.jBox.close();
    }
    function ${input}Callback(api) {
        ckfinderAPI = api;
    }
    function ${input}Del(obj) {
        var url = $(obj).prev().attr("url");

        $("#${input}").val($("#${input}").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
        //<c:if test="${type eq 'files'}">
            $("#${input}").data("filename",$("#${input}").data("filename").replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
        //</c:if>
        ${input}Preview();
    }
    function ${input}DelAll() {
        $("#${input}").val("");
        $("#${input}").data("filename","");
        ${input}Preview();
    }
    function ${input}Preview() {
        var li, urls = $("#${input}").val().split("|");
        var xx = $("#${input}").data("filename");
        var yy = $("#${input}").data("data-filename")
        //<c:if test="${type eq 'files'}">
            if(typeof($("#${input}").data("filename")) != "undefined")
                urls = $("#${input}").data("filename").split("|");
            else
                urls = "";
        //</c:if>
        $("#${input}Preview").children().remove();
        for (var i = 0; i < urls.length; i++) {
            if (urls[i] != "") {
                //<c:if test="${type eq 'thumb' || type eq 'images'}">
                    li = "<li><img src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";
                //</c:if>
                <c:if test="${type ne 'thumb' && type ne 'images'}">
                    li = "<li>urls[i] style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";
                //</c:if>
                //<c:if test="${type ne 'thumb' && type ne 'images'}">
                    li = "<li><a href=\"" + urls[i] + "\" url=\"" + urls[i] + "\" target=\"_blank\">" + decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/") + 1)) + "</a>";
                //</c:if>
                li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×</a></c:if></li>";
                $("#${input}Preview").append(li);
            }
        }
        if ($("#${input}Preview").text() == "") {
            $("#${input}Preview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
        }
    }
    ${input}Preview();
</script>