# Spring_boardStudy

## 프로젝트 목적

* 포트폴리오가 아님.
* 게시판을 복습하며 모르는 부분을 다시 체크하며 개념습득.
* 오류 발생시 오류내용과 해결방법을 기록.
* 날짜를 기록하며 일지형식으로 진행.
* 개발에 대한 스스로의 생각을 작성.

*** 

## 개발환경

* Spring (Eclipse : Spring Tools 3)
* JDK 1.8
* Apache Tomcat 8.0
* MySQL
* MyBatis

***

# 0812 일지

### 개념해결

* "addFlashAttribute"


파라미터를 담아서 넘겨줄 때 사용하는 함수들 중 하나이다. (이 외 addAttribute, addAllAttributes)

다음 코드들을 살펴보자.

```java
@PostMapping("/boardEnroll")

public String boardEnrollPOST(BoardVO bvo, RedirectAttributes rttr) {
  
    log.info("BoardVO : " + bvo);
		
    service.boardEnroll(bvo);
		
    rttr.addFlashAttribute("result", "enroll success");
		
    return "redirect:/board/boardList";
}
```
실제로 이 상태로 form 값을 전송해보면 해보면 /board/boardList 페이지에 파라미터값이 노출 되지않는다. (POST)

반대로 addAttribute를 사용하면 파라미터 값이 노출된다.(GET) 심지어 노출된 이후 새로고침을 해도 계속 노출되고 있는 것을 확인했다.

네이버사전에서 Flash의 뜻을 알아 보았다. 동사로는 '비추다', 명사로는 '섬광, 번쩍임' 이런 뜻이다.

파라미터 값들이 번쩍 하고 사라졌다? 뭐 이렇게 나는 이해를 했다.(일회성)

단어를 이렇게 쪼개서 생각하는게 옳은 일인지는 모르겠으나 이렇게도 유추를 해보았다.

우리 눈에는 직접적으로 보이지는 않았지만 뒤에서는 뭔가가 진행이 되고 있다는 것을 확실히 깨달았다.

아주 기초적인 개념이지만 게시판 복습을 하며 "아~ 이런이유로 이 함수가 쓰였구나." 를 다시 알게되었다.

***

# 0813 일지

### 오류해결

<img src="https://user-images.githubusercontent.com/79797179/184493546-e449c0fb-51cc-4611-b11f-ffbf01286956.png" width="30%">
<img src="https://user-images.githubusercontent.com/79797179/184493545-f199c75b-0f47-4a48-8354-86028d491c65.png" width="80%">

* EL표기시 날짜 값을 불러올떄 오류발생 -> VO 클래스의 필드명과 완전히 동일하게 써야하는것을 깜빡함.

  (regdate -> regDate, updatedate -> updateDate)

***

# 0814 일지

### 오류해결

```java
<c:forEach items="${list}" var="li">
	<tr>
		<td><a href="/board/boardDetail?bno=${li.bno}"><c:out value="${li.bno}"/></a></td>
		<td><c:out value="${li.title}"/></td>
		<td><c:out value="${li.writer}"/></td>
		<td><fmt:formatDate value="${li.regDate}" pattern="yyyy/MM/dd"/></td>
		<td><fmt:formatDate value="${li.updateDate}" pattern="yyyy/MM/dd"/></td>
	</tr>
</c:forEach>
```

위 코드는 게시판에 등록된 글들을 조회할떄 썼던 코드이다. 오류가 없는 코드이다. 하지만 상세목록을 구현하는 도중에 오류가 발생했다. 오류의 아래와 같다.

<img src="https://user-images.githubusercontent.com/79797179/184532963-dc29b2a1-4dd0-4797-8ca4-6e09a0d3c663.png">

* 상세목록페이지는 List 형식이 아니기때문에 오류발생 -> <c:forEach>제거

   (반대로 <c:forEach>문을 쓴다면 받아올 값을 List 형식으로 바꿔주기)

***

# 0815 일지

### 오류해결

* 게시판 수정시 자꾸 null 값으로 등록이 되어버림 -> form 안의 각 name 값들을 VO 클래스의 필드명과 일치시켜줌.
  
  (항상 하는건데 가끔식 이런다.. 기본을 중요시하자 제발..)

***

# 0825 일지

### 느낀점

게시판구현은 어느정도 할 수 있겠는데 아직 페이징 처리에 대한 이해도가 부족한거 같다. 많은 목록부분을 구현하는 모든 부분에서 절대로 배제 할 수 없는 개념이다. 빠른 시일내에 페이징개념을 마스터한 후 다시 readme를 쓰겠다!

***

# 0826 일지

### 개념복습 페이징 처리_1

어제는 개념 20%정도 이해를 했다면 오늘은 90% 이상 페이징원리를 이해했다.

* Criteria class 일부 (아래)

