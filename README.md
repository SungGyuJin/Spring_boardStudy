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

```
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

* EL표기시 날짜 값을 불러올떄 오류발생 -> DAO클래스의 멤버변수와 완전히 동일하게 써야하는것을 깜빡함.

  (regdate -> regDate, updatedate -> updateDate)

***

## 0814 일지

### 오류해결

```
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








