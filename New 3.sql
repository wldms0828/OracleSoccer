SELECT T2.* 
FROM (SELECT 
    ROWNUM RNUM,
    A.*
FROM (SELECT MEM_ID COUNT FROM MEMBER )A)T2
WHERE T2.RNUM BETWEEN 1 AND 5;
;
--

--����� ���� ���̱�
select rownum seq, m.*
from member m;
 
--������ ���� ���ϴ� ����
select t.*
from(select rownum seq, m.*
from member m
order by seq desc)t
where t.seq between 1 and 5;



SELECT (COUNT(*)/5) AS COUNT FROM MEMBER ;
--5.2 PAGE���� 6�� ���;ߵǰ�


--������ ���� ���ϴ� ����
--ROWNUM ���ѵ� �������� ȸ���� ID�� �����ִ� ����
--ROWNUM SEQ 

--SELECT T2* 
--FROM ()
--WHERE T2.SEQ BETWEEN 1 AND 5;
--;

SELECT 
    ROWNUM RNUM,
    A.*
FROM (SELECT MEM_ID COUNT FROM MEMBER )A;
    