```java

private int pageNum;	// 현재페이지
	
private int amount;	// 한 페이지당 보여질 데이터 갯수
	
private int limitValue;	// limit 첫 번째 값, 세팅
	
// 초기 페이지 세팅
public Criteria() {
    this.pageNum = 1;
    this.amount = 10;
}
	
public Criteria(int pageNum, int amount) {
    this.pageNum = pageNum;
    this.amount = amount;
    this.limitValue = (pageNum - 1) * amount;
}
	
public void setPageNum(int pageNum) {
    this.limitValue = (pageNum - 1) * amount;
    this.pageNum = pageNum;
}
```

* PageDTO 일부 (아래)

```java

private int startPage;		// 시작페이지 번호
private int endPage;		// 마지막페이지 번호
private int total;		// 게시글 총 갯수
private boolean prev, next;	// 이전, 다음 버튼
private Criteria cri;		

public Criteria getCri() {
    return cri;
}

/* 생성자 */
public PageDTO(Criteria cri, int total) {

    this.cri = cri;
    this.total = total;

    // 마지막페이지번호 구하는 공식
    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
    
    // 시작페이지번호 구하는 공식
    this.startPage = this.endPage - 9;
    
    // 게시글이 끝나는 진짜 마지막 번호 구하는 공식
    int realEnd = (int) (Math.ceil(total / cri.getAmount()));

    if (realEnd < this.endPage) {
        this.endPage = realEnd;
    }

    this.prev = this.startPage > 1;

    this.next = this.endPage < realEnd;

}
```

* 우선은 MySQL의 limit 방식을 선택.

* Criteria를 1페이지로 세팅.

* 쿼리문은 총 2개 필요 (게시글 총 갯수 쿼리, limit을 이용한 페이징 쿼리)

* 시작페이지번호, 끝페이지번호, 다음, 이전 등 페이징처리에 필요한 모든 변수선언.

### 코드리뷰

```java
this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
```

(한 페이지에 10개의 게시글이 나오는, 버튼이 총 10개가 보인다고 가정 ex 1 2  ~ ~ 9 10)

마지막페이지번호를 구하는 공식이다. 여기서 주의할 점이 하나 있는데, 여기서 말하는 마지막 페이지 번호는 실제 게시글이 끝나는 번호가 아니다. (실제 게시글이 끝나는 번호와 마지막페이지 
번호가 동일 할 수는 있음) 

1 ~ 10의 버튼이 보이는 화면은 마지막 번호가 10,

11 ~ 20의 버튼이 보이는 화면은 마지막번호가 20, 

21 ~ 30의 버튼이 보이는 화면은 마지막번호가 30 이 마지막 번호를 말하는 것이다. 

즉, 저 공식에 의해 endPage의 값이 10이 나왔다면 "아~ 현재 페이지번호는 1에서 10중 하나겠구나"

endPage의 값이 20 이 나왔다면 "아~ 현재 페이지번호는 11에서 20중 하나겠구나" 라고 이해하면 된다.

이 값을 구하는것은 실제 시작페이지를 구하기 위한 첫번째 단계이다.

다음 코드를 보자.

```java
this.startPage = this.endPage - 9;
```

전체적인 코드를 봤을때 endPage의 값은 10의 배수외에는 절대로 나올 수가 없다. (버튼이 10개보인다는 가정하에)

그렇다면 자동적으로 

* 1 ~ 10의 시작페이지는 10 - 9 = 1 페이지시작
* 11 ~ 20의 시작페이지는 20 - 9 = 11 페이지시작
* 21 ~ 30의 시작페이지는 30 - 9 = 21 페이지시작

이렇게 이해하면 된다.

```java
int realEnd = (int) (Math.ceil(total / cri.getAmount()));
if (realEnd < this.endPage) {
    this.endPage = realEnd;
}
```

위 코드는 게시글이 끝나는 진짜 마지막페이지 번호를 구하는 것이다. 중요한 점은 게시글 총 갯수 쿼리를 미리 구해놓아야한다. 

예를 들어 게시글 총 갯수가 37개라면 끝페이지 번호는 10으로 볼 수 있다.

* Math.ceil(37 / 10) >> Math.ceil(3.7) >> realEnd = 4가 되는것이다.

그런데 10페이지 보다도 한참 적다. 무려 6페이지나 공백상태가 될 것이다. 이러한 경우에는 endPage가 그대로 10이 되도록 냅 둘수 없다.

이떄 if문으로 들어가는 것이다. 

endPage값은 10이 나왔지만 게시글이 거기에 한참 못미치기 때문에 게시글이 끝나는 진짜 페이지번호 realEnd 값(4)를 endPage에 대입해주는 것이다.

즉, 진짜 마지막페이지의 번호는 4이고, 4번 페이지의 게시글 갯수는 총 7개가 등록되어 있을 것이다.

