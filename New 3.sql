SELECT T2.* 
FROM (SELECT 
    ROWNUM RNUM,
    A.*
FROM (SELECT MEM_ID COUNT FROM MEMBER )A)T2
WHERE T2.RNUM BETWEEN 1 AND 5;
;
--

--멤버에 순서 붙이기
select rownum seq, m.*
from member m;
 
--페이지 수를 구하는 쿼리
select t.*
from(select rownum seq, m.*
from member m
order by seq desc)t
where t.seq between 1 and 5;



SELECT (COUNT(*)/5) AS COUNT FROM MEMBER ;
--5.2 PAGE수는 6개 나와야되고


--페이지 수를 구하는 쿼리
--ROWNUM 구한뒤 페이지당 회원의 ID만 보여주는 쿼리
--ROWNUM SEQ 

--SELECT T2* 
--FROM ()
--WHERE T2.SEQ BETWEEN 1 AND 5;
--;

SELECT 
    ROWNUM RNUM,
    A.*
FROM (SELECT MEM_ID COUNT FROM MEMBER )A;
    