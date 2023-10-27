<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.warp{
	position: relative;
}

#wrap {
    position: relative;
    width: 100%;
    height: 100%;
    min-width: 1200px;
}

.header {
    height: 90px;
    width: 100%;
    background-color: rgb(0,0,0,0.4);
    position: absolute; 
    z-index : 2;
}

header {
    height: 89px;
    background: rgba(0,0,0,.3);
    width: 100%;
    position: absolute;
    left: 0;
    top: 0;
    z-index: 600;
    border-bottom: 1px solid hsla(0,0%,100%,.3);
}

.header_contents{
    width: 80%;
    margin: 0 auto;
    padding-top: 30px;
    justify-content: space-between;
}

#content {
    margin: 0 auto;
    padding: 0 0 150px;
    width: 1290px;
}

@media (min-width: 1200px)
._grid-system-column_.lg-12 {
    width: 100%;
}

.flex { 
    display : flex; 
 }

 .nav_top > ul{
    list-style: none;
 }

 .nav_top > ul > li{
    display: inline-block;
    margin-left: 30px;
 }
.login {
    margin-left: 30px;
}

.main_content{
    background-color: red;
    width: 80%;
    margin: 0 auto;
}

#container {
    padding-top: 90px;
    min-height: 500px;
}

div {
    display: block;
}

blockquote, body, button, caption, dd, div, dl, dt, fieldset, form, frame, h1, h2, h3, h4, h5, h6, hr, html, iframe, input, legend, li, object, ol, p, pre, q, select, table, td, textarea, tr, ul {
    margin: 0;
    padding: 0;
    font-family: NanumSquare,Nanum Gothic,\\B098\B214\ACE0\B515,"\B9D1\C740 \ACE0\B515",Malgun Gothic,Open Sans,Dotum,\\B3CB\C6C0,arial,sans-serif;
}

.cont {
    padding-bottom: 100px;
}

.sub_visual_wrap {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 570px;
    padding-top: 90px;
}

.sub_visual_wrap .inner_wrap {
    position: absolute;
    top: 0;
    left: 50%;
    width: 423px;
    margin-left: -645px;
}

.inner_wrap {
    margin: 0 auto;
}

.inner_middle, .inner_wrap {
    width: 100%;
    max-width: 1160px;
}

.sub_visual_wrap .sub_info_area {
    position: relative;
    width: 400px;
    height: 480px;
    margin-top: 90px;
    padding: 0 36px;
    background: rgba(0,0,0,.5);
}

.sub_visual_wrap .sub_info_area .sub_info_title {
    width: 260px;
    min-height: 120px;
    padding-top: 30px;
    color: #fff;
}

.sub_visual_wrap .sub_info_area .sub_info_title h3 {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    word-break: break-all;
}

.sub_visual_wrap .sub_info_area .sub_info_title h3 {
    font-size: 32px;
    font-weight: 800;
    line-height: 45px;
}

.sub_visual_wrap .sub_info_area .sub_info_title .h3_sub {
    margin-top: 9px;
    font-size: 20px;
    font-weight: 800;
    line-height: 20px;
}

.sub_visual_wrap .sub_info_area .score_area_l {
    margin-top: 18px;
}

.sub_visual_wrap .sub_info_area .weather {
    position: absolute;
    top: 29px;
    right: 27px;
    width: 90px;
    height: 90px;
    background: rgba(0,0,0,.3);
    border-radius: 50%;
    font-size: 13px;
    color: #fff;
    text-align: center;
}

.score_area_l {
    position: relative;
    width: 103px;
    height: 17px;
    background: url(common/bg_starL_off.png) no-repeat 0 0;
}

.score_area_l .score_count_l {
    position: absolute;
    top: 0;
    left: 0;
    width: 0;
    height: 100%;
    background: url(/image/common/bg_starL_on.png) no-repeat 0 0;
    text-indent: -9999px;
}

.sub_visual_wrap .sub_info_area .tag_area {
    margin-top: 19px;
    min-height: 40px;
    font-size: 14px;
    color: #ccc;
    line-height: 14px;
}

.sub_visual_wrap .sub_info_area .tag_area .best_tag {
    margin-top: 0;
    font-weight: 700;
}

.sub_visual_wrap .sub_info_area .tag_area p {
    margin-top: 8px;
}

.sub_visual_wrap .sub_info_area .basic_information {
    margin-top: 8px;
}

.sub_visual_wrap .sub_info_area .basic_information .info_tit {
    padding-bottom: 10px;
    border-bottom: 1px solid #9398a6;
    font-size: 20px;
    font-weight: 700;
    color: #fff;
    line-height: 20px;
}

.sub_visual_wrap .sub_info_area .basic_information .info_sub_tit {
    float: left;
    width: 60px;
    height: 14px;
    font-size: 14px;
    line-height: 18px;
    color: #ccc;
}

.sub_visual_wrap .sub_info_area .basic_information .info_sub_cont {
    float: left;
    /* width: 290px; */
    min-height: 14px;
    font-size: 14px;
    color: #fff;
    line-height: 18px;
}

.sub_visual_wrap .sub_info_area .basic_information div {
    margin-top: 10px;
}

.sub_visual_wrap .sub_info_area .basic_information .btn_area {
    margin-top: 20px;
}

.sub_visual_wrap .sub_info_area .basic_information .btn_area button {
    float: left;
    padding: 0 10px;
    min-width: 84px;
    height: 30px;
    border: 1px solid #fff;
    font-size: 14px;
    font-weight: 400;
    color: #fff;
    line-height: 30px;
}

.sub_visual_wrap+.sub_visual[data-v-09a75c9f] {
    padding-top: 500px;
}

.location_wrap[data-v-09a75c9f] {
    margin-bottom: 0;
    padding-top: 15px;
    padding-bottom: 15px;
}

.location_wrap {
    position: unset;
}

.location_wrap .location {
    display: none;
}



.location_wrap {
    z-index: 2;
    height: 40px;
    width: auto;
    padding: 30px 0;
    margin: 0 0 60px;
    background: #fff;
    border-bottom: 1px solid #e5e5e5;
    border-top: 0;
}

.location_wrap .location {
    display: none;
}

.appraisal_list {
    padding: 40px 0;
}

ol, ul {
    list-style: none;
}

.appraisal_list li button {
    width: 100%;
}

.appraisal_list li:first-child {
    width: 15%;
    border-left: 0;
}

button {
    border: 0;
    background: none;
    font-family: inherit;
    font-size: inherit;
    color: inherit;
    cursor: pointer;
    text-transform: inherit;
}

.appraisal_list {
    padding: 40px 0;
}


.clear:after {
    display: block;
    content: "";
    clear: both;
}



.appraisal_list li {
    float: left;
    width: 14%;
    height: 100px;
    border-left: 1px solid #e5e5e5;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    text-align: center;
}

.appraisal_list li div {
    height: 50px;
    position: relative;
    margin-bottom: 7px;
}

.appraisal_list li div.ico_like {
    background: url(common/ico_app_like.png) no-repeat 50% 7px;
}

.appraisal_list li div.ico_review {
    background: url(common/ico_app_review.png) no-repeat 50% 7px;
}

.appraisal_list li .appraisal_tit {
    font-size: 16px;
    color: #535353;
    line-height: 16px;
}

.appraisal_list li .appraisal_cnt {
    margin-top: 8px;
    font-size: 16px;
    font-weight: 400;
    color: #ef6d00;
    line-height: 16px;
}

.appraisal_list li div.ico_hits {
    background: url(common/ico_app_hits.png) no-repeat 50% 5px;
}

.add2020_detail {
    margin: 5px auto 0;
    width: 1290px;
}

.add2020_detail_left {
    float: left;
    width: 900px;
}

.add2020_detail_box h2 a.up {
    border: 1px solid #ef6d00;
    background: #fdf0e5;
    font-weight: 700;
    color: #ef6d00;
}

.add2020_detail_box h2 a, .add2020_detail_box h2 a.up {
    position: relative;
    display: block;
    padding: 15px 19px 13px;
    font-size: 18px;
}

.add2020_detail_box_in {
    padding: 20px 0;
}

._grid-system-grid_ {
    position: static;
    width: 100%;
}

._grid-system-column_ {
    position: static;
}

@media (min-width: 1200px)
._grid-system-column_.lg-12 {
    width: 100%;
}