```java 
this.prev = this.startPage > 1;
this.next = this.endPage < realEnd;
```

마지막으로 이전, 다음 버튼 유무 코드이다.

* this.prev = this.startPage > 1;

startPage 역시 10개 버튼기준으로 1, 11, 21, 31 이렇게 된다. 즉, 다시 말해 1 보다 크면 11, 21, 31 등 1 ~ 10 을 벗어난 페이지 번호들을 말한다. 

예를 들어 13페이지가 현재 번호이면 당연히 1 ~ 10 있다는 이야기가 되니까 이전버튼은 존재해야한다.

그러므로 1이상의 startPage의 값은 prev의 값이 true를 가지게 되는 것이다.(이전표시가 보이게됨)

* this.next = this.endPage < realEnd;

다음 버튼역시 간단하다. 앞서 설명한 바와 같이 endPage의 값은 절대 10, 20 30 등 이 외엔 나올 수가 없다.

하지만 realEnd의 값은 12, 38, 192 등 게시글이 몇개가 등록이 됐는지에 따라 어떤 값이든 올 수 있다.

예를 들어 endPage의값이 현재 10이라 가정하고 realEnd 값이 endPage보다 크다는 소리는 게시글이 10페이지를 넘겼다고 생각하면 된다.

언제끝나는 지는 몰라도 최소한 10 페이지는 넘어간다고 보면된다.

반대로 realEnd값이 endPage 값보다 작다면 endPage의 고정 값(10, 20, 30 등)보단는 작다는 소리다.

다시말해 endPage를 못넘겼기 때문에 다음버튼 또한 당연히 존재하지 않는다. (this.next의 값은 false)

> 뭔가 중구난방식으로 썼지만 오늘 하루 최대한 페이징처리에 대한 이해를 바탕으로 복습겸 작성을 해보았다. view까지도 현재 구현한 상태지만 조금 더 정리해서 view개념도 readme에 작성 할 계획이다.

***

# 0827 일지

### 개념복습 페이징 처리_2


* Controller 일부 (아래)
```java
@Autowired private BoardService service;

@GetMapping("/boardList")
public void boardListGET(Model model, Criteria cri) {
		
    model.addAttribute("list", service.boardListPage(cri));
		
    model.addAttribute("pMaker", new PageDTO(cri, service.listTotal()));
}
```

* View 일부 (/board/boardList) (아래)

```java
// 버튼 구현부
<c:if test="${pMaker.prev}">
    <li class="pageInfo_btn prev">
        <a href="${pMaker.startPage - 1}">이전</a>
    </li>
</c:if>
<c:forEach var="num" begin="${pMaker.startPage}" end="${pMaker.endPage}">
    <li class="pageInfo_btn ${pMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
</c:forEach>
<c:if test="${pMaker.next}">
    <li class="pageInfo_btn next">
        <a href="${pMaker.endPage + 1}">다음</a>
    </li>
</c:if>

// 버튼 이동을 도울 form 태그
<form id="moveForm" method="get">
    <input type="hidden" name="pageNum" value="${pMaker.cri.pageNum}">
    <input type="hidden" name="amount" value="${pMaker.cri.amount}">
</form>

<script>
    let moveForm = $("#moveForm");

    $("#page_ul a").on("click", function(e) {

    e.preventDefault();

    moveForm.find("input[name=pageNum]").val($(this).attr("href"));
    moveForm.attr("action", "/board/boardList");
    moveForm.submit();

    });
</script>
```

먼저 <c:if>를 통하여 이전 버튼과 다음 버튼이 참인지 아닌지를 판별한다. 다시 말해 참이면 버튼이 등장, 거짓이면 버튼이 보이지 않는다. 여기까지는 이전에 알고 있던 개념이다. 

이전 버튼에는 - 1을, 다음 버튼에는 + 1 을 하는 이유에 대해서 간략하게 알아보자.

```java
<a href="${pMaker.startPage - 1}">이전</a>
<a href="${pMaker.endPage + 1}">다음</a>
```

0826 일지에서 설명한 바와같이 한 페이지에 게시글 10개를 보여주는 기준으로 잡았을때 

startPage 값은 1, 11, 21, 31, 41 ..... 이렇게 밖에,

endPage 값은 10, 20, 30, 40, 50 ..... 이렇게 밖에 올 수가 없다.

예를들어 

* 총 게시글 수가 10페이지를 훨씬 넘어감
* 현재 페이지가 1 ~ 10에 있다고 가정 

넘어가기로 마음 먹고 다음 버튼을 누르기 직전의 상태를 생각해보라.

PageDTO class의 endPage값은 10으로 되어있다. 왜?

