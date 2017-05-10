<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Groovin one page bootstrap template</title>
<!-- styles -->

<link rel="stylesheet" href="<c:url value='/resources/assets/css/fancybox/jquery.fancybox.css'/>">
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/css/slippry.css'/>">
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<!-- javascript -->
<script src="<c:url value='/resources/assets/js/jquery-1.9.1.min.js'/>"></script>
<script src="<c:url value='/resources/assets/js/jquery.easing.js'/>"></script>
<script src="<c:url value='/resources/assets/js/classie.js'/>"></script>
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<script src="<c:url value='/resources/assets/js/slippry.min.js'/>"></script>
<script src="<c:url value='/resources/assets/js/nagging-menu.js'/>"></script>
<script src="<c:url value='/resources/assets/js/jquery.nav.js'/>"></script>
<script src="<c:url value='/resources/assets/js/jquery.scrollTo.js'/>"></script>
<script>
	$(document).ready(function(){
	  $('#slippry-slider').slippry(
		defaults = {
			transition: 'vertical',
			useCSS: true,
			speed: 5000,
			pause: 3000,
			initSingle: false,
			auto: true,
			preload: 'visible',
			pager: false,		
		} 
	  )
	});
</script>
<script>
function logout() {
	$("#logout").submit();
}
function check() {
	var ch = /.{2,}/;
	 var pass = ch.test($("input[name=keyword]").val());
	if(!pass){
		$("#waring").text("2자 이상 입력해주세요");
	}
	return pass;
}
</script>
<style type="text/css">
#search{
width: 100%;
height: 100%;
position: absolute;
z-index: 6;
}
#searchForm{
width: 400px;
height: 100px;
margin: 500px auto;
}
</style>
</head>
<body>
<header>
<div id="navigation" class="navbar navbar-inverse navbar-fixed-top default" role="navigation">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.html">Groovin</a>
    </div>
	<div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"><nav>
      <ul class="nav navbar-nav navbar-right">
     	<sec:authentication var="id" property="name"/>
     	<c:url var="user" value="user/info">
		<c:param name="id" value="${id }"/>
	 	</c:url>
	  	<sec:authorize access="!isAuthenticated()">
        <li><a href="user/join">회원가입</a></li>
        <li><a href="#myModal" data-toggle="modal" >로그인</a></li>
        <li><a href="qb/save">qna</a></li>
        </sec:authorize>
        <sec:authorize access="hasAuthority('ADMIN')">
		<li><a href="user/join">매니저계정만들기</a></li>
		</sec:authorize>
		<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
		<li><a href="book/add">도서등록</a></li>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		<li><a href="${user}">내정보보기</a></li>
		<li><a href="javascript:logout();">로그아웃</a></li>
		</sec:authorize>
      </ul></nav>
    </div><!-- /.navbar-collapse -->
	</div>

  </div>
</div>
</header>

<div class="modal fade" id="myModal" tabindex="-1"  aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
       <form  action='<c:url value="/user/login"/>' method="post" id="loginForm"> 
      <div class="modal-body">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		ID <input type="text" name="id" value="11">
		PWD <input type="password" name="pwd" value="123">
		
      </div>
      <div class="modal-footer">
     	<button type="submit"  class="btn btn-success">로그인</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
		</form>
    </div>
  </div>
</div>
<!-- section intro -->
<section id="intro">
<div id="search">
<div id="searchForm">
<form action="book/search" method="post" onsubmit="return check();">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<select name="category" class="form-control input-lg">
<option value="bname">제목</option>
<option value="author">저자</option>
<option value="publisher">출판사</option>
</select>
<input type="text" name="keyword" class="form-control input-lg">
<button type="submit" class="btn btn-success" >검색</button><br>
<div id="waring"></div>
</form>
</div>
</div>
			<ul id="slippry-slider">
			  <li>
				<a ><img src="<c:url value='/resources/assets/img/slide/1.jpg'/>" alt="환영합니다."></a>
			  </li>
			  <li>
				<a ><img src="<c:url value='/resources/assets/img/slide/2.jpg'/>"  alt="원하시는 도서를 검색하세요"></a>
			  </li>
			  <li>
				<a ><img src="<c:url value='/resources/assets/img/slide/3.jpg'/>" alt="감사합니다. <span class='red'>♥</span> it :)"></a>
			  </li>
			</ul>
</section>
<!-- end intro -->
<!-- Section about -->
<section id="about" class="section">

<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="heading">
				<h3><span>About us</span></h3>
			</div>
			<div class="sub-heading">
				<p>
					 Creating a visual language around the beliefs of the brands we work with.
				</p>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<div class="team-box">
			<img src="assets/img/dummies/team1.jpg" alt="" class="img-responsive" />
			<div class="roles">
				<h5><strong>Baby Stewards Jr</strong></h5>
				<p>
					CEO - Founder
				</p>
				<ul class="social-profile">
					<li><a href="#"><i class="fa fa-facebook fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-twitter fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-dribbble fa-lg"></i></a></li>
				</ul>
			</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="team-box">
			<img src="assets/img/dummies/team2.jpg" alt="" class="img-responsive" />
			<div class="roles">
				<h5><strong>Tommy Kreunichev</strong></h5>
				<p>
					Lead designer
				</p>
				<ul class="social-profile">
					<li><a href="#"><i class="fa fa-facebook fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-twitter fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-dribbble fa-lg"></i></a></li>
				</ul>
			</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="team-box">
			<img src="assets/img/dummies/team3.jpg" alt="" class="img-responsive" />
			<div class="roles">
				<h5><strong>Moriella Maccini</strong></h5>
				<p>
					Customer support
				</p>
				<ul class="social-profile">
					<li><a href="#"><i class="fa fa-facebook fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-twitter fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-dribbble fa-lg"></i></a></li>
				</ul>
			</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="team-box">
			<img src="assets/img/dummies/team4.jpg" alt="" class="img-responsive" />
			<div class="roles">
				<h5><strong>Brian James Scoothie</strong></h5>
				<p>
					Coffee maker modal
				</p>
				<ul class="social-profile">
					<li><a href="#"><i class="fa fa-facebook fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-twitter fa-lg"></i></a></li>
					<li><a href="#"><i class="fa fa-dribbble fa-lg"></i></a></li>
				</ul>
			</div>
			</div>
		</div>
	</div>
</div>
</section>
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>