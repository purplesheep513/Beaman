	// 맛 별점 제이쿼리 ---> 별을 선택하면 그 옆에 몇 점을 선택했는지 표시해주는 부분 
	var starRating1 = function () {
	    var $star = $(".star-input1"),
	        $result = $star.find("output>b");
	    $(document).on("focusin", ".input1", function () {
	            $(this).addClass("focus");
	        })

	        .on("focusout", ".input1", function () {
	            var $this = $(this);
	            setTimeout(function () {
	                if ($this.find(":focus").length === 0) {
	                    $this.removeClass("focus");
	                }
	            }, 100);
	        })

	        .on("change", ".star-input1 :radio", function () {
	            $result.text($(this).next().text());
	        }).on("mouseover", ".star-input1 label", function () {
	            $result.text($(this).text());
	        }).on("mouseleave", ".input1", function () {
	            var $checked = $star.find(":checked");
	            if ($checked.length === 0) {
	                $result.text("0");
	            } else {
	                $result.text($checked.next().text());
	            }
	        });
	};

	starRating1();
	// 맛 별점 제이쿼리 끝
	// 배달 별점 제이쿼리
	var starRating2 = function () {
	    var $star2 = $(".star-input2"),
	        $result2 = $star2.find("output>b");

	    $(document).on("focusin", ".input2", function () {
	            $(this).addClass("focus2");
	        })

	        .on("focusout", ".input2", function () {
	            var $this = $(this);
	            setTimeout(function () {
	                if ($this.find(":focus2").length === 0) {
	                    $this.removeClass("focus2");
	                }
	            }, 100);
	        })

	        .on("change", ".star-input2 :radio", function () {
	            $result2.text($(this).next().text());
	        }).on("mouseover", ".star-input2 label", function () {
	            $result2.text($(this).text());
	        }).on("mouseleave", ".input2", function () {
	            var $checked2 = $star2.find(":checked");
	            if ($checked2.length === 0) {
	                $result2.text("0");
	            } else {
	                $result2.text($checked2.next().text());
	            }
	        });
	};

	starRating2();
	// 배달 별점 제이쿼리 끝
	// 양 별점 제이쿼리
	var starRating3 = function () {
	    var $star3 = $(".star-input3"),
	        $result3 = $star3.find("output>b");

	    $(document).on("focusin", ".input3", function () {
	            $(this).addClass("focus3");
	        })

	        .on("focusout", ".input3", function () {
	            var $this = $(this);
	            setTimeout(function () {
	                if ($this.find(":focus3").length === 0) {
	                    $this.removeClass("focus3");
	                }
	            }, 100);
	        })

	        .on("change", ".star-input3 :radio", function () {
	            $result3.text($(this).next().text());
	        }).on("mouseover", ".star-input3 label", function () {
	            $result3.text($(this).text());
	        }).on("mouseleave", ".input3", function () {
	            var $checked3 = $star3.find(":checked");
	            if ($checked3.length === 0) {
	                $result3.text("0");
	            } else {
	                $result3.text($checked3.next().text());
	            }
	        });
	};

	starRating3();
	// 양 별점 제이쿼리 끝

	/* 리뷰하기 팝업 jquery */
	jQuery.fn.center = function () {
	    this.css("position", "absolute");
	    this.css("top", Math.max(0, (($(window).height() - $(this)
	                .outerHeight()) / 2) +
	            $(window).scrollTop()) +
	        "px");
	    this.css("left", Math.max(0,
	            (($(window).width() - $(this).outerWidth()) / 2) +
	            $(window).scrollLeft()) +
	        "px");
	    return this;
	}
	ques_bt = function () {
	    $(".his_review").show();
	    $(".his_review").center();
	}

	$(function () {
	    $(".cancle").on("click", function () {
	        $(".his_review").css({
	            "display": "none"
	        });
	    });
	});

	$(function () {
	    $(".write").on("click", function () {
	        $(".his_review").css({
	            "display": "none"
	        });

	    });
	});

	$(function () {
	    $(".review_wr").on(
	        "click",
	        function () {
	            $(".his_review").css({
	                "display": "block"
	            });
	            let storeName = $(this).parents(".history").find(
	                ".store_name").text()
	            let menuName = $(this).parents(".history").find(
	                ".menu_name").text()
	            let storeCode = $(this).parents(".history").find(
	                ".hidden_data3").val()
	            $(".hidden_data1").attr("value", storeName);
	            $(".hidden_data2").attr("value", menuName);
	            $(".hidden_data3").attr("value", storeCode);
	            console.log($(".hidden_data3").attr("value"))

	        });

	});