@media (min-width: 1200px)
._grid-system-column_.lg-1, ._grid-system-column_.lg-2, ._grid-system-column_.lg-3, ._grid-system-column_.lg-4, ._grid-system-column_.lg-5, ._grid-system-column_.lg-6, ._grid-system-column_.lg-7, ._grid-system-column_.lg-8, ._grid-system-column_.lg-9, ._grid-system-column_.lg-10, ._grid-system-column_.lg-11, ._grid-system-column_.lg-12 {
    float: left;
}

.viewer[data-v-7a97b51e] {
    position: relative;
    min-height: 100px;
}

.viewer .row[data-v-7a97b51e] {
    display: block;
    width: 100%;
    margin-bottom: 10px;
    text-align: center;
}

.viewer .row .col[data-v-7a97b51e] {
    display: inline-block;
    width: 50%;
}

a, fieldset, img, table {
    border: 0;
}

img {
    overflow-clip-margin: content-box;
    overflow: clip;
}

img[Attributes Style] {
    width: 100%;
}

._grid-system-row_ {
    position: static;
    width: 100%;
}

.kr .p[data-v-29f7b454] {
    word-break: keep-all;
}

.p[data-v-29f7b454] {
    font-size: 17px;
    text-align: left;
    color: #333;
    line-height: 32px;
}

div.real[data-v-29f7b454] {
    padding-bottom: 20px;
}


.add2020_detail_right {
    float: right;
    width: 350px;
}

.add2020_detail_side_box {
    margin-bottom: 10px;
    padding: 0 10px 19px;
    border: 1px solid #e5e5e5;
}

.add2020_detail_side_box h2 {
    margin: 0 0 25px;
    padding: 18px 0 14px;
    border-bottom: 1px solid #e5e5e5;
    font-size: 18px;
    font-weight: 400;
    color: #000;
}

.add2020_detail_side_box h2 {
    margin: 0 0 25px;
    padding: 18px 0 14px;
    border-bottom: 1px solid #e5e5e5;
    font-size: 18px;
    font-weight: 400;
    color: #000;
}

.add2020_detail_side_info dl {
    padding: 0 4px 11px;
}

.add2020_detail_side_info dt {
    margin: 25px 0 6px;
    padding-left: 19px;
    background: url(common/add2020_detail_bullet.png) 0 0 no-repeat;
    font-size: 16px;
    color: #8c8c8c;
    font-weight: 700;
}
.add2020_detail_side_info dd {
    font-size: 14px;
    color: #353535;
    line-height: 18px;
    word-break: break-all;
}

.conts_detail, .conts_detail p {
    font-size: 18px;
    line-height: 32px;
}

.conts_detail {
    color: #333;
    padding-bottom: 30px;
}

.add2020_detail_tab>ul>li {
    margin-top: 10px;
}

.add2020_detail_tab_box h2 a, .add2020_detail_tab_box h2 a.up {
    position: relative;
    display: block;
    padding: 15px 19px 13px;
    font-size: 18px;
}

.add2020_detail_tab_box h2 a {
    border: 1px solid #e5e5e5;
    background: #f6f6f6;
    font-weight: 400;
    color: #535353;
}

.add2020_detail_left h2 a span.arrow {
    display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    margin-top: -5px;
    width: 10px;
    height: 9px;
    text-indent: -9999px;
    background: url(common/add2020_detail_down.png) 0 0 no-repeat;
}

.detail_page .tab_cont .cont_tit {
    font-size: 24px;
    font-weight: 800;
    color: #1b1b1b;
    line-height: 24px;
}

a, a:active, a:hover, a:link, a:visited {
    color: inherit;
    text-decoration: none;
}

.add2020_detail_con {
    padding: 36px 10px 40px;
    position: static!important;
}

.detail_page .tab_cont .btn_regsit {
    height: 35px;
    padding: 0 19px;
    background: #ef6d00;
    border-radius: 5px;
    font-size: 16px;
    font-weight: 400;
    color: #fff;
    line-height: 35px;
    float: right;
    margin-top: -24px;
}

.detail_page .util_wrap {
    margin-top: 20px;
}

.detail_page .util_wrap .util_area {
    float: left;
}

.detail_page .util_wrap .util_area ul {
    height: 16px;
    padding: 7px 0;
}

.detail_page .util_wrap .util_area ul li:first-child {
    padding-left: 0;
    border-left: 0;
}

.detail_page .util_wrap .util_area ul li {
    float: left;
    padding: 0 20px;
    border-left: 1px solid #d9d9d9;
}

.detail_page .util_wrap .util_area ul li.on a {
    color: #535353;
}

.detail_page .util_wrap .util_area ul li a {
    position: relative;
}

.detail_page .util_wrap .util_area ul li a {
    display: block;
    font-size: 16px;
    color: #8a8b8b;
    line-height: 16px;
}

.clear:after {
    display: block;
    content: "";
    clear: both;
}

.review_wrap {
    margin-top: 25px;
}

.review_wrap .review_list {
    border-top: 1px solid #e5e5e5;
}

.review_wrap .review_item {
    position: relative;
    padding: 20px 0;
    height: 200px;
    border-bottom: 1px solid #e5e5e5;
}

.review_wrap .review_list .review_item .review_area {
    padding-bottom: 15px;
}

.review_wrap .review_area .user_profile {
    float: left;
    width: 80px;
    margin-left:30px;
    /* padding-right: 50px; */
    text-align: center;
}

.review_wrap .review_area .user_profile .photo_area {
    position: relative;
    width: 80px;
    height: 80px;
}

.review_wrap .review_area .user_profile .photo_area .user_profile_img {
    display: block;
    width: 80px;
    height: 80px;
    border-radius: 50%;
}

.review_wrap .review_area .user_profile .user_name {
    margin-top: 14px;
    font-size: 15px;
    color: #1b1b1b;
    line-height: 15px;
}

.review_wrap .review_area .user_profile .reg_date {
    font-size: 12px;
}

.review_wrap .review_area .user_profile .reg_date {
    margin-top: 7px;
    font-size: 14px;
    color: #555;
    line-height: 14px;
}

.review_wrap .review_area .user_profile .score_area_p {
    display: inline-block;
    margin-top: 9px;
}

.score_area_p {
    position: relative;
    width: 65px;
    height: 12px;
    background: url(common/bg_starP_off.png) no-repeat 0 0;
}

.score_area_p .score_count_p {
    position: absolute;
    top: 0;
    left: 0;
    width: 0;
    height: 100%;
    background: url(common/bg_starP_on.png) no-repeat 0 0;
    text-indent: -9999px;
}

.review_wrap .review_item>.review_area>.user_content {
    position: relative;
    min-height: 180px;
}

.review_wrap .review_area .user_content {
    float: left;
    width: 750px;
}

.review_wrap .review_area .user_content .recom_area {
    position: absolute;
    right: 0;
}

.review_wrap .review_area .user_content .recom_area .ico_like {
    float: left;
    padding-left: 20px;
    background: url(/image/common/ico_like.png) no-repeat 0 50%;
    background-size: 15px 11px;
    font-size: 14px;
    color: #ef6d00;
    line-height: 23px;
}

.review_wrap .review_area .user_content .recom_area .btn_rcmd {
    margin-left: 10px;
    border: 1px solid #ef6d00;
    color: #ef6d00;
}

.review_wrap .review_item button {
    min-width: 40px;
    height: 23px;
    padding: 0 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 13px;
    color: #555;
    line-height: 23px;
}

.review_wrap .review_area .user_content .checked_area {
    float: left;
    width: 650px;
}

.review_wrap .review_area .user_content .checked_area .check_list {
    float: left;
    max-width: 550px;
}

.review_wrap .review_area .user_content .review {
    position: relative;
    padding-right: 20px;
    width: 690px;
}

.review_wrap .review_area .user_content .review {
    float: left;
    width: 650px;
    margin: 20px 50px;
}

.review_wrap .review_list .review_item .reg_ripple {
    margin-top: 20px;
}

.review_wrap .review_list .review_item .reg_ripple {
    display: none;
}

.review_wrap .review_list .review_item .reg_ripple .reg_ripple_item {
    padding: 20px 0 1px 130px;
    border-top: 1px solid #e5e5e5;
    background: url(common/ico_reply_mark.png) no-repeat 87px 23px;
}

.review_wrap .review_list .review_item .reg_ripple .reg_ripple_area {
    width: 820px;
}

.review_wrap .review_list .review_item .reg_ripple .reg_ripple_area .reg_ripple_input {
    float: left;
    width: 690px;
}

.paging {
    position: relative;
    text-align: center;
    padding-top: 70px;
}

.paging .page-wrap {
    display: inline-block;
}