```java
this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
```
위 공식에 의해서 말이다. 
```java
<a href="${pMaker.endPage + 1}">다음</a>
```
하지만 endPage의 값에 + 1을 해주면 완전히 다 바뀌게 된다. 이 코드만 봐서는 안되고 아래의 JS코드와 form 태그를 다시보자.
```java
<form id="moveForm" method="get">
    <input type="hidden" name="pageNum" value="${pMaker.cri.pageNum}">
    <input type="hidden" name="amount" value="${pMaker.cri.amount}">
</form>

moveForm.find("input[name=pageNum]").val($(this).attr("href"));
```
a태그를 클릭했을시 name값이 'pageNum'인 친구의 값을 찾아서 파라미터 값을 11을 줘라~ 이런 뜻이다.

<img src="https://user-images.githubusercontent.com/79797179/187032232-b577f258-77e7-44ae-841a-79cd222d307c.png">
<img src="https://user-images.githubusercontent.com/79797179/187032257-606eb563-fd59-438a-9596-93750e2ebc28.png">

위의 이미지를 보시다시피 10페이지를넘어가기전 즉, 다음 버튼을 누르기전의 파라미터값과 다음버튼을 누르고 난 후의 파라미터 값이다. pageNum은 현재 선택된 페이지 번호를 의미한다. 저 파라미터값이 그대로 Criteria class의 멤버변수인 pageNum이 재세팅이 된다. 그리고 그것을 바탕으로 PageDTO class의 생성자 메서드를 이용해 버튼들 역시 재세팅이 되는 원리이다.

이전 버튼 역시 같은 방법이다. 참고로 다음버튼을 + 1이 아닌 +2를 해주니까 11 ~ 20 페이지를 건너뛰고 시작페이지 번호가 21페이지가 되었고 아무 값도 더해주지 않았을때는 다음 버튼을 아무리 눌러도 10페이지에서 새로고침만 될 뿐이었다. 이전버튼 역시 같은 결과를 확인했다.

> 페이징 처리가 처음에는 이게 대체 무슨 소린가.. 했던 그런 기억이 난다. 하지만 다시 보고 또 보고 직접 손으로 적어보고 계산해보고 하니 개념습득이 빨랐다. 혹시 또 모르니 미흡한 부분이 있다면 그 부분을 더 공부 할 것이다.

***

# 0828 일지

## 개념복습 - Spring

페이징 리뷰를 하는 도중 스스로 글을 쓰면서도 도움많이 공부가 되는거 같아 스프링MVC 동작 원리에 대해서 한번 readme에 기록하며 리뷰해보려한다.

먼저 DI니, POJO니 등 의 개념은 제쳐두고 동작순서로 바로 들어가보자.

1. 사용자의 요청을 DispatcherServlet에서 받는다.
2. DispatcherServlet는 handlerMapping을 통해 요청된 Controller를 실행한다.
3. Controller는 서비스 객체를 호출한다.
4. Service는 DAO를 통해 데이터베이스(이하 DB)에 접근하여 데이터를 요청한다.
5. DB에서 전달받은 데이터를 다시 DAO에, 그리고 Service에, 다시 Controller순으로 전달한다. (Model 객체에 데이터 저장)
6. Controller은 ViewResolver를 통해 데이터를 받을 View를 찾는 작업을 진행한다.
7. View를 찾았다면 이 DB값을 DispatcherServlet에게 전달한다.
8. DispatcherServlet은 전달받은 데이터의 내용을 사용자에게 보여준다.

내가 책으로 공부하며 수없이 많은 검색을 하며 본 스프링MVC 동작원리이다. 여기서 크게 벗어나지않는다. 나는 개인적으로 스프링 공부를 독학으로 공부했다. 그래서 그런지 처음에는 당최 무슨 소린지 이해가 가질 않아 소위말하는 클론코딩 즉, 코드를 그대로 베껴서 동작원리를 공부하며 이해한 케이스다. 너무 베껴쓰다보니 나도 모르게 체득화되었다고 해야할까..

각설하고 1번 부터 차근차근 되짚어 보자. 뭔가 형식적이고 딱딱한 말투보다는 최대한 가볍게 글을 써보려 한다. 내가 알고 있는 선에서...

## 1. 사용자로부터 요청을 받는다. 그 요청을 받는 자의 이름은 DispatcherServlet이다.

우리는 수도없이 인터넷에게 내가 원하는 정보를 요청한다. 그 요청의 내용을 가장, 제일, 처음 보는자가 바로 DispatcherServlet이다. 병원에서는 원무과 직원, 식당을 가면 주문을 받으시는 직원이라고하면 이해가 쉬울려나.. 어느 장소를 가든 이용자가 질문을 받는 그 사람이 DispatcherServlet라고 이해하면 편할 것이다.

솔직히 말해 DS는 사용자의 요청이 들어오면 무슨 요청인지 대충은 알아도 그에 대한 진짜 정보라든지 기타등등 그런것을 정확히 알수는 없다. 그래서 이때 등장하는 새로운 인물이 HandlerMapping이다.

