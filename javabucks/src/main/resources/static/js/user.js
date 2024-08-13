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
			
			let cardName = $(this).data('cardname');
			let cardPrice = $(this).data('cardprice');
			let cardRegNum = $(this).data('cardregnum');

			$('#cardpay .card_num').text(cardRegNum);
			$('#cardpay .txt_tit').text(cardName);
			$('#cardpay .card_price span').text(cardPrice);
			
			$("#cardpay input[name='cardRegNum']").val(cardRegNum);
			
            $('#' + popupId).addClass('s_active');
            $('.dimm').addClass('s_active');
        });

		$(".close_btn").on('click', function() {
			let popupId = $(this).data('popup');
			console.log(popupId)

			$('#' + popupId).removeClass('s_active');
            $('.dimm').removeClass('s_active');
			$("input").val("");
			$("textarea").val("");
		});
    });
});
