# Spring_boardStudy

## 프로젝트 목적

* 포트폴리오가 아님.
* 게시판을 복습하며 모르는 부분을 다시 체크하며 개념습득.
* 오류 발생시 오류내용과 해결방법을 기록.
* 날짜를 기록하며 일지형식으로 진행.

***

## 0812 일지

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

## 0813 일지

### 오류해결

<img src="https://user-images.githubusercontent.com/79797179/184493546-e449c0fb-51cc-4611-b11f-ffbf01286956.png" width="30%">
<img src="https://user-images.githubusercontent.com/79797179/184493545-f199c75b-0f47-4a48-8354-86028d491c65.png" width="80%">

* EL표기시 날짜 값을 불러올떄 오류발생 -> VO 클래스의 필드명과 완전히 동일하게 써야하는것을 깜빡함.

  (regdate -> regDate, updatedate -> updateDate)

***

## 0814 일지

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

0815 일지

### 오류해결

* 게시판 수정시 자꾸 null 값으로 등록이 되어버림 -> form 안의 각 name 값들을 VO 클래스의 필드명과 일치시켜줌.
  
  (항상 하는건데 가끔식 이런다.. 기본을 중요시하자 제발..)

***

0825 일지

### 느낀점

게시판구현은 어느정도 할 수 있겠는데 아직 페이징 처리에 대한 이해도가 부족한거 같다. 많은 목록부분을 구현하는 모든 부분에서 절대로 배제 할 수 없는 개념이다. 빠른 시일내에 페이징개념을 마스터한 후 다시 readme를 쓰겠다!

***

0826 일지

### 개념복습 페이징 처리

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

* this.prev 

startPage 역시 10개 버튼기준으로 1, 11, 21, 31 이렇게 된다. 즉, 다시 말해 1 보다 크면 11, 21, 31 등 1 ~ 10 을 벗어난 페이지 번호들을 말한다. 

예를 들어 13페이지가 현재 번호이면 당연히 1 ~ 10 있다는 이야기가 되니까 이전버튼은 존재해야한다.

그러므로 1이상의 startPage의 값은 prev의 값이 true를 가지게 되는 것이다.(이전표시가 보이게됨)

* this.next

다음 버튼역시 간단하다. 앞서 설명한 바와 같이 endPage의 값은 절대 10, 20 30 등 이 외엔 나올 수가 없다.

하지만 realEnd의 값은 12, 38, 192 등 게시글이 몇개가 등록이 됐는지에 따라 어떤 값이든 올 수 있다.

예를 들어 endPage의값이 현재 10이라 가정하고 realEnd 값이 endPage보다 크다는 소리는 게시글이 10페이지를 넘겼다고 생각하면 된다.

언제끝나는 지는 몰라도 최소한 10 페이지는 넘어간다고 보면된다.

반대로 realEnd값이 endPage 값보다 작다면 endPage의 고정 값(10, 20, 30 등)보단는 작다는 소리다.

다시말해 endPage를 못넘겼기 때문에 다음버튼 또한 당연히 존재하지 않는다. (this.next의 값은 false)

> 뭔가 중구난방식으로 썼지만 오늘 하루 최대한 페이징처리에 대한 이해를 바탕으로 복습겸 작성을 해보았다. view까지도 현재 구현한 상태지만 조금 더 정리해서 view개념도 readme에 작성 할 계획이다.

***

  