.paging .page-wrap a.page-first, .paging .page-wrap a.page-last {
    margin: 0 3px;
}

.paging .page-wrap a {
    display: inline-block;
    width: 30px;
    height: 30px;
    margin: 0 8px;
    vertical-align: middle;
    border: 1px solid #ccc;
    line-height: 30px;
    text-align: center;
    font-size: 14px;
}

.spr_com.page-first {
    background-position: 0 -100px;
}

.spr_com {
    display: inline-block;
    background: url(common/spr_comm.png) no-repeat;
    text-indent: -999px;
    overflow: hidden;
    vertical-align: middle;
}

.spr_com.page-prev {
    background-position: -30px -100px;
    margin-right: 30px!important;
}

.paging a.current {
    color: #fff!important;
    font-weight: 700;
    border-color: #ef6d00;
    background-color: #ef6d00;
}

.spr_com.page-next {
    background-position: -60px -100px;
    margin-left: 30px!important;
}

.spr_com.page-last {
    background-position: -90px -100px;
}

.paging .page-wrap a.page-first, .paging .page-wrap a.page-last {
    margin: 0 3px;
}

.add2020_detail_con {
    padding: 36px 10px 40px;
    position: static!important;
}

.tab_cont {
    position: relative;
    padding-top: 50px;
}

p.jisik_tit[data-v-db46a16a] {
    position: relative;
    font-size: 24px;
    font-weight: 600;
    color: #1b1b1b;
    margin: 0 0 26px;
}

p.jisik_tit span[data-v-db46a16a] {
    font-size: 16px;
    color: #ef6d00;
}

p.jisik_tit button[data-v-db46a16a] {
    position: absolute;
    right: 0;
    bottom: 0;
    font-size: 16px;
    font-weight: 400;
    height: 35px;
    padding: 0 19px;
    background: #ef6d00;
    border-radius: 5px;
    color: #fff;
}

table.jisik_list[data-v-db46a16a] {
    width: 880px;
    border-top: 2px solid #535353;
}


table {
    width: 100%;
    border-spacing: 0;
    border-collapse: collapse;
}

thead {
    display: table-header-group;
    vertical-align: middle;
    border-color: inherit;
}

table.jisik_list thead tr th[data-v-db46a16a] {
    text-align: center;
    font-weight: 600;
    font-size: 18px;
    color: #333;
    line-height: 58px;
    padding: 0;
    border-bottom: 1px solid #e5e5e5;
}

.detail_page .tab_cont table th {
    padding-top: 6px;
    font-size: 18px;
    font-weight: 800;
    color: #1b1b1b;
    line-height: 26px;
    text-align: left;
    vertical-align: top;
}

tbody {
    display: table-row-group;
    vertical-align: middle;
    border-color: inherit;
}

table.jisik_list tbody tr td[data-v-db46a16a]:first-child {
    width: 540px;
    text-align: left;
}

table.jisik_list tbody tr td[data-v-db46a16a] {
    border-bottom: 1px solid #e5e5e5;
    line-height: 56px;
    text-align: center;
    padding: 0 10px;
    width: 140px;
}
.detail_page .tab_cont table td {
    word-break: keep-all;
    -ms-word-break: normal;
}

.detail_page .tab_cont table td {
    padding: 6px 0;
    font-size: 16px;
    color: #535353;
    line-height: 20px;
}

table.jisik_list tbody tr td:first-child p[data-v-db46a16a] {
    width: 540px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-break: keep-all;
    cursor: pointer;
}

table.jisik_list tbody tr td:first-child p u.ok[data-v-db46a16a] {
    color: #ef6d00;
}

table.jisik_list tbody tr td:first-child p u[data-v-db46a16a] {
    color: #666;
    text-decoration: none;
}

.know_paging_wrap {
    text-align: center;
    margin: 20px 0;
}

.know_paging_wrap button.active {
    background: #ef6d00;
    color: #fff;
}

.know_paging_wrap button {
    background: #efefef;
    width: 40px;
    height: 40px;
    font-size: 14px;
    border-radius: 50%;
    margin: 0 2px;
}

div.jisik-detail.on[data-v-0fc691de] {
    display: block;
}

div.jisik-detail.on[data-v-db46a16a] {
    display: block;
}

div.jisik-detail[data-v-0fc691de] {
    display: none;
    position: fixed;
    z-index: 601;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    overflow-y: auto;
    background: rgba(0,0,0,.1);
}

div.jisik-detail div.outline[data-v-0fc691de] {
    position: absolute;
    width: 1000px;
    left: 50%;
    margin-left: -500px;
    top: 100px;
    background: #fff;
    padding: 60px 50px 50px;
    -webkit-box-shadow: 0 0 15px rgba(0,0,0,.05098);
    box-shadow: 0 0 15px rgba(0,0,0,.05098);
}

div.jisik-detail [data-v-0fc691de] {
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}