## 2. "핸들러매핑아 이 URL좀 패스할게~"

DispatcherServlet으로 부터 받은 URL정보에 맞게 알맞은 Controller 메소드를 결정한다. 그 자가 바로 HandlerMapping이다.

## 3,4,5. Controller의 역할

이제는 내가 자주 썼던 Controller를 눈으로 볼 수 있는 시점이다.

```java
@GetMapping("/boardList")

@Autowired private BoardService service;

public void boardListGET(Model model) {
		
    model.addAttribute("list", service.boardList());
    
}
```

예를 들면 위 코드와 같다. 여기서 DB접근까지한다. Controller는 BoardService란 객체를 주입받는다. 이 객체를 계속 타고 올라가다 보면 DAO객체를 만날 수 있다.

풀네임은 Data Access Object이다. 실제 DB에 접근하는 최전방과 같은 존재이다. 주로 멤버변수, getter, setter, toString과 같은 코드만 적힌다. DB의 정보를 받은 이 DAO객체는 Service에 전달한다. 이 Service에서 알맞은 로직을 수행한 후의 결과정보를 Controller는 받은 후 View에 뿌려줄 정보를 Model객체에 저장한다. 그리고 DispatcherServlet에게 view name을 리턴한다.

## 6. View를 찾자

이제 거의 다 왔다. 조금만 더 힘내자.

Controller에서 이런 코드를 많이 봤을 것이다.

```java
@GetMapping("/boardEnroll")

return "redirect:/board/boardList";
```

이런 코드들이 뷰 객체를 결정한다고 생각한다. views안에 board폴더 안에 boardList.jsp가 없으면 바로 에러다... 

## 7,8. The end

1에서 봤던 DispatcherServlet이 다시 등장해서 이제 사용자가 원했던 정보를 View에 뿌려주기만하면 스프링 동작은 끝이난다.

> 최대한 내가 알고 있는 Spring 동작원리를 적어봤다. 내가 적었던 코드들이 저 목차범위안에 들어간다 생각하며, 예를 들어 DAO코드를 작성한다면 "아 내가 지금 DB에 접근 할 최전방 객체를 작성중이구나." 라고, Service객체를 작성할 때는 "아 지금 사용자 요청에 관련된 로직을 작성중이구나." 를 생각하며 내가 현재 위치가 어딘지를 매 순간순간 파악하며 프로젝트를 진행하면 개념을 더 깊게 이해 할 수 있을 것이라 생각한다.

***

# 0831

## 기본개념 실수

오늘은 사정상 스케쥴이 많아서 공부를 많이 못했다. crud중에서 조회부분에서 또 막히는 현상이 나타났다. 너무나도 간단한 개념인데..

아래의 interface 부분의 코드를 보자. (DAO: BoardVO)

```java
// 게시판 조회
public BoardVO listBoard();
```

여러사람의 게시글 정보를 불러오는 인터페이스다. 뭔가 이상하지 않는가? 정상적으로 나타내려면 아래의 코드로 수정해야한다.

```java
// 게시판 조회
public List<BoardVO> listBoard();
```

> 테이블에 더미 데이터들은 담겨있는데 아무리 실행해도 값이 안나오는 현상이 발생했다. 리스트형태로 자료형을 바꿔줘야한다.. 항상 그냥 당연히 알고 지나간 개념인데 다시 또 처음부터 게시판을 구현하려고하니 부족한점이 드러났다. 내일은 등록, 수정, 삭제, 상세 조회까지 진행후 다시 리뷰를 할 생각이다.

***

# 0901 일지

## 중간점검 (현재까지의 개발과정에 대한 나의 생각)

