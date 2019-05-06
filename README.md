# 1. 어떤 데이터인가?

네이버 카페 - 중고나라 
<img width="826" alt="1" src="https://user-images.githubusercontent.com/49008642/57233117-016f9180-7059-11e9-849f-83640ba0985d.PNG">
> 수많은 중고거래 사이트 중 가장 활발하게 거래되고 있는 곳.
>> 수입명품(가방, 의류, 신발, 잡화 등), 악세서리, 남녀의류, 기타의류(교복, 잠옷, 작업복 등), 미용(화장품, 향수 등), 출산 및 육아용품, 중고폰, 상품권, 티켓(영화, 연극, 공연 등), 연예인 굿즈, 여행 및 여가(티켓, 용품), 컴퓨터, 카메라, 자전거, 생활용품, 가구, 도서, 부동산 매물 등 거의 모든 종류의 중고품이 거래되는 사이트이다.


# 2. 이 데이터가 유용한 이유는?

1. 매일 셀 수 없이 많은 글이 올라온다. (1초만 지나도 한 화면에 보이는 게시글이 바뀜)
2. 특정 거래 외의 정보도 얻을 수 있다. (예를 들어 판매자 닉네임 클릭 시 그 사람의 블로그나 그 사람이 올린 전체 글을 볼 수 있음)
3. 같은 제품이라도 가격대가 매우 다양하다.

# 3. 웹 크롤링 시 해결해야 할 문제점
- 네이버 카페가 2018년 5월 9일부로 html기능을 제외하여 크롤링 시 위 링크로는 html을 이용할 수 없다. 따라서 pc버전이 아닌 모바일 버전을 이용해야 한다.

  *[네이버카페 html 제외 공지 글] : (https://cafe.naver.com/cafesupport/123313)*


- pc버전에는 있던 게시글 번호 페이지가 모바일버전에서는 더보기 버튼으로 되어있다.
<div>
<img width="400"  src="https://user-images.githubusercontent.com/49008642/57233466-a8ecc400-7059-11e9-882e-5a73ec3a3b1f.PNG">
<img width="400"  src="https://user-images.githubusercontent.com/49008642/57233469-aab68780-7059-11e9-8509-3e1718c503f6.PNG">
</div>
-> 왼쪽은 pc, 오른쪽은 모바일


- RSelenium을 이용해 데이터를 가져오는 중에 특정 글이 삭제된 글이라면 코드 실행이 멈춰버린다.
