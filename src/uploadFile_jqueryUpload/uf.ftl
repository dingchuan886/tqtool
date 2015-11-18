<div class="row">
	<span class="t">上传：</span>
	<div class="up">
		<div class="theme-pic">
			<!--<img src="${(subData.pic)!}" alt="">-->
			<img id="photo_up" width="127" height="127">
		</div>
		<input class="sel-file" type="file" name="photo" id="uploadPhoto">
	</div>
</div>


<script src="${dnsUrl}/js/jquery-1.11.1.min.js?v=${jsVer}" type="text/javascript"></script>
<script type="text/javascript" src="${dnsUrl}/js/ajaxfileupload.js?v=${jsVer}"></script>
<script type="text/javascript">
	function changeOnUpload(){
		$.ajaxFileUpload({
			url:"modifi_uploadPhoto",
			secureuri:false,
			fileElementId:"uploadPhoto",
			success:function(data,status,e){
				var text=$(data).text();
				if(text=="false"){
					alert("请上传正确的图片文件");
				}else if(text.indexOf(".jpg")>=0){
					$("#pic").val(text);
					$("#photo_up").attr("src","${dnsUrl}/upload/pageblock/"+text);
				}else{
					alert("上传失败,文件过大！");				
				}
				$("#uploadPhoto").on("change",function(){
					changeOnUpload();
				});
			},
			error:function(){
				alert("上传失败，请重试！");
				$("#uploadPhoto").on("change",function(){
					changeOnUpload();
				});
			}
		});
	}
	$(function(){
		$("#uploadPhoto").on("change",function(){
			changeOnUpload();
		});
	});
</script>