>뜬금없이 키워드가 중간점검이다. 음.. 뭔가 개발에 대한 이해, 개념 복습보다 쉬어가는 코너? 뭐 그런 취지에서 현재까지 나의 생각에 대해 적어보고 싶었고 또 앞으로 어떤 방향으로 나아갈지에 대한 생각을 글로써보려 한다. 우선 작년 6월 쯤 국비훈련과정을 시작으로 지금까지 왔다. 어렵기도하고 그만두고 싶기도했지만, 나이가 있으니까 다른거 섣불리 시작하기는 그렇고...라고 할 줄 알았는가? 하하하 물론 그만둬야하나 생각은 했지만 일단은 재미가 있었고 흥미가 있었기 때문에 지금 까지 올 수 있었고, 앞으로도 계속해서 이쪽계열로 나갈 생각이다. 우선 내가 먼저 해야할 것은 뭔가를 더 새로 배우고 이러기 보다는 가장 중요한 기본기 그리고 무언가를 새로 배울때 두려운 자세가 아닌 호기심을 가지는 자세가 필요할거 같다. 역시 말보다는 행동인가? 솔직히 말해서 깃허브 잔디 심는 재미때문에 시작한건데 이게 나도 사람인지라 코드가 잘 안쳐지고 피곤할때가 많이있다. 그래도 잔디를 심어야하니까 어거지로 했던게 그래도 몇 번 있었다(다른프로젝트 포함). 하지만 난 잔디를 심어야겠다는 그 마음때문에 컴퓨터앞에 앉고 작업 툴을 실행하면 또 마음이 바뀐다. 어떤 마음으로? 공부하고 싶단 마음으로 말이다. 나는 이 깃허브를 이용해 잔디 심는게 정말 큰 장점이라 한다. 물론 지금 이걸 쓰는 시간에도 너무나도 피곤하고 늦은 시간이지만 처음에는 어떤내용을 오늘 완료할까? 프로젝트는 코드를 친게 오늘은 많이 적어서 커밋할 내용은 없고(오늘 바빳음), 그러다 오늘 주제로 선택한 것이 중간점검의 일기형식의 주제였다. 역시 이 글을 쓰면서도 앞으로 어떤 마음가짐을 가져야할지 정리가 된다. 그렇다고 너무 자주 이러지는 않을거고 ㅎㅎ ... 잔디심는 재미로 readme를 작성하는 것이 아닌 개발자체에 대한 재미로 작성하는 그런 개발자가 되고싶다.

# 0902 일지

## CRUD 인터페이스

우선 아래의 mapper interface의 코드를 보자.

```java
// 게시판 등록
public void regBoard(BoardVO bvo);
	
// 게시판 목록
public List<BoardVO> listBoard();
	
// 게시판 상세조회
public BoardVO detailBoard(int bno);
	
// 게시판 수정
public void modifyBoard(BoardVO bvo);
	
// 게시판 삭제
public void deleteBoard(int bno);
```

1. 게시판 등록

```java
<!-- mapper 일부 : 등록 -->
<insert id="regBoard">
    insert into '테이블명' (title, content, writer) values (#{title}, #{content}, #{writer})
</insert>
```

반환 값이 필요없다. 대신 매개변수가 존재한다. BoardVO 객체 즉, 다오객체를 매개 변수로 받는다.

mapper.xml id값이 인터페이스 메서드명과 동일. (Controller 부분 생략)

2. 게시판 조회
```java
<!-- mapper 일부 : 목록 -->
<select id="listBoard" resultType="com.board.mapper.BoardVO">
    select * from '테이블명'
</select>
```

여러 게시글의 정보를 불러오기때문에 List형을 반환값으로 받는다. 왜? mapper를 이용해서 리스트만 넘겨주면된다. 

매개변수도 필요없다. mapper의 쿼리문에 대한 결과만 있으면 리스트 값이 출력된다.

### (주의) resultType의 경로 설정을 꼭 입력해주자.

mapper.xml id값이 인터페이스 메서드명과 동일. (Controller 부분 생략)

3. 게시판 상세조회

```java
<!-- mapper 일부 : 상세조회 -->
<select id="listBoard" resultType="com.board.mapper.BoardVO">
    select * from '테이블명' where bno = #{bno}
</select>
```

조회개념과 비슷하다. 게시글 하나의 정보를 반환하는 상세조회이기때문에 List를 쓸 필요가 없다. BoardVO 객체를 반환값으로 만든다.

또 한가지 추가되는 점은 매개변수다. 위 쿼리에서는 bno컬럼에 해당하는 글의 정보를 불러와야 하기 때문에 int bno를 파라미터로 받았다.

### (주의) resultType의 경로 설정을 꼭 입력해주자.

mapper.xml id값이 인터페이스 메서드명과 동일. (Controller 부분 생략)

4. 게시판 수정

```java
<!-- mapper 일부 : 수정 -->
<update id="boardModify">
	
    update '테이블명' set
        title = #{title}
        , content = #{content}
        , writer = #{writer}
        , updatedate = now()
    where bno = #{bno}
		
</update>
```

수정역시 간단한다. DB의 값을 수정만 하면 되는 부분이다. 즉, select 처럼 뭔가를 보여주는 개념이 아니다. 

그래서 역시 반환값을 void로 설정했다. 여기서 매개변수는 BoardVO 객체를 넣어줌으로서 수정을 마무리한다. 

그런데 궁금한 점이 있을 수 있다. 수정을 하려면 수정 관련된 bno 값을 파라미터로 받아야 하지 않을까? 라고

생각하겠지만 수정페이지 오기전 즉, view페이지(detailPage)에서 modifyPage로 넘어갈때 form안의 bno값을 

넘겨줌으로써 인터페이스에서 또 매개변수(int bno)를 선언해줄 필요가 없는 것이다.

mapper.xml id값이 인터페이스 메서드명과 동일. (Controller 부분 생략)

5. 게시판 삭제

