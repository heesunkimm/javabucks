$(function() {
	// admin_top 설정 토글
	$("header .setBtn").on('click', function(e){
	    e.stopPropagation();
	    $(".setting_box").toggle();
	});
	$(document).on('click', function(e){
	    if(!$(e.target).closest('.setting_box, .setBtn').length){
	        $(".setting_box").hide();
	    }
	});
	$("header .setting_box li:first-child").on('click', function() {
	    $(".setting_box").hide();
	});
	
	// tab foreach 통합
    $(".tab_btn").each(function() {
        $(this).click(function(e) {
            e.preventDefault();
            let tabId = $(this).data('tab');
        
            $('.tab-content').removeClass('s_active');
            $('#' + tabId).addClass('s_active');
            
            $('.tab_btn').removeClass('s_active');
            $(this).addClass('s_active');
        });
    });

    // popup foreach 통합
    $(".popup_btn").each(function() {
        $(this).on('click', function(e) {
            e.preventDefault();
            let popupId = $(this).data('popup');
        
            $('#' + popupId).addClass('s_active');
            $('.dimm').addClass('s_active');
        });

		$(".close_btn").on('click', function() {
			let popupId = $(this).data('popup');

			$('#' + popupId).removeClass('s_active');
            $('.dimm').removeClass('s_active');
			$(".popup_btn input").val("");
			$(".popup_btn textarea").val("");
		});
    });
});
