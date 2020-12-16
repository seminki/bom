//옵션 추가하기 
$("#add-option").click(function(){
    
    var addOption="";
    addOption+='<tr name="trOption">';
    addOption+='<th>&nbsp&nbsp옵션 내용</th>';
    addOption+='<td><input type="text" class="content" id="content" name="pdtOptionContent"></td>';
    addOption+='<th>추가 요금</th>';
    addOption+='<td><input type="text" class="addprice" name="pdtOptionAddprice">';
    addOption+='<button class="btn btn-success btn-sm delBtn2" name="delBtn">삭제</button></td>';
    addOption+='</tr>';

    $("#insert-table").append(addOption);
});

//옵션 삭제 
$(document).on("click","button[name=delBtn]",function(){

    var trHtml=$(this).parent().parent();
    trHtml.remove();
});


//제품 등록하기 버튼 누르면 실행되는 함수
function insert(){
    
    //유효성검사-카테고리 및 판매상태
    if($("#category").val()==null){
        swal("제품카테고리를 선택해주세요.");
        return false;
    }
    if($("#status").val()==null){
        swal("판매 상태를 선택해주세요.");
        return false;
    }
    
  	//제품명 유효성 검사
  	var val=$("#name").val();
  	if(val.length>0){
  		
  		var name=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,/ ]*$/;
        
        if(!name.test(val)){
               swal("제품명에 특수문자는 입력하실 수 없습니다.");
               $("#name").val('');
               return false;
           }
      	//중복검사
        $.ajax({
            
               url:"${path}/admin/checkPdtName?pdtName="+val,
               type:"get",
               success:function(data){
                   console.log(data);
                   if(data!=0){
                       swal("상품명이 중복됩니다.");
                       $("#name").val('');
                       return false;
                   }
               }
           }); 
        
  	}else{
        swal("제품명을 입력해주세요.");
        return false;
  	}
   
  	//가격 유효성 검사
  	var val2=$("#price").val();
    if(val2.length>0){
    	 var price=/^[0-9]*$/;
        if(!price.test($("#price").val())){
               swal("제품가격에 숫자 외에는 입력하실 수 없습니다.");
               $("#price").val('');
               return false;
        }
    }else{
    	swal("가격을 입력해주세요.");
        return false;
    }
    
  	//간단한 설명 - 글자 수 제한
    $(document).ready(function(){
        $("#intro-text").on('keyup',function(){
            if($(this).val().length>65){
                $(this).val($(this).val().substring(0,65));
                swal("65자를 초과하였습니다.");
            }
        });
    });

  	//옵션내용 유효성 검사
  	var val3=$("input[name=pdtOptionContent]").val();
    if(val3.length>0){
    	var check=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,/ ]*$/;
    	if(!check.test(name)){
            swal("옵션명에 특수문자는 입력할 수 없습니다.");
            $(e.target).val('');
            return false;
        }
    }else{
    	 swal("옵션 내용을 입력해주세요.");
         return false;
    }    

    //옵션가격 유효성 검사
    var val4=$("input[name=pdtOptionAddprice]").val();
    if(val4.length>0){
    	var check=/^[-0-9]*$/;
        if(!check.test(val4)){
               swal("옵션 가격에 숫자 외에는 입력하실 수 없습니다.");
               val4="";
               return false;
        }
    }else{
  	  swal("옵션 가격을 입력해주세요.");
      return false;
	}

    //제품 썸네일 사진
    if($("#input1").val()==""){
        swal("대표이미지를 등록해주세요.");
        return false;
    }
    
    //상세 사진 파일 검사
    if($("input[name=detailImg]").val()==""){
        swal("상세 사진을 등록해주세요.");
        return false;
    }

    //옵션 등록하기
    var list=[];
    var items = document.getElementsByName("pdtOptionContent");
    
    for(var i=0; i<items.length; i++){
        list.push({"pdtOptionContent":$("input[name=pdtOptionContent]").eq(i).val(),
            "pdtOptionAddprice":$("input[name=pdtOptionAddprice]").eq(i).val()});    
    }
    $("#test_list").val(JSON.stringify(list));
}

//이미지 업로드 
$(function(){
       //div 클릭시 파일업로드
       $(".proDiv").on("click",e=>{

           //input file만 선택
           var file=$(e.target).children().first();
           file.click();
    
       });
     
       //파일 업로드시 이미지 체인지
       $(".proPic").on("change",e =>{ 
         
            let reader=new FileReader();
              let div=$(e.target).parent();
              //이전 사진 삭제
            $(e.target).prev().remove();

             reader.onload=e=>{
              let img=$("<img>",{"src":e.target.result,width:"150px",height:"150px",onclick:"fn_upload(this);"});
              img.addClass("proImg");
              div.prepend(img); 

          }
          reader.readAsDataURL($(e.target)[0].files[0]);
       }); 
    
});

//사진 눌렀을 떄 다시 파일 업로드
  function fn_upload(e){
    $(e).next().click();

}  


//이미지 삭제 버튼
$(function(){
    $(".close").on("click",e=>{	  
        //이미지 삭제
        $(e.target).prev().prev().remove();
        //input file value삭제
        console.log($(e.target).prev());
        $(e.target).prev().val("");
       });
});