```java
<!-- mapper 일부 : 삭제 -->
<delete id="boardDelete">
	
    delete from '테이블명' where bno = #{bno}
		
</delete>
```

드디어 마지막 삭제이다. 삭제 역시 간단하다. select처럼 출력해야하는 역할이 없기 때문에 반환 값 역시 void!

등록처럼 DB에 값을 추가하는 개념 즉, DB에서의 변화만 일어나면 된다.

대신 삭제에서는 DB값이 하나 사라진다는 차이뿐이다.

해당 조건은 수정과 같이 bno로 결정한다. 

modifyPage에서 구현한 삭제 태그를 클릭함으로 form을 이용해 해당 게시글의 bno 값을 전달한다. (삭제완료)

mapper.xml id값이 인터페이스 메서드명과 동일. (Controller 부분 생략)

> 처음에 CRUD를 구현할 때 무엇을 반환값으로 가지고 매개변수는 무엇을 넣어야 하는지.. 정말 헷갈렸던 기억이 난다. (각 동작에 해당하는 CRUD) 메서드의 동작원리만 이해 한다면 전혀 어렵지 않은 개념이라는 것이다. 그래도 이보다 훨씬 더 중요한 것은 알고 있다고 해서 방심하지 말고 개념에 대해서 꾸준히 복습하고 점검하는 습관이란것을 잊지말자. 

***

# 0906 일지

## 서버에러

오늘은 현재 프로젝트에서 일어난 에러가 아닌 다른 프로젝트(인터넷 서점서비스)에 관한 에러이다.

잘되던 프로젝트가 갑자기 500 Error을 뿜어내는 에러가 발생했다... 아래의 개발자모드 상황을 보자.

<img src="https://user-images.githubusercontent.com/79797179/188629686-cd5fa4b4-c543-4bfc-89e2-9ab081d72934.png">

처음 겪는 에러이다. 코드상에는 문제가 없는데... 검색결과 서버자체의 에러라고 한다. 다른 프로젝트에서 img 태그를 이용해 연결을 해봤는데 역시나..

그러던중 해결법을 찾았다.. 너무나도 간단하고 허무했다.

바로 Controller 중복 메서드.. 댓글을 쓰는 창에 관련된 메서드인데 주석으로 어떤 기능인 것을 적지않아 혼동이 되었다.

해결 하는데 그렇게 오랜 시간은 걸리지 않았다. 다만 좀 더 집중력있게 작업해야겠다는 생각을 많이했다.

# 0910

## 개념복습 (static)

### static

변수 메모리의 저장위치? 정도로 생각하면 되는거 같다.

일반적으로 우리가 만든 Class는 Static 영역에 생성되고, new 연산을 통해 생성한 객체는 힙영역에 생성된다.

static의 장점으로는 다음번에 사용시 또 다시 객체 생성을 하지않아도 된다는 점이다. 매번 생성해서 쓰지 않아도 되기 떄문에

낭비되는 메모리를 줄일 수 있다.

그러나 프로그램에서 많은 static를 사용하면 프로그램 종료시까지 많이 할당된 채로 

존재하기 때문에 프로그램이 활동?하는 것에 안좋은 영향을 주게 될 것이다.

interface를 구현하는데에 static를 사용할 수 없다는 단점도 있다. 

이렇게 자바의 객체 지향을 제한하기도한다.

그렇다고 쓰지말라는것이 아니다. 적절하게만 static만 잘 사용한다면 프로그램을 만든데 있어 효율적으로

작업할 수 있을 것이다.

# 0912 일지

## 스프링 개발환경 세팅

### 1. pom.xml 수정
   - <org.springframework-version>버전 수정 (ex 5.2.3)</org.springframework-version>

### 2. Project Facets에서 자바 (JDK, 컴파일러) 버전 변경
### 3. 이 후 왼쪽 네비목록에서 Java Compiler 도 앞의 버전과 같이 설정
### 4. pom.xml 수정
   - <java-verison>버전수정 (ex 1.8)</java-veriso>로 변경
   - <plugin>안  그룹ID org.apache.maven.plugins의 버전과 소스 타겟 수정
       ex) 버전은 3.5.1, 소스와 타겟은 자바버전과 같게 수정 ->  update mavaen project
### 5. 라이브러리 추가
 -롬복 jar 다운후 추가 (구글에서 롬복 다운 검색후 맨 위 링크) 
 [pom.xml]에 있는 log4j 라이브러리 코드를 제거 혹은 주석 처리합니다.
 "log4j", "spring-test" 라이브러리 코드를 추가합니다. (원하는 버전을 추가합니다.)
"sprint- test" 경우 spring 버전과 동일하게 하기 위해 ${org.springframework-version}을 입력하였습니다.
 "Junit"라이브러리 경우 기존 '4.7'버전에서 '4.12'버전으로 변경합니다.