div.jisik-detail div.outline ul.jisik_list[data-v-0fc691de] {
    margin: 0 0 30px;
    position: relative;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion[data-v-0fc691de] {
    position: relative;
    padding: 20px 160px 50px 130px;
    border-bottom: 1px solid #ebebeb;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.name[data-v-0fc691de] {
    text-align: center;
    position: absolute;
    left: 10px;
    top: 20px;
    padding-top: 54px;
    width: 100px;
    font-size: 15px;
    color: #1b1b1b;
    background: url(data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='41.746' height='48.505' viewBox='0 0 41.746 48.505'%3E%3Cdefs%3E%3CclipPath id='a'%3E%3Cpath data-name='사각형 117' fill='%23757575' d='M0 0h41.746v48.504H0z'/%3E%3C/clipPath%3E%3C/defs%3E%3Cg data-name='그룹 3310'%3E%3Cg data-name='그룹 3309'%3E%3Cpath data-name='패스 21919' d='M15.786 2.201S-1.836 8.076 2.569 26.433c2.2 4.774 19.091 19.092 20.561 20.193s2.2-8.444 2.2-8.444 25.333-5.875 9.546-31.208C33.042 6.241 27.168 0 15.786 2.201z' fill='%23f4f4f4'/%3E%3Cg data-name='그룹 3165'%3E%3Cg data-name='그룹 3164' clip-path='url(%23a)'%3E%3Cpath data-name='패스 21917' d='M23.769 48.5a1.7 1.7 0 0 1-.953-.291c-.419-.283-10.284-6.932-11.545-7.9l-.125-.1a31.329 31.329 0 0 1-6.2-5.846A20.875 20.875 0 0 1 20.733 0h.142a20.925 20.925 0 0 1 20.871 20.734c0 13.648-11.458 18.075-15.28 19.171l-1.009 7.134a1.7 1.7 0 0 1-1.688 1.461M20.875 3.41h-.119A17.464 17.464 0 0 0 7.55 32.164a28.08 28.08 0 0 0 5.674 5.348l.125.1c.776.6 5.7 3.941 9.114 6.252l.788-5.568a1.7 1.7 0 0 1 1.384-1.439c.556-.1 13.7-2.7 13.7-16.109A17.5 17.5 0 0 0 20.875 3.41' fill='%23f3f3f3'/%3E%3Cpath data-name='패스 21918' d='M28.811 29.057l-1.731 2.056-2.347-2.342a7.56 7.56 0 0 1-4.078 1.144c-4.447 0-7.956-3.485-7.956-9.727s3.508-9.728 7.956-9.728 7.956 3.485 7.956 9.728a11.163 11.163 0 0 1-1.927 6.736zm-7.709-3.9l1.753-2.08 1.755 1.77a8.865 8.865 0 0 0 1.087-4.657c0-4.292-1.9-6.919-5.041-6.919s-5.041 2.627-5.041 6.919 1.9 6.918 5.041 6.918a4.42 4.42 0 0 0 1.977-.416z' fill='%23ef6d00'/%3E%3C/g%3E%3C/g%3E%3C/g%3E%3C/g%3E%3C/svg%3E) no-repeat top/42px auto;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.name strong[data-v-0fc691de] {
    display: none;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.category[data-v-0fc691de] {
    font-size: 15px;
    color: #1b1b1b;
    margin: 0 0 12px;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.title[data-v-0fc691de] {
    font-size: 16px;
    color: #1b1b1b;
    margin: 0 0 12px;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion div.jisik_text[data-v-0fc691de] {
    font-size: 14px;
    color: #535353;
    line-height: 1.6;
}

ul.thumb_img[data-v-0fc691de] {
    font-size: 0;
    margin: 30px 0 10px;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.count[data-v-0fc691de] {
    position: absolute;
    right: 20px;
    bottom: 20px;
    font-size: 14px;
    color: #555;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.count strong[data-v-0fc691de] {
    font-weight: 400;
}

div.jisik-detail div.outline ul.jisik_list li div.qustion p.count span[data-v-0fc691de] {
    font-weight: 600;
}

div.jisik-detail div.outline ul.jisik_list li div.answer[data-v-0fc691de] {
    position: relative;
    padding: 30px 160px 160px 130px;
    border-bottom: 1px solid #ebebeb;
    background-color: #F9F9F9;
}

div.jisik-detail div.outline ul.jisik_list li div.answer p.name[data-v-0fc691de] {
    font-size: 15px;
    color: #1b1b1b;
    margin: 0 0 12px;
}

div.jisik-detail div.outline ul.jisik_list li div.answer p.name span[data-v-0fc691de] {
    font-size: 12px;
    color: #555;
    margin: 0 0 0 10px;
}

div.jisik-detail div.outline ul.jisik_list li div.answer p.title[data-v-0fc691de] {
    font-size: 16px;
    color: #1b1b1b;
    margin: 0 0 12px;
}

div.jisik-detail div.outline ul.jisik_list li div.answer div.jisik_text[data-v-0fc691de] {
    font-size: 14px;
    color: #535353;
    line-height: 1.6;
}

div.jisik-detail div.outline button.close[data-v-0fc691de] {
    position: absolute;
    right: 30px;
    top: 30px;
    width: 26px;
    height: 26px;
    border: none;
    background: url(common/x_sign.png);
    font-size: 0;
}

.pop_wrap {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1000;
}

.pop_wrap .pop_dim {
    display: block;
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    background: rgba(0,0,0,.6);
}

.pop_wrap .pop_container.pop_review {
    padding: 20px 40px;
}

.pop_wrap .pop_container.pop_review {
    margin-left: -350px;
    padding: 40px;
    border: 1px solid #ef6d00;
    width: 700px;
    height: auto;
    opacity: 1;
}

.pop_wrap .pop_container {
    top: 50px;
}

.pop_wrap .pop_container {
    display: block;
    position: absolute;
    top: 20px;
    left: 50%;
    margin-top: 0;
    margin-left: -580px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    padding: 40px;
    width: 1160px;
    height: 800px;
    -webkit-box-shadow: 0 0 8px 1px rgba(0,0,0,.65);
    box-shadow: 0 0 8px 1px rgba(0,0,0,.65);
    -webkit-transition: opacity .39s;
    transition: opacity .39s;
    opacity: 0;
    background: #fff;
}

.pop_wrap .pop_container .pop_content {
    position: relative;
    height: 100%;
    overflow: hidden;
    overflow-y: auto;
}
.pop_wrap .pop_container.pop_review .review_top {
    position: relative;
    padding-top: 5px;
}

.pop_wrap .pop_container.pop_review .review_top h3 {
    font-size: 22px;
    color: #1b1b1b;
}

.pop_wrap table.board_write {
    margin-bottom: 5px;
}

.detail_page .tab_cont table {
   /*  width: 1050px; */
    margin-top: 20px;
}
.pop_wrap table.board_write {
    width: 100%!important;
    border: 0;
}

table {
    width: 100%;
    border-spacing: 0;
    border-collapse: collapse;
}

colgroup {
    display: table-column-group;
}

col[Attributes Style] {
    width: 100px;
}

col {
    display: table-column;
}

tbody {
    display: table-row-group;
    vertical-align: middle;
    border-color: inherit;
}

.pop_wrap table.board_write tbody tr {
    border-bottom: 1px solid #e2e2e2;
}

.detail_page .tab_cont table th {
    padding-top: 6px;
    font-size: 18px;
    font-weight: 800;
    color: #1b1b1b;
    line-height: 26px;
    text-align: left;
    vertical-align: top;
}

.pop_wrap table.board_write th {
    padding: 7px 0;
    font-size: 16px;
    color: #1b1b1b;
    text-align: left;
    letter-spacing: -1px;
}

.detail_page .tab_cont table th {
    padding-top: 6px;
    font-size: 18px;
    font-weight: 800;
    color: #1b1b1b;
    line-height: 26px;
    text-align: left;
    vertical-align: top;
}

.detail_page .tab_cont table td {
    word-break: keep-all;
    -ms-word-break: normal;
}

.detail_page .tab_cont table td {
    padding: 6px 0;
    font-size: 16px;
    color: #535353;
    line-height: 20px;
}

.pop_wrap .pop_container.pop_review .score_area {
    width: 100%;
    overflow: hidden;
    background: none;
}

.pop_wrap .pop_container.pop_review .review_btn_box {
    margin-top: 25px;
    text-align: center;
}

.pop_wrap .pop_container.pop_review .review_btn_box button.btn_regist {
    margin-right: 20px;
    border-color: #f8c990;
    color: #ef6d00;
}

.pop_wrap .pop_container.pop_review .review_btn_box button {
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    border: 2px solid #e5e5e5;
    width: 120px;
    height: 45px;
    font-size: 17px;
}

.pop_wrap .pop_container.pop_review .review_btn_box button.btn_cancel {
    color: #8c8c8c;
}

.pop_wrap .pop_container.pop_review .score_area .btn_score.on {
    background: url(common/bg_star_on.png) no-repeat 0 0;
}

.pop_wrap .pop_container.pop_review .score_area .btn_score {
    float: left;
    margin-right: 3px;
    width: 15px;
    height: 15px;
    text-indent: -9999px;
    background: url(common/bg_star_off.png) no-repeat 0 0;
}

div.jisik-pop.on[data-v-a315ebf2] {
    display: block;
}

div.jisik-pop.on[data-v-db46a16a] {
    display: block;
}

div.jisik-pop[data-v-a315ebf2] {
    display: none;
    position: fixed;
    z-index: 604;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    overflow-y: auto;
    background: rgba(0,0,0,.1);
}

div.jisik-pop[data-v-db46a16a] {
    display: none;
    position: fixed;
    z-index: 604;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    overflow-y: auto;
    background: rgba(0,0,0,.1);
}

div.jisik-pop div.outline[data-v-a315ebf2] {
    position: absolute;
    width: 1000px;
    left: 50%;
    margin-left: -500px;
    top: 100px;
    background: #fff;
    padding: 30px 50px 50px;
    -webkit-box-shadow: 0 0 15px rgba(0,0,0,.05098);
    box-shadow: 0 0 15px rgba(0,0,0,.05098);
}

div.jisik-pop [data-v-a315ebf2] {
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}

div.jisik-pop div.outline h3[data-v-a315ebf2] {
    text-align: center;
    font-size: 20px;
    color: #ef6d00;
    font-weight: 600;
    margin: 0 0 45px;
}

.cont_wrap h3 {
    font-size: 35px;
    color: #1b1b1b;
    line-height: 35px;
    text-align: left;
    margin-bottom: 50px;
    padding-left: 5px;
}

div.jisik-pop div.outline h3 small[data-v-a315ebf2] {
    display: block;
    font-size: 14px;
    color: #999;
    font-weight: 400;
}

div.jisik-pop div.outline div.box[data-v-a315ebf2] {
    margin: 40px 0 0;
}

div.jisik-pop div.outline div.box>div[data-v-a315ebf2] {
    padding: 0 0 25px;
    margin: 0 0 25px;
}

div.jisik-pop div.outline div.box>div h5[data-v-a315ebf2] {
    font-size: 18px;
    color: #333;
    font-weight: 600;
    margin: 0 0 18px;
}

div.jisik-pop div.outline div.box>div.text input[data-v-a315ebf2] {
    width: 100%;
    height: 50px;
    border: 1px solid #e6e6e6;
    padding: 0 20px 0 60px;
    margin: 0 0 20px;
    font-size: 16px;
    color: #535353;
    background: url(common/question_mark.png) no-repeat left  ;
   }
   
   div.jisik-pop div.outline div.box>div.text textarea[data-v-a315ebf2] {
    width: 100%;
    border: 1px solid #e6e6e6;
    padding: 20px;
    margin: 0 0 20px;
    font-size: 16px;
    color: #535353;
    line-height: 1.6;
    height: 300px;
}

textarea {
    resize: none;
}

div.jisik-pop div.outline div.agree[data-v-a315ebf2] {
    padding: 20px;
    background: #f8f8f8;
    border: 1px solid #ddd;
    margin: 0 0 45px;
}

div.jisik-pop div.outline button.submit[data-v-a315ebf2] {
    display: block;
    background: #ef6d00;
    border: 1px solid #ce5e00;
    color: #fff;
    font-size: 18px;
    font-weight: 600;
    height: 45px;
    margin: 0 auto;
    padding: 0 60px;
}

div.jisik-pop div.outline button.close[data-v-a315ebf2] {
    position: absolute;
    right: 30px;
    top: 30px;
    width: 26px;
    height: 26px;
    border: none;
    background: url(common/x_sign.png) no-repeat 50%/100% auto;
    font-size: 0;
}
</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div id="wrap" class="wrap">
<div class="header">
        <div class="header_contents flex">
            <div class="logo">JEJU VISIT</div>
            <div class="nav_top">
                <ul>
                    <li><a href="http://localhost:8080/prj_touristArea/touristArea.jsp">관광지</a></li>
                    <li>맛집</li>
                    <li>게시판</li>
                    <li>투어예약</li>
                </ul>
            </div>
            <div class="search_login flex">
                <div class="search">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                      <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                    </svg>
                </div>
                <div class="login">로그인</div>
            </div>
        </div>
    </div>
   
   	<div id="detailContentsView">
   		<div id="container" data-v-09a75c9f="">
   			<div id="content" data-v-09a75c9f="">
   				<div id="__SEARCH_DATA__" style="display:none;" data-v-09a75c9f="">
   					<pre data-key="language">kr</pre>
   					<pre data-key="contentsid">CONT_000000000500457</pre>
   					<pre data-key="contentscd.value">c1</pre>
   					<pre data-key="contentscd.label">관광지</pre>
   					<pre data-key="contentscd.refId">contentscd&gt;c1</pre>
   					<pre data-key="title">오설록티뮤지엄</pre>
   					<pre data-key="region1cd.value">region2</pre>
   					<pre data-key="region1cd.label">서귀포시</pre>
   					<pre data-key="region1cd.refId">region&gt;region2</pre>
   					<pre data-key="region2cd.value">23</pre>
   					<pre data-key="region2cd.label">안덕</pre>
   					<pre data-key="region2cd.refId">region2&gt;23</pre>
   					<pre data-key="tag">테마공원,커플,친구,부모,아이,혼자,맑음,휴식/힐링,녹차,실내관광지,어트랙션,반려동물,반려동물동반입장,반려동물동반_관광지,무장애관광</pre><pre data-key="introduction">제주녹차문화의 중심, 차박물관과 카페테리아, 2016 KOREAT JEJU TOP 30 선정</pre><pre data-key="readcnt">140412</pre>
   					<pre data-key="snssharecnt">70</pre>
   					<pre data-key="likecnt">96</pre>
   					<pre data-key="reviewcnt">309</pre>
   					<pre data-key="markcnt">2784</pre>
   					<pre data-key="schedulecnt">0</pre>
   					<pre data-key="visitcnt">10</pre>
   					<pre data-key="evelpt">5</pre>
   					<pre data-key="homepage">https://www.osulloc.com/kr/ko/museum</pre>
   					<pre data-key="titleseo">오설록티뮤지엄</pre>
   					<pre data-key="sbstseo">(본문)</pre>
					<pre data-key="keywordseo">테마공원,커플,친구,부모,아이,혼자,맑음,휴식/힐링,녹차,실내관광지,어트랙션,반려동물,반려동물동반,반려동물전용,예스펫존,반려동물동반입장,혼저옵서개,강아지,반려동물여행,반려동물동반관광지</pre>
					<pre></pre>
					<pre></pre>
					<pre></pre>
					<pre data-key="dpassistneedscd.value">1</pre>
					<pre data-key="dpassistneedscd.label">어려움</pre>
					<pre data-key="dpassistneedscd.refId">assistneedscd&gt;1</pre>
					<pre data-key="address">제주특별자치도 서귀포시 안덕면 서광리 1235-1</pre>
					<pre data-key="roadaddress">제주특별자치도 서귀포시 안덕면 신화역사로 15</pre>
					<pre data-key="phoneno">064-794-5312</pre>
					<pre data-key="latitude">33.3063942</pre>
					<pre data-key="longitude">126.2905203</pre>
					<pre data-key="editordesc">&lt;p&gt;&amp;nbsp;&lt;/p&gt;</pre>
					<pre data-key="usedescinfo">연중무휴 /  소형견, 중형견, 대형견 입장 전화 문의 / 안내견 실내입장 가능 / 실외 녹차밭 입장 불가 </pre>
					<pre data-key="tamnaoyn.value">y</pre>
					<pre data-key="tamnaoyn.label">Y</pre>
					<pre data-key="tamnaoyn.refId">codeyn&gt;y</pre>
					<pre data-key="created">20160530111636</pre>
					<pre data-key="repPhoto.descseo">오설록티뮤지엄</pre>
					<pre data-key="repPhoto.photoid">{
						  "photoid": 2019022583605,
						  "imgpath": "https://api.cdn.visitjeju.net/photomng/imgpath/202110/20/003f420c-6efe-41e9-93b7-00fe6ac5e83b.jpg",
						  "thumbnailpath": "https://api.cdn.visitjeju.net/photomng/thumbnailpath/202110/20/3bf30cdd-799f-4789-b172-52b11c07ddf1.jpg"
						}
					</pre>
				</div>
				<div class="cont detail_page detail_style" data-v-09a75c9f="">
					<h2 class="hide" data-v-09a75c9f="">본문</h2>
					<div class="sub_visual_wrap" style="background: url(&quot;https://api.cdn.visitjeju.net/photomng/imgpath/202110/20/003f420c-6efe-41e9-93b7-00fe6ac5e83b.jpg&quot;) 50% 50% / cover no-repeat;" data-v-09a75c9f=""><div class="inner_wrap" data-v-09a75c9f=""><div data-v-09a75c9f=""></div>
					<div class="sub_info_area" data-v-09a75c9f="">
					<div class="sub_info_title" data-v-09a75c9f="">
					<h3 data-v-09a75c9f="" class="">오설록티뮤지엄</h3>
					<p class="h3_sub" style="margin-top:0" data-v-09a75c9f=""></p>
					<!---->
				</div>
				<div class="weather" data-v-09a75c9f="">
					<img data-v-09a75c9f="" src="/image/weather/weather_g_sun.png" alt="맑음" class="ico_weather">
					<p data-v-09a75c9f="">맑음</p>
				</div>
				<div class="score_area_l" data-v-09a75c9f="">
					<p class="score_count_l" style="width:100%;" data-v-09a75c9f="">별점(5점만점에 5점)</p>
				</div>
				<div class="tag_area" data-v-09a75c9f="">
					<p class="best_tag" data-v-09a75c9f="">
						<a href="/kr/search?searchtype=2&amp;q=%ED%85%8C%EB%A7%88%EA%B3%B5%EC%9B%90#">#테마공원</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EC%BB%A4%ED%94%8C#">#커플</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EC%B9%9C%EA%B5%AC#">#친구</a>
					</p>
					<p data-v-09a75c9f="">  
						<a href="/kr/search?searchtype=2&amp;q=%EB%B6%80%EB%AA%A8#">#부모</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EC%95%84%EC%9D%B4#">#아이</a> 
						<a href="/kr/search?searchtype=2&amp;q=%ED%98%BC%EC%9E%90#">#혼자</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EB%A7%91%EC%9D%8C#">#맑음</a> 
						<a href="/kr/search?searchtype=2&amp;q=%ED%9C%B4%EC%8B%9D/%ED%9E%90%EB%A7%81#">#휴식/힐링</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EB%85%B9%EC%B0%A8#">#녹차</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EC%8B%A4%EB%82%B4%EA%B4%80%EA%B4%91%EC%A7%80#">#실내관광지</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EC%96%B4%ED%8A%B8%EB%9E%99%EC%85%98#">#어트랙션</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EB%B0%98%EB%A0%A4%EB%8F%99%EB%AC%BC#">#반려동물</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EB%B0%98%EB%A0%A4%EB%8F%99%EB%AC%BC%EB%8F%99%EB%B0%98%EC%9E%85%EC%9E%A5#">#반려동물동반입장</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EB%B0%98%EB%A0%A4%EB%8F%99%EB%AC%BC%EB%8F%99%EB%B0%98_%EA%B4%80%EA%B4%91%EC%A7%80#">#반려동물동반_관광지</a> 
						<a href="/kr/search?searchtype=2&amp;q=%EB%AC%B4%EC%9E%A5%EC%95%A0%EA%B4%80%EA%B4%91#">#무장애관광</a>
					</p>
				</div>
				<div class="basic_information" data-v-09a75c9f="">
					<p class="info_tit" data-v-09a75c9f="">기본정보</p>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">주소</p>
						<p class="info_sub_cont" data-v-09a75c9f="">제주특별자치도 서귀포시 안덕면 신화역사로 15</p>
					</div>
					<div class="clear" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">연락처</p>
						<p class="info_sub_cont" data-v-09a75c9f="">(+82) 064-794-5312</p>
					</div>
					<div class="clear" style="max-height: 32px;overflow: hidden;" data-v-09a75c9f="">
						<p class="info_sub_tit" data-v-09a75c9f="">홈페이지</p>
						<a href="javascript:void(0);" title="새창열림" class="info_sub_cont" style="word-break: break-all;" data-v-09a75c9f="">https://www.osulloc.com/kr/ko/museum</a>
					</div>
					<div class="btn_area clear" data-v-09a75c9f="">
						<button type="button" data-v-09a75c9f="">길찾기</button>
						<!---->
					</div>
				</div>
			</div>
		</div>
		<div class="outer_wrap" data-v-09a75c9f=""></div>
	</div>
	<div class="cont_wrap sub_visual" data-v-09a75c9f="">
	<div class="location_wrap clear" data-v-09a75c9f="">
	<div class="location clear">
		<a href="/kr/#" class="ico_home">HOME</a>
		<span class="p_depth">
			<a href="javascript:void(0)" class="asd">&gt; 관광지</a>
		</span><div class="lst_depth">
		<a href="javascript:void(0)" title="2뎁스목록 열기(선택된 목록)" class="btn_dropdown">&gt; 테마관광지</a>
		<!---->
	</div>
	</div>
	
	</div>
		<ul class="appraisal_list clear" data-v-09a75c9f="">
			<li data-v-09a75c9f=""><button type="button" data-v-09a75c9f=""><div class="ico_like" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">좋아요<span class="status" data-v-09a75c9f="">선택 안됨</span></p><p class="appraisal_cnt" data-v-09a75c9f="">96</p></button></li>
			<li data-v-09a75c9f=""><button type="button" data-v-09a75c9f=""><div class="ico_zzim" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">찜하기<span class="status" data-v-09a75c9f="">선택 안됨</span></p><p class="appraisal_cnt" data-v-09a75c9f="">2,784</p></button></li>
			<li data-v-09a75c9f=""><div class="ico_review" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">리뷰</p><p class="appraisal_cnt" data-v-09a75c9f="">309</p></li>
			<li data-v-09a75c9f=""><div class="ico_schedule" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">일정 등록</p><p class="appraisal_cnt" data-v-09a75c9f="">0</p></li>
			<li data-v-09a75c9f=""><div class="ico_back" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">방문했어요</p><p class="appraisal_cnt" data-v-09a75c9f="">10</p></li>
			<li data-v-09a75c9f=""><div class="ico_hits" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">조회</p><p class="appraisal_cnt" data-v-09a75c9f="">140,412</p></li><li data-v-09a75c9f=""><div class="ico_sns" data-v-09a75c9f=""></div><p class="appraisal_tit" data-v-09a75c9f="">SNS 공유 수</p><p class="appraisal_cnt" data-v-09a75c9f="">70</p></li>
		</ul>
		<div class="add2020_detail" data-v-09a75c9f="">
			<div class="add2020_detail_left" data-v-09a75c9f="">
				<div id="tab0" class="add2020_detail_box" data-v-09a75c9f="">
					<h2 data-v-09a75c9f="">
						<a href="#" class="up" data-v-09a75c9f="">상세정보<span class="arrow" data-v-09a75c9f="">확장됨</span></a>
					</h2>
					<div class="add2020_detail_box_in" data-v-09a75c9f="">
						<div data-helper-component-key="core-system-grid" __vue_component_directive="ice?visit-jeju;contents;kr-CONT_000000000500457;@5" __vue_component_directive_fallback="ice?visit-jeju;contents;kr-CONT_000000000500457;@5" __directive_pos="0" data-accept-components="contentsDecoration/htmlBlock.vue,contentsDecoration/contentsTitle.vue,contentsDecoration/subContentsTitle.vue,contentsDecoration/GridImageViewer.vue,contentsDecoration/relativeComponent.vue,contentsDecoration/contentsParagraph.vue,contentsDecoration/Quotation.vue,contentsDecoration/devideLine.vue,contentsDecoration/YouTube.vue,contentsDecoration/Caption.vue,contentsDecoration/html2.vue" data-fragment-name="컨텐츠" class="_grid-system-grid_ grid-container " style="background-color:transparent;width:100%;">
						<div data-helper-component-key="core-system-row" __directive_pos="0.0" class="_grid-system-row_"><div data-helper-component-key="core-system-column" __directive_pos="0.0.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12">
						<div __directive_pos="0.0.0.0" class="viewer" data-v-7a97b51e=""><!----><div class="row" style="margin-bottom:10px;" data-v-7a97b51e=""><div class="col" style="width: 900px;" data-v-7a97b51e=""><img src="//api.cdn.visitjeju.net/photomng/imgpath/202110/20/bb987cc7-f70b-47e1-b37c-b4e44ae22667.JPG" alt="오설록티뮤지엄 이미지 1" width="100%" data-v-7a97b51e=""></div></div><!----></div><!----></div><!----></div><div data-helper-component-key="core-system-row" __directive_pos="0.1" class="_grid-system-row_"><div data-helper-component-key="core-system-column" __directive_pos="0.1.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12"><div __directive_pos="0.1.0.0" class="p fr-view" data-v-29f7b454=""><div class="real" data-v-29f7b454="">
							<p><br></p>
							<p>(본문)<br><br> (본문2)</p>
							<p><br></p>
						</div>
						<!---->
					</div>
					<!---->
				</div>
				<!---->
				</div>
				<div data-helper-component-key="core-system-row" __directive_pos="0.2" class="_grid-system-row_">
					<div data-helper-component-key="core-system-column" __directive_pos="0.2.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12">
						<div __directive_pos="0.2.0.0" class="viewer" data-v-7a97b51e="">
						<!---->
							<div class="row" style="margin-bottom:10px;" data-v-7a97b51e="">
								<div class="col" style="width: 445px; margin-right: 10px;" data-v-7a97b51e="">
									<img src="//api.cdn.visitjeju.net/photomng/imgpath/201908/06/3c3bb801-6699-4bbd-87bf-afd69cb3ce30.jpg" alt="오설록티뮤지엄2019 이미지 2" width="100%" data-v-7a97b51e=""></div>
									<div class="col" style="width: 445px;" data-v-7a97b51e="">
										<img src="//api.cdn.visitjeju.net/photomng/imgpath/201908/06/f85e4552-0858-4869-8f9b-c430e1da51bf.jpg" alt="오설록티뮤지엄2019 이미지 3" width="100%" data-v-7a97b51e=""></div>
									</div>
									<!---->
								</div>
								<!---->
							</div>
							<!---->
						</div>
						<div data-helper-component-key="core-system-row" __directive_pos="0.3" class="_grid-system-row_">
							<div data-helper-component-key="core-system-column" __directive_pos="0.3.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12">
								<div __directive_pos="0.3.0.0" class="viewer" data-v-7a97b51e="">
								<!---->
									<div class="row" style="margin-bottom:10px;" data-v-7a97b51e="">
										<div class="col" style="width: 900px;" data-v-7a97b51e="">
											<img src="//api.cdn.visitjeju.net/photomng/imgpath/201908/06/87fd7eef-56d0-427d-b501-b3e1ec9cbf20.jpg" alt="오설록티뮤지엄2019 이미지 4" width="100%" data-v-7a97b51e=""></div>
											</div>
											<!---->
										</div>
										<!---->
								</div>
								<!---->
							</div>
							<div data-helper-component-key="core-system-row" __directive_pos="0.4" class="_grid-system-row_">
								<div data-helper-component-key="core-system-column" __directive_pos="0.4.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12">
									<div __directive_pos="0.4.0.0" class="viewer" data-v-7a97b51e="">
									<!---->
										<div class="row" style="margin-bottom:10px;" data-v-7a97b51e="">
											<div class="col" style="width: 445px; margin-right: 10px;" data-v-7a97b51e="">
												<img src="//api.cdn.visitjeju.net/photomng/imgpath/201908/06/c07ce724-396e-4bde-a9a0-60bee84860a8.jpg" alt="오설록티뮤지엄2019 이미지 5" width="100%" data-v-7a97b51e=""></div>
												<div class="col" style="width: 445px;" data-v-7a97b51e="">
													<img src="//api.cdn.visitjeju.net/photomng/imgpath/201908/06/de62b5c8-43bb-4d2d-889b-6775aaa0ade3.jpg" alt="오설록티뮤지엄2019 이미지 6" width="100%" data-v-7a97b51e=""></div>
												</div>
												<!---->
											</div>
											<!---->
										</div>
										<!---->
									</div>
									<div data-helper-component-key="core-system-row" __directive_pos="0.5" class="_grid-system-row_">
										<div data-helper-component-key="core-system-column" __directive_pos="0.5.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12">
											<div __directive_pos="0.5.0.0" class="viewer" data-v-7a97b51e="">
											<!---->
												<div class="row" style="margin-bottom:10px;" data-v-7a97b51e="">
													<div class="col" style="width: 900px;" data-v-7a97b51e="">
														<img src="//api.cdn.visitjeju.net/photomng/imgpath/202110/20/50395229-b26e-455b-a7d2-7d5d4691449e.jpg" alt="오설록티뮤지엄 이미지 7" width="100%" data-v-7a97b51e=""></div>
													</div>
													<div class="row" style="margin-bottom:10px;" data-v-7a97b51e="">
													<div class="col" style="width: 900px;" data-v-7a97b51e="">
														<img src="//api.cdn.visitjeju.net/photomng/imgpath/201908/06/c3b686e5-4d17-46f4-9e96-1de49d6af809.jpg" alt="오설록티뮤지엄2019 이미지 8" width="100%" data-v-7a97b51e=""></div>
													</div>
													<!---->
												</div>
												<!---->
											</div>
											<!---->
										</div>
										<div data-helper-component-key="core-system-row" __directive_pos="0.6" class="_grid-system-row_">
											<div data-helper-component-key="core-system-column" __directive_pos="0.6.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12"><!----></div>
											<!---->
										</div>
									</div>
									<!---->
								<div class="conts_detail"><p>&nbsp;</p>
							</div>
						</div>
						<!---->
					</div>
					<div class="add2020_detail_tab" data-v-09a75c9f="">
						<ul data-v-09a75c9f="">
							<!--질문게시판  -->
							<li data-v-09a75c9f="">
								<div id="tab6" class="add2020_detail_tab_box" data-v-09a75c9f="">
									<h2 data-v-09a75c9f=""><a href="#" data-v-09a75c9f="">질문<span class="arrow" data-v-09a75c9f="">축소됨</span></a></h2><div id="stab6" transition="fadeIn" class="add2020_detail_con tab_cont kr" style data-v-db46a16a="" data-v-09a75c9f=""><p class="jisik_tit" data-v-db46a16a="">
        제주관광 지식iN <span data-v-db46a16a="">(13)</span><button type="button" data-v-db46a16a="">지식iN에 문의하기</button></p><table class="jisik_list" data-v-db46a16a=""><thead data-v-db46a16a=""><tr data-v-db46a16a=""><th data-v-db46a16a="">제목</th><th data-v-db46a16a="">카테고리</th><th data-v-db46a16a="">답변수</th><th data-v-db46a16a="">작성일</th></tr></thead><tbody data-v-db46a16a=""><tr data-v-db46a16a=""><td data-v-db46a16a=""><p data-v-db46a16a=""><u class="ok" data-v-db46a16a="">[답변]</u> 서귀포연금관리공단앞에서우도가는긴</p></td><td data-v-db46a16a="">관광지</td><td data-v-db46a16a="">1</td><td data-v-db46a16a="">2023.07.23</td></tr><tr data-v-db46a16a=""><td data-v-db46a16a=""><p data-v-db46a16a=""><u class="ok" data-v-db46a16a="">[답변]</u> 대중교통편</p></td><td data-v-db46a16a="">관광지</td><td data-v-db46a16a="">1</td><td data-v-db46a16a="">2023.07.23</td></tr><tr data-v-db46a16a=""><td data-v-db46a16a=""><p data-v-db46a16a=""><u class="ok" data-v-db46a16a="">[답변]</u> 우도 맛집 추천해주세요 가격도 너무 세지않는 곳으로요</p></td><td data-v-db46a16a="">음식점</td><td data-v-db46a16a="">1</td><td data-v-db46a16a="">2023.07.22</td></tr><tr data-v-db46a16a=""><td data-v-db46a16a=""><p data-v-db46a16a=""><u class="ok" data-v-db46a16a="">[답변]</u> 우도 들어가는 배편 타는 위치와 시간표는 어떻게 되나요??</p></td><td data-v-db46a16a="">관광지</td><td data-v-db46a16a="">1</td><td data-v-db46a16a="">2023.07.22</td></tr><tr data-v-db46a16a=""><td data-v-db46a16a=""><p data-v-db46a16a=""><u class="ok" data-v-db46a16a="">[답변]</u> 후쿠시마 오염수 방류로 인해 우도에 위치한 해양도립공원도 악영향을 받을 수 있는지 질문드립니다 </p></td><td data-v-db46a16a="">관광지</td><td data-v-db46a16a="">1</td><td data-v-db46a16a="">2023.07.20</td></tr></tbody></table>
        						<div class="know_paging_wrap" data-v-db46a16a="">
        						<!---->
        							<button type="button" class="active">1</button>
        							<button type="button" class="">2</button>
        							<button type="button" class="">3</button>
        							<button type="button">&gt;</button></div>
        							
        							<!-- 질문하기  class = on붙이기 (jisik-pop on) -->
        							<div data-v-a315ebf2="" data-v-db46a16a="" class="jisik-pop" >
        								<div data-v-a315ebf2="" class="outline"><h3 data-v-a315ebf2="">질문하기<small data-v-a315ebf2="">제주관광 관련 궁금한 점을 작성하여 주세요. 관련된 분야의 전문 지식인의 답변을 받으실 수 있습니다.</small></h3>
        									<div data-v-a315ebf2="" class="box">
        										<div data-v-a315ebf2="" class="text">
        											<h5 data-v-a315ebf2="">질문입력</h5>
        											<input data-v-a315ebf2="" type="text" placeholder="제목을 입력하세요">
        											<textarea data-v-a315ebf2="" placeholder="내용을 입력하세요"></textarea>
       											</div>
											<button data-v-a315ebf2="" type="button" class="submit">작성완료</button>
											<button data-v-a315ebf2="" type="button" class="close">창 닫기</button>
										</div>
									</div>
        							
        							
        							<!-- 질문 답변 -->
        							<div data-v-0fc691de="" data-v-db46a16a="" class="jisik-detail on" style="display:none;">
        							<div data-v-0fc691de="" class="outline"><ul data-v-0fc691de="" class="jisik_list"><li data-v-0fc691de=""><div data-v-0fc691de="" class="qustion"><p data-v-0fc691de="" class="name"><strong data-v-0fc691de="">작성자 : </strong>정강현
                        <span data-v-0fc691de=""><strong data-v-0fc691de="">올린시간 : </strong> 2023.07.22</span></p><p data-v-0fc691de="" class="category"><strong data-v-0fc691de="">카테고리 : </strong> [관광지]</p><p data-v-0fc691de="" class="tag"><a data-v-0fc691de="" href="">#우도</a><a data-v-0fc691de="" href="">#우도여객선</a><a data-v-0fc691de="" href="">#우도배편</a></p><p data-v-0fc691de="" class="title">우도 들어가는 배편 타는 위치와 시간표는 어떻게 되나요?? </p><div data-v-0fc691de="" class="jisik_text"><div data-v-0fc691de="">우도에 들어가는 배편은 어디에서 타나요??
<br>그리고 배편이 운항하는 시간표는 어떻게 되나요?!</div><ul data-v-0fc691de="" class="thumb_img"></ul></div><p data-v-0fc691de="" class="count"><strong data-v-0fc691de="">답변수 : </strong><span data-v-0fc691de="">1</span></p><button data-v-0fc691de="" type="button" class="answer">답변하기</button><div data-v-0fc691de="" class="buttons"><!----><!----></div></div><div data-v-0fc691de="" class="answer"><p data-v-0fc691de="" class="name"><strong data-v-0fc691de="">작성자 : </strong>@비공개
                        <span data-v-0fc691de=""><strong data-v-0fc691de="">올린시간 : </strong> 2023.07.23</span></p><p data-v-0fc691de="" class="title">우도배편</p><div data-v-0fc691de="" class="jisik_text"><div data-v-0fc691de=""><div data-v-0fc691de="" class="comment_contents">성산포항 가셔서 타시면 됩니다.
<br>계절에 따라 8시나 9시부터 저녁 6시정도까지 하는 것 같아요
<br>30분마다 한번씩 왔다갔다 하니 여유 있게 타실 수 있을 것 같습니다.</div><ul data-v-0fc691de="" class="thumb_img"></ul></div><div data-v-0fc691de="" class="tags"></div></div>

</div>
</li></ul><button data-v-0fc691de="" type="button" class="close">창 닫기</button></div></div>
        							
        							<!----><!---->
        							<div data-v-9db46a28="" data-v-db46a16a=""><!----></div></div></div></li>
				       		 <!--리뷰  -->
				       		 <!-- style display : none -->
                   			 <li data-v-09a75c9f="">
                   			 	<div id="tab3" class="add2020_detail_tab_box" data-v-09a75c9f="">
                   			 		<h2 data-v-09a75c9f=""><a href="#" data-v-09a75c9f="">리뷰<span class="arrow" data-v-09a75c9f="">축소됨</span></a></h2>
                   			 			<div id="stab3" transition="fadeIn" class="add2020_detail_con tab_cont" style data-v-09a75c9f=""><p class="cont_tit">여행가의 리뷰<span style="font-weight: 800; color: rgb(239, 109, 0); line-height: 24px; margin-left: 0px;">(309)</span></p>
                   			 				<button type="button" id="regsitReview" class="btn_regsit">리뷰 및 평가 등록</button>
                   			 				<div class="util_wrap clear">
                   			 					<div class="util_area">
                   			 						<ul class="clear">
                   			 							<li class="on"><a href="javascript:void(0)">최신</a></li>
                   			 							<li class=""><a href="javascript:void(0)">평가</a></li>
               			 							</ul>
           			 							</div>
           			 							</div>
           			 							<div class="review_wrap">
           			 								<ul class="review_list">
           			 									<li id="contentsReviewItem0" class="review_item">
           			 										<div class="review_area clear">
           			 											<div class="user_profile"><div class="photo_area">
           			 												<img src="common/img_non_profile.png" alt="프로필이미지" class="user_profile_img">
           			 												<!---->
       			 												</div>
       			 												<p class="user_name">jun*****</p>
       			 												<p class="reg_date">2019.12.11</p>
       			 												<div class="score_area_p">
       			 													<p class="score_count_p" style="width:100%;">별점(5점만점에 5점)</p>
   			 													</div>
		 													</div>
		 													<div class="user_content">
		 														<div class="review clear"><p class="review_txt">오설록티뮤지엄에서 초록을 모아보다</p>
		 															<p class="review_origin_text" style="display:none;"></p>
		 															
																		</div>
																	
		 														</div>
		 														</div>
		 												
															</li>
														</ul>
													</div>
													<div class="paging">
														<div id="paging" class="page-wrap">
														<a href="javascript:void(0)" class="spr_com page-first">첫 페이지</a>
														<a href="javascript:void(0)" class="spr_com page-prev">이전 페이지</a>
														<a href="javascript:void(0)" title="현재 페이지" class="current">1</a>
														<a href="javascript:void(0)" title="" class="">2</a>
														<a href="javascript:void(0)" title="" class="">3</a>
														<a href="javascript:void(0)" title="" class="">4</a>
														<a href="javascript:void(0)" title="" class="">5</a>
														<a href="javascript:void(0)" title="" class="">6</a>
														<a href="javascript:void(0)" title="" class="">7</a>
														<a href="javascript:void(0)" title="" class="">8</a>
														<a href="javascript:void(0)" title="" class="">9</a>
														<a href="javascript:void(0)" title="" class="">10</a>
														<a href="javascript:void(0)" class="spr_com page-next">다음 페이지</a>
														<a href="javascript:void(0)" class="spr_com page-last">마지막 페이지</a>
														</div>
													</div>
													
													<!--리뷰 평가 및 등록-->
													<div data-v-2ede1d5f="" class="pop_wrap pop_review_write_box" style="display:none">
														<div data-v-2ede1d5f="" class="pop_dim"></div>
														<div data-v-2ede1d5f="" class="pop_container pop_review">
															<div data-v-2ede1d5f="" class="pop_content">
															<div data-v-2ede1d5f="" class="review_top">
																<h3 data-v-2ede1d5f="">리뷰 쓰기</h3>
															</div>
															<div data-v-2ede1d5f="">
																<table data-v-2ede1d5f="" class="board_write">
																	<colgroup data-v-2ede1d5f="">
																		<col data-v-2ede1d5f="" width="100">
																	</colgroup>
																	<tbody data-v-2ede1d5f="">
																		<tr data-v-2ede1d5f="">
																			<th data-v-2ede1d5f=""><span data-v-2ede1d5f="">평가</span></th>
																				<td data-v-2ede1d5f="">
																					<div data-v-2ede1d5f="" class="score_area">
																						<input data-v-2ede1d5f="" type="hidden" value="regsitReview" id="reviewBoxfocusTarget">
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score1 on"><span data-v-2ede1d5f="" class="hide">5점만점에 1점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score2 on"><span data-v-2ede1d5f="" class="hide">5점만점에 2점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score3 on"><span data-v-2ede1d5f="" class="hide">5점만점에 3점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score4 on"><span data-v-2ede1d5f="" class="hide">5점만점에 4점</span><!----></button>
																						<button data-v-2ede1d5f="" type="button" title="별점 선택" class="btn_score btn_score5 "><span data-v-2ede1d5f="" class="hide">5점만점에 5점</span><!----></button>
																					</div>
																				</td>
																			</tr>
																			
																			<tr data-v-2ede1d5f="">
																				<th data-v-2ede1d5f=""><label data-v-2ede1d5f="" for="txtContent">리뷰</label></th>
																					<td data-v-2ede1d5f="">
																						<textarea data-v-2ede1d5f="" rows="4" cols="50" id="txtContent" maxlength="1000" title="리뷰 입력"></textarea>
																					</td>
																			</tr>
																			
																			
																			</tbody>
																		</table>
																	</div>
																	<!---->
																	
																	
																	<div data-v-2ede1d5f="" class="review_btn_box">
																		<button data-v-2ede1d5f="" type="button" class="btn_regist">등록</button>
																		<button data-v-2ede1d5f="" type="button" class="btn_cancel">취소</button>
																	</div>
																</div>
															</div>
															<!---->
														</div>
													
													
													<div id="review_popup" class="photo_popup review_photo" style="display: none"><img src="" alt=""><button type="button" class="btn_close">닫기</button></div></div></div></li>
                                                </ul>
                                               </div></div>
                                               <div class="add2020_detail_right" data-v-09a75c9f="">
                                               	
                                               <div class="add2020_detail_side_box" data-v-09a75c9f="">
                                               	<h2>이용안내 </h2>
                                               		<div class="add2020_detail_side_info">
                                               		<dl>
                                               			<dt>소개</dt>
                                               			<dd>제주녹차문화의 중심, 차박물관과 카페테리아, 2016 KOREAT JEJU TOP 30 선정</dd>
                                               			<dt>상세 정보</dt>
                                               			<dd>연중무휴 /  소형견, 중형견, 대형견 입장 전화 문의 / 안내견 실내입장 가능 / 실외 녹차밭 입장 불가 </dd>
                                               			<dt>이용 시간</dt>
                                               			<dd>
										                    평일 : 09:00 ~ 19:00 ,
										                    주말 : 09:00 ~ 19:00
               											 </dd>
               											 <dt>요금 정보</dt>
               											 <dd>무료</dd>
               											 <dt>장소 특성</dt>
               											 <dd>실외</dd>
               											 <dt>주요목적</dt>
               											 <dd>포토스팟</dd>
               											 <!---->
               											 <dt>평균 소요 시간</dt>
               											 <dd>1시간 미만</dd>
               											 <dt>경사도(난이도)</dt>
               											 <dd>중</dd>
               											 <dt>편의시설</dt>
               											 <dd>공용주차장,현금결제,카드결제,화장실,무료 WIFI,편의점,음료대,유도 및 안내시설,경보 및 피난시설,엘리베이터</dd>
               											 <!---->
          											 </dl>
          											 <!----><!----><!----><!---->
       											 </div>
   											 </div>
										 </div>
										 <div class="clear" data-v-09a75c9f="">
									 </div>
								 </div>
							 </div>
						 </div>
					 </div>
				 </div>
				 <!---->
		 </div>
    </div>
</body>
</html>