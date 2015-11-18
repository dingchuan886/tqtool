<form id="form_upload_news_pic" action="uploadPagePic" method="post" enctype="multipart/form-data">
	<div class="theme-pic"><img id="img_news_pic" src="/img/theme_demo_pic.jpg" alt="" width="127" height="127"></div>
	<input id="btn_upload_news_pic" name="photo" class="sel-file" type="file">
</form>

<script src="${dnsUrl}/js/jquery-1.11.1.min.js?v=${jsVer}" type="text/javascript"></script>
<script src="${dnsUrl}/js/jquery.form.js?v=${cssVer}" type="text/javascript"></script>

<script>
//ÉÏ´«Í¼Æ¬
$(function(){

	$("#btn_upload_news_pic").on("change",function(){
		$("#form_upload_news_pic").ajaxSubmit({ 
			success: callUpPic
			error: errUpload
		});
	});
		
	function callUpPic(data, status) {
		var obj = jQuery.parseJSON(data);//if datatype is json
		alert(obj.icon);
		$("#img_view_1").attr('src', obj.icon); 
		//$("#news_titlephoto").val(html);
		<#if callBackFun?length gt 0>
		${callBackFun}(obj);
		</#if>
	}
	
	function errUpload(html) {
		alert("err"+html);
	}
	
})

</script>