### 6.MySQL 설정하기
 - 메이븐 추가 (이후 src/test/java에서  테스트 진행)
### 7. HikariCP 설정 및 테스트
### 8. root-context.xml 설정
 -DataSource 설정 (bean 2개) 이후 테스트(@Runwidth)
### 9. MyBatis 라이브러리 추가 및 SQLSessionFactory 설정
 -mybatis
 -mybatis-spring
 -spring-jdbc  <versiont>${org.springframework}
 -mybatis-tx  <versiont>${org.springframework}}
### 10. SqlSessionFactory 설정 (root-context.xml) 후 테스트 (src/test/java)
### 11. Log4jdbc-log4j2 라이브러리 추가 및 설정
 - 라이브러리 추가
- 로그설정파일 추
  log4jdbc.spylogdelegator.name=net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator
- JDBC 연걸정보설정 (rootcontext.xml 변경)
        - hikariConfig 위 두줄 주석 처리 후 2개 추가
### 12. maven사이트에서 java servlet api 복사후 pom.xml 에서 version은  3.1.0으로 변경 

### 13. 필수 패키지추가
- 패키지명.패키지명.model : VO(value Object) 패키지입니다. 데이터 타입을 저장합니다.
- 패키지명.패키지명.mapper : DAO(Data Access Object) 역할을 하는 패키지입니다. 데이터베이스 접속하
                                  는 역할을 합니다.
- 패키지명.패키지명.service :  Service 패키지입니다. Mapper와 Controller 사이를 연결해주는 역할입니다
     
root-context.xml 네임스페이스 추가 (context, mybatis-spring)
다시 source 탭을 누른 후 아래 항목 추가
    <mybatis-spring:scan base-package="패키지명.패키지명.mapper"/>
    <context:component-scan base-package="패키지명.패키지명.model"></context:component-scan>
    <context:component-scan base-package="패키지명.패키지명.service"></context:component-scan>

### 14. Mapper XML 저장경로 생성
### 15. 톰캣연동
### 16. 프로젝트 절대경로 설정(/) 구동 테스트 (Run Server) 
### 17. 한글설정 2개
 - 해당 프로젝트 Properties -> resources Other 선택하고 UTF-8
 - (web.xml) 복사파일

The end

> 지금까지 스프링 환경설정은 생략하고 진행하는 경우가 많았었다. 부트와 다르게 설정이 정말 복잡하고 할게 많다... 그래도 한번 메모해두면
다음에도 도움이 될거 같아서 따로 세팅하는 부분만 작성해봤다. 전자정부 표준프레임워크가 거의 스프링과 동일하기 떄문에 세팅역시 중요하다.
앞으로 무언가를 할때 한 부분만 중점적으로 공부하기 보단 "막히는 부분을 없애자" 라는 느낌으로 공부하면 실무에서도 큰 도움이 될 것이다.

# 0913 

## 지금까지 1일 1커밋을 하며 느낀점

> 아직 1년이 되지는 않았지만 그 동안 1일 1커밋에 대한 내 생각을 적어보자고한다. 처음에는 그저 취업에 대한 열정으로 시작한 주제였으나 시간이 흐르면서 하루라도 빠지면 먼가 찝찝한 기분이 드는게 싫어라는 마음으로 바뀐거 같다. 그래서 별 시덥잖은 코딩작업도 억지로 해가며 잔디를 심었다. 하지만 그렇다고 대부분이 그렇진않았다. 열에 1개정도?만 그랬고 대부분의 날은 의미있는 작업이였다. 뭔가 공부를 하기 싫은날도 이러한 이유(커밋)때문이라도 억지로 컴퓨터 앞에 앉으면 또 술술 작업을 시작한 경험이 많이 있다. 결론적으로 나는 취업을 했다. 정말 기쁜 일이고, 열심히 해야겠다는 생각이 든다. 그런데 간혹보면 취업이 되면 커밋이 뚝 끊어진다는 글을 많이 봤다. 그런 글을 보고 나는 안그럴거야 라고 생각을 했다. 하지만 솔직히 다시한번 더 생각해보면 나도 예외는 아닐거라 생각한다. 취업전이야 시간도 남아돌고 일이 없으니 스스로 작업하는 시간이 많지만, 일을 시작하게 되면 또 그만큼 바빠지고, 육체적으로나 정신적으로나 더 피곤해지기 마련이다. 그럼에도 불구하고 그 마음만큼은 놓지안으려 한다. 대신 이제는 방향을 좀 바꾸는게 어떨까 싶다. 취업을 위한 커밋이 아닌 좀 더 깊이가 있는 내용들로 혹은 블로그를 하는것도 좋다고 생각한다. 뭔가 남에게 보여주는 커밋보다 더 영양가가 높고 내 실력향상을 위한 그러한 노력말이다.

