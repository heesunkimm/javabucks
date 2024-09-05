$(function() {
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
			$(".popup_box input").val("");
			$(".popup_box textarea").val("");
		});
    });
});
